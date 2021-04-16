Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3A56362AA5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 23:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235699AbhDPV5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 17:57:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60190 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbhDPV5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 17:57:23 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618610217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hrx5kAgolu7NaicQEsBpTD/f2tNIxdpmfDnk7KuYUfY=;
        b=kFfjBAL85gup+vvMOZX28aArbVlibEK40LgW3kMABndwW4jHnPPiGHORf6Ta+tQR37bvpN
        tnBabVwM1L8isMgylN/U0/Nm8oSKb4SpLI/Dx2Ab2eURO6b4/DD8GVEEMzpl88vhXT97tq
        AIFecnvMWD9O8yLqDqJ3CgzzEH+NLjQArJkFzNmUvult7LnKc/BWq14I6boOCgj456eEq2
        S3aGU9+KtmScHbTatqa2vPA6gStfqCGgyfi1vMSJ6kzZbiVt36VZJbX5xZMhf3+8f6JGco
        IKUZPR+T19pgKPOH+iLqu0GenUxw2rvUQL7PHFA9Hd79yB1RqsTZz+oESgg04A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618610217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hrx5kAgolu7NaicQEsBpTD/f2tNIxdpmfDnk7KuYUfY=;
        b=1WLGGP+eEkgO2apsN2HzDZ72s4EFB10tO3N5H0aQkMFVpfXMrDTscAfyIJpw5Mct3/IqDk
        Kfl9nCco2nG5jZCA==
To:     zhaoxiao <zhaoxiao@uniontech.com>
Cc:     mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        nivedita@alum.mit.edu, clin@suse.com,
        andriy.shevchenko@linux.intel.com, ndesaulniers@google.com,
        dan.j.williams@intel.com, masahiroy@kernel.org,
        linux-kernel@vger.kernel.org, jroedel@suse.de,
        peterz@infradead.org, jpoimboe@redhat.com,
        zhaoxiao <zhaoxiao@uniontech.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2] X86: Makefile: Replace -pg with CC_FLAGS_FTRACE
In-Reply-To: <20210416053928.11576-1-zhaoxiao@uniontech.com>
References: <20210416053928.11576-1-zhaoxiao@uniontech.com>
Date:   Fri, 16 Apr 2021 23:56:57 +0200
Message-ID: <87pmytuc46.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16 2021 at 13:39, zhaoxiao wrote:
> In preparation for x86 supporting ftrace built on other compiler
> options, let's have the x86 Makefiles remove the $(CC_FLAGS_FTRACE)
> flags, whatever these may be, rather than assuming '-pg'.

s/let's have the/make the/

> There should be no functional change as a result of this patch.

Should be? Either you know that there is no functional change or not. If
you're unsure why are you posting it at all?

So this wants to be:

   No functional change.

Other than that and the fact that this is incomplete as it fails to
catch _all_ instances of -pg in arch/x86 and also leaves stale comments
around I'm ok with the intent.

# git grep '\-pg' arch/x86/
arch/x86/entry/vdso/Makefile:# vDSO code runs in userspace and -pg doesn't help with profiling anyway.
arch/x86/kernel/ftrace_64.S: * gcc -pg option adds a call to 'mcount' in most functions.
arch/x86/purgatory/Makefile:# Default KBUILD_CFLAGS can have -pg option set when FTRACE is enabled. That
arch/x86/um/vdso/Makefile:# vDSO code runs in userspace and -pg doesn't help with profiling anyway.
arch/x86/um/vdso/Makefile:CFLAGS_REMOVE_vdso-note.o = -pg -fprofile-arcs -ftest-coverage
arch/x86/um/vdso/Makefile:CFLAGS_REMOVE_um_vdso.o = -pg -fprofile-arcs -ftest-coverage

grep is not rocket science ...

Thanks,

        tglx
