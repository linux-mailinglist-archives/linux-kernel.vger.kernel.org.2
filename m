Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6206A388176
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 22:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352155AbhERUhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 16:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236628AbhERUhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 16:37:45 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF66C061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 13:36:26 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id p6so5766178plr.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 13:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iMHbPKb1AhvuJccsSxrJGFr8X4+0YMZrG3gQe/JeWjM=;
        b=b3GWO2fSSF+IEHLWy8rVuzHE25lpIcW/uGadrCE5ZgqIOSEhDwiBRhm/ZKR8eC2pqp
         9IvUfPhXkkP6bdgnNdn3ePR1c+VfhDmXvKG1TSmcJw/QSbOuSxfKRjOQix8ls9i9Rzik
         IowCGFfjVE2MhibvZsLxpJRZAkBydwV5TgP0t2npq/uAEfwHtWrxnFCWS4L4WeEAfXoh
         R2ZOHlpRPSJ4il4yTNZ5fxr7+tjwyX5pIv2Deh8272LPr1knqErkbzFnbqtAaURAwxZP
         4mzdkdIiagmifLuWX1OYJMd3W39hJdQO20hjIJGKyt0HlJsq/Z7kMXi1FrL2vyIHuQwq
         W53Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iMHbPKb1AhvuJccsSxrJGFr8X4+0YMZrG3gQe/JeWjM=;
        b=BMZqahQWYHnbA3l8be3ag+lFdkUZxf4q9eLjjShYBcj7qRMu7vp+J3ApHRfGqNjqpc
         eRYoWmKfCMMGEHeMj+xgiSQWj1qJLXn6ew4W7A1Ky4mN39Z9gHvcT42k+ri5/vaxm6oo
         5kvuOJQOeQbPjZs5l1uFk0wwNwzFniSFONF3IdgWiXsk0WA8tbqGZ8cIrPDVTCaL9sFa
         g9A6F0eFJGVg6QNe1dJQfuJqD35Tt+vDNbKTz6vlVIOf47aavmQdI8c7EOyMDAHh4Kzn
         FJykXfhtOHMc9HHJcokjJkpm2YRr1PdWp8hA5HMxqwv55p/B2vuSgBFgYM2taLy/3E4R
         MvMw==
X-Gm-Message-State: AOAM532DiH8/bBjho/t/Lfa+PBdSsuFuO62yog67A5NtewcNF+mZiYFA
        3M2cTPbuAzsNxNphP9xqNQI=
X-Google-Smtp-Source: ABdhPJyu6aZtH9UBP+047gh6lGAL2nkLew0eMESzPTWTYRexz04yXy+P9EIubrQjnclebD7BmCkaDg==
X-Received: by 2002:a17:902:8682:b029:ef:d2:4311 with SMTP id g2-20020a1709028682b02900ef00d24311mr6552896plo.4.1621370186078;
        Tue, 18 May 2021 13:36:26 -0700 (PDT)
Received: from devbox.home ([50.39.96.2])
        by smtp.gmail.com with ESMTPSA id p65sm8547563pfb.62.2021.05.18.13.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 13:36:25 -0700 (PDT)
Date:   Tue, 18 May 2021 13:35:27 -0700
From:   Pawan Gupta <writetopawan@gmail.com>
To:     "Saripalli, RK" <rsaripal@amd.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, Jonathan Corbet <corbet@lwn.net>, bsd@redhat.com
Subject: Re: [v6 1/1] x86/bugs: Implement mitigation for Predictive Store
 Forwarding
Message-ID: <20210518203527.3i7bfpo7j6lx42i2@devbox.home>
References: <20210517220059.6452-1-rsaripal@amd.com>
 <20210517220059.6452-2-rsaripal@amd.com>
 <20c6fa3d-949d-156a-6d74-89829e3bffdf@infradead.org>
 <5fee3f12-27f3-3984-ce33-60734190ff0c@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <5fee3f12-27f3-3984-ce33-60734190ff0c@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.05.2021 07:27, Saripalli, RK wrote:
>
>
>On 5/17/2021 9:55 PM, Randy Dunlap wrote:
>> Hi again,
>>
>> On 5/17/21 3:00 PM, Ramakrishna Saripalli wrote:
>>> From: Ramakrishna Saripalli <rk.saripalli@amd.com>
>>>
>>> Certain AMD processors feature a new technology called Predictive Store
>>> Forwarding (PSF).
>>>
>>> PSF is a micro-architectural optimization designed to improve the
>>> performance of code execution by predicting dependencies between
>>> loads and stores.
>>>
>>> Incorrect PSF predictions can occur due to two reasons.
>>>
>> ...
>>
>>>
>>> Kernel parameter predictive_store_fwd_disable has the following values
>>>
>>> - on. Disable PSF on all CPUs.
>>>
>>> - off. Enable PSF on all CPUs.
>>>        This is also the default setting.
>>>
>>> Signed-off-by: Ramakrishna Saripalli<rk.saripalli@amd.com>
>>> ---
>>>  .../admin-guide/kernel-parameters.txt         |  5 +
>>>  arch/x86/include/asm/cpufeatures.h            |  1 +
>>>  arch/x86/include/asm/msr-index.h              |  2 +
>>>  arch/x86/include/asm/nospec-branch.h          |  6 ++
>>>  arch/x86/kernel/cpu/bugs.c                    | 94 +++++++++++++++++++
>>>  5 files changed, 108 insertions(+)
>>>
>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>> index 04545725f187..a5f694dccb24 100644
>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>> @@ -3940,6 +3940,11 @@
>>>  			Format: {"off"}
>>>  			Disable Hardware Transactional Memory
>>>
>>> +	predictive_store_fwd_disable=	[X86] This option controls PSF.
>>> +			off - Turns on PSF.
>>> +			on  - Turns off PSF.
>>> +			default : off.
>>
>>
>> and as I did earlier, I still object to "off" meaning PSF is on
>> and "on" meaning that PSF is off.
>>
>> It's not at all user friendly.
>>
>> If it's done this way because that's how the h/w bit is defined/used,
>> that's not a good excuse IMHO.
>>
>> Hm, it sorta seems to be a common "theme" when dealing with mitigations.
>> And too late to fix that.
>
>Based on previous feedback from Thomas Gleixner, I reworded this as a mitigation instead of as a "feature".
>In that vein, all the mitigation code moved into bugs.c like other mitigations, similar to
>spec_control_bypass_disable with an ON/OFF but no prctl/seccomp/auto.

Maybe change the help text to something like:

	on  - Turns on PSF mitigation.
	off - Turns off PSF mitigation.

Thanks,
Pawan
