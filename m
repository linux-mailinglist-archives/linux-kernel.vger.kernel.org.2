Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3D8401E42
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 18:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244091AbhIFQ3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 12:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244088AbhIFQ3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 12:29:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D692EC061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 09:28:27 -0700 (PDT)
Date:   Mon, 6 Sep 2021 18:28:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630945705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PB4sDy5RPN525RHq+Yq5F3Pi1PEcR3nel1GIZvo8hVo=;
        b=2XSfZwPk+fJ6GZUip7jDuRN1AMDPIrkuYGo7fcajv/m9mNriOOiTbuTJQTOVw07YNpWES/
        z1rnrej9D2T828PmPZKCPcE3fLA7EODI9uhu7/X1iOzVIUaKdYJk3YiVDtvN4QoPNvRDhK
        1Rf6kntcvldZTeu5f74BgT461p3HcrcbjV64YLKemkVzMX5Ph2G83eUyseOFNrkVR9nvvX
        /i8gNpr/pNpZUI7lwsBQ8/eUNdSVKdvuiS+LQHILo5W/Xr7JEUXwG43zoI6G7BnSDgnH//
        U3feZmF51W1ymZUEnnd2icJi4M3M525xJgU0RssAbgtTo8Z7F7MZdemWOK8cSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630945705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PB4sDy5RPN525RHq+Yq5F3Pi1PEcR3nel1GIZvo8hVo=;
        b=6F9YD1u9sdGPcUgYsMqx0vvh/x7qdeOw0AZ9I7Pjo+t+PwC8T0GBtrdT+mXRD8kQ8RnNjU
        mdAtUVgCFAF1PhDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Marco Elver <elver@google.com>
Cc:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Clark Williams <williams@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/5] kcov: PREEMPT_RT fixup + misc
Message-ID: <20210906162824.3s7tmdqah5i7jnou@linutronix.de>
References: <20210830172627.267989-1-bigeasy@linutronix.de>
 <CANpmjNPZMVkr5BpywHTY_m+ndLTeWrMLTog=yGG=VLg_miqUvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANpmjNPZMVkr5BpywHTY_m+ndLTeWrMLTog=yGG=VLg_miqUvQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-09-06 18:13:11 [+0200], Marco Elver wrote:
> Thanks for sorting this out. Given syzkaller is exercising all of
> KCOV's feature, I let syzkaller run for a few hours with PROVE_LOCKING
> (and PROVE_RAW_LOCK_NESTING) on, and looks fine:
> 
>     Acked-by: Marco Elver <elver@google.com>
>     Tested-by: Marco Elver <elver@google.com>

awesome.

> > One thing I noticed and have no idea if this is right or not:
> > The code seems to mix long and uint64_t for the reported instruction
> > pointer / position in the buffer. For instance
> > __sanitizer_cov_trace_pc() refers to a 64bit pointer (in the comment)
> > while the area pointer itself is (long *). The problematic part is that
> > a 32bit application on a 64bit pointer will expect a four byte pointer
> > while kernel uses an eight byte pointer.
> 
> I think the code is consistent in using 'unsigned long' for writing
> regular pos/IP (except write_comp_data(), which has a comment about
> it). The mentions of 64-bit in comments might be inaccurate though.
> But I think it's working as expected:
> 
> - on 64-bit kernels, pos/IP can be up to 64-bit;
> - on 32-bit kernels, pos/IP can only be up to 32-bit.
> 
> User space necessarily has to know about the bit-ness of its kernel,
> because the coverage information is entirely dependent on the kernel
> image. I think the examples in documentation weren't exhaustive in
> this regard. At least that's my take -- Dmitry or Andrey would know
> for sure (Dmitry is currently on vacation, but hopefully can clarify
> next week).

okay.

> Thanks,
> -- Marco

Sebastian
