Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E70E241EAF2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 12:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352491AbhJAKcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 06:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbhJAKcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 06:32:08 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C1DC06177B
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 03:30:24 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id t8so14757930wri.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 03:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qhH1uVfrvA2WMKNAisYCIIjOhTu11VObwXrq+F6JWoY=;
        b=P6JEFsTFLGREaNWoZ7tQZKnuYYLQggrHSOfLMUJD+RMfmeiVwS9Ov/agP0Bwhvs4jP
         ViHW1kW2zb8smbPMeQaMBQ1TQoHg8u/hWvE6K3zgtj7useUCfQHjxz75xepIWXflXQBu
         D9y8oLc8dFONkCwNM/aEE2TiJM4d2uMWCHv7vfE2tF60mMCSD4AbtV9RhZROJdwSgkgs
         7t7VlA8ReW/F8hCfrxqgMr+n4I45ZzRCvV5bIttS0hxWOpQxVqmxo2+/hVUdb75dJAOD
         frjrKuQbkRKfhGAeXp/MXeP/HY3l6HyPweyuoclDvq+IblRKbNaXdQEimHLn3VcbufED
         92Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qhH1uVfrvA2WMKNAisYCIIjOhTu11VObwXrq+F6JWoY=;
        b=VDhe02E7Ni6kqA39fC773Q12kyfZn90SA3PXwDoBHYoGkagVOu6LmSKZAjDN7j6BGr
         AJqNVhWuJWOQi6a3du07AYJ4aunbkCyHGr9tUVgZZdeSB3U6HZK7nX1ue4Z8Aejw7Jf9
         PgMyjSTTpVbJJn4T4UgpYcVr+B/9QudVsbyfYoRU9d0HBoY/8nG9WFZgL3U8LSPPy9wC
         V4DEO10GmDbYXubrNghXGsO5Y6Uts/yQ14eXlsjSAufQydNGoKrj70h4lY6rfC+hUYwH
         gK4WmAFTErOs5l/7TbWURmaV2sN69meOAI8jnnihfOJPNdFYj8agPPD610q/gFK5a34L
         kC6A==
X-Gm-Message-State: AOAM530wny+t7gCb1pQM9tBBD5OV0/pl6W7rCbKOuz2zCP952vYkIG48
        UzZfes1V91lmPwWiY8+ouUcTDQ==
X-Google-Smtp-Source: ABdhPJwxL3qiDUm00jRN9entmpu9ZMZJ1j7if6JeWZ2AIBUzK+gvXLSC0Oo4boqTjshMAa8Mx+iBOQ==
X-Received: by 2002:a5d:544c:: with SMTP id w12mr11612586wrv.398.1633084222508;
        Fri, 01 Oct 2021 03:30:22 -0700 (PDT)
Received: from [192.168.0.46] ([82.142.20.44])
        by smtp.googlemail.com with ESMTPSA id o19sm5698172wrg.60.2021.10.01.03.30.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Oct 2021 03:30:21 -0700 (PDT)
Subject: Re: [RFD] Remove the userspace governor and the cooling device set
 state sysfs entry
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
References: <d46b5007-428b-5f31-52d9-a964cc60ad92@linaro.org>
 <39728f24-7781-543c-ad28-fd1c7552d96a@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <2b8300b2-4678-3e3c-71e3-6d276b99eb07@linaro.org>
Date:   Fri, 1 Oct 2021 12:30:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <39728f24-7781-543c-ad28-fd1c7552d96a@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Lukasz,

On 30/09/2021 12:10, Lukasz Luba wrote:
> Hi Daniel,
> 
> On 9/22/21 10:59 AM, Daniel Lezcano wrote:
>>
>> Hi,
>>
>> the userspace governor is sending temperature when polling is active and
>> trip point crossed events. Nothing else.
>>
>> In the other side, the cooling device have their cooling device
>> set_cur_state read-writable all the time.
>>
>> The thermal framework is wrongly used by userspace as a power capping
>> framework by acting on the cooling device opaque state. This one then
>> competes with the in-kernel governor decision.
>>
>> As the new netlink thermal notification is able to provide the same
>> information than the userspace governor.
>>
>> I propose to remove the userspace governor and the cur_state entry in
>> the sysfs exported file.
>>
>> The DTPM framework is the right framework to do power capping and
>> moreover it deals with the aggregation via the dev pm qos.
>>
>> Does it make sense ?
> 
> It sounds that we should be OK with the information from netlink.
> I don't see objections. We can also extend the netlink packet when
> needed. I'm fine with removing the user-space governor.

thank you for your answer. I'll propose a patch with a warn when the
userspace governor is registered in order to let know people the
governor is deprecated.

Probably, it would make sense to emit a warning also when the cooling
device state is set from userspace.

For the next release, we should be able to drop the userspace governor
and make the cooling device state read-only.

Does it make sense ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
