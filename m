Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 328A23051CD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 06:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbhA0FPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 00:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239652AbhA0EtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 23:49:17 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAD1C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 20:49:02 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id my11so2383405pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 20:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5YTr1EEhs+jj2WHQwkT89TcFm/em4DGnwVspZEpL97A=;
        b=RlLrEPaq5WpFGniD2x8b04wZFQ6PtfcV2qsGrNoi1qfh6eBQE+GAQFAxu4wXcNH3jD
         O0gKXOwNrC8Q7iqaG+YwxsXQTTL7PANVlJy6X23kKSiHNQ9rBV/Y8YDL76/hMCZ9KlrE
         eHYoLN16D+b6c5mDbMGYPAMpvwvY3KCbwtIsN+lwn34U9riodVR7ORaatm0oq4htzO0w
         U8U4JgHIVfy1mF9i3UHdmKTcf61YGpVl9+QXsXdTJAWltBXgTjwxUMfoGKoC/It1qEEQ
         jxhWhIbkOuk07jlvUkX3WuCzLzcR7vmEmNJXyHDoFTQK7lEk5SVfpS6VjE4pbRHnRhJT
         L51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5YTr1EEhs+jj2WHQwkT89TcFm/em4DGnwVspZEpL97A=;
        b=G1fF3U2UQlvxaHWOb+B2Md3dZTSaAUlmpL180znk+Ef5lhO5+HgAWPU0YC/Llxr+HN
         6GLByUXqQ1ryZeL1CkSqvLIO7Ki0f+iClYYP5CGOEJBxLPFbbbctoNWzgfp48XO4le2h
         QFyH4w14ZHe5sqCIH6H7yChuyBrE73kKBwQiW66cgfYhzLWMFYJIc/d3H/c+aeWn/OFQ
         cq2BT+NgWiGnBWpiHF3Dhk6ntnnRIkTtG07BIFCQpjDR/7j9d1xUB1lXG+5BanufZSSR
         v+LZ9iqwp2qf5G4hx2qET9f0hlBkIV7uiX06RvZe4fLGu4bkEGxMIGzMpvaFFRpiTMdG
         YnwQ==
X-Gm-Message-State: AOAM532wp5zxmGI1ircrtDKJFusjHqm06yCtvBuyTl2WXZLSpMrODVAV
        kr9/kHLdjB/9qhuoo3iXPZI=
X-Google-Smtp-Source: ABdhPJwT86NlXbeo0tUZ22FIJEoKi5Nahex9P11UaR6y9t6c3u8nbvbOXIKz0NF7Q8Y3SBzA/wn9Lw==
X-Received: by 2002:a17:90a:3e81:: with SMTP id k1mr3661737pjc.13.1611722941942;
        Tue, 26 Jan 2021 20:49:01 -0800 (PST)
Received: from [10.230.29.30] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id e12sm610360pga.13.2021.01.26.20.49.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 20:49:01 -0800 (PST)
Subject: Re: [PATCH v6 0/2] ARM: Implement MODULE_PLT support in FTRACE
To:     Alexander X Sverdlin <alexander.sverdlin@nokia.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Russell King <linux@armlinux.org.uk>,
        Ingo Molnar <mingo@redhat.com>
References: <20200217140955.211661-1-alexander.sverdlin@nokia.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <48289cbf-9108-2807-7143-c3ae625bd940@gmail.com>
Date:   Tue, 26 Jan 2021 20:48:59 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20200217140955.211661-1-alexander.sverdlin@nokia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

On 2/17/2020 6:09 AM, Alexander X Sverdlin wrote:
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

We have been using those patches and I was wondering what happened after
this version since they did not show up upstream nor in Russell's patch
tracker? Would you be willing to resubmit them?

Thanks!
-- 
Florian
