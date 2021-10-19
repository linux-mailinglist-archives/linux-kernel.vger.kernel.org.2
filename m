Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 513E94330BB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 10:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbhJSIID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 04:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbhJSIHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 04:07:05 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19B9C06176E
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 01:04:52 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id r18so46103015wrg.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 01:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l+GAWBc9BZHqEazjKcWHkAIbitohWGHbcy98/VQuwuc=;
        b=wZe8A+0f+KqRQO5bWdGhoQdtLXTNtl4cxoM2hm8XsXt8crfIY/gog33zgkFF9SPSqV
         RpgTy60/qLq9/hnOLvhapVRbIKDAvZhA0uFIptKCOD2Wxi7MRgnvBsZUk+aQobMqDzdN
         eVBF9OUT86FpldH0FxYIpuBrj5z9RuX0lbu+vmJf4FWTvlQDFL4M31mssZz/Zu4Zj+nN
         w3n9pqJn3StzOeeKDhbEU/7JsCdrml3hfMODWOWZZpPN6R4FaBwZVriC/VNJMtDMJM3u
         M+aEQHES4LURpYaZQdworn5+ZkR2e75/9JjYV4eO9CuRqrsCvad4VVaZJaSB/87RgJr/
         RCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l+GAWBc9BZHqEazjKcWHkAIbitohWGHbcy98/VQuwuc=;
        b=PJaO1ZFHrS8KyRvAahRLl2MlsDQHUJN1a6EBDIbuKOLCgmR0rll68efsuFMNOu+2/y
         WBieq/LgYQFjjo3ei9U8Kn3Vmd2IDfzkT9PTrRbbuyS731jkNBB0uQKGg13MbrAvZNz1
         NAsbkqqw9g2BJ0wBc0z0Z5idysxnLJ27CmP7me9uQPS3yfLDhu6O8ycH8aNA9xQxyEi5
         plSpc0csDihqiniVwYcV55rT2FWMJdIPseNuBRuT9kBnk6OvQcjtNd/Gy4v+GWiD1vNP
         svre7YpEfk8FMwbOwZOGjacZTM5UUVJPZUSfmtqwWEQToaC2yL8/JO/Amp+tXvvnAVGQ
         uwyg==
X-Gm-Message-State: AOAM533wYcyg7+pJ/6ihJOq2dzurX1dtCKeFrJlj+Nnz5OrKpHnq4h9a
        g6wWWhvPKPs3BrK7QVWskpi9FQ==
X-Google-Smtp-Source: ABdhPJxFxhjrpwZ5x0yYOQka2ym+ZPXc9sW3aZLUppDaARCEiKaPdtk971GGBDzBLKjThG+2L6mt7g==
X-Received: by 2002:adf:a319:: with SMTP id c25mr42912102wrb.307.1634630690342;
        Tue, 19 Oct 2021 01:04:50 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:c590:9206:d20a:23bd? ([2a01:e34:ed2f:f020:c590:9206:d20a:23bd])
        by smtp.googlemail.com with ESMTPSA id s13sm1545247wmc.47.2021.10.19.01.04.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 01:04:49 -0700 (PDT)
Subject: Re: [PATCH v3 00/17] clocksource/arm_arch_timer: Add basic ARMv8.6
 support
To:     Marc Zyngier <maz@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Shier <pshier@google.com>,
        Raghavendra Rao Ananta <rananta@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Oliver Upton <oupton@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel-team@android.com
References: <20211010114306.2910453-1-maz@kernel.org>
 <20211011110243.GB4068@willie-the-truck> <87mtnfptni.wl-maz@kernel.org>
 <2cf7b564-63c2-ac6c-a083-f7ac2caab6fc@linaro.org>
 <877decotwi.wl-maz@kernel.org>
 <d0c55386-2f7f-a940-45bb-d80ae5e0f378@linaro.org>
 <87v91to35b.wl-maz@kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <5ab16f85-abb2-996b-cf78-64e18cb54c71@linaro.org>
Date:   Tue, 19 Oct 2021 10:04:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <87v91to35b.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2021 10:00, Marc Zyngier wrote:
> On Mon, 18 Oct 2021 08:51:19 +0100,
> Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> On 17/10/2021 11:57, Marc Zyngier wrote:
>>> Hi Daniel,
>>>
>>> On Sat, 16 Oct 2021 22:59:33 +0100,
>>> Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>>>
>>>>
>>>> Hi Marc,
>>>>
>>>>
>>>> On 11/10/2021 15:39, Marc Zyngier wrote:
>>>>
>>>> [ ... ]
>>>>
>>>>> Thanks for that. All addressed now. I'll repost the series once we've
>>>>> addressed the question below.
>>>>>
>>>>>> How do you want to merge this series? It would be nice to have the arch
>>>>>> bits in the arm64 tree, if possible, as we'll be tripping over the cpucaps
>>>>>> stuff otherwise.
>>>>>
>>>>> I think we should keep the series together, as asm/arch_timer.h gets a
>>>>> beating all over the place, and there is no chance the arm64 bits at
>>>>> the end can apply (let alone work) on their own.
>>>>>
>>>>> So either Daniel would ack the series for it to go via arm64, or
>>>>> create a stable branch with the first 13 patches that would go in both
>>>>> the clocksource and arm64 trees.
>>>>>
>>>>> Daniel, any preference?
>>>>
>>>> yes, I prefer a stable branch for this series.
>>>>
>>>> https://git.linaro.org/people/daniel.lezcano/linux.git/log/?h=timers/drivers/armv8.6_arch_timer
>>>>
>>>
>>> OK, this branch is now slightly outdated, since I have reworked it at
>>> Will's request. -rc5 is also too recent a base for arm64, which is
>>> usually based on -rc3.
>>>
>>> I'll repost a new series today or tomorrow and provide tags for both
>>> you and Will to pull from.
>>
>> Ok, thanks. I've updated the branch accordingly.
>>
>> Let me know if everything is fine, so I can prepare a PR for the 'tip' tree.
> 
> Looks OK to me, although you seem to carry two distinct versions of
> the patches (v3 and v4) in -next.

Oh, right :/

Thanks for pointing this out


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
