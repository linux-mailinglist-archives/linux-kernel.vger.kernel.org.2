Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671A234AD3C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 18:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhCZRRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 13:17:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35898 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230233AbhCZRRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 13:17:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616779056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mEEFXRI0haCPgEoj51KZ0TTntyj6AagoVCMBBQHaCvk=;
        b=X4CYAm9jLrmHeJWi2+9KrnAwjyngd2EECxIYes58RHSShneyPMvnWM+S0zs9Wh90XmXjQG
        LV7fNSeMyNb26P3/GqpDJWrqkvgbFvSa6YaLzDx601tKEg7sFxZxGQwzgBmdqMxe1ABh1f
        9736czYC9u8bORhxYHDW72ikBwrAZ54=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-v8-zEBjLO6qhG4JGUc3H3A-1; Fri, 26 Mar 2021 13:17:34 -0400
X-MC-Unique: v8-zEBjLO6qhG4JGUc3H3A-1
Received: by mail-wm1-f70.google.com with SMTP id g187so866714wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 10:17:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mEEFXRI0haCPgEoj51KZ0TTntyj6AagoVCMBBQHaCvk=;
        b=qyRi5VdsZrN9o3FBW5uc8axd3Yrjt+EvjjLy/vfrbfta4lLudKIuy635BhTLxSFFwD
         pPyhe+Cv1ACfoQMIdTBqt4BTJmPSKN09KmDw+4afxbLY6PEl6tiFuXvF6WfYfokPi0bs
         KBx5oEruRGjbhwSnQ5+WciqCEKRVxkPVKp8IReHTyQLrbTdp35kbv0PcXJ/i5/PKA9Vc
         2tI5hmoXeTDpt+B3IwmHmjhmkDorYcysgc9nqaf0LgeF+AZPpkj32vj7R+C8jF3hCZmc
         2KV4W27nbElr2pQlc0RMtt7qtDF7UKJU34Puen2TF9nYWIbKMHp8gH/iLWGFu7zCEpVd
         G0SA==
X-Gm-Message-State: AOAM530PxVt/H+THnC6ttYT0t9eVJxDUAEjKbJda2jSb3aIPCXBimMO/
        ihJLHWE0qLsGbZbkaD9QQj7oolkgEfGVe8EvN1TRkC4Qb5HR99ORZtgK0M0qgMbKCDcJNHRlX8D
        vSSBCHUcrHT4D4I20WCFAERsiHvd1pPgpXq9l1IFu4il3gkRz6+6mUAhEVY5VyXABvf/Px3BY+9
        cb
X-Received: by 2002:a5d:4e48:: with SMTP id r8mr15116731wrt.276.1616779052603;
        Fri, 26 Mar 2021 10:17:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygIbw9AH1Dl8SfS3n9BfFo/8Npev5hJgg5emJQHMJVFvsusaS1yx+C4E0KLz3Gy7niIFkspw==
X-Received: by 2002:a5d:4e48:: with SMTP id r8mr15116698wrt.276.1616779052312;
        Fri, 26 Mar 2021 10:17:32 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id s3sm11722803wmd.21.2021.03.26.10.17.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Mar 2021 10:17:31 -0700 (PDT)
Subject: Re: [PATCH v2] selftests: kvm: make hardware_disable_test less
 verbose
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andrew Jones <drjones@redhat.com>, linux-kernel@vger.kernel.org
References: <20210323104331.1354800-1-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <222fc568-399e-b3c4-5354-09169edcb78f@redhat.com>
Date:   Fri, 26 Mar 2021 18:17:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210323104331.1354800-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/21 11:43, Vitaly Kuznetsov wrote:
> hardware_disable_test produces 512 snippets like
> ...
>   main: [511] waiting semaphore
>   run_test: [511] start vcpus
>   run_test: [511] all threads launched
>   main: [511] waiting 368us
>   main: [511] killing child
> 
> and this doesn't have much value, let's print this info with pr_debug().
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>   tools/testing/selftests/kvm/hardware_disable_test.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/hardware_disable_test.c b/tools/testing/selftests/kvm/hardware_disable_test.c
> index 2f2eeb8a1d86..5aadf84c91c0 100644
> --- a/tools/testing/selftests/kvm/hardware_disable_test.c
> +++ b/tools/testing/selftests/kvm/hardware_disable_test.c
> @@ -108,7 +108,7 @@ static void run_test(uint32_t run)
>   	kvm_vm_elf_load(vm, program_invocation_name, 0, 0);
>   	vm_create_irqchip(vm);
>   
> -	fprintf(stderr, "%s: [%d] start vcpus\n", __func__, run);
> +	pr_debug("%s: [%d] start vcpus\n", __func__, run);
>   	for (i = 0; i < VCPU_NUM; ++i) {
>   		vm_vcpu_add_default(vm, i, guest_code);
>   		payloads[i].vm = vm;
> @@ -124,7 +124,7 @@ static void run_test(uint32_t run)
>   			check_set_affinity(throw_away, &cpu_set);
>   		}
>   	}
> -	fprintf(stderr, "%s: [%d] all threads launched\n", __func__, run);
> +	pr_debug("%s: [%d] all threads launched\n", __func__, run);
>   	sem_post(sem);
>   	for (i = 0; i < VCPU_NUM; ++i)
>   		check_join(threads[i], &b);
> @@ -147,16 +147,16 @@ int main(int argc, char **argv)
>   		if (pid == 0)
>   			run_test(i); /* This function always exits */
>   
> -		fprintf(stderr, "%s: [%d] waiting semaphore\n", __func__, i);
> +		pr_debug("%s: [%d] waiting semaphore\n", __func__, i);
>   		sem_wait(sem);
>   		r = (rand() % DELAY_US_MAX) + 1;
> -		fprintf(stderr, "%s: [%d] waiting %dus\n", __func__, i, r);
> +		pr_debug("%s: [%d] waiting %dus\n", __func__, i, r);
>   		usleep(r);
>   		r = waitpid(pid, &s, WNOHANG);
>   		TEST_ASSERT(r != pid,
>   			    "%s: [%d] child exited unexpectedly status: [%d]",
>   			    __func__, i, s);
> -		fprintf(stderr, "%s: [%d] killing child\n", __func__, i);
> +		pr_debug("%s: [%d] killing child\n", __func__, i);
>   		kill(pid, SIGKILL);
>   	}
>   
> 

Queued, thanks.

Paolo

