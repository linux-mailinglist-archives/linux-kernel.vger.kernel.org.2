Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 843903EB388
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 11:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239712AbhHMJuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 05:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239370AbhHMJug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 05:50:36 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6375C0617AD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 02:50:09 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id n13-20020a17090a4e0d00b0017946980d8dso894356pjh.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 02:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RAz/Im2O2D0PVJYzLw0GvtWHajffI0uko6BVtdR8kig=;
        b=W2rEqQW+usxN+AbT4yJeR+eFoGAbEaXrBkpYVDbqByhFW+KdAjLYQgy7xM7c80wIGk
         NZ9sJVV9LDiAfhMhjLdbLNr4zJLFAZaGsm3Ah/0xO+Zu+Km8F+F8ZXtgslo2Z6BIS2D7
         bRXHOFiqHcjNwt76sWp2Z3gRNI9VgIJOR009bPZzC3iYOue2oBzqiBpMS7n6C3XZWLTE
         SnaWg+S5WnJUxxG5z2fOjE/iLs2336z1pyrMucIE+jHhYfEg/hLPv7SSDYj2ZLEqmQRP
         7pdLpeP4oSHq75iirkmw4SQFJPRd4+HIJmQpqsMmo39vUMaXj+u6ZEYG8P+rdUN8k9T+
         /fVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RAz/Im2O2D0PVJYzLw0GvtWHajffI0uko6BVtdR8kig=;
        b=lgu+HoHHJ9v90JE82pGkNZRW0vtCvmXf/W3jP04H+JGyj+NzCUMuIGu0pzz1itThiR
         vCqGdi1Prx/tAy1estOtFeaE0jl3wZxkvK8CMgSjazEQMOLMcYA2tNB5ENUTLfZnDXdB
         lrXDTaCm0LBi3/XaZ8np1oijlMtwwUVDOJinNubANDb6/TvNQ6XKD3IXCS8PHejg5l28
         tBqIhK+Xbmk/z/NGx/v+3QqBSkbMFVk2R7DL3c/YMbGIqwISw1gy+cUZ7+3Qq3vLAZ2P
         geRRSbc2xbiOwpzdr+NPvAnNYlgZgPRuY3RcRXU8v+r164X8L3iDjsPaDpqaopT3yOLS
         dyPg==
X-Gm-Message-State: AOAM532ARUN2eONIgJKYPM/dpB0CAg5C/fxMWQWz0uQy2r6F0tdGyuWE
        plKAyJXAqdsFONRM+wMNRZ6eBv/q5mA0oQ==
X-Google-Smtp-Source: ABdhPJw5cyWuImWVnIxRZJhPAyC9HkG/H/PERXnp/EEW2ZTkpCJE1GhFPgK7fxh0A1Xld0XtU3NVjg==
X-Received: by 2002:a63:ed47:: with SMTP id m7mr1640554pgk.194.1628848209313;
        Fri, 13 Aug 2021 02:50:09 -0700 (PDT)
Received: from [192.168.10.23] (219-90-184-65.ip.adam.com.au. [219.90.184.65])
        by smtp.gmail.com with UTF8SMTPSA id j6sm1937877pgq.0.2021.08.13.02.50.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 02:50:08 -0700 (PDT)
Message-ID: <be02290c-60a0-48af-0491-61e8a6d5b7b7@ozlabs.ru>
Date:   Fri, 13 Aug 2021 19:50:04 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0
Subject: Re: [PATCH kernel] KVM: PPC: Book3S HV: Make unique debugfs nodename
Content-Language: en-US
To:     Paul Mackerras <paulus@ozlabs.org>
Cc:     linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <20210707041344.3803554-1-aik@ozlabs.ru>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
In-Reply-To: <20210707041344.3803554-1-aik@ozlabs.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/07/2021 14:13, Alexey Kardashevskiy wrote:
> Currently it is vm-$currentpid which works as long as there is just one
> VM per the userspace (99.99% cases) but produces a bunch
> of "debugfs: Directory 'vm16679' with parent 'kvm' already present!"
> when syzkaller (syscall fuzzer) is running so only one VM is present in
> the debugfs for a given process.
> 
> This changes the debugfs node to include the LPID which alone should be
> system wide unique. This leaves the existing pid for the convenience of
> matching the VM's debugfs with the running userspace process (QEMU).
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Looks like this is not enough as syzkaller still manages to cause the 
error message, I need more robust approach as in 
https://lore.kernel.org/patchwork/patch/1472025/  or   alternatively 
move this debugfs stuff under the platform-independent directory, how 
about that?


> ---
>   arch/powerpc/kvm/book3s_hv.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 1d1fcc290fca..0223ddc0eed0 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -5227,7 +5227,7 @@ static int kvmppc_core_init_vm_hv(struct kvm *kvm)
>   	/*
>   	 * Create a debugfs directory for the VM
>   	 */
> -	snprintf(buf, sizeof(buf), "vm%d", current->pid);
> +	snprintf(buf, sizeof(buf), "vm%d-lp%ld", current->pid, lpid);
>   	kvm->arch.debugfs_dir = debugfs_create_dir(buf, kvm_debugfs_dir);
>   	kvmppc_mmu_debugfs_init(kvm);
>   	if (radix_enabled())
> 

-- 
Alexey
