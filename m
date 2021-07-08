Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E22A3BF3F0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 04:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbhGHCZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 22:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbhGHCZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 22:25:40 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D81C061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 19:22:58 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id y4so1876744pgl.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 19:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=L9ZzMO/peqn6RjqikFr8dYXKCUUURvXv/xvzuiz9Gcg=;
        b=sqVUCblt6YbpHOIC+8fh382fu2yduVloIOccYtsHNuLy2665lyxR/g9GUDe1Vs8ofD
         rNTEBWrbzY8rTWdro1WR+QUkgdghK7JSomCw03NMBMLeBmBbdMWfZ0kMaBVrjUnFFn/J
         FU1RcHjuhD8ylUQJDGUtnTvwx3g+QA4XhcOhCxIyYi603WD91GSzxNFAVmoWdaivaeIy
         T33502MZo28xIZfltFPmhbQjx7010qn0AvjbLVqcXb9b91n44dvvFki8ErUCSJoCi0dK
         3zJaqUxx059uCRPY+5JWgl4dcioI4VYaXheUxR4r0am2vwZ9Ji/RuXSflMzz5+HfPKnm
         ZmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=L9ZzMO/peqn6RjqikFr8dYXKCUUURvXv/xvzuiz9Gcg=;
        b=atH9vBbJ6VvyCSjkHxmDUw8yVek33Nf7ihGRwHYI9VDXRhsLD4HTBmGOPy/1WdOGyd
         bTJFuRBHyval4ctD/98zUJayVdZRadZs6P2bKnywORuzTt+aWhKoIpGCCf2tp0sye3bF
         UIYXjGi5kwtLRCTcu8K5XJja69k5enTOGndZwntz+KtabS/U5z61mbYuyqxrC79P/Kio
         ArqtAn34ULmif98PYU95ArQkijRgz7o6u76tB/uEMRDKXP83uEg9nXVDXuMm+cSp399A
         r1pb2xwpDvg2Wid/u7x1hzZNkwqW1TJ92++AoomZvgKgM+fz/gEU0KNEyLgktyxIqdP2
         uxUA==
X-Gm-Message-State: AOAM531iYR7a78UDw4HaKVYRqpNYbalJTTxaeBmkPMer4xxuD3r+V6oL
        wHxeCyVMJoM9KnMoqVcbEs3bBlbUPCB4CA==
X-Google-Smtp-Source: ABdhPJxjwp0VZUWtk582B8D83sqx5L5ovUaeeEilDOLIBZHiqCNSo05hlDyZZDoZ78ZHZjAgPKJ/9g==
X-Received: by 2002:a63:1308:: with SMTP id i8mr29514509pgl.19.1625710978256;
        Wed, 07 Jul 2021 19:22:58 -0700 (PDT)
Received: from [192.168.10.23] (219-90-184-65.ip.adam.com.au. [219.90.184.65])
        by smtp.gmail.com with UTF8SMTPSA id j15sm7712642pjn.28.2021.07.07.19.22.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jul 2021 19:22:57 -0700 (PDT)
Message-ID: <894b13be-20a3-6855-0136-6419700fa3e9@ozlabs.ru>
Date:   Thu, 8 Jul 2021 12:22:53 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:89.0) Gecko/20100101
 Thunderbird/89.0
Subject: Re: [PATCH kernel] KVM: PPC: Book3S HV: Make unique debugfs nodename
Content-Language: en-US
To:     Fabiano Rosas <farosas@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
        Paul Mackerras <paulus@ozlabs.org>
References: <20210707041344.3803554-1-aik@ozlabs.ru>
 <87zguynhfo.fsf@linux.ibm.com>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
In-Reply-To: <87zguynhfo.fsf@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/07/2021 03:48, Fabiano Rosas wrote:
> Alexey Kardashevskiy <aik@ozlabs.ru> writes:
> 
>> Currently it is vm-$currentpid which works as long as there is just one
>> VM per the userspace (99.99% cases) but produces a bunch
>> of "debugfs: Directory 'vm16679' with parent 'kvm' already present!"
>> when syzkaller (syscall fuzzer) is running so only one VM is present in
>> the debugfs for a given process.
>>
>> This changes the debugfs node to include the LPID which alone should be
>> system wide unique. This leaves the existing pid for the convenience of
>> matching the VM's debugfs with the running userspace process (QEMU).
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> 
> Reviewed-by: Fabiano Rosas <farosas@linux.ibm.com>

thanks.

Strangely it also fixes a bunch of

BUG: unable to handle kernel NULL pointer dereference in corrupted
BUG: unable to handle kernel paging request in corrupted

I was having 3 of these for every hour of running syzkaller and not 
anymore with this patch.


> 
>> ---
>>   arch/powerpc/kvm/book3s_hv.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
>> index 1d1fcc290fca..0223ddc0eed0 100644
>> --- a/arch/powerpc/kvm/book3s_hv.c
>> +++ b/arch/powerpc/kvm/book3s_hv.c
>> @@ -5227,7 +5227,7 @@ static int kvmppc_core_init_vm_hv(struct kvm *kvm)
>>   	/*
>>   	 * Create a debugfs directory for the VM
>>   	 */
>> -	snprintf(buf, sizeof(buf), "vm%d", current->pid);
>> +	snprintf(buf, sizeof(buf), "vm%d-lp%ld", current->pid, lpid);
>>   	kvm->arch.debugfs_dir = debugfs_create_dir(buf, kvm_debugfs_dir);
>>   	kvmppc_mmu_debugfs_init(kvm);
>>   	if (radix_enabled())

-- 
Alexey
