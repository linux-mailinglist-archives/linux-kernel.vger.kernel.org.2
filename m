Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7BB94292E3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 17:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbhJKPQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 11:16:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58168 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233622AbhJKPQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 11:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633965245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JzSZRIiW+aXjnRDBWbHKvvrzYi/BoJ6tma0KiYAtr+s=;
        b=DUX8X5ne/1zDdrR12mvQe93MEyUIFV/TqyFKB90sYfOzG15/BLvbQECCzdWY+yfMHBlo3P
        TZEu9CSc+q1GxBfIeAJLUiJQVtgLv2ZszTl2MuB5EOi5khez4WvCuI1HsOgH7b3vI6L60D
        zjLTRVkDN+RS5Sr5wx/QzV5w0I65EUU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-g8L5aFkuPXquRDLofVAUKA-1; Mon, 11 Oct 2021 11:14:03 -0400
X-MC-Unique: g8L5aFkuPXquRDLofVAUKA-1
Received: by mail-wr1-f72.google.com with SMTP id s18-20020adfbc12000000b00160b2d4d5ebso13616674wrg.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 08:14:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=JzSZRIiW+aXjnRDBWbHKvvrzYi/BoJ6tma0KiYAtr+s=;
        b=suO/6C/BpqgNJnQpNmoVL2zqAa/enrW0KklmeZmpqLU29yfmCNzwnr5AUUI76P6mVr
         hq6T1NTY1vRYy9R6gzzZhpjp7N+1Iwht43neqLcQQ+CY7lhypY4Ep1vHdoOMEvkg4KGK
         YcUa0fPiZBk3E9OeYPTo+ahnkaT6RILfrPxmDF7nzuSVUXoi+TfoUZZDjnUOBKnMaxk8
         R/QvlHfYmYQB8eRybuCdHyNI+pioOvLz9/9x/MrP6qkvyPLvTxMWn674gGBigRpiEfHb
         UTYPv4um23/wLTATqyQwygEiiAnYgslzkvEgU48Y1/sBVGe+K2ifQ5zhbXVZGYStNQ5Q
         6OKw==
X-Gm-Message-State: AOAM533LBvCm9ep8IHbXXzdhl17LU4xrKx5Dd05FZBKLueIs1ehU/YPm
        0mXPp+N7CEizW8GRxr8zq6/+dfEZeraeoeZwNgJiMk6faO22CwJOw6bKUcep7C39qn5kU3AS15H
        jH7jd5nj+6t6ZL/tQJzL2NEH7DsQ0p1CKBMV97xU8tXm3EeArGSE8oxxizEHFqcfZ6mkgcLC0ft
        gW
X-Received: by 2002:adf:a31d:: with SMTP id c29mr24729871wrb.381.1633965241430;
        Mon, 11 Oct 2021 08:14:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyT1w9tE08j6c6gdbrJzeNwlidfRMe/kQM/9ddAAAg0M+wpzHCkafgPVlinl4sjFJeJoSwBhg==
X-Received: by 2002:adf:a31d:: with SMTP id c29mr24729841wrb.381.1633965241174;
        Mon, 11 Oct 2021 08:14:01 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id v4sm11244822wmh.23.2021.10.11.08.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 08:14:00 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] KVM: nVMX: Track whether changes in L0 require
 MSR bitmap for L2 to be rebuilt
In-Reply-To: <YWDaOf/10znebx5S@google.com>
References: <20211004161029.641155-1-vkuznets@redhat.com>
 <20211004161029.641155-4-vkuznets@redhat.com>
 <YWDaOf/10znebx5S@google.com>
Date:   Mon, 11 Oct 2021 17:13:59 +0200
Message-ID: <87zgrfzj9k.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Mon, Oct 04, 2021, Vitaly Kuznetsov wrote:
>> Introduce a flag to keep track of whether MSR bitmap for L2 needs to be
>> rebuilt due to changes in MSR bitmap for L1 or switching to a different
>> L2. This information will be used for Enlightened MSR Bitmap feature for
>> Hyper-V guests.
>> 
>> Note, setting msr_bitmap_changed to 'true' from set_current_vmptr() is
>> not really needed for Enlightened MSR Bitmap as the feature can only
>> be used in conjunction with Enlightened VMCS but let's keep tracking
>> information complete, it's cheap and in the future similar PV feature can
>> easily be implemented for KVM on KVM too.
>> 
>> No functional change intended.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>
> ...
>
>>  void vmx_disable_intercept_for_msr(struct kvm_vcpu *vcpu, u32 msr, int type)
>> diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
>> index 592217fd7d92..eb7a1697bec2 100644
>> --- a/arch/x86/kvm/vmx/vmx.h
>> +++ b/arch/x86/kvm/vmx/vmx.h
>> @@ -148,6 +148,12 @@ struct nested_vmx {
>>  	bool need_vmcs12_to_shadow_sync;
>>  	bool dirty_vmcs12;
>>  
>> +	/*
>> +	 * Indicates whether MSR bitmap for L2 needs to be rebuilt due to
>> +	 * changes in MSR bitmap for L1 or switching to a different L2.
>> +	 */
>> +	bool msr_bitmap_changed;
>
> This is misleading, and arguably wrong.  It's only accurate when used in conjuction
> with a paravirt L1 that states if a VMCS has a dirty MSR bitmap.  E.g. this flag
> will be wrong if L1 changes the address of the bitmap in the VMCS, and it's
> obviously wrong if L1 changes the MSR bitmap itself.
>
> The changelog kind of covers that, but those details will be completely lost to
> readers of the code.

Would it help if we rename 'msr_bitmap_changed' to something?

>
> Would it be illegal from KVM to simply clear the CLEAN bit in the eVMCS at the
> appropriate points?

It would probably be OK to do that while we're in L2, however, in case
we're running L1 things can get messy. E.g. MSR-bitmap for L1 is changed
and we clear the clean bit in the currently mapped eVMCS for L2. Later,
before L1 runs L2, it sets the bit back again indicating 'no changes in
MSR-bitmap-12' and we (erroneously) skip updating MSR-Bitmap-02.

-- 
Vitaly

