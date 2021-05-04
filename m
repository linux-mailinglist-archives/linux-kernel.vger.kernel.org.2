Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD65A3731D7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 23:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbhEDVWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 17:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbhEDVWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 17:22:20 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAD3C061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 14:21:23 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id e15so300136pfv.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 14:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4S1+Lbb8bvwn24O+HnZVKhqiDbYHj3lTo0d9nlGMzgM=;
        b=fjBm8NWZyZrrrmTh4i/iwxvRLRliD4H91N+StjRX/d2QvPkwf9XfrIc4OLPo7Nk3ZM
         3ZaJrol/7huD1AfK6eL/IRpAWWcHWBbm94tDjzA14DatkaizFoLqjjwkeN3N7DCXxa1U
         3mwCmfM5HdaHw5Wy/h/7mC3KC4Jb/LRcTUg+ZAlwfH64lozCnCKyBmEhwRENfrXGO5Yk
         JvBgf6Ke6ySB3Du32CeQzimW5Wct4JirV7YwupXG2s9UW+ktdZnnBe1Ihd9byZyqXLAs
         9c5chEpuO+Mo8SS6EzazcjKwRkEOZYx4LBe/YZdgquhiLc6GVd8RQQUZwFiWTi+OZB6L
         Ko+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4S1+Lbb8bvwn24O+HnZVKhqiDbYHj3lTo0d9nlGMzgM=;
        b=FwfADU68rlK9CVSsz8pWc/0MhFeBk0sxgOx3lLlbndQVXF6qhWFgxHIa46l+JcgyAT
         /nAfBxwr5Ag+sJn9apRuVu5gHDnPrg2M9CcMDbJ1sgiUQO0bd0/QXBqRqjgUEQcLhvlz
         udorttFHHGr52mD9tJqdyiAYVUNuvw/3MGoWxhaRBtw8pS8mtg3+W1yiOdEsEJLgqe2S
         Ozc+n2DV/rJ5FHtHqDe/d9BVaZLVUUoQbRjf8YSVr2WHt/R21SZg+2fUJG2kFqeo6Qpu
         OoTKOz4Xxyefm/K3lS1i/4w8tPa9Ae2tVI+9oQYH9zISylQQY5Qi26S1VyYEx365/E93
         gFSw==
X-Gm-Message-State: AOAM532awVTpghXgpX0FP9RLIlnROcuaagWb+bAdLNU7SkwjQtqzMv1d
        I3I4uJgmnGzN5fLkHezQsS6Irw==
X-Google-Smtp-Source: ABdhPJzKycDUQzzAG49OCmTkpVYLW7MJG5CSlMgiOymwYu2KzmryxRvfQ1Tnc7LfqojxKpLRTphYrw==
X-Received: by 2002:a63:5b0e:: with SMTP id p14mr24914000pgb.110.1620163283320;
        Tue, 04 May 2021 14:21:23 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id t19sm13584936pfg.100.2021.05.04.14.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 14:21:22 -0700 (PDT)
Date:   Tue, 4 May 2021 21:21:18 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andi Kleen <ak@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Uros Bizjak <ubizjak@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Joerg Roedel <jroedel@suse.de>, Jian Cai <caij2003@gmail.com>
Subject: Re: [PATCH] KVM/VMX: Invoke NMI non-IST entry instead of IST entry
Message-ID: <YJG6ztbGjtuctec4@google.com>
References: <20210426230949.3561-1-jiangshanlai@gmail.com>
 <20210426230949.3561-3-jiangshanlai@gmail.com>
 <87bl9rk23k.ffs@nanos.tec.linutronix.de>
 <878s4vk1l9.ffs@nanos.tec.linutronix.de>
 <875yzzjxth.ffs@nanos.tec.linutronix.de>
 <87wnseis8v.ffs@nanos.tec.linutronix.de>
 <87r1imi8i1.ffs@nanos.tec.linutronix.de>
 <44e20d7cdbf0ffdb7d9dce7d480f86a6f14d16c1.camel@redhat.com>
 <ae801539-592a-af9a-55a1-3a4b8309ff1e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae801539-592a-af9a-55a1-3a4b8309ff1e@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2021, Paolo Bonzini wrote:
> On 04/05/21 23:05, Maxim Levitsky wrote:
> > Does this mean that we still rely on hardware NMI masking to be activated?
> 
> No, the NMI code already handles reentrancy at both the assembly and C
> levels.
> 
> > Or in other words, that is we still can't have an IRET between VM exit and
> > the entry to the NMI handler?
> 
> No, because NMIs are not masked on VM exit.  This in fact makes things
> potentially messy; unlike with AMD's CLGI/STGI, only MSRs and other things
> that Intel thought can be restored atomically with the VM exit.

FWIW, NMIs are masked if the VM-Exit was due to an NMI.
