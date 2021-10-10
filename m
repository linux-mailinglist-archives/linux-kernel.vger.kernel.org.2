Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43BFA428135
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 14:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbhJJMYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 08:24:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:38226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231892AbhJJMYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 08:24:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E18DE60EDF;
        Sun, 10 Oct 2021 12:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633868564;
        bh=MFImbL7l7iaihtx0OWpPhL0Cx6Oqn4VM20u+CfvjnGU=;
        h=Date:From:To:Cc:Subject:From;
        b=d0VzwahRyfgcYxaVj3SNb8rpNrrtMItE8E3pKQ8e6B95dPQC3StN7N2lFrV6q0YNA
         o+s0J+KlErfnkJdn726PuyhnECiSmeCBOohx07DBGtEb9TE7r6MzGtIWi5D8CHOqPq
         nEzQXlzxwg3C8IjrWMnm+ZdN8lbUGH06GBiyQD6E=
Date:   Sun, 10 Oct 2021 14:22:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: usb-audio: allow -EPIPE errors for some v2 messages
Message-ID: <YWLbEdHUE3k/i0fe@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Schiit Hel device does not like to respond to all get_ctl_value_v2()
requests for some reason.  This used to work in older kernels, but now
with more strict checking, this failure causes the device to fail to
work.

Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

This fixes the Shiit Hel device that I have.  It used to work on older
kernels (a year ago?), but stopped working for some reason and I didn't
take the time to track it down.  This change fixes the issue for me, but
feels wrong for some reason.  At least now I can use the device as a
headphone driver, much better than the built-in one for my current
machine...

If needed, I can take the time to do bisection to track down the real
issue here, it might be due to stricter endpoint checking in the USB
core, but that feels wrong somehow.

Here's the debugfs USB output for this device, showing the endpoints:

T:  Bus=07 Lev=02 Prnt=02 Port=01 Cnt=01 Dev#=  5 Spd=480 MxCh= 0
D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=30be ProdID=0101 Rev=01.02
S:  Manufacturer=Schiit Audio
S:  Product=Schiit Hel
C:  #Ifs= 4 Cfg#= 1 Atr=c0 MxPwr=0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=01(audio) Sub=01 Prot=20 Driver=snd-usb-audio
E:  Ad=8f(I) Atr=03(Int.) MxPS=   6 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=01(audio) Sub=02 Prot=20 Driver=snd-usb-audio
E:  Ad=05(O) Atr=05(Isoc) MxPS= 104 Ivl=125us
E:  Ad=85(I) Atr=11(Isoc) MxPS=   4 Ivl=1ms
I:  If#= 2 Alt= 1 #EPs= 1 Cls=01(audio) Sub=02 Prot=20 Driver=snd-usb-audio
E:  Ad=88(I) Atr=05(Isoc) MxPS= 156 Ivl=125us
I:  If#= 3 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=00 Prot=00 Driver=usbhid
E:  Ad=84(I) Atr=03(Int.) MxPS=  16 Ivl=1ms

Any other suggestions to fix this are welcome.

 sound/usb/mixer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index a2ce535df14b..37d3d697776b 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -371,11 +371,11 @@ static int get_ctl_value_v2(struct usb_mixer_elem_info *cval, int request,
 			      validx, idx, buf, size);
 	snd_usb_unlock_shutdown(chip);
 
-	if (ret < 0) {
+	if ((ret < 0) && (ret != -EPIPE)) {
 error:
 		usb_audio_err(chip,
-			"cannot get ctl value: req = %#x, wValue = %#x, wIndex = %#x, type = %d\n",
-			request, validx, idx, cval->val_type);
+			"cannot get ctl value: req = %#x, wValue = %#x, wIndex = %#x, type = %d, ret = %d\n",
+			request, validx, idx, cval->val_type, ret);
 		return ret;
 	}
 
-- 
2.33.0

