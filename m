Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFCDC306454
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 20:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344617AbhA0TmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 14:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344607AbhA0Tho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 14:37:44 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69593C061756
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 11:36:59 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id r38so2257636pgk.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 11:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Lrgo7ExcxZOc6wDuEAWDaLWJ735zWTiQ6RpyvZWHowE=;
        b=ZAte76qDU3nNVp9j191EvXLtls45dYfuBYA30x1Is8f3Ws5n9bF5mCOTvAwpMxkjcY
         C6XcIYWQQck07cfCsfdWYgPPhp9Ja0hLOncYd0iryR7JT1luEvfgRE4FDv2NfZJPbUzz
         YqnEIlxbDrEv9b+WUl5I2+st0lN+LWHo7Pw6sHdiHp1ygmp41t7ydCtZ1m+Z9Yp1pt9t
         ywu6ymO9xKppkTEsMpVe9VBPAXo5zYxkCnG0sgKn1tuc5I9TEZIINqz4dw7smaBGkxTW
         EqXi0hZCBziaaoFKFEWplwKfcT5h+Qh+2wRZBjf7TdUMCkbNkhoUJ2LpVt/D7VLa0ViB
         N/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Lrgo7ExcxZOc6wDuEAWDaLWJ735zWTiQ6RpyvZWHowE=;
        b=sjKT7IVCFjdG2wo5orX4FRtVsCnZhcdc97nAYyPPUP7wlcBMEx68b8x+NS/NDkYJf5
         VnDZVzhfYH6nyr4swmuGx9oaOIcQGm7eAwJ23DV1mi0Tz826IM1/HWvsHE2swrlTUfDq
         8TharnjGPA2Kmy5Q2d13hiCjbNFvqnN1czXStj39eRVIvTAsarATZHZQLb/xiWp7eHpP
         w7u2u/Yk4c7bRLl9Jjenq199PKxKSBIrNFflx3pGERSZ6CyYUG4s9LM6voLK+1HE/iH/
         a0tbzvYPcW02YF/TapskQ8kvFgwUs3/QPQ/4OUy7qqbU6i7arDTENckzi82XzQWvHXgP
         0rnQ==
X-Gm-Message-State: AOAM532ARICKDUSekJ4yI0YbBkvr84hbs01i0VcuJjO5doE+jQVtNcCs
        OuTRqmmyQdSw4F/HJVfZ5nI=
X-Google-Smtp-Source: ABdhPJxUwRLChY+8LiSGb7sRv98f5AL/zks0hzlPO6MsZlqFz+QJb/0HO3lNWw4YYxmed+DRXYG6tg==
X-Received: by 2002:a65:6881:: with SMTP id e1mr13045178pgt.290.1611776218876;
        Wed, 27 Jan 2021 11:36:58 -0800 (PST)
Received: from [10.230.29.30] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id gg22sm2853963pjb.24.2021.01.27.11.36.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 11:36:58 -0800 (PST)
Subject: Re: [PATCH v7 2/2] ARM: ftrace: Add MODULE_PLTS support
To:     Alexander A Sverdlin <alexander.sverdlin@nokia.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
References: <20210127110944.41813-1-alexander.sverdlin@nokia.com>
 <20210127110944.41813-3-alexander.sverdlin@nokia.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <2855919e-2bc4-ff26-8f1b-c2a96aec9018@gmail.com>
Date:   Wed, 27 Jan 2021 11:36:56 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210127110944.41813-3-alexander.sverdlin@nokia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/27/2021 3:09 AM, Alexander A Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> 
> Teach ftrace_make_call() and ftrace_make_nop() about PLTs.
> Teach PLT code about FTRACE and all its callbacks.
> Otherwise the following might happen:
> 
> ------------[ cut here ]------------
> WARNING: CPU: 14 PID: 2265 at .../arch/arm/kernel/insn.c:14 __arm_gen_branch+0x83/0x8c()
> ...
> Hardware name: LSI Axxia AXM55XX
> [<c0314a49>] (unwind_backtrace) from [<c03115e9>] (show_stack+0x11/0x14)
> [<c03115e9>] (show_stack) from [<c0519f51>] (dump_stack+0x81/0xa8)
> [<c0519f51>] (dump_stack) from [<c032185d>] (warn_slowpath_common+0x69/0x90)
> [<c032185d>] (warn_slowpath_common) from [<c03218f3>] (warn_slowpath_null+0x17/0x1c)
> [<c03218f3>] (warn_slowpath_null) from [<c03143cf>] (__arm_gen_branch+0x83/0x8c)
> [<c03143cf>] (__arm_gen_branch) from [<c0314337>] (ftrace_make_nop+0xf/0x24)
> [<c0314337>] (ftrace_make_nop) from [<c038ebcb>] (ftrace_process_locs+0x27b/0x3e8)
> [<c038ebcb>] (ftrace_process_locs) from [<c0378d79>] (load_module+0x11e9/0x1a44)
> [<c0378d79>] (load_module) from [<c037974d>] (SyS_finit_module+0x59/0x84)
> [<c037974d>] (SyS_finit_module) from [<c030e981>] (ret_fast_syscall+0x1/0x18)
> ---[ end trace e1b64ced7a89adcc ]---
> ------------[ cut here ]------------
> WARNING: CPU: 14 PID: 2265 at .../kernel/trace/ftrace.c:1979 ftrace_bug+0x1b1/0x234()
> ...
> Hardware name: LSI Axxia AXM55XX
> [<c0314a49>] (unwind_backtrace) from [<c03115e9>] (show_stack+0x11/0x14)
> [<c03115e9>] (show_stack) from [<c0519f51>] (dump_stack+0x81/0xa8)
> [<c0519f51>] (dump_stack) from [<c032185d>] (warn_slowpath_common+0x69/0x90)
> [<c032185d>] (warn_slowpath_common) from [<c03218f3>] (warn_slowpath_null+0x17/0x1c)
> [<c03218f3>] (warn_slowpath_null) from [<c038e87d>] (ftrace_bug+0x1b1/0x234)
> [<c038e87d>] (ftrace_bug) from [<c038ebd5>] (ftrace_process_locs+0x285/0x3e8)
> [<c038ebd5>] (ftrace_process_locs) from [<c0378d79>] (load_module+0x11e9/0x1a44)
> [<c0378d79>] (load_module) from [<c037974d>] (SyS_finit_module+0x59/0x84)
> [<c037974d>] (SyS_finit_module) from [<c030e981>] (ret_fast_syscall+0x1/0x18)
> ---[ end trace e1b64ced7a89adcd ]---
> ftrace failed to modify [<e9ef7006>] 0xe9ef7006
> actual: 02:f0:3b:fa
> ftrace record flags: 0
> (0) expected tramp: c0314265
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>

Tested-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
