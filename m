Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C47032C147
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1838409AbhCCTAe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 3 Mar 2021 14:00:34 -0500
Received: from mail.actia.se ([195.67.112.82]:25647 "EHLO mail.actia.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1579350AbhCCSbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 13:31:07 -0500
X-Greylist: delayed 943 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Mar 2021 13:31:06 EST
Received: from S036ANL.actianordic.se (192.168.16.117) by
 S036ANL.actianordic.se (192.168.16.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 3 Mar 2021 19:14:39 +0100
Received: from S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69]) by
 S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69%3]) with mapi id
 15.01.2176.004; Wed, 3 Mar 2021 19:14:39 +0100
From:   John Ernberg <john.ernberg@actia.se>
To:     "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "kempe@lysator.liu.se" <kempe@lysator.liu.se>,
        John Ernberg <john.ernberg@actia.se>
Subject: [PATCH] ALSA: usb: Add Plantronics C320-M USB ctrl msg delay quirk
Thread-Topic: [PATCH] ALSA: usb: Add Plantronics C320-M USB ctrl msg delay
 quirk
Thread-Index: AQHXEFkTCsQRnWxDKk2OSuE4/Zlp2w==
Date:   Wed, 3 Mar 2021 18:14:39 +0000
Message-ID: <20210303181405.39835-1-john.ernberg@actia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.0
x-originating-ip: [10.11.250.6]
x-esetresult: clean, is OK
x-esetid: 37303A2905BC1358637367
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The microphone in the Plantronics C320-M headset will randomly
fail to initialize properly, at least when using Microsoft Teams.
Introducing a 20ms delay on the control messages appears to
resolve the issue.

Link: https://gitlab.freedesktop.org/pulseaudio/pulseaudio/-/issues/1065
Tested-by: Andreas Kempe <kempe@lysator.liu.se>
Signed-off-by: John Ernberg <john.ernberg@actia.se>
---

Note: Microsoft Teams is the only application tests have been performed with
and no other kinds of investigations have been performed, like USB packet logging.
Originally reported as a possible PulseAudio issue, where it was suggested to
try a delay quirk in the kernel.
If other tests should be performed, please let me know which tests and I will try to do them.

All testing was done on 5.10, patch was then applied on sound.git master for submission

I did not register to the mailing lists, please keep me CC on any comments. Thanks!

 sound/usb/quirks.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index d02dac5fcd40..a31b7db92b1e 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1673,6 +1673,14 @@ void snd_usb_ctl_msg_quirk(struct usb_device *dev, unsigned int pipe,
 	    && (requesttype & USB_TYPE_MASK) == USB_TYPE_CLASS)
 		msleep(20);
 
+	/*
+	 * Plantronics C320-M needs a delay to avoid random
+	 * microhpone failures.
+	 */
+	if (chip->usb_id == USB_ID(0x047f, 0xc025)  &&
+	    (requesttype & USB_TYPE_MASK) == USB_TYPE_CLASS)
+		msleep(20);
+
 	/* Zoom R16/24, many Logitech(at least H650e/H570e/BCC950),
 	 * Jabra 550a, Kingston HyperX needs a tiny delay here,
 	 * otherwise requests like get/set frequency return
-- 
2.30.0
