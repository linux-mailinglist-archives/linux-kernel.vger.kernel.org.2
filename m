Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 133804401EA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 20:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbhJ2Sdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 14:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbhJ2Sdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 14:33:53 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB1FC061570
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 11:31:24 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id j28so5175670ila.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 11:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mf2CSn+LLgrTkJdXfd7F97mVU6u+18tKJPoVJKny3bw=;
        b=Oy3FNsGEk/V2ZF314tLgSX+Enfg3GItchp/AaflZVZxMGwaZNbQ9oJOj2CTRgWaZ9a
         XzxBxKvMn1fmtbwpJ675It6y0gn6Z5EssUZlK2eOh4SuZrFxjtOcBeVqSJLy6L9/jSMd
         v6IgLajzAeygXuzIW9g3SkqcqAGUBY6IyS9vcfzEaurHyNNR5AYGCApoJx55gIJ0O8Xe
         rkZ8JV8HNJqUmTxRLXKUKNe6n3Vo12SR8tvKV54MjH/29IvMObmVf4Dnt8tgvDiyJUgX
         VLiLp+UZe6OMe+wHfJTYQfiJldV1RWq7fcgtPoEMxbEMboqtpTfLiLKbeHzxhw/cFy/J
         9fjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mf2CSn+LLgrTkJdXfd7F97mVU6u+18tKJPoVJKny3bw=;
        b=RjaVW7AZnvs0NJDO229u6BK9CeipXmt83PsuXPF/66bF6aHBi5st0D/nAc+P9vZuMo
         EigfGNLcunfCfpHDX0IJwO597wnv8S6XtvxkjP+sfAPISniN1DepGBHXat2qMu9h++B+
         pVpK2CKdIIGsvdaujTbDglTXGYSpbmZAn1GWvxJT1DkcST6DPcWWhwE2HjgEF22vj7pv
         u7oar1ZTiANmrUOTitbrQge8wYrcMiuUhwMJAHbYdBuV0+6A60J8LfHQ2A6WcT/TfRtA
         fNQBzfJh0g9B4a3LTy99yFAKdS5Kk1Ji3CoeFCCjEsbW4N7wai5adrohsauGB3A20IBb
         f+2g==
X-Gm-Message-State: AOAM5314xp3UUOoLDKz6J4D4/3Ho0Qr2/MzraJp5O4PR+TV9O81o4o44
        xcaKWw4/5JyYR8gP54F3XCc=
X-Google-Smtp-Source: ABdhPJxi8jHFHACJn5p1MMl0+YsmeJY66XOGfgAKuKC2SZblb4dATssIv3dHTVxPy3ctpHZ9vdEiOw==
X-Received: by 2002:a92:d5c5:: with SMTP id d5mr6614119ilq.307.1635532283827;
        Fri, 29 Oct 2021 11:31:23 -0700 (PDT)
Received: from jason-mate (c-73-208-52-59.hsd1.il.comcast.net. [73.208.52.59])
        by smtp.gmail.com with ESMTPSA id k16sm3517333ior.50.2021.10.29.11.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 11:31:23 -0700 (PDT)
From:   Jason Ormes <skryking@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Jason Ormes <skryking@gmail.com>
Subject: [PATCH] HX-Stomp XL USB_ID.
Date:   Fri, 29 Oct 2021 13:31:05 -0500
Message-Id: <20211029183105.28503-1-skryking@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jason Ormes <skryking@gmail.com>
---
 sound/usb/format.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/format.c b/sound/usb/format.c
index 50efccbffb8a..e8fc2c350a9f 100644
--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -414,6 +414,7 @@ static int line6_parse_audio_format_rates_quirk(struct snd_usb_audio *chip,
 	case USB_ID(0x0e41, 0x4242): /* Line6 Helix Rack */
 	case USB_ID(0x0e41, 0x4244): /* Line6 Helix LT */
 	case USB_ID(0x0e41, 0x4246): /* Line6 HX-Stomp */
+        case USB_ID(0x0e41, 0x4253): /* Line6 HX-Stomp XL*/
 	case USB_ID(0x0e41, 0x4247): /* Line6 Pod Go */
 	case USB_ID(0x0e41, 0x4248): /* Line6 Helix >= fw 2.82 */
 	case USB_ID(0x0e41, 0x4249): /* Line6 Helix Rack >= fw 2.82 */
-- 
2.25.1

