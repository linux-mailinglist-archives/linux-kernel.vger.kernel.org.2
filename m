Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4E1424A51
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 01:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239725AbhJFXGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 19:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbhJFXGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 19:06:01 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47879C061746
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 16:04:09 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id i65so707769pfe.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 16:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7VGNl1bVaKnqpRjbs3iJ7wg68fh1QpcyuHqmjoJiM0s=;
        b=gL2s4yEO1StLPD6nfJ6/Na4zt+9oEq7ycVcJkG5xgdy0rdR9TdeUtzPlkzNfEVGTB0
         GamjZ5D+kARB0HNJ+8Qm4HMCD/FkbXQQMUE24/pWkKxOCPVgJQcjhogoqWQxGGRNqHBU
         X8pdsouRIXIsiI5v4aR3lBwdzBn14i2nBfCBKCT7I35YJdw2IkaRpmMOqbgK82RwiM20
         aUZfiiu0LfV513D12BXfzFuCWjK0DgVsy018mwK/b0uI/YvqtZ5/JqROwuAosxETvwx7
         D8tLvL6S70xiYUYyXF6zxLHocRWWsfrX1Z36K95szNWWax9Sz2JAKTofwA7IfcZ+7Ohu
         eW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7VGNl1bVaKnqpRjbs3iJ7wg68fh1QpcyuHqmjoJiM0s=;
        b=RN5j6HVlbOcehL5RtO8IhoiHfwFSJnePw46nDSFtID0zAJeRF3PuWXTrHsbmgpFBka
         UAXB4Vins05DGVB/pWUa4HPBQTPqN/I8o5JAH/jWVqmDsdq1lMOMSSJdExeHon+Tc55c
         TTAdK/XZX1hXCxxpVkqJ/l0MIfkkEMUZl0Y9qjh9XnIAZ+AJG2ZmxeypcdUtLUu1mOZh
         um8c2L0lcENdusQqlxSsc5EKo3YxkI2f+a+J9pDaOrpbMyDaQLiE9r5xEIcthIyApz60
         B7x5ZBg8G2rWEHLzZdBR+QGT6Qo76Oig69/hGA+1fjk1DYxxOQWmNWo5oEGOmu96/bhC
         DbLQ==
X-Gm-Message-State: AOAM530RrwUunkYtFSAXCzlCHKQ8iJA6Wxu7Hi5UOcD8DOegrLJA4pve
        qAoSUqbRmBrfHAK43vQflM9L/g==
X-Google-Smtp-Source: ABdhPJxekChk3UVn0xP4vnm7oylhSRjjBuI9okEFoHZz3c0PLAxMIWecw3tyzARhj3hth+lmO5eCWQ==
X-Received: by 2002:a63:6e03:: with SMTP id j3mr585745pgc.465.1633561448652;
        Wed, 06 Oct 2021 16:04:08 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id p9sm20857853pfn.7.2021.10.06.16.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 16:04:08 -0700 (PDT)
Date:   Wed, 6 Oct 2021 23:04:04 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Reiji Watanabe <reijiw@google.com>
Subject: Re: [PATCH v2 06/10] KVM: x86: Fold fx_init() into
 kvm_arch_vcpu_create()
Message-ID: <YV4rZHGII2PaXIGY@google.com>
References: <20210921000303.400537-1-seanjc@google.com>
 <20210921000303.400537-7-seanjc@google.com>
 <87tuie7zhb.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tuie7zhb.fsf@vitty.brq.redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021, Vitaly Kuznetsov wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> > Move the few bits of relevant fx_init() code into kvm_arch_vcpu_create(),
> > dropping the superfluous check on vcpu->arch.guest_fpu that was blindly
> > and wrongly added by commit ed02b213098a ("KVM: SVM: Guest FPU state
> > save/restore not needed for SEV-ES guest").
> 
> I have more questions to the above mentioned commit: why is it OK to
> 'return 0' from kvm_vcpu_ioctl_x86_set_xsave() without writing anything
> to 'guest_xsave'? Same goes to kvm_arch_vcpu_ioctl_get_fpu(). Whould't
> it be better to throw an error as we can't actually get this information
> for encrypted guests? It's probably too late to change this now I
> suppose ...

Yep, I would also have preferred that KVM force userspace to avoid ioctls() that
cannot work, but that ship has sailed.
