Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 340CA38D73D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 21:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbhEVTdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 15:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbhEVTdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 15:33:31 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F798C061574
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 12:32:06 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id f22so9136283pfn.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 12:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id;
        bh=etKYDS5uAQ5qqnzu2k3mx2BQc5MVAc3RoI6hB7aUSKk=;
        b=ENtMtbXJvHpIe6sUlXwwIF/UuDDqjmxl4xHwoBSIxvz8H+WtuQqYeSUnAVHoRRLR51
         aZo+SZMeFygvoEeqeAVBI15qFcicW4qVx7rDbe9bV+EQaHukCvMNnuGnN6ZwfTh6RuOI
         7BJyL0MzbMOlTYPpIhbC7LEvntX6HXL1VOcEIfgB/QSh9NKYi5ETMftlt0hO2rqo1AMm
         w/K8ZtqtrhhQU3q6vHch/Aigk8QOnHBOHm4Bd/Rt2syl3J0voTMnNuDsAUsxKo4zcvB3
         XmSQaHIqOoJw6tAvOsHgxsrmUDcFj4ThsB4aLKZSFJgsAXAlLtNRhJwLN01HRIOD37s/
         GWIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id;
        bh=etKYDS5uAQ5qqnzu2k3mx2BQc5MVAc3RoI6hB7aUSKk=;
        b=j9cb4kGVIeA9CEpQVsZJiz0oP2VJSXm/JIU0tyYYOOhooyB8+qOB8MSvbz+NPyqQ1V
         ZcvLUccgl/f5YR6ScaRw+soAGG48RS+r4kGWjyPlY9BGpi0gE1YXbO0YMEk6bVJG1SPt
         ga/hm6ri8gXq4FCV7So4nHKZidZv3o1Y8su6dzxcyyBxzuE5zQdqAd8e9t9+q3luCZ5N
         OWE1f95AAmcFodERGQ1iKtXToq0bzymnNib0iDuFbY5DjZjmmVHqnp5N6gExpJHduDTK
         J361OzUBpMjodk8a3MYhd4bdtRtPCwt7L4tKwR4Ns0ds3g+GA2p2ziJAlgG6DZthB3N4
         DQWg==
X-Gm-Message-State: AOAM530MaPjP0N3VtFLMRul/pzD9uq8zkP35PrIk0T5Avf0dJJmeXUz7
        rgjTHmvyaQ7H2TN1B5+JCO6YJQ==
X-Google-Smtp-Source: ABdhPJxT2VRDTaqQDATEmQAvfGBKRdVYoqTMZXQ0n27UEKf7Co7J0c9f9cgqRHBs0EGTLm/r++s3xQ==
X-Received: by 2002:a63:d40d:: with SMTP id a13mr5503703pgh.382.1621711925684;
        Sat, 22 May 2021 12:32:05 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id f2sm7517956pgl.67.2021.05.22.12.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 12:32:05 -0700 (PDT)
Date:   Sat, 22 May 2021 12:32:05 -0700 (PDT)
X-Google-Original-Date: Sat, 22 May 2021 12:31:58 PDT (-0700)
Subject:     Re: [PATCH] RISC-V: Don't check text_mutex during stop_machine
In-Reply-To: <20210506092550.6c2206b3@gandalf.local.home>
CC:     linux-riscv@lists.infradead.org, mingo@redhat.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, mhiramat@kernel.org, zong.li@sifive.com,
        guoren@linux.alibaba.com, Atish Patra <Atish.Patra@wdc.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        changbin.du@gmail.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     rostedt@goodmis.org
Message-ID: <mhng-edd9e8bd-e585-4b6b-8e40-797215bfdf75@palmerdabbelt-glaptop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 May 2021 06:25:50 PDT (-0700), rostedt@goodmis.org wrote:
> On Thu,  6 May 2021 00:10:41 -0700
> Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
>> ---
>> In theory we should be able to avoid using stop_machine() with some
>> clever code sequences, but that's too big of a change to be considered a
>> fix.  I also can't find the text I thought was in the ISA manual about
>> the allowed behaviors for concurrent modification of the instruction
>> stream, so I might have just mis-remembered that.
>> ---
>
> I wonder if you could at least use break points, as some other archs do,
> and what x86 does.
>
> If you have this make believe machine code:
>
> 	00 00 00 00		nop
>
> And you want to turn it into a call.
>
> 	aa 12 34 56		bl ftrace_caller
>
> And if your architecture has a way to inject a break point on live code.
> Let's call this FF for the break point code.
>
> You can inject that first:
>
> 	FF 00 00 00

That would rely on this "concurrent writes to the instruction stream 
don't tear" property that I thought we'd put in the ISA but I can't 
actually find in the text of the document.  That said, I hadn't actually 
thought about replacing single bytes in the instruction stream.  In 
theory we don't have anything that guartees those won't tear, but I'm 
not sure how any reasonable implementation would go about manifesting 
those so it might be an easy retrofit to the ISA.

I ran through our breakpoint encodings and don't think those help, but 
we do have 0x00000013 as a NOP (addi x0, x0, 0) which is one byte away 
from 0x00000000 (which is defined to be an invalid instruction on all 
RISC-V systems).  There's really no difference between how a breakpoint 
traps and how an illegal instruction traps on RISC-V, so we should be 
able to use that to construct some sort of sequence.

So we can start with

    nop
    nop
    nop
    nop
    nop

then do a single-byte write to turn it into

    unimp
    nop
    nop
    nop
    nop

we can then IPI to all the harts in order to get them on the same page 
about that trap, which we can then skip over.  We'll need some way to 
differentiate this from accidental executions of unimp, but we can just 
build up a table somewhere (it wasn't immediately clear how x86 does 
this).  Then we have no ordering restrictions on converting the rest of 
the stub into what's necessary to trace a function, which should look 
the same as what we have now

    unimp
    save ra, ...(sp)
    auipc ra, ...
    jalr ra, ...
    load ra, ...(sp)

At which point we can IPI everywhere to sync the instructions stream 
again, before we turn off the trap

    nop
    save ra, ...(sp)
    auipc ra, ...
    jalr ra, ...
    load ra, ...(sp)

> sync all CPUs where now all callers will hit this and jump to the break
> point handler, which simply does:
>
> 	ip = ip + 4;
> 	return;
>
> and returns back to the instruction after this nop/call.

There'll be some slight headaches there because the length of the all-0 
unimplemented instruction depends on which extensions are supported, but 
we can detect ILEN at runtime so that shouldn't be a showstopper.

> Change the rest of the instruction.
>
> 	FF 12 34 56
>
> sync all CPUs so that they all see this new instruction, but are still
> triggering the break point.
>
> Then finally remove the break point.
>
> 	aa 12 34 56
>
> And you just switched from the nop to the call without using stop machine.

OK, ya I think that all should work.  We're still depending on this 
"single byte writes to the instruction stream don't tear" guarantee, but 
I think that's a bit pedantic.  I'll open a question on the ISA spec 
just to be sure one I can link here.

I'm probably not going to have the time to do this for a bit because I'm 
buried in this non-coherent stuff, but if someone wants to take a shot 
at it I'd be happy to take a look.

Thanks for pointing this out, this should get is away from 
stop_machine() way sooner than waiting for a multi-byte modification 
sequence would!
