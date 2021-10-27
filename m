Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 514A043D659
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 00:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhJ0WPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 18:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhJ0WO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 18:14:59 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5E7C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 15:12:33 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id v1-20020a17090a088100b001a21156830bso6318713pjc.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 15:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=cHz5jop8T/lwVeHdgU4OLjqSsNE5NE66qnh2txZDW1Y=;
        b=nFVIZLP0EQ3/SLtcTkWFJP/CMOKtd/bG2t0y5hTrVxVnkcUEZunvqlmXPus15pq7Hp
         I6V/DM6OHjwldspqlh8sMcYjIUnbUiuj/q7DWUJKD0XuswSjNakf8d19SkWKKk4qIG93
         akQXrNqm22rLwNa1kh8qj/cLcuPWsZ81kXsG12O6I8fwxhlMM4VhyXTt+aXg6AgfulZL
         gVj3zKNcWvEIYpKEIib1AbGFfghUj8lIMmVh5HZAKPrI9bsQ47Z8ukOxiL+LXLzRnBZr
         TEgQvFkhkBxDBoRFCf4ZjwSULXMM3r1hFfxbhzQ2IbZOC1dPTr54a6FaSJJ7OZGpIbmm
         cn7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=cHz5jop8T/lwVeHdgU4OLjqSsNE5NE66qnh2txZDW1Y=;
        b=MokAoHgwSlJXkEOZ/IyhiKs3rJYcIw21ot/ngLgur+wvT1MM0Vz7AP5X2b2arWO2+2
         CdF+RPkVrZ2WnlwhdzQlU1iwpGYtefdbgtAoFrAprMfGSs1hyKpBIM8sB2kGTVtPFoyf
         NUFoywHAW+h1AciY6zqRoVf3vy37iQYGE6KjJU3SovUaJ1/d+PJn3iZG4vRc0HGkG0iZ
         7sKf/3UNPkIwELkt8ZgV7pECqRYjgRdvCmocBx0Kh2kD5DcFy/IFapjDq4T3BeaTlSpl
         peE3xXix8yySdRIiAKbe/QtvemFMnJ57eQtyBo1Jlg2e6RVh53vKvAZgTTk3O7StKm0D
         w3hg==
X-Gm-Message-State: AOAM530lAcY0VnpatGvBa39/NIO/hlLtx6IY7lpi3CgtnhIyvb9mppE7
        eRzCxDJaSoiVczU+jpmbaKjLgQ==
X-Google-Smtp-Source: ABdhPJxd0TAmzkhB0bYq38wxLqY1jwO2hPoqQZhNmADDa6ISOp0edfYUas+ijiAcy3CeCojKor1IPA==
X-Received: by 2002:a17:90a:e7d0:: with SMTP id kb16mr378209pjb.9.1635372753231;
        Wed, 27 Oct 2021 15:12:33 -0700 (PDT)
Received: from localhost ([2620:0:1000:5e10:d96b:421d:2a73:9190])
        by smtp.gmail.com with ESMTPSA id d15sm1026200pfu.12.2021.10.27.15.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 15:12:32 -0700 (PDT)
Date:   Wed, 27 Oct 2021 15:12:32 -0700 (PDT)
X-Google-Original-Date: Wed, 27 Oct 2021 14:58:57 PDT (-0700)
Subject:     Re: [PATCH 1/1] riscv: defconfig: enable DRM_NOUVEAU
In-Reply-To: <a4f8fad0-4ae4-5a7e-1691-ae46abd061fa@canonical.com>
CC:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Anup Patel <Anup.Patel@wdc.com>,
        axboe@kernel.dk, sagar.kadam@sifive.com,
        Atish Patra <Atish.Patra@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     heinrich.schuchardt@canonical.com
Message-ID: <mhng-ecb4debb-aa09-4102-bbf4-0223eff391d7@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2021 00:31:54 PDT (-0700), heinrich.schuchardt@canonical.com wrote:
> On 10/27/21 04:31, Damien Le Moal wrote:
>> On 2021/10/27 8:58, Palmer Dabbelt wrote:
>>> On Tue, 12 Oct 2021 09:46:58 PDT (-0700), heinrich.schuchardt@canonical.com wrote:
>>>> Both RADEON and NOUVEAU graphics cards are supported on RISC-V. Enabling
>>>> the one and not the other does not make sense.
>>>>
>>>> As typically at most one of RADEON, NOUVEAU, or VIRTIO GPU support will be
>>>> needed DRM drivers should be compiled as modules.
>>>
>>> Do you have an nVidia card that works on real hardware?  Last I checked
>>> was a while ago, but they weren't working at the time (IIRC it was
>>> something to do with PCIe addressing, but it was a hardware limitation
>>> so I don't remember exactly how it all fits together).
>>>
>>> If they work then I'm happy to flip them on.
>
> My SiFive Unmatched is running KDE on a GT710.
>
> It would be unfair to treat the two major GPU vendors AMD and Nvidia
> differently.
>
>>
>> Why enable this at all ? If they do not work, then disabling theses cards make
>> sense. But if they do work, isn't leaving the config to be the default defined
>> by the driver the preferred approach ? Otherwise, we will eventually end-up with
>> a defconfig that has everything enabled...
>
> If you want to get your system up, having keyboard input and GPU output
> is the bare minimum that you need to proceed unless you are a developer
> working over UART and have a second system available.
>
> To keep the kernel small DRM drivers should be modules.

I can buy the argument for not having any of this in arch defconfigs, 
but in practice there's a lot of stuff in defconfigs that I don't really 
think should be arch decisions (ext4, for example).  If we've got AMD in 
there and the nVidia cards work then I don't see any reason to 
differentiate between the two, so let's just do the same thing for both.

This is on for-next.

>
> Best regards
>
> Heinrich
>
>>
>>>
>>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>>> ---
>>>>   arch/riscv/configs/defconfig | 7 ++++---
>>>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
>>>> index 4ebc80315f01..c252fd5706d2 100644
>>>> --- a/arch/riscv/configs/defconfig
>>>> +++ b/arch/riscv/configs/defconfig
>>>> @@ -72,9 +72,10 @@ CONFIG_GPIOLIB=y
>>>>   CONFIG_GPIO_SIFIVE=y
>>>>   # CONFIG_PTP_1588_CLOCK is not set
>>>>   CONFIG_POWER_RESET=y
>>>> -CONFIG_DRM=y
>>>> -CONFIG_DRM_RADEON=y
>>>> -CONFIG_DRM_VIRTIO_GPU=y
>>>> +CONFIG_DRM=m
>>>> +CONFIG_DRM_RADEON=m
>>>> +CONFIG_DRM_NOUVEAU=m
>>>> +CONFIG_DRM_VIRTIO_GPU=m
>>>>   CONFIG_FRAMEBUFFER_CONSOLE=y
>>>>   CONFIG_USB=y
>>>>   CONFIG_USB_XHCI_HCD=y
>>>
>>> _______________________________________________
>>> linux-riscv mailing list
>>> linux-riscv@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>>>
>>
>>
