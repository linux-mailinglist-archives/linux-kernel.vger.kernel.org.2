Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEAF44D882
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 15:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbhKKOra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 09:47:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:39985 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233722AbhKKOr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 09:47:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636641880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9h35ss/MZV4b7BsVK6YSJJk8fuPoOjbqo9hy449dhgU=;
        b=Uz6yzdfzswbrabN4FXGSttdkKJ/Jy8KXg7AwP+h6lfT5yPl1g3H4tqJ84rB5SprioqVc/0
        kQ8uYbdDex78tftbjFPUic9ayr6zdwT+ptFaQvbcpjEXVPycxuOxPtmTCWmBh2IRzqK8x7
        lg8/H+2+NroiHHHXDBaeL/pK9vfvy/U=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-RKX4T0HCNLi-BlS4ksV1yw-1; Thu, 11 Nov 2021 09:44:39 -0500
X-MC-Unique: RKX4T0HCNLi-BlS4ksV1yw-1
Received: by mail-ed1-f69.google.com with SMTP id x13-20020a05640226cd00b003e2bf805a02so5539557edd.23
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 06:44:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=9h35ss/MZV4b7BsVK6YSJJk8fuPoOjbqo9hy449dhgU=;
        b=q6aSsrjA6Ubth+YJpjfjsS/B77z2O7aqHiu6GIFS1x0sLV3p1Oj8nm22ZPncF8rbAB
         Plbqkdp/hjxT45bj+Ap85VG2wrMCHCxb1GbWtNSPc1BoiQIDcZpBbyCdGZ0P0hwA30QA
         YWJhhda10U3VAl4xGOf7tbSutTAfkrrLknzG2u72d9oIc2zlDqvfgH+/gZsmpwKOtwNJ
         H6XGhbwIzZr0u4XVBf5D+LIksCmc29ALVqkE9xkWho5yY+p5oaUWdRqUdotVz9ifYNAy
         rtBN1En096n0J9UPZ3vU+HhdKw1plephoMrFiIEuJrZegca2wizeXfOn+bATIFbpNtns
         bXIQ==
X-Gm-Message-State: AOAM532d0O9K4nSvXm0L+Jpw8W4CKMA5NydfEcZ92ipScp1zf971FFBs
        mnKibciKoJFWO7gHbWXRXGdP1AQPrFzubPr/jyViEdoeMPG3Pc7oSNL04ccTPsdGPa/U+br2fzB
        Iq26nUntEorKfMq+hfM0c8wkj0v9tYCJ0K2XZEEmnPh2VZuHpB5RgiQ8JX2DmhSOefh91NbKKCn
        uF
X-Received: by 2002:a05:6402:524b:: with SMTP id t11mr10875870edd.98.1636641877923;
        Thu, 11 Nov 2021 06:44:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJymshSnBa02uZ+mhC68CkdDPxQgbf+jB00yvDwjrbLe9OLRw94VZDtbrVjyAffqcbZU9xGRQA==
X-Received: by 2002:a05:6402:524b:: with SMTP id t11mr10875844edd.98.1636641877764;
        Thu, 11 Nov 2021 06:44:37 -0800 (PST)
Received: from fedora (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id m9sm1420991eje.102.2021.11.11.06.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 06:44:37 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Eduardo Habkost <ehabkost@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] KVM: x86: Drop arbitraty KVM_SOFT_MAX_VCPUS
In-Reply-To: <YY0qgUqM3CuDHWgB@google.com>
References: <20211111134733.86601-1-vkuznets@redhat.com>
 <5cdb6982-d4ec-118e-2534-9498196d11b8@redhat.com>
 <YY0qgUqM3CuDHWgB@google.com>
Date:   Thu, 11 Nov 2021 15:44:36 +0100
Message-ID: <87bl2qg3aj.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Thu, Nov 11, 2021, Paolo Bonzini wrote:
>> On 11/11/21 14:47, Vitaly Kuznetsov wrote:
>> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> > index ac83d873d65b..91ef1b872b90 100644
>> > --- a/arch/x86/kvm/x86.c
>> > +++ b/arch/x86/kvm/x86.c
>> > @@ -4137,7 +4137,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>> >   		r = !static_call(kvm_x86_cpu_has_accelerated_tpr)();
>> >   		break;
>> >   	case KVM_CAP_NR_VCPUS:
>> > -		r = KVM_SOFT_MAX_VCPUS;
>> > +		r = num_online_cpus();
>
> I doubt it matters much in practice, but this really should be
>
> 		r = min(num_online_cpus(), KVM_MAX_VCPUS);
>

Nice catch, actually! It makes no sense to recommend > KVM_MAX_VCPUS. We
should fix this across all arches though, I'll take that as an action
item.

-- 
Vitaly

