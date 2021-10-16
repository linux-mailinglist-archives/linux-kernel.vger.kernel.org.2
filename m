Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7A9F43051C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 23:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244648AbhJPWBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 18:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235312AbhJPWBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 18:01:45 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D5AC061765
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 14:59:36 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id r7so33167289wrc.10
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 14:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gtjoNpKT1+hdasIsYE2uXFGE/XY4xV3IcqIJcmREP+M=;
        b=P+musAqTZ/9Mm0DHstghqaKJlK5Jt8b8KNAPWI0+2ycX7k8wEFXrFZ6rAlurR8BJPg
         5bTyY3tcrX/qz/Eq8TUhU9Nx32Avkmi3Lrofe29aqQSyvqJoalXF2WQI/EXjuqzAr9u6
         igl5vhUTjCnS3YoMP/XBhuf33ilZNzZVcT/w6bggv6RfQGsqodrUcfOXjmmGaDHjCPD0
         NiGlVLk1bjhqiC+d4W9bdopQdFTWMVtaU0lT1KVP58AvS4i+8d0ZMxa481pRdGJn1pXd
         qFxe1bdh99LnOQe9pqpeD9StrF6R4ermqFxt17j6zQcPh7SAySjU2+Ewy0iqSjFuq6/G
         X1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gtjoNpKT1+hdasIsYE2uXFGE/XY4xV3IcqIJcmREP+M=;
        b=n4kyHAa72uP4EoK4EYjIR+cjEJTPA64YIhCfBZrga/vNTODH7CFK3h6n5AfCr2gQCP
         arhF83Bnw0DewR+SIkhN5Iy08UzPbBNnaP7NfsEEYqaOgFRHU6//yoAf1V3L2OyGAQs+
         NQrEKrqVZVot0k4xVCHAZjCz1ttqHb+WZI+BblqMntnE69+jdnoVAFR1i5DUTjmmxAXB
         bPgB1kjeeerhCeVu7G/uow3npawPhXR+nNoTOF+dvkAcZdqjj950Gqu0EzZhOei+nsqo
         NisHFVOOpdlBW77pa2a8uukJYu8JIjFYUwDeltnwQIXQZ4oSnz6D5svkH+XSqf8UeCnz
         Gzpw==
X-Gm-Message-State: AOAM532ak95BLJN3ZQcJlEC+1XwrnLWincCzCND++BOE8CLId/PodtTp
        IuFGLvpIp+/fCbyXf/zJxhOaiHqPzNbtPsKg
X-Google-Smtp-Source: ABdhPJzi9fi+UK3QNOEaBqZBWAUKkt/tyjVVNQauw2DJMKwiD7UkmiesJqF14ttV27v3yWPSrso3iw==
X-Received: by 2002:adf:ab1c:: with SMTP id q28mr24890966wrc.39.1634421575345;
        Sat, 16 Oct 2021 14:59:35 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:f04d:f65f:efd5:698? ([2a01:e34:ed2f:f020:f04d:f65f:efd5:698])
        by smtp.googlemail.com with ESMTPSA id u13sm63336wri.50.2021.10.16.14.59.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Oct 2021 14:59:34 -0700 (PDT)
Subject: Re: [PATCH v3 00/17] clocksource/arm_arch_timer: Add basic ARMv8.6
 support
To:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
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
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <2cf7b564-63c2-ac6c-a083-f7ac2caab6fc@linaro.org>
Date:   Sat, 16 Oct 2021 23:59:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <87mtnfptni.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Marc,


On 11/10/2021 15:39, Marc Zyngier wrote:

[ ... ]

> Thanks for that. All addressed now. I'll repost the series once we've
> addressed the question below.
> 
>> How do you want to merge this series? It would be nice to have the arch
>> bits in the arm64 tree, if possible, as we'll be tripping over the cpucaps
>> stuff otherwise.
> 
> I think we should keep the series together, as asm/arch_timer.h gets a
> beating all over the place, and there is no chance the arm64 bits at
> the end can apply (let alone work) on their own.
> 
> So either Daniel would ack the series for it to go via arm64, or
> create a stable branch with the first 13 patches that would go in both
> the clocksource and arm64 trees.
> 
> Daniel, any preference?

yes, I prefer a stable branch for this series.

https://git.linaro.org/people/daniel.lezcano/linux.git/log/?h=timers/drivers/armv8.6_arch_timer


Thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
