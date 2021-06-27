Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 363F23B5225
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 07:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbhF0FQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 01:16:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229472AbhF0FQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 01:16:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BFF0561C18;
        Sun, 27 Jun 2021 05:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624770840;
        bh=8SJ0rdNiF1eGxKYghOID17R/TEXH/bxSrVL61q47o6g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tsvX004sWQ1Vml6hsSQVSayCX2z9ZKSHM9fz3et7JdxKmZ1cJiKkh1mflXfbEnQwK
         muYfgh+F0tu0MSrKS2CGUF0eEU5C5axXUHbxuxCTxxO/pGnNECZosGR9xRLLFJZ3di
         vSZ/jtVj1fpSB6bFV+QEQpSgNzPxavCaDIML/q3r/DsAcwuZ8+TJ7Fgx6ZiI3BNo+q
         crO3gJBWo4DIHWmOIXn9Q7Jn5ls5tRkuPDl0057Yj+e/BGjHwqOol+xKrMR4KMVr6T
         jlxFAT2ZtHN4qgYOOsmQATGDN7HAm6s/TeBfAPvvfidcf6Nd6PA3VFG0UtMC7a4Ndd
         wwAA23J8lpUYw==
From:   Nathan Chancellor <nathan@kernel.org>
To:     "Geoffrey D. Bennett" <g@b4.vu>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v5] ALSA: usb-audio: scarlett2: Fix for loop increment in scarlett2_usb_get_config
Date:   Sat, 26 Jun 2021 22:12:03 -0700
Message-Id: <20210627051202.1888250-1-nathan@kernel.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890
In-Reply-To: <20210625202604.GB23780@m.b4.vu>
References: <20210625202604.GB23780@m.b4.vu>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

sound/usb/mixer_scarlett_gen2.c:1189:32: warning: expression result
unused [-Wunused-value]
                        for (i = 0; i < count; i++, (u16 *)buf++)
                                                    ^      ~~~~~
1 warning generated.

It appears the intention was to cast the void pointer to a u16 pointer
so that the data could be iterated through like an array of u16 values.
However, the cast happens after the increment because a cast is an
rvalue, whereas the post-increment operator only works on lvalues, so
the loop does not iterate as expected. This is not a bug in practice
because count is not greater than one at the moment but this could
change in the future so this should be fixed.

Replace the cast with a temporary variable of the proper type, which is
less error prone and fixes the iteration. Do the same thing for the
'u8 *' below this if block.

Fixes: ac34df733d2d ("ALSA: usb-audio: scarlett2: Update get_config to do endian conversion")
Link: https://github.com/ClangBuiltLinux/linux/issues/1408
Acked-by: Geoffrey D. Bennett <g@b4.vu>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---

v1 -> v2:

* Use temporary variables of proper type rather than casting, as
  requested by Takashi.

* Mention that there is not a bug at the moment per Geoffrey's comment.

v2 -> v3:

* Restrict scope of buf_16 more, as requested by Geoffrey.

* Add Geoffrey's ack.

v3 -> v4:

* Fix stray newline added below

  if (config_item->size >= 8) {

  leftover from buf_16's declaration.

v4 -> v5 (or how many times does it take Nathan to get a patch right):

* Re-add note about no bug that was dropped in v3 by accident, as
  noticed by Geoffrey. My apologies for the multiple revisions.

 sound/usb/mixer_scarlett_gen2.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/sound/usb/mixer_scarlett_gen2.c b/sound/usb/mixer_scarlett_gen2.c
index fcba682cd422..161d832cafef 100644
--- a/sound/usb/mixer_scarlett_gen2.c
+++ b/sound/usb/mixer_scarlett_gen2.c
@@ -1177,6 +1177,7 @@ static int scarlett2_usb_get_config(
 	const struct scarlett2_config *config_item =
 		&scarlett2_config_items[info->has_mixer][config_item_num];
 	int size, err, i;
+	u8 *buf_8;
 	u8 value;
 
 	/* For byte-sized parameters, retrieve directly into buf */
@@ -1185,9 +1186,12 @@ static int scarlett2_usb_get_config(
 		err = scarlett2_usb_get(mixer, config_item->offset, buf, size);
 		if (err < 0)
 			return err;
-		if (size == 2)
-			for (i = 0; i < count; i++, (u16 *)buf++)
-				*(u16 *)buf = le16_to_cpu(*(__le16 *)buf);
+		if (size == 2) {
+			u16 *buf_16 = buf;
+
+			for (i = 0; i < count; i++, buf_16++)
+				*buf_16 = le16_to_cpu(*(__le16 *)buf_16);
+		}
 		return 0;
 	}
 
@@ -1197,8 +1201,9 @@ static int scarlett2_usb_get_config(
 		return err;
 
 	/* then unpack from value into buf[] */
+	buf_8 = buf;
 	for (i = 0; i < 8 && i < count; i++, value >>= 1)
-		*(u8 *)buf++ = value & 1;
+		*buf_8++ = value & 1;
 
 	return 0;
 }

base-commit: 0cbbeaf370221fc469c95945dd3c1198865c5fe4
-- 
2.32.0.93.g670b81a890

