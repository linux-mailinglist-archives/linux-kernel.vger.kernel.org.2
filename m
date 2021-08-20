Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B610E3F365E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 00:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbhHTWZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 18:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbhHTWZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 18:25:57 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CE9C061760
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 15:25:18 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id w68so9830075pfd.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 15:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YqTJx2d+rK7r/727Mx+pw0RMm85LxTM+dupa4DkkVUg=;
        b=XMJxhivK8HayiVyEBDemyRelIu51Uql4arICrgl1Xtu+OpldaIQuiN92D0dB+2PvY2
         AoWaNBB7KO7F5FKoudHlgDL/hNd8A+FowUsdw3wL6BDm/iTL4Cc6YiTOferscwepyuQG
         9XzUtw99s5/KFwywXDFpqMheslrF3wDRzL/P2DgSQRR0RtQLiklqmvKdqBE5L3ZAbbaZ
         dmEsmdra+vDsgdRhVivluTSEwsP4y90ta1vlg9CE5AvtSTW6wIrc35O7x62Y6nnvox8U
         jQS6/7VhaJmZu5wZ3xMtHYlcMetnl4hW/FqOnidhXXsmNwQLT3BkojygGTev8rmNq1ca
         Ezdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YqTJx2d+rK7r/727Mx+pw0RMm85LxTM+dupa4DkkVUg=;
        b=kuR+nuaNQ9z4G1Jl6wFm5diG/1xxgJRyLJSE55Ir3zq8ukceqNDA5kH9vnFt0tPX31
         PLJ7MRBac8vcCqcz8eeOhgeUBqhUjaJGPAIC/xCKFVKIFrhsw+fF4qh2LZCocZ2xcFPl
         K0N2H8u9mLI/UVsI/KiwJaikjIKOfgTxJGylhd1EK5iycJg0kxRb61S7z3pYQfv/JojX
         4OiVkpzJzY7ZxWK1Lhbj0Ply8+MLWka1hcbw+HlqUeq+In7ROWZRPUCrj2bIDTjAXnLw
         adnySF6O0DLFibkTHWnqSyXMOAYH1YwFS+fpfA7FfvhGnEz1eLs0nSINDo2SpqR1y9uo
         88Aw==
X-Gm-Message-State: AOAM531rbHWQ4b/3wgpCuR1Ms6UXrguv+wB9rRxxHgsfLSJSLVKWBFNR
        XAYrApPxw1qWHIfE1SOtiX+Udw==
X-Google-Smtp-Source: ABdhPJyV4IjFC28xX7oRVRErRr3HUFYCEi0w5LU0UmTHa8mL37R5Jfy+NpSbOUll/e+Fp+fYUTcY5g==
X-Received: by 2002:aa7:864e:0:b0:3e3:439b:c3fc with SMTP id a14-20020aa7864e000000b003e3439bc3fcmr9023525pfo.64.1629498318096;
        Fri, 20 Aug 2021 15:25:18 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id o14sm9367987pgl.85.2021.08.20.15.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 15:25:17 -0700 (PDT)
Date:   Fri, 20 Aug 2021 22:25:11 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     "Russell King, ARM Linux" <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>, gor <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>, rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>, shuah <shuah@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-csky <linux-csky@vger.kernel.org>,
        linux-mips <linux-mips@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        Peter Foley <pefoley@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Ben Gardon <bgardon@google.com>
Subject: Re: [PATCH 4/5] KVM: selftests: Add a test for KVM_RUN+rseq to
 detect task migration bugs
Message-ID: <YSArx+ppjIH+6/uK@google.com>
References: <20210818001210.4073390-1-seanjc@google.com>
 <20210818001210.4073390-5-seanjc@google.com>
 <1540548616.19739.1629409956315.JavaMail.zimbra@efficios.com>
 <YR7qXvnI/AQM10gU@google.com>
 <407716135.20250.1629484298288.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <407716135.20250.1629484298288.JavaMail.zimbra@efficios.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021, Mathieu Desnoyers wrote:
> I still really hate flakiness in tests, because then people stop caring when they
> fail once in a while. And with the nature of rseq, a once-in-a-while failure is a
> big deal. Let's see if we can use other tricks to ensure stability of the cpu id
> without changing timings too much.

Yeah, zero agrument regarding flaky tests.

> One idea would be to use a seqcount lock.

A sequence counter did the trick!  Thanks much!

> But even if we use that, I'm concerned that the very long writer critical
> section calling sched_setaffinity would need to be alternated with a sleep to
> ensure the read-side progresses. The sleep delay could be relatively small
> compared to the duration of the sched_setaffinity call, e.g. ratio 1:10.

I already had an arbitrary usleep(10) to let the reader make progress between
sched_setaffinity() calls.  Dropping it down to 1us didn't affect reproducibility,
so I went with that to shave those precious cycles :-)  Eliminating the delay
entirely did result in no repro, which was a nice confirmation that it's needed
to let the reader get back into KVM_RUN.

Thanks again!
