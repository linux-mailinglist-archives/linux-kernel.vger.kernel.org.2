Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33BC142684F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 12:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239982AbhJHKyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 06:54:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37076 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239651AbhJHKyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 06:54:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633690370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bXeqaJQRHIjGRFMe5JQ357RA8p6YK7boOm1VSZD5rnM=;
        b=KH7WQFZ4TR5wPOQJQZYVEKLIpSOiz3Ha9KwW0hiFA25EYouO7br+2dVu5EiYS5KpHBusza
        gSGzgqp2hIFDLvaSBpIkR3eeRBzsenqC/7cnW+4iTQT/cupAs9KnuOv2OwxDKP9mlQYL2g
        OSf4CNgB6fbPKCHjrKjbKmOrqGbO7vo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-2sIwQGdHOpeh56qddfAQag-1; Fri, 08 Oct 2021 06:52:49 -0400
X-MC-Unique: 2sIwQGdHOpeh56qddfAQag-1
Received: by mail-wr1-f72.google.com with SMTP id h11-20020adfa4cb000000b00160c791a550so6818360wrb.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 03:52:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=bXeqaJQRHIjGRFMe5JQ357RA8p6YK7boOm1VSZD5rnM=;
        b=QqRNJ8tBYIIpUsoTuPLuRjUM6XqP6h/HwoZ8Oxsv2lmikH7AykvVujMCslRpA+2Jsj
         x3B4ykSZsxZJZ4lJTRZ3HBaSsU3U1SN1pRcJUQAloKt9LYMTJyULHuXAZQLRBixVMeVn
         p68qXzih9d2B5vYb1M5dSab99FT5wSUXV3esgKq1B4WGJ1SkfsGwq5vUVRDOj+cMd2FJ
         YaRImTGxel+Im59zj9vmkkG+5NSbvh8sM61dJQ2Z00VY34nBVOwgqkhiVLgyyrHuidtM
         bYo32djwsxamHpJEI/VDlD/5YaiweKHrkmE2EgD8Dl7iDvFkJorzITwjuT4cJr9m9Ike
         mivA==
X-Gm-Message-State: AOAM532NO2J8wUenmGL/Iuis82AgmD+dGSv3E/87jBWFGMU3jkrn/nfq
        EY6YGldjtPWUQOD6Hc2sBZuokj/qvpR3l9yOhFbxy91SnJonIoL49uCatdCJGYOr7KQ49wHdFnI
        UyusaZ8iBwtuAD/4lEYGlYyrt
X-Received: by 2002:a5d:47cd:: with SMTP id o13mr3165145wrc.85.1633690368299;
        Fri, 08 Oct 2021 03:52:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx95/KS3DNJ5vz5xhS/EN/yS2kB8/wbXBtifrJL81st7o9TE+bwlPVJ+PXLSKHW5fXBOiyYkw==
X-Received: by 2002:a5d:47cd:: with SMTP id o13mr3165124wrc.85.1633690368144;
        Fri, 08 Oct 2021 03:52:48 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id e1sm2228739wru.26.2021.10.08.03.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 03:52:47 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 3/3] KVM: LAPIC: Optimize PMI delivering overhead
In-Reply-To: <1633687054-18865-3-git-send-email-wanpengli@tencent.com>
References: <1633687054-18865-1-git-send-email-wanpengli@tencent.com>
 <1633687054-18865-3-git-send-email-wanpengli@tencent.com>
Date:   Fri, 08 Oct 2021 12:52:46 +0200
Message-ID: <87ily73i0x.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wanpeng Li <kernellwp@gmail.com> writes:

> From: Wanpeng Li <wanpengli@tencent.com>
>
> The overhead of kvm_vcpu_kick() is huge since expensive rcu/memory
> barrier etc operations in rcuwait_wake_up(). It is worse when local 
> delivery since the vCPU is scheduled and we still suffer from this. 
> We can observe 12us+ for kvm_vcpu_kick() in kvm_pmu_deliver_pmi() 
> path by ftrace before the patch and 6us+ after the optimization. 
>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  arch/x86/kvm/lapic.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 76fb00921203..ec6997187c6d 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -1120,7 +1120,8 @@ static int __apic_accept_irq(struct kvm_lapic *apic, int delivery_mode,
>  	case APIC_DM_NMI:
>  		result = 1;
>  		kvm_inject_nmi(vcpu);
> -		kvm_vcpu_kick(vcpu);
> +		if (vcpu != kvm_get_running_vcpu())
> +			kvm_vcpu_kick(vcpu);

Out of curiosity,

can this be converted into a generic optimization for kvm_vcpu_kick()
instead? I.e. if kvm_vcpu_kick() is called for the currently running
vCPU, there's almost nothing to do, especially when we already have a
request pending, right? (I didn't put too much though to it)

>  		break;
>  
>  	case APIC_DM_INIT:

-- 
Vitaly

