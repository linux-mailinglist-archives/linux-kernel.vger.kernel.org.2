Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763BF400193
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 16:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349560AbhICOzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 10:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349539AbhICOzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 10:55:52 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DE7C061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 07:54:53 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id k17so3458601pls.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 07:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zcZ/sXt90893FBSCWdUgATs3aWLIfrYQ34PJYV2dZJc=;
        b=hauAnT3zndI3mOqhhNntv1SZlGJfUoSGiJXr48EJkTsGxuROAGNeKRBN7Vb2V7eEer
         /UN2xeYuXQDDHxZQ0JUUT4ZHQRe4aqyBFanYTS2BuVy6a8UzHLPryCKChqXxs2L6weoj
         owtgkAJM/d7SSjG1+IJeAEqR/mpfuh9qPtbb73WtNmOJr4JZyXLf1LUy6tvMzhv6XmFR
         61Mypj7E5M1yZ81tqTQtvHU+EzDhUeh13Z0Y1j/KbcTH6peXG2xnwFOEDyOfyiValpBQ
         iCrpCsxc6JG8nUJUdpu+hG6qgGdh3/oG85ClCoXnqd0DRR9kGwGF98xpgGHxapMbqmKo
         NEyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zcZ/sXt90893FBSCWdUgATs3aWLIfrYQ34PJYV2dZJc=;
        b=JhD2XPh6vEjvuI1sbl+8hKmH7sr4e1ELs/wUzUSgoi2AoOTm5oQ+kSmWcreff3QPKz
         H+vDtXk/ooXbGjQbjHQ6X76Oc4jBYQo9i/DMZLY2F4f+n47emy3p2kDSytALJ6sFn+2F
         Z+ciHB2B9THLrLgsP0e5+poaxNa8jpZXRChF6kuq6Lyj+Dzke5wRwlJZ3rPePYvkfcHL
         UA6VNsEDLhZlJh7soXCDTgoAGE/Ts6LolrRKs+rS675aEi4sSbF/7bIygM7oV/yq/jI5
         0BY+KCt3emFHt53n4gnkKiTeuxGq+Ih8OWH9ClmBPSXvgDfmI79zx+ZRi22iuP5Q+6mI
         EXRA==
X-Gm-Message-State: AOAM532hiJ4hzyqoMfAXhd8sOg3gSBcFgjQjvVVtbLU1+AiEcLrJQaZH
        bfvZbfHgdzpC52D1QXJUxvP7NA==
X-Google-Smtp-Source: ABdhPJx6rBI/0INfExIO/0BvrWyU/n69Lb9NJdoHIhgBLJM4G9ggQFlFrp4zJdJ9j4y9AcG56IKTaQ==
X-Received: by 2002:a17:902:9889:b0:12c:fd88:530b with SMTP id s9-20020a170902988900b0012cfd88530bmr3571237plp.33.1630680892323;
        Fri, 03 Sep 2021 07:54:52 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id n10sm5553799pjp.3.2021.09.03.07.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 07:54:51 -0700 (PDT)
Date:   Fri, 3 Sep 2021 14:54:48 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Eduardo Habkost <ehabkost@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 7/8] KVM: Pre-allocate cpumasks for
 kvm_make_all_cpus_request_except()
Message-ID: <YTI3OL9scNnhFpWA@google.com>
References: <20210827092516.1027264-1-vkuznets@redhat.com>
 <20210827092516.1027264-8-vkuznets@redhat.com>
 <YTE9OsXABLzUitUd@google.com>
 <87o89am8fn.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o89am8fn.fsf@vitty.brq.redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2021, Vitaly Kuznetsov wrote:
> Sean Christopherson <seanjc@google.com> writes:
> >> @@ -5581,9 +5583,15 @@ int kvm_init(void *opaque, unsigned vcpu_size, unsigned vcpu_align,
> >>  		goto out_free_3;
> >>  	}
> >>  
> >> +	for_each_possible_cpu(cpu) {
> >> +		if (!alloc_cpumask_var_node(&per_cpu(cpu_kick_mask, cpu),
> >> +					    GFP_KERNEL, cpu_to_node(cpu)))
> >> +			goto out_free_4;
> >
> > 'r' needs to be explicitly set to -EFAULT, e.g. in the current code it's
> > guaranteed to be 0 here.
> 
> Oops, yes. Any particular reason to avoid -ENOMEM? (hope not, will use
> this in v5)

Huh.  Yes, -ENOMEM.  I have no idea why I typed -EFAULT.
