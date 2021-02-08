Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFE2313E61
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 20:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236111AbhBHTDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 14:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234859AbhBHRcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 12:32:23 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185DFC06178C
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 09:31:43 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id e9so8198420plh.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 09:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y/QEFnrG7fworsDTM5/MKjQTiO+u2x25yTr8afAVmgQ=;
        b=vkGgrefRLZqcacx0Swj5lRFXVHfQRh8nXwCCS6tpAEEzbySJz8n7z8jqG1Q5mAT/Q6
         vfIIfKHgWaiFB36lOcjq2jOfwN8y9ilnmdP4f0zjh0EMcMJegT/DOhJ6SVUt5dtclhLC
         u+5Wg0JfC4/3jUjAJmgr03jXvwHik5urxL3QTuSnD5J9GXj8mgeOJvVGkutil9dOrNmi
         73MVVmxrl2wLG16l3F+DDE5IHqEjiUBVOecjQGXXF7LI6gPcwhjsAr6ndMy71eG+pHyH
         iqxR9eVA3+kpvBZ40njuozp1rItcZYWtz8NZ0qwtdwWDcFZBT8prBU74StaL4tUjuGKY
         HIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y/QEFnrG7fworsDTM5/MKjQTiO+u2x25yTr8afAVmgQ=;
        b=dJdCWJesgUnUJqC7AW1Snp9xEMEFagqlNiD6r6/pfdOjBVAdZ3M1unc+jQ1+x4cpJq
         Sie5ddCyN0KyoAzTF77q+pTqm1sHD9571AR3CDz0a/c1obzxLwuvOBkJvwYknW33pANq
         tLQJx7dceRUBdQaRfAz5kD7SRtAJVoRyKWeV4/ZSA1K8BfnZl5GlWzwsIoBfQDY5H1i7
         nZ9hDAITwd3BKRapqxMlvy+94uAErZXtDSKcdoVlz/V2Bwc/aFYMjGBCI4KgXW1Xy6Oi
         +6cYaJGIK+Fp8v2qJT+9jhA7kEIYzO57qnZlyiks6ZwB0A3yGKIZMI/FTKV3olQjWYz3
         qHqQ==
X-Gm-Message-State: AOAM531hAfdHIBZgcnfGOvzXunDMYLB/X9g8J11Ut6Yn/S0QC+IMcIgR
        ifNiTQiqD+DXOKcYEj4QDxndEA==
X-Google-Smtp-Source: ABdhPJxHZfWM0wz97VDIGgC9GwCHDFIbGFR6QLFyKQiOAyZYiyj3at+PnA6eWyWbvEVbAFrEX1eM2A==
X-Received: by 2002:a17:90a:757:: with SMTP id s23mr17896192pje.39.1612805502414;
        Mon, 08 Feb 2021 09:31:42 -0800 (PST)
Received: from google.com ([2620:15c:f:10:e4db:abc1:a5c0:9dbc])
        by smtp.gmail.com with ESMTPSA id k6sm20726631pgk.36.2021.02.08.09.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 09:31:41 -0800 (PST)
Date:   Mon, 8 Feb 2021 09:31:35 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Jing Liu <jing2.liu@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jing2.liu@intel.com
Subject: Re: [PATCH RFC 3/7] kvm: x86: XSAVE state and XFD MSRs context switch
Message-ID: <YCF1d0F0AqPazYqC@google.com>
References: <20210207154256.52850-1-jing2.liu@linux.intel.com>
 <20210207154256.52850-4-jing2.liu@linux.intel.com>
 <ae5b0195-b04f-8eef-9e0d-2a46c761d2d5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae5b0195-b04f-8eef-9e0d-2a46c761d2d5@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021, Paolo Bonzini wrote:
> On 07/02/21 16:42, Jing Liu wrote:
> > |In KVM, "guest_fpu" serves for any guest task working on this vcpu
> > during vmexit and vmenter. We provide a pre-allocated guest_fpu space
> > and entire "guest_fpu.state_mask" to avoid each dynamic features
> > detection on each vcpu task. Meanwhile, to ensure correctly
> > xsaves/xrstors guest state, set IA32_XFD as zero during vmexit and
> > vmenter.|
> 
> Most guests will not need the whole xstate feature set.  So perhaps you
> could set XFD to the host value | the guest value, trap #NM if the host XFD
> is zero, and possibly reflect the exception to the guest's XFD and XFD_ERR.
> 
> In addition, loading the guest XFD MSRs should use the MSR autoload feature
> (add_atomic_switch_msr).

Why do you say that?  I would strongly prefer to use the load lists only if they
are absolutely necessary.  I don't think that's the case here, as I can't
imagine accessing FPU state in NMI context is allowed, at least not without a
big pile of save/restore code.
