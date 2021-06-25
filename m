Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A80753B488B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 19:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbhFYSAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 14:00:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:46006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229531AbhFYSAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 14:00:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C697461962;
        Fri, 25 Jun 2021 17:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624643869;
        bh=oOSj0X4FE7FErjVHq3yjylZUVNnZQxO6Kpg8jzl59ig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mhMtgKGfZyF1K3+8aZ/Qhxu42oLBbajrDychBw8zh9rQtIpvD2XTRCV/TC4b9xiK3
         hjFFPa4ufe9/OZn1fppoff2VH7udIPTibbPY8azMQJNb+naWQ6Fe83mOE+gYxgq1um
         6AfgBHA001YuNyhmTpja8MQxnEWXLQuGfxvyeC6nh4VzRxO5FbLPmLxuf4hcXq48O6
         5lQQ7d5PeWqQuwgMkKaPoQlsp8je9R0AODopWXSfvX6a0iD5D2yZmGbAftaxYEixDh
         mJqm04VHek6yv4lG8h+l39yoT7XsXD3myjiOgM95dNsNvViPxCcDX7/1IiC3hOarJ0
         3rSp6Gd+yuq3A==
From:   Nathan Chancellor <nathan@kernel.org>
To:     "Geoffrey D. Bennett" <g@b4.vu>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2] ALSA: usb-audio: scarlett2: Fix for loop increment in scarlett2_usb_get_config
Date:   Fri, 25 Jun 2021 10:54:19 -0700
Message-Id: <20210625175418.2019892-1-nathan@kernel.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890
In-Reply-To: <s5heecql74j.wl-tiwai@suse.de>
References: <s5heecql74j.wl-tiwai@suse.de>
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
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---

v1 -> v2:

* Use temporary variables of proper type rather than casting, as
  requested by Takashi. I did not include Geoffrey's ack for this
  reason.

* Mention that there is not a bug at the moment per Geoffrey's comment.

 sound/usb/mixer_scarlett_gen2.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/sound/usb/mixer_scarlett_gen2.c b/sound/usb/mixer_scarlett_gen2.c
index fcba682cd422..b13903bed330 100644
--- a/sound/usb/mixer_scarlett_gen2.c
+++ b/sound/usb/mixer_scarlett_gen2.c
@@ -1177,17 +1177,22 @@ static int scarlett2_usb_get_config(
 	const struct scarlett2_config *config_item =
 		&scarlett2_config_items[info->has_mixer][config_item_num];
 	int size, err, i;
+	u8 *buf_8;
 	u8 value;
 
 	/* For byte-sized parameters, retrieve directly into buf */
 	if (config_item->size >= 8) {
+		u16 *buf_16;
+
 		size = config_item->size / 8 * count;
 		err = scarlett2_usb_get(mixer, config_item->offset, buf, size);
 		if (err < 0)
 			return err;
-		if (size == 2)
-			for (i = 0; i < count; i++, (u16 *)buf++)
-				*(u16 *)buf = le16_to_cpu(*(__le16 *)buf);
+		if (size == 2) {
+			buf_16 = buf;
+			for (i = 0; i < count; i++, buf_16++)
+				*buf_16 = le16_to_cpu(*(__le16 *)buf_16);
+		}
 		return 0;
 	}
 
@@ -1197,8 +1202,9 @@ static int scarlett2_usb_get_config(
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

