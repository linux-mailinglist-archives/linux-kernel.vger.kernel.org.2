Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2253ECFCC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 09:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234386AbhHPH4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 03:56:30 -0400
Received: from phobos.denx.de ([85.214.62.61]:42756 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234400AbhHPHzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 03:55:51 -0400
Received: from [IPv6:::1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 0ABAC82DF6;
        Mon, 16 Aug 2021 09:55:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1629100517;
        bh=qxdKNE6QZJ3jeX2FGy/HZQJa6oKpB6hiuozRQUI6IDw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cRA5UbNdVWoubpaYLWeAE+/oyVcstfuKhxopjzt/MrYg0ujuZ/BQaEZfNnkt4Qj0K
         dH2Rya1P4R/+CXDvOw/PcB6OLM/h73WT3cYmVvFznM9G6uT+6rqUz+9wwCs3Km6hov
         +FA5EAOltqqEwU+aozZxR2FT4iOa2XKeJrvRY1krJkV2CLThG17URtI7qw6N530oDZ
         utvZqKp5OhGSzsbrRkhSiIYUuKjUfSlo4i9Prd+6gUreL3SZcGi/zUdK9wJVQ20NbD
         8SjQXIeKOS+NexcoBTgj3Qu253V0nv8ui4QiabuQW31Wb5uTRHSpTXu4/2pS7x5Nvy
         H1fMXDx+uGrFw==
Subject: Re: Revert "video: fbdev: mxsfb: Remove driver"
To:     Alistair Francis <alistair23@gmail.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, b.zolnierkie@samsung.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alistair Francis <alistair@alistair23.me>,
        Sam Ravnborg <sam@ravnborg.org>
References: <CAKmqyKMLyx+CvBQbLz-xQvwLS692tx-4xOgU7b-V2J676D29yg@mail.gmail.com>
 <d983217b-e117-361c-0306-b131695bb93f@denx.de>
 <CAKmqyKOsUcta1cXxamJZnf01G9beCZrDKia068HR+J0AadgNiA@mail.gmail.com>
From:   Marek Vasut <marex@denx.de>
Message-ID: <bff9ba97-bc26-f091-ba71-5e639af524d4@denx.de>
Date:   Mon, 16 Aug 2021 09:55:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAKmqyKOsUcta1cXxamJZnf01G9beCZrDKia068HR+J0AadgNiA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/21 9:34 AM, Alistair Francis wrote:
> On Sun, Aug 15, 2021 at 10:31 PM Marek Vasut <marex@denx.de> wrote:
>>
>> On 8/15/21 2:16 PM, Alistair Francis wrote:
>>> Hello,
>>>
>>> Commit f225f1393f034 "video: fbdev: mxsfb: Remove driver" removed the
>>> mxsfb fbdev driver.
>>>
>>> I am now working on getting mainline Linux running on the reMarkable 2
>>> eInk reader [1]. Unfortunately the rM2 doesn't use the standard EPD
>>> controller on the i.MX SoC, but instead uses the LCD controller.
>>>
>>> eInk panels are complex to control and require writing temperature
>>> dependent waveforms. As these waveforms are proprietary [2] the rM
>>> team runs closed source software called SWTCON in userspace to control
>>> the panel [3].
>>>
>>> This closed source software expects the fbdev mxsfb driver and it
>>> doesn't work with the DRM mxsfb driver (at least not that I can get it
>>> to).
>>>
>>> The NXP fork of Linux also re-adds the fbdev driver [4], so they also
>>> see some uses for it.
>>>
>>> I was wondering if the community would be open to re-adding the fbdev
>>> mxsfb driver to mainline? It could be re-added with a different
>>> dt-binding so that it is not used by default and only enabled for
>>> boards when required (like for the rM2).
>>>
>>> 1: https://remarkable.com/store/remarkable-2
>>> 2: https://goodereader.com/blog/e-paper/e-ink-waveforms-are-a-closely-guarded-secret
>>> 3: https://remarkablewiki.com/tech/rm2_framebuffer
>>> 4: https://source.codeaurora.org/external/imx/linux-imx/log/drivers/video/fbdev/mxsfb.c?h=lf-5.10.35-2.0.0
>>
>> +CC Sam.
>>
>> What sort of special thing does your proprietary userspace do that
>> cannot be added to the DRM driver or the fbdev emulation (if needed) ?
> 
> It's hard to tell. When using the DRM driver I get cryptic errors
> about the frame buffer not being available.

Do you have fbdev emulation enabled ? Does /dev/fbX exist ?

What sort of messages do you get and from where ?

You could run strace on the application to see how it communicates with 
the old driver via the ioctl interface and compare it with the fbdev 
emulation on the new driver, maybe there is some odd ioctl which is not 
emulated.

There is also NXP 5.10.35 fork, so you could try picking the fbdev 
driver from there and add printks/trace_printks/etc. into both that and 
the fbdev emulation code, to see whether how either is called and what 
is failing/missing in the emulation.

> It's difficult to know
> what is going on as I don't have access to any of the source. I
> suspect the userspace code could be updated to use the DRM driver, but
> we would need the reMarkable devs to do that.
> 
> There is some effort to re-implement the proprietary user space swtcon
> (https://github.com/timower/rM2-stuff#swtcon), but it seems to have
> stalled. It wouldn't be impossible to get swtcon to work with the DRM
> driver, but it would require a very large amount of reverse
> engineering, that probably will never happen.
> 
> I wanted to see what the thoughts were on re-adding the fbdev mxsfb
> driver. The commit message just says that because there is a DRM
> driver we no longer need the fbdev one, but here is a case for the
> fbdev driver. I was thinking that continuing to support the fbdev
> mxsfb driver wouldn't be too much of a maintenance burden (but that's
> obviously up to you). The NXP tree also seems to think the fbdev
> driver is worth keeping around.

I don't think the NXP tree is a particularly good example of best 
practice, they don't use the mxsfb in the first place, they wrote their 
own DRM driver for the LCDIF IP, and they also keep the fbdev driver 
around, so yes, they have three drivers for the same IP in different 
state of decay and with different problems, instead of one driver that 
has all the functionality and fixes. Sigh ...

I cannot decide on the fbdev thing, that's I think up to Sam. However, 
my suggestion would be to find out what is missing in the fbdev 
emulation and possibly fill that in, so we will have only one driver to 
support all the functionality.
