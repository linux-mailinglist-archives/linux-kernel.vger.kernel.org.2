Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86AEA36F25A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 23:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbhD2Vzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 17:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbhD2Vzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 17:55:47 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97D9C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 14:54:58 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id n6so1290183pfv.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 14:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xILzlD8Dc/GC/uEcYmCRAVPf5ev0yMARXoUln4gBq+M=;
        b=eIYbBZxhCJo4QYi8f2O4+a/PDCv49G7XQEh46rHgNeVgZkAPo27YclJTFAoSur+0jI
         Xu1c/2yXHlP/idepUEDlanvWe0G8/b1Ybyat/wVSWFVCsa9BHYp6JXwqqGooSwepyCm3
         b7yM0u1tr06nhWrZJQKj853ZY38kkLCxw7eM2B0j1KTDBLLvtSYDmumDUtEO7HBZ5L17
         cjEkzFk4lLvetZYuMOG0bexbhqgzcWP5r8NCBaCItRGXCPeHGPZdmkAGhsDBZUI7mcU8
         +eyc/jdqyqOGn1zwFZIO3+OkVdRcXDg5niV5Y1tKOUyrTHLPTN9ajffZdmzACyONS9bZ
         Cf5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xILzlD8Dc/GC/uEcYmCRAVPf5ev0yMARXoUln4gBq+M=;
        b=FfqanNr6A0mhUO+ezFsFL5WAvRURwtY2aOAZV2sYjmk2DY3claqB3Pi/B1H8cY+vTD
         rnC8thuq1rbJIQHgkHcbfXc2auMOGlLc7Le2MhmSPOBs20YujmqAugt9m5YtRT2IVBtL
         L1W/6lX544nwMbSvDo/fIY34c3174quft6yKzvVUKUGoOQnJ6yAxHxxB94yXX4QUCaBy
         AfcPE3jki6GlWe4AlP87+Bfe5/JXY33E3Zr/WZO+2b9r/bc+lht0MA2WVhAO6b6VE1gI
         vhoX0fw6ElkNydhjqF8ddluJuaKuyzLhX8mh0C8G+nbx6yKAAJyieeF0LjDB/m7XnOCR
         fxNQ==
X-Gm-Message-State: AOAM5301RP2RvW3ocQOrryy1Wt15UMAfEqfFH4QymOthcyFVnSL8nSLO
        a+8Z0TESeJHefASLQXrPRKI=
X-Google-Smtp-Source: ABdhPJxWYGupRvMzQopX9u2g7/MngEcIFHl1KxNOdrbssRowLBPVMtHH4KtwsfwB6l6kPIkFuk0N/Q==
X-Received: by 2002:a62:7c4d:0:b029:289:d38:d1be with SMTP id x74-20020a627c4d0000b02902890d38d1bemr572168pfc.23.1619733298295;
        Thu, 29 Apr 2021 14:54:58 -0700 (PDT)
Received: from mail.google.com ([141.164.41.4])
        by smtp.gmail.com with ESMTPSA id 18sm3181647pji.30.2021.04.29.14.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 14:54:57 -0700 (PDT)
Date:   Fri, 30 Apr 2021 05:54:51 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, peterz@infradead.org, jpoimboe@redhat.com,
        jbaron@akamai.com, ardb@kernel.org,
        Atish Patra <Atish.Patra@wdc.com>,
        Anup Patel <Anup.Patel@wdc.com>, akpm@linux-foundation.org,
        rppt@kernel.org, mhiramat@kernel.org, zong.li@sifive.com,
        guoren@linux.alibaba.com, wangkefeng.wang@huawei.com,
        0x7f454c46@gmail.com, chenhuang5@huawei.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH] RISC-V: insn: Use a raw spinlock to protect TEXT_POKE*
Message-ID: <20210429215451.yuey5gzmfh2dkzp5@mail.google.com>
References: <20210429061713.783628-1-palmer@dabbelt.com>
 <20210429123007.5144fc0d@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429123007.5144fc0d@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 12:30:07PM -0400, Steven Rostedt wrote:
> On Wed, 28 Apr 2021 23:17:13 -0700
> Palmer Dabbelt <palmer@dabbelt.com> wrote:
> 
> > From: Palmer Dabbelt <palmerdabbelt@google.com>
> > 
> > We currently use text_mutex to protect the fixmap sections from
> > concurrent callers.  This is convienent for kprobes as the generic code
> > already holds text_mutex, but ftrace doesn't which triggers a lockdep
> > assertion.  We could take text_mutex for ftrace, but the jump label
> > implementation (which is currently taking text_mutex) isn't explicitly
> > listed as being sleepable and it's called from enough places it seems
> > safer to just avoid sleeping.
> > 
> > arm64 and parisc, the other two TEXT_POKE-style patching
> > implemnetations, already use raw spinlocks.  abffa6f3b157 ("arm64:
> > convert patch_lock to raw lock") lays out the case for a raw spinlock as
> > opposed to a regular spinlock, and while I don't know of anyone using rt
> > on RISC-V I'm sure it'll eventually show up and I don't see any reason
> > to wait.
> 
> On x86 we use text_mutex for jump label and ftrace. I don't understand the
> issue here. The arm64 update was already using spin locks in the
> insn_write() function itself. riscv just makes sure that text_mutex is held.
> 
> It also looks like ftrace on riscv should also have text_mutex held
> whenever it modifies the code. Because I see this in
> arch/riscv/kernel/ftrace.c:
> 
> 
> int ftrace_arch_code_modify_prepare(void) __acquires(&text_mutex)
> {
>         mutex_lock(&text_mutex);
>         return 0;
> }
> 
> int ftrace_arch_code_modify_post_process(void) __releases(&text_mutex)
> {
>         mutex_unlock(&text_mutex);
>         return 0;
> }
> 
> Which should be getting called before and after respectively from when
> ftrace does its updates.
> 
> Can you show me the back trace of that lockdep splat?
> 
The problem is that lockdep cannot handle locks across tasks since we use
stopmachine to patch code for risc-v. So there's a false positive report.
See privious disscussion here:
https://lkml.org/lkml/2021/4/29/63

> -- Steve

-- 
Cheers,
Changbin Du
