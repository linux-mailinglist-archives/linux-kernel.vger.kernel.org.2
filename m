Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC643B49AF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 22:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbhFYUP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 16:15:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:40264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229573AbhFYUP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 16:15:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C4FFE61879;
        Fri, 25 Jun 2021 20:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624651987;
        bh=9dGndesqenWa7LqpmTkh/VkTIUvlXFjI1oyySUK2Wio=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=obrIPNX2aRIOkzMAHxdZGVi1I2p+g8oAjPThh3wEYCpo3uYI7FekdIHmsZ+XznjEl
         2RN7Sbk1p9e2XjwPCd5iITm0snR5mzy70ODfSnj2yLHHsTzw13R0Sd4nBwfSXTFdTH
         bPyRrcUra+rY2wqScCtcuhr1PjMaZ/pXhGIiokDxjfRRDJzDpks1X5v3mHZ6Bw28us
         GxH1ZTZVO6v+3J1Qdm1p70LRUbOlZROaTaphzhwQd0O9adnB9V+KtJRs6MobbMXlzk
         OlfGw5UN268kdztPfyOcJXpQ1tcWmmbpK8j9YIdci9xFrLBaKggzfVbJjGHYVdJ6jA
         aADVUNzS3B4hA==
From:   Nathan Chancellor <nathan@kernel.org>
To:     "Geoffrey D. Bennett" <g@b4.vu>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v4] ALSA: usb-audio: scarlett2: Fix for loop increment in scarlett2_usb_get_config
Date:   Fri, 25 Jun 2021 13:11:51 -0700
Message-Id: <20210625201150.1523987-1-nathan@kernel.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890
In-Reply-To: <20210625200549.1061113-1-nathan@kernel.org>
References: <20210625200549.1061113-1-nathan@kernel.org>
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
the loop does not iterate as expected.

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

