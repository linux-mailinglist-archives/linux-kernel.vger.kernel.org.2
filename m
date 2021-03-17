Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3D333EF0D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 12:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbhCQLCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 07:02:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57516 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231189AbhCQLB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 07:01:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615978918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8UuCsD850dkXejHGU+2PtFbLb7htKiE2TVgMOJIoD6g=;
        b=fDTe4NiWqwSGHayzI4Qzo02QKkcaczzWGM5OhV9DsyVFceiq2U3Eu/imE1sQCfV0jYtwc7
        Jty4St78qPqRQ/nWBfeLndvfhRxBGgqFxWLWLAFz5v4gl9NU6sYFN4amFGcqu/EP768p4g
        X6Y7ivvcdrxnjAx3Tt5H6qgmzUb0btw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-XJmBAvBvNsSvJl7IUIsVMA-1; Wed, 17 Mar 2021 07:01:55 -0400
X-MC-Unique: XJmBAvBvNsSvJl7IUIsVMA-1
Received: by mail-wr1-f71.google.com with SMTP id h30so18263549wrh.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 04:01:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8UuCsD850dkXejHGU+2PtFbLb7htKiE2TVgMOJIoD6g=;
        b=abYOV7I5wNS1rAvc5pQ5nUoJMa+rpWBYkZimloDdi+jcE1a7UFxAXVBdqRH2AOdvtB
         mf3OYxTOPgDvxvAPipxXz2a0fqwAXP4ZfsVnMLGQv3elOVd8sUx0MTM4Fmq8+sbMrEAw
         qAx2ixIQNx8btJwAU7IAV3U5Mj0yX/upLZUbcx02PYVPyVUxCn6uN4KO9xgx8BBJL0kq
         /k6eRRTqr1zjjgR3EIpiU00/KP83fWoH4WfeW5XZJBrHR0wlYd22VCWBy7ynH+JcPpcT
         T12TBwX0QR0OFsQ/b4tFo38yHtqhpF1tm5SaW64anwwkyaw1h0ZKKxOSu4A0D+X3xnSu
         gt/A==
X-Gm-Message-State: AOAM532fp7lKWqJ22KYjGpmt9N8zrIzDDzwqMVoCLbP1aJsFQD/mywOi
        ZGw5FtXcuXZZg+NsR7A7lL6Mb0VrkjRM20wpKiXktxYIWI1W4S6cFWldKkiqHWZq/Er0lGkP0Hg
        U4tsypMybjy/YkFxLLk+DaRPH
X-Received: by 2002:a5d:570b:: with SMTP id a11mr3773349wrv.281.1615978909064;
        Wed, 17 Mar 2021 04:01:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0VbLKaFTaCVqAGRs1rbeHF4D2KRhuHJRPmfB/eQ82N3o85USqkuU5BHbA8VdPUP1BHaQSpw==
X-Received: by 2002:a5d:570b:: with SMTP id a11mr3773334wrv.281.1615978908914;
        Wed, 17 Mar 2021 04:01:48 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id e1sm26436179wrd.44.2021.03.17.04.01.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 04:01:48 -0700 (PDT)
To:     Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        linux-kselftest@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20210317074426.8224-1-eesposit@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] selftests/kvm: add set_boot_cpu_id test
Message-ID: <c4adbfcd-1c5a-3f7a-7d61-206964256963@redhat.com>
Date:   Wed, 17 Mar 2021 12:01:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210317074426.8224-1-eesposit@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/21 08:44, Emanuele Giuseppe Esposito wrote:
> +	printf("vcpu executing...\n");
> +	vcpu_run(vm, vcpuid);
> +	printf("vcpu executed\n");
> +
> +	switch (get_ucall(vm, vcpuid, &uc)) {
> +	case UCALL_SYNC:
> +		printf("stage %d sync %ld\n", stage, uc.args[1]);
> +		TEST_ASSERT(!strcmp((const char *)uc.args[0], "hello") &&
> +			    uc.args[1] == stage + 1,
> +			    "Stage %d: Unexpected register values vmexit, got %lx",
> +			    stage + 1, (ulong)uc.args[1]);
> +		return;
> +	case UCALL_DONE:
> +		printf("got done\n");

You can remove the printfs here.

> +		return;
> +	case UCALL_ABORT:
> +		TEST_ASSERT(false, "%s at %s:%ld\n\tvalues: %#lx, %#lx", (const char *)uc.args[0],
> +			    __FILE__, uc.args[1], uc.args[2], uc.args[3]);
> +	default:
> +		TEST_ASSERT(false, "Unexpected exit: %s",
> +			    exit_reason_str(vcpu_state(vm, vcpuid)->exit_reason));
> +	}
> +}
> +
> +static void add_x86_vcpu(struct kvm_vm *vm, uint32_t vcpuid, void *code)
> +{
> +	vm_vcpu_add_default(vm, vcpuid, code);
> +	vcpu_set_cpuid(vm, vcpuid, kvm_get_supported_cpuid());
> +}
> +
> +static void run_vm_bsp(uint32_t bsp_vcpu)
> +{
> +	struct kvm_vm *vm;
> +	int stage;
> +	void *vcpu0_code, *vcpu1_code;
> +
> +	vm = create_vm();
> +
> +	vcpu0_code = guest_bsp_vcpu;
> +	vcpu1_code = guest_not_bsp_vcpu;
> +
> +	if (bsp_vcpu == VCPU_ID1) {
> +		vcpu0_code = guest_not_bsp_vcpu;
> +		vcpu1_code = guest_bsp_vcpu;
> +
> +		vm_ioctl(vm, KVM_SET_BOOT_CPU_ID, (void *) VCPU_ID1);
> +	}
> +
> +	add_x86_vcpu(vm, VCPU_ID0, vcpu0_code);
> +	add_x86_vcpu(vm, VCPU_ID1, vcpu1_code);
> +
> +	for (stage = 0; stage < 2; stage++) {
> +		run_vcpu(vm, VCPU_ID0, stage);
> +		run_vcpu(vm, VCPU_ID1, stage);
> +	}

These are just stylistic nits, but:

1) you could pass a bool to add_x86_vcpu, like

	add_x86_vcpu(vm, VCPU_ID0, bsp_vcpu == VCPU_ID0);
	add_x86_vcpu(vm, VCPU_ID1, bsp_vcpu == VCPU_ID1);

instead of having the vcpu0_code and vcpu1_code pointers.

2) you could move the for loop inside run_vcpu.  This way you can assert 
that you get UCALL_DONE when stage == 2.

> +	kvm_vm_free(vm);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	if (!kvm_check_cap(KVM_CAP_SET_BOOT_CPU_ID)) {
> +		print_skip("set_boot_cpu_id not available");
> +		return 0;
> +	}
> +
> +	run_vm_bsp(VCPU_ID0);
> +	run_vm_bsp(VCPU_ID1);
> +	run_vm_bsp(VCPU_ID0);

Looks good!  Just another small change: since this third test is not 
adding much, you could instead invoke KVM_SET_BOOT_CPU_ID(VCPU_ID1) 
*after* the creation of the vCPUs instead of before.  This should fail 
with -EBUSY, and vcpu 0 will remain the BSP.

Paolo

