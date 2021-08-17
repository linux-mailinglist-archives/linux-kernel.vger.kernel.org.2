Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 454EE3EEA81
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 12:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236176AbhHQKFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 06:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239287AbhHQKEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 06:04:32 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BEAC061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 03:03:51 -0700 (PDT)
Received: from [IPv6:::1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id A78F580C87;
        Tue, 17 Aug 2021 12:03:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1629194628;
        bh=m4wfMZxqNNmxFWB9gjExRoiafVD/AFM3ZmrLihzAB3A=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UrNjRkMy352lv0le8KG5+J5uH+rnkUS4U67gU55mmpjMfhFBUX6eg6l6+CkDutxbE
         pV2WdKIoxIDLmiGLGpvzAI2tlzPjk73dBB+ztx16bmO1Yxq3eEJNizNDbzXjPCpetf
         +E5/fy/Q8GVw6RFrng2r2rWDCuRha0oLwbz1FlmROdrsmVIZxoaXywkzYDX4jhcLMx
         d8usbPJEQ+PsYd/5TFH2ShtOI5r6PmyCQI9GRPghSPW2yFxM/w+ZnHUG3MyK06bkaj
         b+J3n1YrICTRJScbYMwa86/HnMf1hPQ9+c9G3zQ+Rs+LtPXpPJ8iTB1278CvumNMAI
         npfBJPhPijZqA==
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
 <bff9ba97-bc26-f091-ba71-5e639af524d4@denx.de>
 <CAKmqyKPF3T_Sx+hL=4OSamLdjy=0fwmrTrVeb-GY0Ja9M=mi+Q@mail.gmail.com>
From:   Marek Vasut <marex@denx.de>
Message-ID: <ab2b7f4f-3e36-461c-6a6c-02ee7ed6cb99@denx.de>
Date:   Tue, 17 Aug 2021 12:03:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAKmqyKPF3T_Sx+hL=4OSamLdjy=0fwmrTrVeb-GY0Ja9M=mi+Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/21 11:08 AM, Alistair Francis wrote:
> On Mon, Aug 16, 2021 at 5:55 PM Marek Vasut <marex@denx.de> wrote:
>>
>> On 8/16/21 9:34 AM, Alistair Francis wrote:
>>> On Sun, Aug 15, 2021 at 10:31 PM Marek Vasut <marex@denx.de> wrote:
>>>>
>>>> On 8/15/21 2:16 PM, Alistair Francis wrote:
>>>>> Hello,
>>>>>
>>>>> Commit f225f1393f034 "video: fbdev: mxsfb: Remove driver" removed the
>>>>> mxsfb fbdev driver.
>>>>>
>>>>> I am now working on getting mainline Linux running on the reMarkable 2
>>>>> eInk reader [1]. Unfortunately the rM2 doesn't use the standard EPD
>>>>> controller on the i.MX SoC, but instead uses the LCD controller.
>>>>>
>>>>> eInk panels are complex to control and require writing temperature
>>>>> dependent waveforms. As these waveforms are proprietary [2] the rM
>>>>> team runs closed source software called SWTCON in userspace to control
>>>>> the panel [3].
>>>>>
>>>>> This closed source software expects the fbdev mxsfb driver and it
>>>>> doesn't work with the DRM mxsfb driver (at least not that I can get it
>>>>> to).
>>>>>
>>>>> The NXP fork of Linux also re-adds the fbdev driver [4], so they also
>>>>> see some uses for it.
>>>>>
>>>>> I was wondering if the community would be open to re-adding the fbdev
>>>>> mxsfb driver to mainline? It could be re-added with a different
>>>>> dt-binding so that it is not used by default and only enabled for
>>>>> boards when required (like for the rM2).
>>>>>
>>>>> 1: https://remarkable.com/store/remarkable-2
>>>>> 2: https://goodereader.com/blog/e-paper/e-ink-waveforms-are-a-closely-guarded-secret
>>>>> 3: https://remarkablewiki.com/tech/rm2_framebuffer
>>>>> 4: https://source.codeaurora.org/external/imx/linux-imx/log/drivers/video/fbdev/mxsfb.c?h=lf-5.10.35-2.0.0
>>>>
>>>> +CC Sam.
>>>>
>>>> What sort of special thing does your proprietary userspace do that
>>>> cannot be added to the DRM driver or the fbdev emulation (if needed) ?
>>>
>>> It's hard to tell. When using the DRM driver I get cryptic errors
>>> about the frame buffer not being available.
>>
>> Do you have fbdev emulation enabled ? Does /dev/fbX exist ?
> 
> I do and /dev/fb0 exists
> 
>>
>> What sort of messages do you get and from where ?
> 
> This is the error I get:
> 
> xochitl[252]: Error writing variable information: Invalid argument...

Some ioctl returns -EINVAL maybe ? strace would tell you.

> xochitl is the proprietary userspace code. I don't really have a good
> idea of what that error would mean.
> 
> I also see this:
> 
> Framebuffer has wrong id: "mxcfb"

Are you sure you're not confusing mxcfb (The freescale imx scanout 
engine) with mxsfb (The originally sgtl block, bought by freescale) ?

>> You could run strace on the application to see how it communicates with
>> the old driver via the ioctl interface and compare it with the fbdev
>> emulation on the new driver, maybe there is some odd ioctl which is not
>> emulated.
> 
> I had a quick look at this.
> 
> xochitl does a lot more than just controls the display, it interacts
> with lots of other hardware and strace produces a lot of logs. I also
> don't see the error when manually starting it, only at boot (but it
> still doesn't work).
> 
> A quick run with
> 
> strace -f xochitcl
> 
> and I don't even see an access to /dev/fb0, so I'm not sure where the
> accesses are coming from.

You can try writing the output of strace to file (strace -o) for easier 
analysis. Then grep for either access to /dev/fb0 (or any symlink to it 
which might exist), or search for the mxcfb string, maybe the 
application aborts even before opening the fbdev due to some other problem.
