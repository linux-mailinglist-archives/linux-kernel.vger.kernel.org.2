Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11F5E326963
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 22:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhBZV0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 16:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbhBZV0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 16:26:13 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDD2C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 13:25:33 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id t29so7096626pfg.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 13:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=george-graphics-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NlWMLWhxZMu4ySEeDP2fa+9dxkabBQGlKANZO0dxadc=;
        b=x5TesxhGQAcUy+Ho3TA2HZgoc55dKXVbJz6h6A9cWXxOvjGCja7x1K8zm0wSmGTcmb
         w1oNEZjTgnqjSMft+468Oi9Pf4tA4DFmlMJUZ1Sj01SCs2zwnVNy0BpIaKv1BEUs6qLn
         OlDcXQ9WHAKhav3PnKDGbNBKcuMaxZGkscPoBbVQis13nKokugdTelTBE6fxW7vdahS1
         9JtPLpyIABZiXzoZKjZSb3QMoLEO4Mjk0tl+WqC5YIWnznWDa3LxP2pqKBlsWM3BaWVK
         3sjEI5W3IQdMZJnp1YWnp743RZp3vQEchSOyirJ9j/2CB0SDGT0jafdCVPuF4zX1Z8l8
         WtNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NlWMLWhxZMu4ySEeDP2fa+9dxkabBQGlKANZO0dxadc=;
        b=t0ztd8jEFWMGaV4gPnfqHnGSkbMQSHnI92qtG5THYLEbmHybow0+ntUv4b3ugolaei
         d9L+9zSkzJ7Xf6P40JKtV/qKPuTtC0RYCaf3vj8FjrJBubMXmRjd2eHSEbQnGP68tbQe
         ztml2IfWCVrzD4ARAFEnAbW87hJKJBuTbZxG14z5kQf5Dv84OtRA16cBUYboY7LAtRr7
         5yqoHJHS8kU+s3QGzBYGEPwqcDjZynMA5V9TNed6bMHvGzWJrdxpFcHnigJkV/uVKYOY
         f72ZXdWe05rGxeuDdRmjvVK0ArOvT3+2Yopg3qIo2+/117On3T/27jU3FwvqI31GwYpq
         CeNg==
X-Gm-Message-State: AOAM530HJSxAFyGG6uNl5IzcU8JS/7Ea1VU5FmzpRrxq7IR+a2bHZ88E
        kpblJbVa2FJu9q0YJol8GZ6fkA==
X-Google-Smtp-Source: ABdhPJyjjgYgu5zlTQCwgMXEkrFWh7Y+XgmWZTjJvNpBKmcrMDtdxy/QCaEdCk2OZSTSUMptc8AhPw==
X-Received: by 2002:a65:4141:: with SMTP id x1mr4503126pgp.421.1614374732569;
        Fri, 26 Feb 2021 13:25:32 -0800 (PST)
Received: from sequencer.hsd1.wa.comcast.net ([2601:602:8000:181:df1d:64b5:575f:9598])
        by smtp.gmail.com with ESMTPSA id u129sm10317695pfu.219.2021.02.26.13.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 13:25:31 -0800 (PST)
From:   George Harker <george@george-graphics.co.uk>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     George Harker <george@george-graphics.co.uk>,
        Clemens Ladisch <clemens@ladisch.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] use usb headers rather than define structs locally
Date:   Fri, 26 Feb 2021 21:24:56 +0000
Message-Id: <20210226212457.24538-1-george@george-graphics.co.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <s5hczwpucd3.wl-tiwai@suse.de>
References: <s5hczwpucd3.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use struct definitions from linux/usb/midi.h rather than locally define
the structs in sound/usb/midi.c .

Signed-off-by: George Harker <george@george-graphics.co.uk>
---
 sound/usb/midi.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index 0c23fa6d8..610cf54ee 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -47,6 +47,7 @@
 #include <linux/usb.h>
 #include <linux/wait.h>
 #include <linux/usb/audio.h>
+#include <linux/usb/midi.h>
 #include <linux/module.h>
 
 #include <sound/core.h>
@@ -77,23 +78,6 @@ MODULE_AUTHOR("Clemens Ladisch <clemens@ladisch.de>");
 MODULE_DESCRIPTION("USB Audio/MIDI helper module");
 MODULE_LICENSE("Dual BSD/GPL");
 
-
-struct usb_ms_header_descriptor {
-	__u8  bLength;
-	__u8  bDescriptorType;
-	__u8  bDescriptorSubtype;
-	__u8  bcdMSC[2];
-	__le16 wTotalLength;
-} __attribute__ ((packed));
-
-struct usb_ms_endpoint_descriptor {
-	__u8  bLength;
-	__u8  bDescriptorType;
-	__u8  bDescriptorSubtype;
-	__u8  bNumEmbMIDIJack;
-	__u8  baAssocJackID[];
-} __attribute__ ((packed));
-
 struct snd_usb_midi_in_endpoint;
 struct snd_usb_midi_out_endpoint;
 struct snd_usb_midi_endpoint;
@@ -1875,7 +1859,7 @@ static int snd_usbmidi_get_ms_info(struct snd_usb_midi *umidi,
 	    ms_header->bDescriptorType == USB_DT_CS_INTERFACE &&
 	    ms_header->bDescriptorSubtype == UAC_HEADER)
 		dev_dbg(&umidi->dev->dev, "MIDIStreaming version %02x.%02x\n",
-			    ms_header->bcdMSC[1], ms_header->bcdMSC[0]);
+			    ((uint8_t *)&ms_header->bcdMSC)[1], ((uint8_t *)&ms_header->bcdMSC)[0]);
 	else
 		dev_warn(&umidi->dev->dev,
 			 "MIDIStreaming interface descriptor not found\n");
-- 
2.20.1

