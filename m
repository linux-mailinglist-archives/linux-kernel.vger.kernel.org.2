Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 229B5362F09
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 11:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236085AbhDQJvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 05:51:43 -0400
Received: from cable.insite.cz ([84.242.75.189]:50272 "EHLO cable.insite.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231387AbhDQJvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 05:51:42 -0400
X-Greylist: delayed 466 seconds by postgrey-1.27 at vger.kernel.org; Sat, 17 Apr 2021 05:51:42 EDT
Received: from localhost (localhost [127.0.0.1])
        by cable.insite.cz (Postfix) with ESMTP id 637E3A1A3D401;
        Sat, 17 Apr 2021 11:43:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ivitera.com; s=mail;
        t=1618652606; bh=ZWpJY/HjT8t8Njrqdqjjue1gioq82r4lxM1RGXN8Flw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GmzKoCcPHrYNDbynyt2lTVBSVgD55CRFzHkFlMAT6Hc56zrnm2U8PQRffr+d87Y8a
         wNjY1XK6vEgLY4LX1z50S3hqBV1UQAWArgYXTkwLB6LGkcz6k61LokNaiEOkoaHI/h
         58i9AJkIZTbWSBAZ1MgHAFY4shui2Z9VRl5O757c=
Received: from cable.insite.cz ([84.242.75.189])
        by localhost (server.insite.cz [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IUa4vBq-Qe0l; Sat, 17 Apr 2021 11:43:20 +0200 (CEST)
Received: from [192.168.105.22] (ip28.insite.cz [81.0.237.28])
        (Authenticated sender: pavel)
        by cable.insite.cz (Postfix) with ESMTPSA id 18EEBA1A3D400;
        Sat, 17 Apr 2021 11:43:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ivitera.com; s=mail;
        t=1618652600; bh=ZWpJY/HjT8t8Njrqdqjjue1gioq82r4lxM1RGXN8Flw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=S++3gDgjjyPJPBdDsWj6j8lMbUKMhOv3goECWHx8xklM4loqtb2WFD2Is0/xC9w2j
         588nsHbMyPAqJs1sWkMms49qHmrtNVZeoYXgBvW7eyhl751wjsK+yD148oGICNui4m
         o7FCkBcSE6pxAeHQ0NjaeIhyhcUuxa3Y1edY0rKo=
Subject: Re: [PATCH 2/8] usb: gadget: f_uac2/u_audio: add feedback endpoint
 support
To:     Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     gschmottlach@gmail.com, linux-usb@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1614603943-11668-1-git-send-email-ruslan.bilovol@gmail.com>
 <1614603943-11668-3-git-send-email-ruslan.bilovol@gmail.com>
From:   Pavel Hofman <pavel.hofman@ivitera.com>
Message-ID: <be928b87-9ebe-43da-216d-40904b7ef8e0@ivitera.com>
Date:   Sat, 17 Apr 2021 11:43:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1614603943-11668-3-git-send-email-ruslan.bilovol@gmail.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne 01. 03. 21 v 14:05 Ruslan Bilovol napsal(a):
> +static void u_audio_set_fback_frequency(enum usb_device_speed speed,
> +					unsigned int freq, void *buf)
> +{
> +	u32 ff = 0;
> +
> +	if (speed == USB_SPEED_FULL) {
> +		/*
> +		 * Full-speed feedback endpoints report frequency
> +		 * in samples/microframe
> +		 * Format is encoded in Q10.10 left-justified in the 24 bits,
> +		 * so that it has a Q10.14 format.
> +		 */
> +		ff = DIV_ROUND_UP((freq << 14), 1000);
> +	} else {
> +		/*
> +		 * High-speed feedback endpoints report frequency
> +		 * in samples/microframe.
> +		 * Format is encoded in Q12.13 fitted into four bytes so that
> +		 * the binary point is located between the second and the third
> +		 * byte format (that is Q16.16)
> +		 *
> +		 * Prevent integer overflow by calculating in Q12.13 format and
> +		 * then shifting to Q16.16
> +		 */
> +		ff = DIV_ROUND_UP((freq << 13), (8*1000)) << 3;
> +	}

Hi Ruslan,

Thanks a lot for your patch. The HS calculation of Q16.16 feedback value
overflows at some 524kHz, disallowing use of larger samplerates (e.g.
768kHz or higher).

I tested the formula used in alsa USB driver
https://github.com/torvalds/linux/blob/d99676af540c2dc829999928fb81c58c80a1dce4/sound/usb/endpoint.c#L80
which uses only 10bit shift. The feedback control in UAC2 gadget now
works up to 4M samplerate with 1Hz precision (tested on RPi4 with
bInterval = 1, checked in stream0 proc file on linux host).

--- a/drivers/usb/gadget/function/u_audio.c
+++ b/drivers/usb/gadget/function/u_audio.c
@@ -118,7 +119,8 @@ static void u_audio_set_fback_frequency(enum
usb_device_speed speed,
                 * Prevent integer overflow by calculating in Q12.13
format and
                 * then shifting to Q16.16
                 */
-               ff = DIV_ROUND_UP((freq << 13), (8*1000)) << 3;
+               //ff = DIV_ROUND_UP((freq << 13), (8*1000)) << 3;
+               ff = ((freq << 10) + 62) / 125;
        }
        *(__le32 *)buf = cpu_to_le32(ff);
 }


Best regards,

Pavel.




