Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4D3E34F14B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 20:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbhC3S57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 14:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbhC3S5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 14:57:19 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DE6C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 11:57:19 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id p12so7738259pgj.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 11:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Im8HC/95If4NF2ZyRBUTtbjnh4iyHk5nc6Niu3yE2kI=;
        b=YsWI6d8pVBmK2DRUAL5G8nV9RK6/pwZizWuNl2Cnnc8b4vVFKwhu3+FxQ6eCd7/L6U
         19afu5ezM0U55CeLbw1D5UotMJt8PpcyNoCniEPtTO55LGgd3ozVlWl0UDAwL00pq44N
         Ja9ZoPhWtRXulEvjDlwza8WtMwZeuvPeHQtXMgAUONcM+/D4jLFd9su0N6CT8fehVPdl
         MqiJdegD/412zf9atKd5+I+6p/MidACqsSsn9Vn8D+EFWs6T5v0+9j1SG1WmjLOQx9UI
         +gES3Mdiib2XCkFNNtcRpqDRvhwkD7Mx104iW9gB9TBecfKtRfCjTNFPDKtI1iYlqlEH
         VIZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Im8HC/95If4NF2ZyRBUTtbjnh4iyHk5nc6Niu3yE2kI=;
        b=HDVWqa941aQZKpvsPdAssv2i3jXEwE5fAoR4BD9L2snD661Wptd0cu/obpCQRAckxR
         ctJ6I8eu+XLUOMfmXRY2zLbOQgB+UZxnz/DbtLpCsVe41Cab7As5pg8LPBJzxGhltkO+
         cGW26CLYL0PxHyuUdBalrvT/ikKGGsyBsu+NnmhuqKZHDcTM/69RC2y7zyeErq3ht/D9
         98XDaLHiTI/lL8KasQRvmVTYQSUqBv5yA7rIuXQ3TuyX2dwwSYd1A+z5eUTTqoLME7oW
         j7araV6T2AaiuYH9XFl6IvaN8whMvOI4/hgmZwwM5BU0Rtb95f7GEj+XiCZI59iLdSVI
         afwA==
X-Gm-Message-State: AOAM530Gyq3IbZx0eqNaI7TvFM3lkLtRtwRMb6S40TuxxJd6FuDiZrMN
        IHV6B18M4+x39VZ6uzDs1v8+r08oztk=
X-Google-Smtp-Source: ABdhPJzDsnHRJPC0VL0EvMfo8p++K+IryJt+5Vns0bWCn0Pjibss8aTUDVXbOIbi7JKF5BgTYYjVQg==
X-Received: by 2002:aa7:9e43:0:b029:1f3:a2b3:d9fd with SMTP id z3-20020aa79e430000b02901f3a2b3d9fdmr31780722pfq.74.1617130638779;
        Tue, 30 Mar 2021 11:57:18 -0700 (PDT)
Received: from [10.67.49.104] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id w5sm21593939pge.55.2021.03.30.11.57.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 11:57:18 -0700 (PDT)
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
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <9bce83d4-a493-eb26-3fa0-344e863826c7@gmail.com>
Date:   Tue, 30 Mar 2021 11:57:16 -0700
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
> 
> Alexander Sverdlin (3):
>   ARM: PLT: Move struct plt_entries definition to header
>   ARM: Add warn suppress parameter to arm_gen_branch_link()
>   ARM: ftrace: Add MODULE_PLTS support

Tested-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks a lot!
-- 
Florian
