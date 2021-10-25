Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABC504394B5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 13:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbhJYL0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 07:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbhJYL0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 07:26:02 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872A2C061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 04:23:40 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id m22so8888687wrb.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 04:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=pnAOfuMn5EWMJj8YVjvNcYDnPGOu1OrWcdPGU69i9WU=;
        b=dcLz/4fMoOzmVl2D+aaGjBKG2ULuC3/o64EkVkImWK67kW3V4mwvpKWoMWuTA7VaYw
         Bg+hj+NxCwOr87qPewiOOkZ0VT4MMcDzpEBDNYRGPXT0GRgINVje/dOiUaQlZSIhXbtE
         FbflKlBYNaekSlStrbDOZJil1+qZvf4BsNbTIaLOJXTgsf0yoON4Mh0U3MOOphN53OpI
         3PAPBIlNXzNcF6AV6XmkshR4Hd36eQrglS4qF+PCBDRZ+w2QwVNm/F5NFro4zyolq+hQ
         8bgafTrKHxRz3FLrauXnlc+TgF4X/GNFaj6lfg7d3xqm4y1l7VFGBukPzqk2a+gFEDEU
         NuRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=pnAOfuMn5EWMJj8YVjvNcYDnPGOu1OrWcdPGU69i9WU=;
        b=hOsqY3l5Xj313NsntWu5SlUkOIeeh3abVtrQxJf9tzaBFmN966bPyem3Q+2tRy+ZSB
         kj/JKotohOET73IjT1Dl3uIQeK/LMlpE0b8uy+IrXftPTpF/kicKwGCPqeQSQqanr/GY
         PtxKmsVVD6vh3fXElxvQM6WkF1Wl/DzpoI7HuJo7TuYwgAnlC28v8BssZQSK2Mdw1Mbb
         XeyeIavXdgT+SSrQLmTeOVC8FglLJQ0WsLqReBhRyE+6V+h6hqjK566nwocQqwvxz2Fp
         aueblKZl7tJ5eHOpDUGfXmGyjAyyhw1FfVmagRSYQZCKYBoVdqLdLlVAfo75HfSRxz3z
         dWyg==
X-Gm-Message-State: AOAM532RMZof+kojlyRh/5Sm8+Js7RgowN8ubvGz2Xz2JWOa7Pyu6JVY
        Z2g+X7Q1FIkObb8PAlw17Lk=
X-Google-Smtp-Source: ABdhPJx0t3+Pcy8GZqhqvya20QCKopu7PsZvwn6w0Fdd4q31S3HmDFYbbvzQoRHLvC2Af/Pma2lIXA==
X-Received: by 2002:a5d:62d0:: with SMTP id o16mr22842373wrv.206.1635161019070;
        Mon, 25 Oct 2021 04:23:39 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea1b5.dip0.t-ipconnect.de. [91.14.161.181])
        by smtp.gmail.com with ESMTPSA id j7sm20229073wmq.32.2021.10.25.04.23.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 04:23:38 -0700 (PDT)
Subject: Re: I got an IOMMU IO page fault. What to do now?
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     iommu@lists.linux-foundation.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Xinhui Pan <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        it+linux-iommu@molgen.mpg.de
References: <7a5123b0-6370-59dc-f0c2-8be5b370d9ba@molgen.mpg.de>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <0cfccc44-6cc6-98f5-ecd6-2f376839ec18@gmail.com>
Date:   Mon, 25 Oct 2021 13:23:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <7a5123b0-6370-59dc-f0c2-8be5b370d9ba@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

not sure how the IOMMU gives out addresses, but the printed ones look 
suspicious to me. Something like we are using an invalid address like -1 
or similar.

Can you try that on an up to date kernel as well? E.g. ideally bleeding 
edge amd-staging-drm-next from Alex repository.

Regards,
Christian.

Am 25.10.21 um 12:25 schrieb Paul Menzel:
> Dear Linux folks,
>
>
> On a Dell OptiPlex 5055, Linux 5.10.24 logged the IOMMU messages 
> below. (GPU hang in amdgpu issue #1762 [1] might be related.)
>
>     $ lspci -nn -s 05:00.0
>     05:00.0 VGA compatible controller [0300]: Advanced Micro Devices, 
> Inc. [AMD/ATI] Oland [Radeon HD 8570 / R7 240/340 OEM] [1002:6611] 
> (rev 87)
>     $ dmesg
>     […]
>     [6318399.745242] amdgpu 0000:05:00.0: AMD-Vi: Event logged 
> [IO_PAGE_FAULT domain=0x000c address=0xfffffff0c0 flags=0x0020]
>     [6318399.757283] amdgpu 0000:05:00.0: AMD-Vi: Event logged 
> [IO_PAGE_FAULT domain=0x000c address=0xfffffff7c0 flags=0x0020]
>     [6318399.769154] amdgpu 0000:05:00.0: AMD-Vi: Event logged 
> [IO_PAGE_FAULT domain=0x000c address=0xffffffe0c0 flags=0x0020]
>     [6318399.780913] amdgpu 0000:05:00.0: AMD-Vi: Event logged 
> [IO_PAGE_FAULT domain=0x000c address=0xfffffffec0 flags=0x0020]
>     [6318399.792734] amdgpu 0000:05:00.0: AMD-Vi: Event logged 
> [IO_PAGE_FAULT domain=0x000c address=0xffffffe5c0 flags=0x0020]
>     [6318399.804309] amdgpu 0000:05:00.0: AMD-Vi: Event logged 
> [IO_PAGE_FAULT domain=0x000c address=0xffffffd0c0 flags=0x0020]
>     [6318399.816091] amdgpu 0000:05:00.0: AMD-Vi: Event logged 
> [IO_PAGE_FAULT domain=0x000c address=0xffffffecc0 flags=0x0020]
>     [6318399.827407] amdgpu 0000:05:00.0: AMD-Vi: Event logged 
> [IO_PAGE_FAULT domain=0x000c address=0xffffffd3c0 flags=0x0020]
>     [6318399.838708] amdgpu 0000:05:00.0: AMD-Vi: Event logged 
> [IO_PAGE_FAULT domain=0x000c address=0xffffffc0c0 flags=0x0020]
>     [6318399.850029] amdgpu 0000:05:00.0: AMD-Vi: Event logged 
> [IO_PAGE_FAULT domain=0x000c address=0xffffffdac0 flags=0x0020]
>     [6318399.861311] AMD-Vi: Event logged [IO_PAGE_FAULT 
> device=05:00.0 domain=0x000c address=0xffffffc1c0 flags=0x0020]
>     [6318399.872044] AMD-Vi: Event logged [IO_PAGE_FAULT 
> device=05:00.0 domain=0x000c address=0xffffffc8c0 flags=0x0020]
>     [6318399.882797] AMD-Vi: Event logged [IO_PAGE_FAULT 
> device=05:00.0 domain=0x000c address=0xffffffb0c0 flags=0x0020]
>     [6318399.893655] AMD-Vi: Event logged [IO_PAGE_FAULT 
> device=05:00.0 domain=0x000c address=0xffffffcfc0 flags=0x0020]
>     [6318399.904445] AMD-Vi: Event logged [IO_PAGE_FAULT 
> device=05:00.0 domain=0x000c address=0xffffffb6c0 flags=0x0020]
>     [6318399.915222] AMD-Vi: Event logged [IO_PAGE_FAULT 
> device=05:00.0 domain=0x000c address=0xffffffa0c0 flags=0x0020]
>     [6318399.925931] AMD-Vi: Event logged [IO_PAGE_FAULT 
> device=05:00.0 domain=0x000c address=0xffffffbdc0 flags=0x0020]
>     [6318399.936691] AMD-Vi: Event logged [IO_PAGE_FAULT 
> device=05:00.0 domain=0x000c address=0xffffffa4c0 flags=0x0020]
>     [6318399.947479] AMD-Vi: Event logged [IO_PAGE_FAULT 
> device=05:00.0 domain=0x000c address=0xffffff90c0 flags=0x0020]
>     [6318399.958270] AMD-Vi: Event logged [IO_PAGE_FAULT 
> device=05:00.0 domain=0x000c address=0xffffffabc0 flags=0x0020]
>
> As this is not reproducible, how would debugging go? (The system was 
> rebooted in the meantime.) What options should be enabled, that next 
> time the required information is logged, or what commands should I 
> execute when the system is still in that state, so the bug (driver, 
> userspace, …) can be pinpointed and fixed?
>
>
> Kind regards,
>
> Paul
>
>
> [1]: https://gitlab.freedesktop.org/drm/amd/-/issues/1762
>      "Oland [Radeon HD 8570 / R7 240/340 OEM]: GPU hang"

