Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA6AF459636
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 21:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbhKVUoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 15:44:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:46488 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231307AbhKVUoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 15:44:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637613656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WRqDdF850L0C93VLFXSpRulH8UU6sU0ROB6ecfELzDs=;
        b=BMI/vdsq6S1nDZ22oFc9UQ/E+Eu7l4BK9WLYRfNnReNWJnbdHPTCQ5b8oZwS/J4RP2sDOF
        VTZPSVJ19Oq2lVNRkTJQCWuQD3X7fVtKMK7JxIyTqeeDq+qFJCRJuqD3s89pmunmuRFKGu
        tWe4cqlrxtcyT0XsSk0SK/5jqS31rLM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-165-jg_rV4FCPdWSHBgMgbeeFA-1; Mon, 22 Nov 2021 15:40:55 -0500
X-MC-Unique: jg_rV4FCPdWSHBgMgbeeFA-1
Received: by mail-wr1-f70.google.com with SMTP id y4-20020adfd084000000b00186b16950f3so3361080wrh.14
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 12:40:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=WRqDdF850L0C93VLFXSpRulH8UU6sU0ROB6ecfELzDs=;
        b=O0BakDB1S+7vhoMF/pbONGnGEYSNLX3uK9SSGrow0AbWnle9pqPERsw5bISDJVEC+Y
         P3AyZ/R6zmdUfZXC3lRX71vZ4u//GJghPKCIAE73ZVqVvWXQcbNo66/uEpxc5u8rliZt
         oUPYkMcfCkWCpdufzsgpENa5+l3R3Yvcrql/RsEyRfTyviQpWfselbIEiTqM6LWfTikJ
         FszxM3Qsft4H42XdZkC3QLpJ270ok0/UtGDdRS1hphdBjaz1iwmPijD1vQv5NnIqkdvj
         jaEHNwbMxjkgvgixWDtJv8QrhqJeA1ghWt086N7UwVvG0/vvD+/aRRDuC2EnibIviB/w
         ZzSA==
X-Gm-Message-State: AOAM530A3Cl2RRMl4kKS81n21hciq+TP5EE3rLDAZkFyPkRozIPM4mAV
        o4MCMvCoqLrFhchLToZr26o4MD+OcJOxWKDHvcQxFZCrTL3MDkTiqSf0b7gCitl28NLWqZO/6iN
        2rCV1DJF1WVMgiBUG2ZU9IaRn
X-Received: by 2002:a05:600c:b43:: with SMTP id k3mr33145708wmr.159.1637613654390;
        Mon, 22 Nov 2021 12:40:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzEBNm2G6Vn2RWskud4VMr0M2tZtX7miMSSkO0U/YK7/s72UGaytBV8OE+JlhmPzUPOrKU4+A==
X-Received: by 2002:a05:600c:b43:: with SMTP id k3mr33145679wmr.159.1637613654177;
        Mon, 22 Nov 2021 12:40:54 -0800 (PST)
Received: from ?IPv6:2a0c:5a80:3c10:3400:3c70:6643:6e71:7eae? ([2a0c:5a80:3c10:3400:3c70:6643:6e71:7eae])
        by smtp.gmail.com with ESMTPSA id z5sm27398883wmp.26.2021.11.22.12.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 12:40:53 -0800 (PST)
Message-ID: <0e948a211bd8d63ba05594fb8c03bf3a77a227a0.camel@redhat.com>
Subject: Re: [RFC PATCH 2/2] KVM: arm64: export cntvoff in debugfs
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, rostedt@goodmis.org,
        james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
        linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        mingo@redhat.com, mtosatti@redhat.com, nilal@redhat.com
Date:   Mon, 22 Nov 2021 21:40:52 +0100
In-Reply-To: <87fsrs732b.wl-maz@kernel.org>
References: <20211119102117.22304-1-nsaenzju@redhat.com>
         <20211119102117.22304-3-nsaenzju@redhat.com> <87fsrs732b.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc, thanks for the review.

On Fri, 2021-11-19 at 12:17 +0000, Marc Zyngier wrote:
> On Fri, 19 Nov 2021 10:21:18 +0000,
> Nicolas Saenz Julienne <nsaenzju@redhat.com> wrote:
> > 
> > While using cntvct as the raw clock for tracing, it's possible to
> > synchronize host/guest traces just by knowing the virtual offset applied
> > to the guest's virtual counter.
> > 
> > This is also the case on x86 when TSC is available. The offset is
> > exposed in debugfs as 'tsc-offset' on a per vcpu basis. So let's
> > implement the same for arm64.
> 
> How does this work with NV, where the guest hypervisor is in control
> of the virtual offset? 

TBH I handn't thought about NV. Looking at it from that angle, I now see my
approach doesn't work on hosts that use CNTVCT (regardless of NV). Upon
entering into a guest, we change CNTVOFF before the host is done with tracing,
so traces like 'kvm_entry' will have weird timestamps. I was just lucky that
the hosts I was testing with use CNTPCT.

I believe the solution would be to be able to force a 0 offset between
guest/host. With that in mind, is there a reason why kvm_timer_vcpu_init()
imposes a non-zero one by default? I checked out the commits that introduced
that code, but couldn't find a compelling reason. VMMs can always change it
through KVM_REG_ARM_TIMER_CNT afterwards.

> I also wonder why we need this when userspace already has direct access to
> that information without any extra kernel support (read the CNTVCT view of
> the vcpu using the ONEREG API, subtract it from the host view of the counter,
> job done).

Well IIUC, you're at the mercy of how long it takes to return from the ONEREG
ioctl. The results will be skewed. For some workloads, where low latency is
key, we really need high precision traces in the order of single digit us or
even 100s of ns. I'm not sure you'll be able to get there with that approach.

[...]

> > diff --git a/arch/arm64/kvm/debugfs.c b/arch/arm64/kvm/debugfs.c
> > new file mode 100644
> > index 000000000000..f0f5083ea8d4
> > --- /dev/null
> > +++ b/arch/arm64/kvm/debugfs.c
> > @@ -0,0 +1,25 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2021 Red Hat Inc.
> > + */
> > +
> > +#include <linux/kvm_host.h>
> > +#include <linux/debugfs.h>
> > +
> > +#include <kvm/arm_arch_timer.h>
> > +
> > +static int vcpu_get_cntv_offset(void *data, u64 *val)
> > +{
> > +	struct kvm_vcpu *vcpu = (struct kvm_vcpu *)data;
> > +
> > +	*val = timer_get_offset(vcpu_vtimer(vcpu));
> > +
> > +	return 0;
> > +}
> > +
> > +DEFINE_SIMPLE_ATTRIBUTE(vcpu_cntvoff_fops, vcpu_get_cntv_offset, NULL, "%lld\n");
> > +
> > +void kvm_arch_create_vcpu_debugfs(struct kvm_vcpu *vcpu, struct dentry *debugfs_dentry)
> > +{
> > +	debugfs_create_file("cntvoff", 0444, debugfs_dentry, vcpu, &vcpu_cntvoff_fops);
> > +}
> 
> This should be left in arch_timer.c until we actually need it for
> multiple subsystems. When (and if) that happens, we will expose
> per-subsystem debugfs initialisers instead of exposing the guts of the
> timer code.

Noted.

-- 
Nicolás Sáenz

