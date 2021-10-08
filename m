Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D00442715D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 21:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbhJHTXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 15:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbhJHTXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 15:23:46 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2D1C061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 12:21:50 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id s15so32825917wrv.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 12:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=forissier-org.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G5MXHL3RVxoVQVhCir7zA7PPA7xLL8Bs78TVa7I6ECg=;
        b=3M5DM7GuLTq65/4rdqUXQ4Mh553R+gh6NCcOajc6PSseSXXMJWxm525x+HzaqcKE1E
         Mhn1NDvRdMo1HfA2+KqUR8c1wA255/GB24+Ybhl5hl1naHUghSOSyMZ2qAKneaffPS5s
         xjOKhwiy594mA+UUx4fcihp7S26Pi57NnOTd/qnRTzvvHdcxlrw5CvyikpAYYqrwjp2L
         55gnkm6QY3wLagWqwnEMP4VQHsNRFV+6CWC8dyPi+UM4iYF+PS3GX8g1gol6Zy/MxKnu
         1QYj/nFlGrO9YmFVDYrwK/JvTEzwPz3J1drUOgX5dl+87Z/wNLspxiBBba+6yLBeolU1
         hWGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G5MXHL3RVxoVQVhCir7zA7PPA7xLL8Bs78TVa7I6ECg=;
        b=p3hYl8FjRTyX3B/U42zP5abVajMPFXbtN0c55kyazBS6gpytsZ8joajGLHatyfAtLQ
         IZxlNHPe89GYcbvlDhwUjGTKWYKo9DhFjpNcPj5iKsn8GDhAWQZ93gFu91xXI6k5WtdD
         xVg5EVlY/5y8Sza9qYkdcYXKD0YTGwAnTpmj+61Bb/j50MR30Dk67u6o0Wzn2OUazH23
         ZoWBzcxxSPmSQMGx3qVUdGMcWortEhjnOCuLUu7uaiDGrtSQJzSkp9D7fhajvSq7J657
         /zY9/zFYkdCgRIXo90J7K4oO8djP/AZkm8xML5IhYJXTTdL03qsEHiKCsdHSwVMseRtP
         doLA==
X-Gm-Message-State: AOAM532djXRC9bDRDo+b536ID8F4Q8Pdl2rYOpT2n4tbTQ7m/ezCooDt
        lyS6JIMcyCSglkl1mmFNBzKSIg==
X-Google-Smtp-Source: ABdhPJxOKpj9j2pUB9abtT1MZchONytdzTG/Nhp80ROIe6hQEcFYAMkHzH1akLXMPukqOvui/KzjZQ==
X-Received: by 2002:a05:600c:3504:: with SMTP id h4mr1122400wmq.123.1633720908418;
        Fri, 08 Oct 2021 12:21:48 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:3cb:7bb0:2004:21db:309b:6f18? ([2a01:e0a:3cb:7bb0:2004:21db:309b:6f18])
        by smtp.gmail.com with ESMTPSA id o6sm292622wri.49.2021.10.08.12.21.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Oct 2021 12:21:48 -0700 (PDT)
Subject: Re: [PATCH v6 5/5] optee: add FF-A support
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org,
        Sumit Garg <sumit.garg@linaro.org>,
        Marc Bonnici <marc.bonnici@arm.com>, sughosh.ganu@linaro.org
References: <20211006070902.2531311-1-jens.wiklander@linaro.org>
 <20211006070902.2531311-6-jens.wiklander@linaro.org>
 <20211008132732.hbmkd3hftdydtrsc@bogus>
 <20211008163200.wgls7gijpsk556kl@bogus>
From:   Jerome Forissier <jerome@forissier.org>
Message-ID: <94277064-eff7-cd63-b5cb-d6b53e408e81@forissier.org>
Date:   Fri, 8 Oct 2021 21:21:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211008163200.wgls7gijpsk556kl@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

On 10/8/21 6:32 PM, Sudeep Holla wrote:
> On Fri, Oct 08, 2021 at 02:27:32PM +0100, Sudeep Holla wrote:
>> On Wed, Oct 06, 2021 at 09:09:02AM +0200, Jens Wiklander wrote:
>>> Adds support for using FF-A [1] as transport to the OP-TEE driver.
>>>
>>> Introduces struct optee_msg_param_fmem which carries all information
>>> needed when OP-TEE is calling FFA_MEM_RETRIEVE_REQ to get the shared
>>> memory reference mapped by the hypervisor in S-EL2. Register usage is
>>> also updated to include the information needed.
>>>
>>> The FF-A part of this driver is enabled if CONFIG_ARM_FFA_TRANSPORT is
>>> enabled.
>>>
>>
>> I am not sure if I missed this with earlier version but I see the below
>> warning the second time I insert the optee module. I am sure I tested it
>> with previous version when I was fixing issues with FF-A as a module.
>>
>> Not sure if I am missing something in my steps.
>>
> 
> OK, more info, indeed I didn't observe this issue 2 weeks back with optee
> at commit 57e642f12085 ("core: enable system PTA upon user TA support").
> The UUID(d96a5b40-c3e5-21e3-8794-1002a5d5c61b) wasn't enumerated with above
> commit. Today I am testing the latest commit 2de2880065f3 ("core: update
> reference link to PrimeCell Cache Controller").
> 
> Though it looks like an issue with the driver, the latest optee changes
> triggered the driver to hit this issue in my setup. Hope this helps.

Totally makes sense. The optee_os commit triggering this is almost
certainly 811c42d40cd0 ("plat-vexpress: enable CFG_ENABLE_EMBEDDED_TESTS
by default"). With this commit, the "invoke tests" PTA gets included by
default in the TEE binary. This PTA has the TA_FLAG_DEVICE_ENUM flag so
it is enumerated by the Linux driver. AFAICT the vexpress platform has
no other PTA with that flag, so as you said the OP-TEE commit is simply
 exposing a bug in the Linux driver.

> IIUC we are not undoing optee_register_device executed via
> optee_enumerate_devices in the exit path.

That doesn't sound good indeed ;)

-- 
Jerome
