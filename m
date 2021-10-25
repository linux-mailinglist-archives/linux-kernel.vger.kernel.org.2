Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C831B439887
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 16:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbhJYO24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 10:28:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45156 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233556AbhJYO2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 10:28:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635171983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0JDFR/w0BO+fJnaqyJz0KqLIzoSXAKAPvBzPCJS8rh0=;
        b=hbCJMtC+feXdD4DZpsFhxR0KHosx1zwzyF8Tv1JUfLQGhFPT6Sz9jaYEhXZ8ctLiBr5K/+
        1Af4KNf2fipA4V/TwlqSvOhuL0s5hBfhvsM7MGI8li9fR49uEYSSeK/5IpxDydkWDJz9qy
        I/Q+pHO5qIr6muF9tbKPliOWf9AUoz0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-SUmqaruQPcSzG9aO_dBgNw-1; Mon, 25 Oct 2021 10:26:22 -0400
X-MC-Unique: SUmqaruQPcSzG9aO_dBgNw-1
Received: by mail-ed1-f69.google.com with SMTP id t18-20020a056402021200b003db9e6b0e57so816589edv.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 07:26:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0JDFR/w0BO+fJnaqyJz0KqLIzoSXAKAPvBzPCJS8rh0=;
        b=kCK9h39KytANM2V9BkNcNJz0mWxH8TVcP3hvfXnQYWkWpGXakdjlpr/X9BAogIm9Fs
         4d/honaF/GUdPvwjAjrYpUu0se7Nf26MobdyNurnQYT84IbrBMOpKNsf1/SqaK2o4xUv
         b3FtjGeuuJC2HV72xeKsOTfUV+Ea1UxWQVukoPYVkFREZScYGfHwB3Lx5y7B14yTzbkG
         eFvsWD8/yRtyyYrq1BegWRpqeUyfUcjIlK8yTHOrdlJN5e27OwNppn8kETncOSmKmcTe
         V0e9UXQLwigvm/JL4AlbpQMmYgwmmfUbUdtLvidQ1EIoeAnEHNv45YCGLKHV3SzrBUmG
         lsxA==
X-Gm-Message-State: AOAM532N72cm/N+hn2+jhSWs+Uv9TuOrvXrbzlAJkyz88crmhl0UEw1M
        4eXpFkQ7AALH1fTonI3NJqT9yl6gDhO9dCimUgm0HskLTHXz4HQBpelibjFxEpDJ4R4csc5QXgK
        YO1GKklEJGmfpyDqb+Sm3p8g1
X-Received: by 2002:a50:d78c:: with SMTP id w12mr26913803edi.147.1635171980781;
        Mon, 25 Oct 2021 07:26:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKDlcJy9Ggfa6iOgv+1CVaZWvopovsowDbFDE9dApjZRuZhu/xUobrIcg2Oe5NEBC4id/OJQ==
X-Received: by 2002:a50:d78c:: with SMTP id w12mr26913764edi.147.1635171980582;
        Mon, 25 Oct 2021 07:26:20 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id hs28sm1430847ejc.111.2021.10.25.07.26.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 07:26:19 -0700 (PDT)
Message-ID: <0333be2a-76d8-657a-6c82-3bb5c9ff2e3b@redhat.com>
Date:   Mon, 25 Oct 2021 16:26:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v2 35/43] KVM: SVM: Signal AVIC doorbell iff vCPU is in
 guest mode
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Anup Patel <anup.patel@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
Cc:     James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Atish Patra <atish.patra@wdc.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-mips@vger.kernel.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Matlack <dmatlack@google.com>,
        Oliver Upton <oupton@google.com>,
        Jing Zhang <jingzhangos@google.com>
References: <20211009021236.4122790-1-seanjc@google.com>
 <20211009021236.4122790-36-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211009021236.4122790-36-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/21 04:12, Sean Christopherson wrote:
> +	 */
> +	if (vcpu->mode == IN_GUEST_MODE) {
>   		int cpu = READ_ONCE(vcpu->cpu);
>   
>   		/*
> @@ -687,8 +692,13 @@ int svm_deliver_avic_intr(struct kvm_vcpu *vcpu, int vec)
>   		if (cpu != get_cpu())
>   			wrmsrl(SVM_AVIC_DOORBELL, kvm_cpu_get_apicid(cpu));
>   		put_cpu();
> -	} else
> +	} else {
> +		/*
> +		 * Wake the vCPU if it was blocking.  KVM will then detect the
> +		 * pending IRQ when checking if the vCPU has a wake event.
> +		 */
>   		kvm_vcpu_wake_up(vcpu);
> +	}
>   

Does this still need to check the "running" flag?  That should be a 
strict superset of vcpu->mode == IN_GUEST_MODE.

Paolo

