Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D130331844
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 21:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbhCHUNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 15:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbhCHUMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 15:12:46 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6BCC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 12:12:45 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id jt13so22983121ejb.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 12:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=/W4otkmmjwcr/fDPTjV2MzMqweHNYI9SQRwwtT6wDVc=;
        b=UaP8Yjn41znjF/ge9BA49yawCJaal6NgtQjQPA52V4/2Yh5nXawOiI3EqYCqHTCV04
         YGY9hnEM0A+BPJBlKG/hE2SncTDlauMKxDomCTGVMt1HAOsGE6f7KFn+LKri6h/vW7tx
         Pf5LZ57yxjwvIIbcWs/CuI2R3WvYtMj1jrC8B7xsI9lqvn2fxwnNwqo4JUxLy/8o6CaR
         NaO/yqdjVRwEhn2S+Vo6ZNBrbO7zZn1eM3mheIRoWSlmvUuZlr6y7tTyVAZfMryBwkkX
         1JzNgIt25PkIteY2sxLMFLu7cfUS8Lidu1zEJBLIU9sL+ov+jNYZpuFI80SJxiJD+Vqh
         CUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/W4otkmmjwcr/fDPTjV2MzMqweHNYI9SQRwwtT6wDVc=;
        b=JfOCVhf+xp0sbtCB5JRaSomwwiY0gYEAMknrd7M6MtRx1yZrNeZwkGFzdRVc+aopuX
         qnVYjCxjTJTjOPBUf6mF2wHVCGlYAjPXDz2NjCpVarc/yWzrM+jMrmF8BxiT2dEPfJ8+
         2+itPtJmUC6F2+auHXZMpxwfuLHxFz/SUDV7aY+9YAjrfz/swd1S7pCgkTKE5JnGWcpb
         T+BPMRoOE/SCFuq5j8WTXiU0BmTcE7rb4T5PFHrpbG6QxXV4CsT8GWz3xBqKGY4oBQmQ
         yRcOwsSYpEuw205sFxz20jW3WQlTwOyW9G6nUfkX2BdQPrvDgCZGhLNloq1Q+spr48Y1
         HJzg==
X-Gm-Message-State: AOAM530Bv3n0iPHfwlBNA4h5ot4fAi+1ITrEaFRe03g4zS1uuR81EG3h
        vn/7kbUWWCnoDJKTOEe4U0o=
X-Google-Smtp-Source: ABdhPJwfchN8hYHdQjUxA+RM+VV1rd5tt90jMxASWsGgdOMaCpDzs9dlA8KRQRBWgXjsgH3HODwV1Q==
X-Received: by 2002:a17:906:1d44:: with SMTP id o4mr15626192ejh.130.1615234364672;
        Mon, 08 Mar 2021 12:12:44 -0800 (PST)
Received: from ?IPv6:2a01:c23:6c03:dc00:772e:c5dc:d360:4620? (dynamic-2a01-0c23-6c03-dc00-772e-c5dc-d360-4620.c23.pool.telefonica.de. [2a01:c23:6c03:dc00:772e:c5dc:d360:4620])
        by smtp.gmail.com with ESMTPSA id t15sm8264111edc.34.2021.03.08.12.12.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Mar 2021 12:12:44 -0800 (PST)
Subject: Re: [PATCH] drm/amdkfd: fix build error with missing AMD_IOMMU_V2
To:     Felix Kuehling <felix.kuehling@amd.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Philip Yang <philip.yang@amd.com>, David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20210308153359.2513446-1-arnd@kernel.org>
 <176cae4d-33bc-1d51-a7d7-58eeeea5180e@amd.com>
 <CAK8P3a0nUKSJ2+knM6+REp8HXRFbz5-DmNRAusezkT+XzZQa7Q@mail.gmail.com>
 <92a6c999-c20a-2311-4e31-209a2d9229ed@amd.com>
 <CAK8P3a1SRubvaPzn2020Nc_SsL8xBW7ODGOGtF_4UYASGqTq-w@mail.gmail.com>
 <f2829f2e-6498-53d4-93fa-1613e988803f@amd.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <71d1bd79-881c-062c-0b41-4be0cdf3c4d5@gmail.com>
Date:   Mon, 8 Mar 2021 21:12:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <f2829f2e-6498-53d4-93fa-1613e988803f@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 08.03.21 um 21:02 schrieb Felix Kuehling:
> Am 2021-03-08 um 2:33 p.m. schrieb Arnd Bergmann:
>> On Mon, Mar 8, 2021 at 8:11 PM Felix Kuehling <felix.kuehling@amd.com> wrote:
>>> Am 2021-03-08 um 2:05 p.m. schrieb Arnd Bergmann:
>>>> On Mon, Mar 8, 2021 at 5:24 PM Felix Kuehling <felix.kuehling@amd.com> wrote:
>>>>> The driver build should work without IOMMUv2. In amdkfd/Makefile, we
>>>>> have this condition:
>>>>>
>>>>> ifneq ($(CONFIG_AMD_IOMMU_V2),)
>>>>> AMDKFD_FILES += $(AMDKFD_PATH)/kfd_iommu.o
>>>>> endif
>>>>>
>>>>> In amdkfd/kfd_iommu.h we define inline stubs of the functions that are
>>>>> causing your link-failures if IOMMU_V2 is not enabled:
>>>>>
>>>>> #if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
>>>>> ... function declarations ...
>>>>> #else
>>>>> ... stubs ...
>>>>> #endif
>>>> Right, that is the problem I tried to explain in my patch description.
>>>>
>>>> Should we just drop the 'imply' then and add a proper dependency like this?
>>>>
>>>>        depends on DRM_AMDGPU && (X86_64 || ARM64 || PPC64)
>>>>        depends on AMD_IOMMU_V2=y || DRM_AMDGPU=m
>>>>
>>>> I can send a v2 after some testing if you prefer this version.
>>> No. My point is, there should not be a hard dependency. The build should
>>> work without CONFIG_AMD_IOMMU_V2. I don't understand why it's not
>>> working for you. It looks like you're building kfd_iommu.o, which should
>>> not be happening when AMD_IOMMU_V2 is not enabled. The condition in
>>> amdkfd/Makefile should make sure that kfd_iommu.o doesn't get built with
>>> your kernel config.
>> Again, as I explained in the changelog text, AMD_IOMMU_V2 configured as
>> a loadable module, while AMDGPU is configured as built-in.
> I'm sorry, I didn't read it carefully. And I thought "imply" was meant
> to fix exactly this kind of issue.
>
> I don't want to create a hard dependency on AMD_IOMMU_V2 if I can avoid
> it, because it is only really needed for a small number of AMD APUs, and
> even there it is now optional for more recent ones.
>
> Is there a better way to avoid build failures without creating a hard
> dependency?

What you need is the same trick we used for AGP on radeon/nouveau:

depends on AMD_IOMMU_V2 || !AMD_IOMMU_V2

This way when AMD_IOMMU_V2 is build as a module DRM_AMDGPU will be build 
as a module as well. When it is disabled completely we don't care.

Regards,
Christian.

>    The documentation in
> Documentation/kbuild/kconfig-language.rst suggests using if
> (IS_REACHABLE(CONFIG_AMD_IOMMU_V2)) to guard those problematic function
> calls. I think more generally, we could guard all of kfd_iommu.c with
>
>      #if IS_REACHABLE(CONFIG_AMD_IOMMU_V2)
>
> And use the same condition to define the stubs in kfd_iommu.h.
>
> Regards,
>    Felix
>
>
>> The causes a link failure for the vmlinux file, because the linker cannot
>> resolve addresses of loadable modules at compile time -- they have
>> not been loaded yet.
>>
>>        Arnd
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

