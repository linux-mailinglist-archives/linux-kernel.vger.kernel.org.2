Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0345039E16F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 18:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbhFGQFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 12:05:23 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:44710 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbhFGQFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 12:05:22 -0400
Received: by mail-pf1-f174.google.com with SMTP id u18so13395796pfk.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 09:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S2ebInYGpF1WI3iSf00AhxxVa41E0+LgB6jF5A4/MpY=;
        b=j6pUzUMEqozYc1QqJS6dI49MmsDeUYdANLfcoCOzDl+rifVgDwVwErdysEglpq19U0
         IeAdiUzp1f31qH3YOfkuOVcFLB/aFfpWB6/a4rccKUVcUzCunRqQOCoRQYudjkj4yyCi
         pUfl3nJVGtlICi+xIh0ak6LvCYn8H/Xda3UvteC0tqQW6s/IXuq02QiEhUCtL7UYOApS
         LeVO3KFzZtomYist3ntt1rRhkukI3KLcBNrSlJMsSP7a6JtqvkFbBbeav6BAQliDVwep
         LIjfbQAV2UdW4wOdpAdPh0pKNZ3jVAlH1athgDFwE7lkwPgoHhdqyK7Q0ukfjfqxlxbM
         /zPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S2ebInYGpF1WI3iSf00AhxxVa41E0+LgB6jF5A4/MpY=;
        b=AtO2SQ7MwSdiUn9D2cWfxN8WqNk9oKBCGxfqriPlINPmXPlrmSGO4gtiU9ib96ugub
         o7PZ4Vm4mBRK0Do3LtGs3ntdhoSVHmkIBVKq3zlICYStHEizrN8wGvJtmBLpbbqoI0+b
         QaP3d9ZwUdx2uhbv179/nn3FvFBonzIhhpXWMbz8dlapahPD9PRr31UhqKfPrqnWOjXo
         mAlK1ZSWzvPnuwxx5B5mIH5pnsqsf4e9d7EI9PNLY768b223fADpc4SaBPFoGaUvnACJ
         syoJb+AJnOIFgWryu9Wb0Gd44ARJdhmzmM4ZJV/7AWlOaV4fvkw/WjeYkJkz+nIbE8TB
         UI/A==
X-Gm-Message-State: AOAM531LI8s/v+MYb6M63bGo4Dlmjt6OKPuQcTA09eYEY9W/q+An9Q+A
        OHrCEguQZ7Ik0dldoXUgQOupTIviI1BhqA==
X-Google-Smtp-Source: ABdhPJyjh/ydI474RWGq1/ASY8DdyBwxcvvpjtbbWU3y/hzG9lF5QN+I961XT891nzz+V8PP/BXk1g==
X-Received: by 2002:a65:498e:: with SMTP id r14mr9221782pgs.57.1623081751392;
        Mon, 07 Jun 2021 09:02:31 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id z205sm3610230pfc.165.2021.06.07.09.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 09:02:30 -0700 (PDT)
Date:   Mon, 7 Jun 2021 16:02:27 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jacob Wen <jian.w.wen@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/2] tracing: Add a verifier to check string pointers for
 trace events
Message-ID: <YL5DE9vqDG/fUSMh@google.com>
References: <20210226185909.100032746@goodmis.org>
 <20210226190705.871102407@goodmis.org>
 <YLrRUmwjjaozIt4K@google.com>
 <20210604222830.2505d67a@rorschach.local.home>
 <20210604224544.134c652f@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604224544.134c652f@rorschach.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021, Steven Rostedt wrote:
> On Fri, 4 Jun 2021 22:28:30 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > What you described to me does not sound like a false positive, and
> > converting to __string() is not a workaround but an actual fix, and
> > would also need to be backported to stable.
> 
> If the event you are talking about is kvm_nested_vmenter_failed, which
> records a pointer to the message, then, yes, that is unsafe and buggy.

Yep, that's the one.

> If that event is defined by the kvm module, and used in kvm_intel. If
> you have this:
> 
> 	# echo 1 > /sys/kernel/tracing/events/kvm/kvm_nested_vmenter_failed
> 
> 	# do_whatever_causes_that_to_trigger
> 
> 	# rmmod kvm_intel
> 
> 	# cat trace
> 
> Then that pointer to the string will point to some random memory.
> Before this patch, it could even possibly crash the kernel!

I assumed that was the gist of the unsafe string detection, but the module core
data exemption confused me.  I take it that the tracepoint itself goes away if
the module is unloaded?  I.e. it's safe for a module to pass a constant string to
its own tracepoints, but not to tracepoints defined elsewhere?  The comment
above tracepoint_string() seems to confirm this.

> There's two fixes you can do with this. One is to covert that to use
> __string, the other is to do what RCU does, and use the
> tracepoint_string() functionality.
> 
> RCU has:
> 
> 	#define TPS(x)	tracepoint_string(x)
> 
> And wrap all strings with that TPS(), like in nested_vmx_reflect_vmexit():
> 
>         if (unlikely(vmx->fail)) {
>                 trace_kvm_nested_vmenter_failed(
> -                       "hardware VM-instruction error: ",
> +                       TPS("hardware VM-instruction error: "),
>                         vmcs_read32(VM_INSTRUCTION_ERROR));
>                 exit_intr_info = 0;
>                 exit_qual = 0;
>                 goto reflect_vmexit;
>         }
> 
> What the tracepoint_string does is to save the string into core kernel
> memory (there's logic to use the same string if it is already
> available), and it wont free it when the module is unloaded.

This doesn't appear to be correct.  Were you thinking of something else?

Unless I'm misreading the code and section output, tracepoint_string() just saves
a pointer to the string into a dedicated section, it doesn't magically hoist the
string itself into the kernel proper.  And I can't see how that would work, e.g.
if the module is compiled and linked independent from the core kernel.

And the comment above the macro strongly suggests that persistence needs to be
guaranteed by the entity using tracepoint_string().  Testing bears this out, e.g.
the WARN and UNSAFE_MEMORY errors still happen when using tracepoint_string().

 * The @str used must be a constant string and persistent as it would not
 * make sense to show a string that no longer exists. But it is still fine
 * to be used with modules, because when modules are unloaded, if they
 * had tracepoints, the ring buffers are cleared too. As long as the string
 * does not change during the life of the module, it is fine to use
 * tracepoint_string() within a module.
 */
#define tracepoint_string(str)						\
	({								\
		static const char *___tp_str __tracepoint_string = str; \
		___tp_str;						\
	})


Thanks for the help!

> This makes the string safe to use by the trace event directly.
> 
> Not only is the TPS safe, it also allows userspace tools to know what
> the string is, as it is exported in printk_formats. Otherwise trace-cmd
> and perf will only display a pointer hex value as it has no idea what
> its pointing to (both TPS and __string fixes this).
