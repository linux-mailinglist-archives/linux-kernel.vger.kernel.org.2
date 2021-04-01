Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87794351177
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbhDAJIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:08:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34490 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233736AbhDAJIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:08:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617268097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SH8q6v7mosb9ZWkhGf8eANcJIvuHX/dVnNgdkFE16jE=;
        b=JyuCQVPFwIp/3uxqt6W7vC6AlxMS+8uw2UNA7rWHqxguau+l+0eazFFlNzbYH4llmylV4k
        px3LV4973LiLlktBRLaZmI4uSansLUVeRB6Zt1DH2lxIVDRchJIqMpqjNk+pkoMd+fny94
        cKGqt2iTSR/KCXwKZVIyxv3+JwWPeTE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-uhKuSGaPM3abFDfgIEObTQ-1; Thu, 01 Apr 2021 05:08:16 -0400
X-MC-Unique: uhKuSGaPM3abFDfgIEObTQ-1
Received: by mail-ej1-f71.google.com with SMTP id li22so1958458ejb.18
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 02:08:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=SH8q6v7mosb9ZWkhGf8eANcJIvuHX/dVnNgdkFE16jE=;
        b=byqfzOk63qX4awgE8dzYT8vLQo96+nsG6bdaNRy76dpJ4+DHwDk7uT7ep6YTvor0rP
         2mAns8gXzSUB4rO98vw3mBIokjUG/fca7NqScRqFgm7OMBhrdgTZ+sesM7/NB4KqTPf/
         tkYiSbkO8Ko9LQaUOTxqS3zVsf2awWnB881Xv2kvmcqJkTEyUJp886FvjBHC56U0j0Iz
         R+mEzPhFeFEtkUk5Fwt0gWxj8/NqAMMqJCIAtPPjNXaFuwwOHyxWHH+lFDfYmnltFnTy
         TRRolz7VMMgTd7Z0Zs5JRv63H4PjbD30S9hjeKORGEDgHh903FweVgLrE0UG6jawIWHX
         vERA==
X-Gm-Message-State: AOAM530HTYqFBGmoo/8lL6VVSzyp3nLM6WdzScroCzvUcRVCLhB/MAJu
        ubeSPkeOkir7y0HzJvWMSuUHXrq0eU4dDg3jhDBW5h+Oe4AYNPavTcKZNRSD9bdieq7nx7wNiPn
        Et+XguMqgL9+CcVYgwt6Bnbnz09jY1wfKztIgvEHQIVQVMdDRc+/WMwJVeVXIJpEdXKT8LfEtXM
        g/
X-Received: by 2002:aa7:d296:: with SMTP id w22mr9132653edq.150.1617268094974;
        Thu, 01 Apr 2021 02:08:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxkaDtD/zV8/+g4vA8exSjAqnDTdsDQz0T3HuSz8w49b9Wf/JUk9n3MB5ubq9QTsnrpDORKRg==
X-Received: by 2002:aa7:d296:: with SMTP id w22mr9132630edq.150.1617268094789;
        Thu, 01 Apr 2021 02:08:14 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id x4sm2967618edd.58.2021.04.01.02.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 02:08:14 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>,
        Yang Li <yang.lee@linux.alibaba.com>
Cc:     pbonzini@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: Fix potential memory access error
In-Reply-To: <YGS6XS87HYJdVPFQ@google.com>
References: <1617182122-112315-1-git-send-email-yang.lee@linux.alibaba.com>
 <YGS6XS87HYJdVPFQ@google.com>
Date:   Thu, 01 Apr 2021 11:08:13 +0200
Message-ID: <87mtuis77m.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Wed, Mar 31, 2021, Yang Li wrote:
>> Using __set_bit() to set a bit in an integer is not a good idea, since
>> the function expects an unsigned long as argument, which can be 64bit wide.
>> Coverity reports this problem as
>> 
>> High:Out-of-bounds access(INCOMPATIBLE_CAST)
>> CWE119: Out-of-bounds access to a scalar
>> Pointer "&vcpu->arch.regs_avail" points to an object whose effective
>> type is "unsigned int" (32 bits, unsigned) but is dereferenced as a
>> wider "unsigned long" (64 bits, unsigned). This may lead to memory
>> corruption.
>> 
>> /home/heyuan.shy/git-repo/linux/arch/x86/kvm/kvm_cache_regs.h:
>> kvm_register_is_available
>> 
>> Just use BIT instead.
>
> Meh, we're hosed either way.  Using BIT() will either result in undefined
> behavior due to SHL shifting beyond the size of a u64, or setting random bits
> if the truncated shift ends up being less than 63.
>

A stupid question: why can't we just make 'regs_avail'/'regs_dirty'
'unsigned long' and drop a bunch of '(unsigned long *)' casts? 

-- 
Vitaly

