Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8F33D44C6
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 06:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbhGXDnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 23:43:41 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:39702 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233812AbhGXDnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 23:43:39 -0400
X-UUID: 835c1033b48042da90d5566321577798-20210724
X-UUID: 835c1033b48042da90d5566321577798-20210724
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <chihhao.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1923782835; Sat, 24 Jul 2021 12:24:08 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 24 Jul 2021 12:24:06 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 24 Jul 2021 12:24:06 +0800
From:   <chihhao.chen@mediatek.com>
To:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <damien@zamaudio.com>, <chihhao.chen@mediatek.com>,
        <perex@perex.cz>, <tiwai@suse.com>, <matthias.bgg@gmail.com>
CC:     <wsd_upstream@mediatek.com>
Subject: [PATCH] ALSA: usb-audio: fix incorrect clock source setting
Date:   Sat, 24 Jul 2021 12:23:41 +0800
Message-ID: <1627100621-19225-1-git-send-email-chihhao.chen@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "chihhao.chen" <chihhao.chen@mediatek.com>

The following scenario describes an echo test for
Samsung USBC Headset (AKG) with VID/PID (0x04e8/0xa051).

We first start a capture stream(USB IN transfer) in 96Khz/24bit/1ch mode.
In clock find source function, we get value 0x2 for clock selector
and 0x1 for clock source.

Kernel-4.14 behavior
Since clock source is valid so clock selector was not set again.
We pass through this function and start a playback stream(USB OUT transfer)
in 48Khz/32bit/2ch mode. This time we get value 0x1 for clock selector
and 0x1 for clock source. Finally clock id with this setting is 0x9.

Kernel-5.10 behavior
Clock selector was always set one more time even it is valid.
When we start a playback stream, we will get 0x2 for clock selector
and 0x1 for clock source. In this case clock id becomes 0xA.
This is an incorrect clock source setting and results in severe noises.
We see wrong data rate in USB IN transfer.
(From 288 bytes/ms becomes 144 bytes/ms) It should keep in 288 bytes/ms.

This earphone works fine on older kernel version load because
this is a newly-added behavior.

Signed-off-by: chihhao.chen <chihhao.chen@mediatek.com>
---
 sound/usb/clock.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/usb/clock.c b/sound/usb/clock.c
index 52de522..14456f6 100644
--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -324,6 +324,12 @@ static int __uac_clock_find_source(struct snd_usb_audio *chip,
 					      sources[ret - 1],
 					      visited, validate);
 		if (ret > 0) {
+			/*
+			 * For Samsung USBC Headset (AKG), setting clock selector again
+			 * will result in incorrect default clock setting problems
+			 */
+			if (chip->usb_id == USB_ID(0x04e8, 0xa051))
+				return ret;
 			err = uac_clock_selector_set_val(chip, entity_id, cur);
 			if (err < 0)
 				return err;
-- 
1.7.9.5

