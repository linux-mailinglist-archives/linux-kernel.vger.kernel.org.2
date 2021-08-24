Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A02583F59E7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 10:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235382AbhHXIiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 04:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235349AbhHXIiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 04:38:14 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF78C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 01:37:31 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id r2so19109429pgl.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 01:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=B2gKm6chBsv5r3i/L80Y3/d7t6I2kPU5f7xacAN/16I=;
        b=UN1hqkTUde+ZVmSeDs02KLaAqXx+Udsm8mkh6v/GeeQMKx9dUk3As7xnfnzTCdVvIT
         8GAdUxoIa2yNJ1CT23mGdkZgZoRYCn396OF0ASku2oEgxzklDtMa3azVrL+49MbiuVHe
         Ys8qNpa5mE9KrEsMezYUpgiC64AkYaXleghP6Semde5mheftJcQQrlAR4pC+Nx9xyKXf
         FzwkfCFrBnkSP0X2SY4coE8htycrioioGpxj5zPfjnEGzdH+4UoCrU7FL6CH7N/yFTgC
         ZtsmHIBe/Qx4Sbwxq0IRDLLHF0Rdh+F4nMlSZdlz2ZyMiYY54IiujG06xWqKWly7QcUT
         4Jsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=B2gKm6chBsv5r3i/L80Y3/d7t6I2kPU5f7xacAN/16I=;
        b=op1XfvpnS45O3WO6qTr2oKpnBpAjnD6cOULwjDshnT3nAxEjj682iq4fP4DzG1WxwJ
         HCVK0joKetn4AdyZDqj+9DKk4vI07IlDE9cyMRPE7x7OZx0fQKorPO0l3mqfUEkh+/7F
         uC32+5h1Ex2hOq2OGVKUCmZynOBbMs2HKua2jlGFetEnXuSUXd1U2wZv+44mowC4Pnuk
         1CZfubVFzRpCgnfG7gJYJPlvqdvGthUTT+PX9mIS+Lv5OWzDaG4OWRrdqMOzZVkUFTAf
         o8J1OiFZqxoQ4TvBsy9WfrRoG2xzxcgRcZNJ0lREPKzl0dbfd/NPIsSXPmLNeV4vJvrf
         PN2A==
X-Gm-Message-State: AOAM531BePGfG0sg2qcLiR5Cg2B36Rn6A8V7NbOxnduFrir72+rKYBDY
        3GO7FPJvovwbeFDjCFqCyXv6jQ==
X-Google-Smtp-Source: ABdhPJwm8/hDWjBO4m0jD9d+GUvfnpaDVbH4ZheRLKmoA8ju9VtsRmFdyxMMuVmlFA/NmuXdBO1Ygw==
X-Received: by 2002:a62:9712:0:b029:3be:3408:65a9 with SMTP id n18-20020a6297120000b02903be340865a9mr38537843pfe.63.1629794250637;
        Tue, 24 Aug 2021 01:37:30 -0700 (PDT)
Received: from [192.168.10.23] (124-171-108-209.dyn.iinet.net.au. [124.171.108.209])
        by smtp.gmail.com with UTF8SMTPSA id ds6sm1700529pjb.32.2021.08.24.01.37.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 01:37:30 -0700 (PDT)
Message-ID: <a1be1913-f564-924b-1750-03efa859a0b1@ozlabs.ru>
Date:   Tue, 24 Aug 2021 18:37:25 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0
Subject: Re: [PATCH kernel] KVM: PPC: Book3S HV: Make unique debugfs nodename
Content-Language: en-US
To:     Fabiano Rosas <farosas@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@ozlabs.org>
References: <20210707041344.3803554-1-aik@ozlabs.ru>
 <be02290c-60a0-48af-0491-61e8a6d5b7b7@ozlabs.ru>
 <87pmubu306.fsf@linux.ibm.com>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
In-Reply-To: <87pmubu306.fsf@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/08/2021 08:20, Fabiano Rosas wrote:
> Alexey Kardashevskiy <aik@ozlabs.ru> writes:
> 
>> On 07/07/2021 14:13, Alexey Kardashevskiy wrote:
> 
>> alternatively move this debugfs stuff under the platform-independent
>> directory, how about that?
> 
> That's a good idea. I only now realized we have two separate directories
> for the same guest:
> 
> $ ls /sys/kernel/debug/kvm/ | grep $pid
> 19062-11
> vm19062
> 
> Looks like we would have to implement kvm_arch_create_vcpu_debugfs for
> the vcpu information and add a similar hook for the vm.

Something like that. From the git history, it looks like the ppc folder 
was added first and then the generic kvm folder was added but apparently 
they did not notice the ppc one due to natural reasons :)

If you are not too busy, can you please merge the ppc one into the 
generic one and post the patch, so we won't need to fix these 
duplication warnings again? Thanks,



>>> ---
>>>    arch/powerpc/kvm/book3s_hv.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
>>> index 1d1fcc290fca..0223ddc0eed0 100644
>>> --- a/arch/powerpc/kvm/book3s_hv.c
>>> +++ b/arch/powerpc/kvm/book3s_hv.c
>>> @@ -5227,7 +5227,7 @@ static int kvmppc_core_init_vm_hv(struct kvm *kvm)
>>>    	/*
>>>    	 * Create a debugfs directory for the VM
>>>    	 */
>>> -	snprintf(buf, sizeof(buf), "vm%d", current->pid);
>>> +	snprintf(buf, sizeof(buf), "vm%d-lp%ld", current->pid, lpid);
>>>    	kvm->arch.debugfs_dir = debugfs_create_dir(buf, kvm_debugfs_dir);
>>>    	kvmppc_mmu_debugfs_init(kvm);
>>>    	if (radix_enabled())
>>>

-- 
Alexey
