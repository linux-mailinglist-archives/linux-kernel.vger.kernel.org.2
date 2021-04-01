Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE016352430
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 01:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235884AbhDAXwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 19:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbhDAXwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 19:52:37 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88265C0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 16:52:36 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id v23so1765424ple.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 16:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SEHNUE5bPreCk0YNPUlKmfUdSYB5CVpf+CCeqNykU10=;
        b=J7xW51CzYpZjYXmWQCq34hmEsImnvM5EBx2wI1bgXtbsw6s2Oamp64yTcGoDbiOvis
         V1YvW3rn/1DOyHFJn3DfArOwMa00YQbA+nIMr+CY31DoO4xniAPSGfG4DWhgf15qdtfW
         dQ3Cc2fTIFX+grA2YRgCoJvCMQfAx8hFhvvkqBbBOyscRyGPNJu8w0/q+G2SEc9iIBEa
         47L3zguwbA/shghY9ja8ylRWn6yRKZPIC64KQnbGdBXWHZjzEbF4vnjKKYpFAqQhpHIg
         WbX9i6VAFejIDGzrFQC3Dj877LrFcCInLTPRU/nUAdIjvEaxCRefigmg/3vURoU8wDIH
         5f+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SEHNUE5bPreCk0YNPUlKmfUdSYB5CVpf+CCeqNykU10=;
        b=AGh0vUBtvzK5jhllEoXcWtHZcX5j1lOdSznJC05+Bb74xvrozRZOMbvhK3kPI4JBlm
         DJ9zXLoBTtAPzKbfoifqSOQRU8ja9/4Uo1sZJfQjdA7JDY1qcPRNffcz7AJPwjwONEhe
         zRNn3pnxb73LE12G5d01368j/1iBiRZWnnqPIoh/DaAZ/b8/nu+emdbFAwVmbKauH+hG
         gLSy6i+GM+3P1/COj1e54gs9KJYpvOegSVukT5SyU+rLsYF0sqpOmcqlZHHts+dPoZKg
         sGAe9s8i8kz532fDhD6eqCJhMvD3lxAZ6G746BPRG5oQ0z9nmME6YmHxcKfZWp2p1WIV
         shBw==
X-Gm-Message-State: AOAM532lnWr7GvJTPzmS3jcMUFTtxw5YrkztTrB7xiWkuqnMfUEqXC1L
        ZCw70IbNqqDkjGJMDBUGTxI=
X-Google-Smtp-Source: ABdhPJzNiOp2cAnGCHyj7/uXJ9wcoFfJleqTzORqEIdPeCI6Bx6CnXw9OJErXWedP6MSwRmt7Lbcpg==
X-Received: by 2002:a17:902:7d8d:b029:e6:4061:b767 with SMTP id a13-20020a1709027d8db02900e64061b767mr10150510plm.32.1617321155872;
        Thu, 01 Apr 2021 16:52:35 -0700 (PDT)
Received: from [10.67.49.104] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d2sm6237968pjx.42.2021.04.01.16.52.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 16:52:35 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v8 0/3] ARM: Implement MODULE_PLT support in FTRACE
To:     Alexander A Sverdlin <alexander.sverdlin@nokia.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Qais Yousef <qais.yousef@arm.com>
References: <20210330114035.18575-1-alexander.sverdlin@nokia.com>
Message-ID: <a8b8dabd-6637-335d-5abc-5a88d21b4db0@gmail.com>
Date:   Thu, 1 Apr 2021 16:52:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210330114035.18575-1-alexander.sverdlin@nokia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/21 4:40 AM, Alexander A Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> 
> FTRACE's function tracer currently doesn't always work on ARM with
> MODULE_PLT option enabled. If the module is loaded too far, FTRACE's
> code modifier cannot cope with introduced veneers and turns the
> function tracer off globally.
> 
> ARM64 already has a solution for the problem, refer to the following
> patches:
> 
> arm64: ftrace: emit ftrace-mod.o contents through code
> arm64: module-plts: factor out PLT generation code for ftrace
> arm64: ftrace: fix !CONFIG_ARM64_MODULE_PLTS kernels
> arm64: ftrace: fix building without CONFIG_MODULES
> arm64: ftrace: add support for far branches to dynamic ftrace
> arm64: ftrace: don't validate branch via PLT in ftrace_make_nop()
> 
> But the presented ARM variant has just a half of the footprint in terms of
> the changed LoCs. It also retains the code validation-before-modification
> instead of switching it off.
> 
> Changelog:
> v8:
> * Add warn suppress parameter to arm_gen_branch_link()
> v7:
> * rebased
> v6:
> * rebased
> v5:
> * BUILD_BUG_ON() ensures fixed_plts[] always fits one PLT block
> * use "for" loop instead of "while"
> * scripts/recordmcount is filtering reloc types
> v4:
> * Fixed build without CONFIG_FUNCTION_TRACER
> * Reorganized pre-allocated PLTs handling in get_module_plt(),
>   now compiler eliminates the whole FTRACE-related handling code
>     if ARRAY_SIZE(fixed_plts) == 0
>     v3:
>     * Only extend struct dyn_arch_ftrace when ARM_MODULE_PLTS is enabled
>     v2:
>     * As suggested by Steven Rostedt, refrain from tree-wide API modification,
>       save module pointer in struct dyn_arch_ftrace instead (PowerPC way)

FWIW, ftracetest did not pick up new failures (nor were new tests fixed)
with this patch series.
-- 
Florian
