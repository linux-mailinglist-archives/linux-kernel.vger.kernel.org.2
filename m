Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B180313EA0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 20:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236029AbhBHTOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 14:14:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22754 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235060AbhBHRzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 12:55:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612806834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AGNSJcTi1GoljhoR82wLbrQntb542AwjI3pFM5LOGco=;
        b=Kd3CcHzhFdutNPwU2HFT0btZ9mzVCQOXsny/rjL0DXzBvpY3ozjoGmRMxwtB2Q+PKrjpam
        UOANdZiY8GEW8Vrg1lULf1EsgA3/RlFo1SqBUfpGe9zUmSTRDXi61dhcin7Xd9VKzfEU/M
        zdmSVEfkv09HW/CFndGfXFHp7tTyOOk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-583-Oguu71TKOp6N6UQxxFMdjA-1; Mon, 08 Feb 2021 12:53:53 -0500
X-MC-Unique: Oguu71TKOp6N6UQxxFMdjA-1
Received: by mail-wr1-f72.google.com with SMTP id x12so13678025wrw.21
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 09:53:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AGNSJcTi1GoljhoR82wLbrQntb542AwjI3pFM5LOGco=;
        b=fwXy+AlCAcAq3fPyW/rSZfPN6rPkogs9dMiaCW2BFwAWAQK5IUtwHjjiS+Ly0AP7Uh
         qFYZz8e2wqquzvOAJfxhZQa/KwmbvQ4vbYMd5uTxt4MGNgLR8d9Kj/+MSMX2qhzgqeCa
         dhJVeDtcBYNhA+TS0abTcf08azwJJeUDEQ8FRSoPO3f5jxGeqdEEZFJcMENf650bqMO+
         QaVir5TEFfYAWBSw4RTZsZ4N+/h9TjHkhveft54RFXYJgOlvdzN+5UT89TZUditoAEes
         OLxF6lug/O4DQDqX2Wtbzk7VmBj5ZC88YJ3RYjytJUY4rCtITHi84Q+pERtLCWEX7Ngs
         Fmvg==
X-Gm-Message-State: AOAM531c/sg89ZzXVdlwpgoQIbwf7ax7Vf5EUJDFJ5759Oettt53c0Dc
        E3wKdweB710A9gbUj3r9RRzgO9meDoX8NsthmHxW4LrS7eG/14rEB4rtKcr0os5mLb7ZFgJumMn
        xhGqhRl46R+swPDruFEQf0DM2
X-Received: by 2002:a1c:6387:: with SMTP id x129mr15900601wmb.84.1612806830720;
        Mon, 08 Feb 2021 09:53:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJySadVeryWc/7vUh0Ff5GUx9WW+NmNKRHZ1APFrdW/36WG32BOLRjVIUusY0dEbCCjEaVe5ig==
X-Received: by 2002:a1c:9dcd:: with SMTP id g196mr14066748wme.30.1612806338634;
        Mon, 08 Feb 2021 09:45:38 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id d16sm29664733wrr.59.2021.02.08.09.45.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 09:45:36 -0800 (PST)
To:     Sean Christopherson <seanjc@google.com>
Cc:     Jing Liu <jing2.liu@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jing2.liu@intel.com
References: <20210207154256.52850-1-jing2.liu@linux.intel.com>
 <20210207154256.52850-4-jing2.liu@linux.intel.com>
 <ae5b0195-b04f-8eef-9e0d-2a46c761d2d5@redhat.com>
 <YCF1d0F0AqPazYqC@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH RFC 3/7] kvm: x86: XSAVE state and XFD MSRs context switch
Message-ID: <77b27707-721a-5c6a-c00d-e1768da55c64@redhat.com>
Date:   Mon, 8 Feb 2021 18:45:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YCF1d0F0AqPazYqC@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/21 18:31, Sean Christopherson wrote:
> On Mon, Feb 08, 2021, Paolo Bonzini wrote:
>> On 07/02/21 16:42, Jing Liu wrote:
>>> In KVM, "guest_fpu" serves for any guest task working on this vcpu
>>> during vmexit and vmenter. We provide a pre-allocated guest_fpu space
>>> and entire "guest_fpu.state_mask" to avoid each dynamic features
>>> detection on each vcpu task. Meanwhile, to ensure correctly
>>> xsaves/xrstors guest state, set IA32_XFD as zero during vmexit and
>>> vmenter.
>>
>> Most guests will not need the whole xstate feature set.  So perhaps you
>> could set XFD to the host value | the guest value, trap #NM if the host XFD
>> is zero, and possibly reflect the exception to the guest's XFD and XFD_ERR.
>>
>> In addition, loading the guest XFD MSRs should use the MSR autoload feature
>> (add_atomic_switch_msr).
> 
> Why do you say that?  I would strongly prefer to use the load lists only if they
> are absolutely necessary.  I don't think that's the case here, as I can't
> imagine accessing FPU state in NMI context is allowed, at least not without a
> big pile of save/restore code.

I was thinking more of the added vmentry/vmexit overhead due to 
xfd_guest_enter xfd_guest_exit.

That said, the case where we saw MSR autoload as faster involved EFER, 
and we decided that it was due to TLB flushes (commit f6577a5fa15d, 
"x86, kvm, vmx: Always use LOAD_IA32_EFER if available", 2014-11-12). 
Do you know if RDMSR/WRMSR is always slower than MSR autoload?

Paolo

