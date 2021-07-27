Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2483D6B82
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 03:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbhG0ApQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 20:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbhG0ApP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 20:45:15 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B736C061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 18:25:42 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id q17-20020a17090a2e11b02901757deaf2c8so2675246pjd.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 18:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/t7f81wmDGE9gCk41v1NLLvWhSnv41AnaYKKhZPegeQ=;
        b=ZCvsBQewZ907UF3Ro1DLZ7PZByNA2KJqY0W5KZBeHARVf2pSvfuWo0/UpzW5IOP5Rq
         MKfoaMIuKidCUFJZVSr/kLhxBnckBso5CQrxEucrCRZUg3XrWtgsRjszBEkat/g8tmHI
         QG0jIQYGQ6/OfSaklFvphljMPZdkney/9f3um/CoYKMuiaDjT+tP90tz+mfbcEK5+BhA
         JhATmylKSCdz8hduBFM19J+sn93/1CMUkWpI7zl2vBzDSdKPS6CrG6Mmw2OLJmDb79SK
         cwJl+plrWbxUCcW9HGvpbi86VFYq3T04sC4tthEePLDoCxSFlv8avoro7yGcPc648uNz
         Fb5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/t7f81wmDGE9gCk41v1NLLvWhSnv41AnaYKKhZPegeQ=;
        b=NXKsO9eV4y0KRJIyJCMHUnSgQfDUlH+6WPpXfIRGkZUaMSw7X3OQTJrYxri7gqsOIo
         8Y1K3fYafXmwI3j+X3BflhO3IRT3RbMvDKHmNMX/l8B5MRrdbVbuucbeD59Bi4dVC3/n
         8vRc9MMj2lbqVbSJpc5okoQuo4ZrN8ub4L/32F3m4FICIHgjdPjlCyT/1/3ZTHXf4DDQ
         bHAga4tr4EUWwL2My4+O3VGLDPUJ+hiu+l8sa+cR0zaZ+0FIIrCWPTi965jKdUErbi1e
         L4uCbCBwl67Ee0nEM5dqMkchpnxFk3+tkgetpyyQH9BuQnPS87lhusN7gzFLdOoPgtAD
         KrAw==
X-Gm-Message-State: AOAM532VFULU+sjxbc4tELZR85NKPPe7J8mRhnuPqU1CWI3idqWytQCR
        QzVRPujex+LaHr2lau5HvGKQ6A==
X-Google-Smtp-Source: ABdhPJz890wTAonMOzNcvs3uodhfLYosNqjCzI0af1SDHIip2c6ld2PEFx1LJQf2b9AXimtwpxAdRw==
X-Received: by 2002:a65:6498:: with SMTP id e24mr20844452pgv.447.1627349141523;
        Mon, 26 Jul 2021 18:25:41 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id k4sm798222pjs.55.2021.07.26.18.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 18:25:40 -0700 (PDT)
Date:   Tue, 27 Jul 2021 01:25:37 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Li,Rongqing" <lirongqing@baidu.com>
Cc:     Wanpeng Li <kernellwp@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        kvm <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?562U5aSN?= =?utf-8?Q?=3A?= [PATCH] KVM: Consider SMT
 idle status when halt polling
Message-ID: <YP9gkSk+CHdKLP/Q@google.com>
References: <20210722035807.36937-1-lirongqing@baidu.com>
 <CANRm+Cx-5Yyxx5A4+qkYa01MG4BCdwXPd++bmxzOid+XL267cQ@mail.gmail.com>
 <4efe4fdb91b747da93d7980c10d016c9@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4efe4fdb91b747da93d7980c10d016c9@baidu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021, Li,Rongqing wrote:
> > > > SMT siblings share caches and other hardware, halt polling will
> > > > degrade its sibling performance if its sibling is busy
> > >
> > > Do you have any real scenario benefits? As the polling nature, some
> > > cloud providers will configure to their preferred balance of cpu usage
> > > and performance, and other cloud providers for their NFV scenarios
> > > which are more sensitive to latency are vCPU and pCPU 1:1 pin，you
> > > destroy these setups.
> > >
> > >     Wanpeng
> > 
> 
> 
> Run a copy (single thread) Unixbench, with or without a busy poll program in
> its SMT sibling,  and Unixbench score can lower 1/3 with SMT busy polling
> program

Rather than disallowing halt-polling entirely, on x86 it should be sufficient to
simply have the hardware thread yield to its sibling(s) via PAUSE.  It probably
won't get back all performance, but I would expect it to be close. 

This compiles on all KVM architectures, and AFAICT the intended usage of
cpu_relax() is identical for all architectures.

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 6980dabe9df5..a07ecb3c67fb 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3111,6 +3111,7 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
                                goto out;
                        }
                        poll_end = cur = ktime_get();
+                       cpu_relax();
                } while (kvm_vcpu_can_poll(cur, stop));
        }


