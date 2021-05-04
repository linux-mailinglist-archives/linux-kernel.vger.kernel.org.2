Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA6537320E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 23:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbhEDVwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 17:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbhEDVwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 17:52:02 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B14C061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 14:51:07 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id i190so336320pfc.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 14:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VqtYvGK2HW/675ICBPcjqx1NTuB+M4OsXaqpSs46khM=;
        b=QVzEY1/U66ql90TgUkNXnanon4r1J+F8V1Gt1Z4s5/5TrMs+tD6bjJBjsnHFJrxGVR
         Tv0S9Sn1fBbNgOUIjsxdlfVTxK/6zGH1tetbrj8jx4/EYzbPzKav2DSWMBklIxj7KQfW
         /bZVW6cSqc7tV9B6ciuT5EKNmyDR4V6gzpao7w+D83KB+Kt0E8YJh8GIcK/Vc8S21uQV
         95ameDL+aEyLlr7sXj7zFJtXQ1arJ1nZSBUPjyj7w0gz+a3/kDtG4RKe+s0rBjhJwm00
         OhcvNYRi39aziHoPnkjAIEhP9sM3PDO9P17WlJeKHhtw2ELJNPoql9V1fPXdsgfcZNCY
         4NYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VqtYvGK2HW/675ICBPcjqx1NTuB+M4OsXaqpSs46khM=;
        b=PpVKFomkIFiVnLQgj21y8c1iBIgV7qmCNOzdbDEuW82m/FAHRxs6EqjcfbEfXOjjPz
         FF7ChcbDiYQHm7QnjUY72RAguGhJ7AezEZZXlv1ue5DGnqK2s+KlQ2WZTt66LYxWfwAD
         IAfFvlC4SytXkj7BzhJtXHxM0Ii9Sai9C8+wasQuc/myFLpK4jitAG6JHzy09IaKI7HO
         tc9Ph1rfs9XWGjn8F7+TWuJlFeuF+v3V9vEexyUdLOSMVPi4lZ6fSEXkxgbBxf4X6jTA
         f4Pxs99eix0zqmuXBEPORHzcOsrCKigitq7DPHmFr7yrohESzd9AdwcXS/QbLzWb35LJ
         NxEA==
X-Gm-Message-State: AOAM532tYNJ8ptuXpO5dP2UBZLwMCP6CfZlJMLdtyCtKOjq1936DK4+l
        irhUjhEtfEkiw/4owtePJldSPg==
X-Google-Smtp-Source: ABdhPJzkmLrLLD0/l4/t/IcaSwG83WGzyVrq8p5sXjdb/DpYBUdbDT95ew7RUGTG01LIDQmDoMPX1w==
X-Received: by 2002:a17:90a:280d:: with SMTP id e13mr7873857pjd.191.1620165067168;
        Tue, 04 May 2021 14:51:07 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id l64sm4655029pgd.20.2021.05.04.14.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 14:51:06 -0700 (PDT)
Date:   Tue, 4 May 2021 21:51:02 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Maxim Levitsky <mlevitsk@redhat.com>,
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
        Juergen Gross <JGross@suse.com>,
        Joerg Roedel <jroedel@suse.de>, Jian Cai <caij2003@gmail.com>
Subject: Re: [PATCH] KVM/VMX: Invoke NMI non-IST entry instead of IST entry
Message-ID: <YJHBxvR2mqsSX0pU@google.com>
References: <YJG6ztbGjtuctec4@google.com>
 <38B9D60F-F24F-4910-B2DF-2A57F1060452@amacapital.net>
 <625057c7-ea40-4f37-8bea-cddecfe1b855@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <625057c7-ea40-4f37-8bea-cddecfe1b855@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2021, Paolo Bonzini wrote:
> On 04/05/21 23:23, Andy Lutomirski wrote:
> > > On May 4, 2021, at 2:21 PM, Sean Christopherson <seanjc@google.com> wrote:
> > > FWIW, NMIs are masked if the VM-Exit was due to an NMI.
> 
> Huh, indeed:  "An NMI causes subsequent NMIs to be blocked, but only after
> the VM exit completes".
> 
> > Then this whole change is busted, since nothing will unmask NMIs. Revert it?

SMI?  #MC?  :-)

> Looks like the easiest way out indeed.

I've no objection to reverting to intn, but what does reverting versus handling
NMI on the kernel stack have to do with NMIs being blocked on VM-Exit due to NMI?
I'm struggling mightily to connect the dots.
