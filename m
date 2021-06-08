Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6144439EAC1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 02:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbhFHAgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 20:36:52 -0400
Received: from mail-pl1-f182.google.com ([209.85.214.182]:40636 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbhFHAgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 20:36:51 -0400
Received: by mail-pl1-f182.google.com with SMTP id e7so9667319plj.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 17:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VjYZkdAh6XPRWdRICkFVqrEq2Tj+cpaidhfkOKHJ4Ys=;
        b=VxDpUN2YqnA3P9FRBWtKzfkmPb7dN1ye0DLknStv0JLAD0lfAYJiloty4u2A2nLkC2
         pGtWItn3Gvk4OP+7W0gKfvq98YmCnreZ6G/AZanLijfQNUOgVlrZ57WL8DFZXizrrFVy
         pmUSWL5JCCSY4etvrLNznIf4K9hXQGkpCBFTVTI4XOMiUB/Joal4/q8VPtGA9Ih4BiOS
         EGSFYbQ82tzTIw30T6l7qvgwYlkqNJqFbJ27IJ0ytbAqLkt0vhbwxiEl8wqEmw5Lt4U0
         wUXZq1UWdi9HNXQISzwxdhUUp292917s71LULkIm/re9u/Z/7gCBLrDa+fqdIoRIgynB
         K5fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VjYZkdAh6XPRWdRICkFVqrEq2Tj+cpaidhfkOKHJ4Ys=;
        b=Xu5MWOi1rmHM6w7xDD64V/R44P9/hudg6mbSmuxyr/vPzVOUURXFRqoR3SJW9kWBfo
         2hXZzRk/wXlsWbbt6r60odfP7xpyQt9AmhSJnY1eyCmMtgSypxAM+VSetrQylZ7medUH
         tSzfhv8hUaaXF4F4F0fG2Fi1CmRyYrsyTe5JoDIFcH46GKMnPQVjYs9rARCtL2KQdJVy
         CeOr4BHE7E1zx1DEc59tdB+R5O+Gpab1A4qfVkujOdf//a4R/ufhvQLumD9tF48shmOn
         uW/yAy28md/4p2lApYnPSLsQlCdtHXQUY3bysH4RnZrwMTARC9BI730PzA+NPBNMpz/k
         gnZQ==
X-Gm-Message-State: AOAM53025oG3LFet9Rhlmpjs7T5NlPgBl4ahVozrL1QQKqRVg5FNARKG
        2kDlOxj3CJjl7ifpHf7xkxrLfg==
X-Google-Smtp-Source: ABdhPJxnA3XzhRo8+VYT28itEv6F2Z/s5O1sM7tVTLKsRNjAihqVyM93md4xbDZEh+bPzrNNoLjm1Q==
X-Received: by 2002:a17:90a:7f85:: with SMTP id m5mr23359411pjl.128.1623112438897;
        Mon, 07 Jun 2021 17:33:58 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id t19sm490189pjq.44.2021.06.07.17.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 17:33:58 -0700 (PDT)
Date:   Tue, 8 Jun 2021 00:33:54 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: X86: reset and read st->preempted in atomic way
Message-ID: <YL668lnelAVNlLWx@google.com>
References: <CANRm+CypKbrhwFR-jLCuUruXwApq4Tb62U_KP_4H-_=7yX1VQg@mail.gmail.com>
 <20210531174628.10265-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210531174628.10265-1-jiangshanlai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nit: the shortlog is somewhat inaccurate now, maybe just:

  KVM: x86: Ensure PV TLB flush tracepoint reflects KVM behavior

or something along those lines.  Not sure what the best wording is :-/

On Tue, Jun 01, 2021, Lai Jiangshan wrote:
> From: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> In record_steal_time(), st->preempted is read twice, and
> trace_kvm_pv_tlb_flush() might output result inconsistent if
> kvm_vcpu_flush_tlb_guest() see a different st->preempted later.
> 
> It is a very trivial problem and hardly has actual harm and can be
> avoided by reseting and reading st->preempted in atomic way via xchg().
> 
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>

I saw this quirk too, but couldn't quite bring myself to care enought to test a
patch :-)

Reviewed-by: Sean Christopherson <seanjc@google.com> 
