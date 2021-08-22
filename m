Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7219A3F41B8
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 23:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbhHVVZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 17:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbhHVVZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 17:25:21 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09CEC061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 14:24:39 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id g135so8080wme.5
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 14:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=2ehVnFN8NmhfsM13jcyhzZcdVCILCdcqL2zE2BLby+4=;
        b=TfRlO1DJOfYQvuQic8en7fjDDFRu/yfM6V+MYGWYhO4GtghD64sNplb+3XEjoq1qDE
         oyin8fK5eiVOtw/zCdQ3fcoWY6HAJtaM3CsDtPnIVftjT14udbd5/j+6pxMFerwKCxBH
         8ptGAqEAbYLmuZWaO3Y1g61tuw/n9lfW8vKw7irDUAad8ro1cY7lrdDq+dRS8AUI+Ypu
         /AOpn+yUleWzbbC4dtJZpjjNALI5V/h7duGyOL0cOTVPPyeYMplEK+hQ3gmCCpAUCU/k
         IRMZM1OCcsLMGS2sfjVuMYNZd7AEFOaek9J6kxsbC4UsJ3ue2L1RJPm2ejOm+vqUHHp7
         nN0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2ehVnFN8NmhfsM13jcyhzZcdVCILCdcqL2zE2BLby+4=;
        b=uZpE5DUUwhmshRvV9d7H0MagN4cv2qglFd459NAm31c4ZZ/BQeTzNGdE2hkIIgah9C
         PZlNAguqkesnz04AhWSKYpA4s7XY7cucyFpuyuhgBI7Ft0CNrogJyMxMgEWu8sIo4qO3
         eyeNqQSrhNMyfkLbCNBHzEzFos4kc3tYDRhyLaKNaHzWhOBWJEnchqvwBA5++mZjp1I9
         Kkl5f5NvEdOptBR4ji+0iEmotL2K9smDshSYrngjA2sYlB06TSJKrq+bMOE72QUtxSiv
         FmL1RpD++/PpqCCj3niYo/ZFyE/9HfdDdjRIWHS5v+aruBD2V7OjKnNUL1MRACGhX0zX
         xDDA==
X-Gm-Message-State: AOAM531c/DKAJeIAJ8j309HgleB7XhHx/BFjVTxngJ8ZK3uPDa7CHUL3
        AITSDBaUkDnRaL9EGpU3ZOIGDsh2v5o5
X-Google-Smtp-Source: ABdhPJyi0DORS3LiULyroKt9yKZPorwQYLifuD0ZhgyKQQQX/rbTCZXvaCjcjn74TRaKJykPWdl9mg==
X-Received: by 2002:a1c:4e17:: with SMTP id g23mr12977142wmh.80.1629667478199;
        Sun, 22 Aug 2021 14:24:38 -0700 (PDT)
Received: from ?IPv6:2a02:810b:f40:4200:f3bc:8bd1:bbc3:e753? ([2a02:810b:f40:4200:f3bc:8bd1:bbc3:e753])
        by smtp.gmail.com with ESMTPSA id q17sm12771705wrr.91.2021.08.22.14.24.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Aug 2021 14:24:37 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: rockchip: Re-add interrupt-names for RK3399's
 vpu
To:     Heiko Stuebner <heiko@sntech.de>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     Rob Herring <robh+dt@kernel.org>, Johan Jonker <jbx6244@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210822115755.3171937-1-knaerzche@gmail.com>
 <CAAEAJfDLvctAk3omLgFBBbzvufFKwSW5_cQZ+MjvyN4khGOe_w@mail.gmail.com>
 <24767661.6Emhk5qWAg@phil>
From:   Alex Bee <knaerzche@gmail.com>
Message-ID: <62e8d794-4125-68da-186e-80465179f506@gmail.com>
Date:   Sun, 22 Aug 2021 23:24:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <24767661.6Emhk5qWAg@phil>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko, Hi Ezequiel,

Am 22.08.21 um 22:25 schrieb Heiko Stuebner:
> Hi,
>
> Am Sonntag, 22. August 2021, 16:37:24 CEST schrieb Ezequiel Garcia:
>> Hi Alex, Heiko,
>>
>> On Sun, 22 Aug 2021 at 08:58, Alex Bee <knaerzche@gmail.com> wrote:
>>> Commit a728c10dd62a ("arm64: dts: rockchip: remove interrupt-names from iommu nodes")
>>> intended to remove the interrupt-names property for mmu nodes, but it
>>> also removed it for the vpu node in rk3399.dtsi. That makes the driver
>>> fail probing currently.
>>> Fix this by re-adding the property for this node.
>>>
>>> Fixes: a728c10dd62a ("arm64: dts: rockchip: remove interrupt-names from iommu nodes")
>> AFAICS a728c10dd62a removed lots of interrupt-names properties
>> from devices other than IOMMU.
>>
>> Maybe it's best to revert it?
> where did you see more mistakes in it?
Yes, all the other removals in that commit are for iommu nodes.
>
> I.e. first of all, at least when grepping through my kernel history, I only see
>    commit 53a05c8f6e8e ("arm64: dts: rockchip: remove interrupt-names from iommu nodes")

Oops, yes: I took the commit id of my local tree: could you please fix 
the commit message with the correct id, before applying?

Thanks,

Alex

> with a different hash and at least there I see a lot of iommu interrupt removals
> and this one line removing the vpu irqs in error.
>
> So from my glance at it, applying Alex' patch should solve the issue?
>
> Heiko
>
>
