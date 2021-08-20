Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 679533F34A1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 21:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbhHTTYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 15:24:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35581 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229923AbhHTTYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 15:24:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629487414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e9w0Wui0S9JFIo8imxcdNxMuJT75RM52d050cVRzcis=;
        b=iQFO1TDdCaOgynMKDXgHhGHu8UlVg2XZw9GpACecNeMjmIqYIRZuHVr2C1sjs8SBCgoVPL
        IQ2JbkXwvf2BUJ8qCVAidHq2Gjwp8zm5r3rg0nNFY5zWVWs4wZsISsHe6AFK0TCojJjgPn
        mFywLrxjyoirzkSNHqyEgc1DsNphgps=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-b539qGrFMgyZPu9pB5p0vw-1; Fri, 20 Aug 2021 15:22:29 -0400
X-MC-Unique: b539qGrFMgyZPu9pB5p0vw-1
Received: by mail-ot1-f72.google.com with SMTP id k18-20020a9d7dd2000000b0051aec75d1abso2342428otn.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 12:22:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e9w0Wui0S9JFIo8imxcdNxMuJT75RM52d050cVRzcis=;
        b=lv87G2NLMBLIdG6CShnKy+tmwHjp3Oxw1VypNt3bEH+TTKP+7M3VfuPE6CFMsHT28l
         8J7Com/Eit6VW+yC6pfuM8ZRyiayH/jXy3Rjb1c2UPYIoVr5J0gleHyUr8gxQK9E0z4L
         aCFUdEeFjHdo9mZua7YISTlyQPbvzH52foh67+011rlYXX6uIkg4wqg0SPJvKf3rkiTW
         Yg1wxpFpDkx1MAjtinOLmPQDZlh+vQ20mAmnf1x2tGRLGRqho8jJ0Z9oc0MirOx7q4da
         pGMvFqeotTN9hZQcUKs99/0pb9hw0JzWlWNykeffd33AZVee9jcyuJ3JEbASDR7kNvfZ
         AJhA==
X-Gm-Message-State: AOAM532bZsTPvpO9KCljwwbDlmSlDiX/NLcwSBa0tEqrJ/8ndVCDElHu
        moCnZcyFafSr2pFtBQlXPCzlGY0vuMUvlxlIMjJjrV6yGoH1Gn0rK1cac5y1ZkTYzgfY0ZRb9J9
        +/f+xnRKc1obmfayXMJzXURwo
X-Received: by 2002:aca:d610:: with SMTP id n16mr4308889oig.170.1629487348373;
        Fri, 20 Aug 2021 12:22:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwycWbSNov2qN6XA73agM+PuKLxBN3y6vQRFUuctvPXGJvCN2UJVNMeRaFpFDSARAcAb3v3tQ==
X-Received: by 2002:aca:d610:: with SMTP id n16mr4308878oig.170.1629487348160;
        Fri, 20 Aug 2021 12:22:28 -0700 (PDT)
Received: from treble ([68.74.140.199])
        by smtp.gmail.com with ESMTPSA id y33sm1658640ota.66.2021.08.20.12.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 12:22:27 -0700 (PDT)
Date:   Fri, 20 Aug 2021 12:22:24 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, joro@8bytes.org,
        boris.ostrovsky@oracle.com, jgross@suse.com, x86@kernel.org,
        mbenes@suse.com, rostedt@goodmis.org, dvyukov@google.com,
        elver@google.com
Subject: Re: [PATCH v2 01/24] x86/xen: Mark cpu_bringup_and_idle() as
 dead_end_function
Message-ID: <20210820192224.ytrr6ybuuwegbeov@treble>
References: <20210624094059.886075998@infradead.org>
 <20210624095147.693801717@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210624095147.693801717@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 11:41:00AM +0200, Peter Zijlstra wrote:
> The asm_cpu_bringup_and_idle() function is required to push the return
> value on the stack in order to make ORC happy, but the only reason
> objtool doesn't complain is because of a happy accident.
> 
> The thing is that asm_cpu_bringup_and_idle() doesn't return, so
> validate_branch() never terminates and falls through to the next
> function, which in the normal case is the hypercall_page. And that, as
> it happens, is 4095 NOPs and a RET.
> 
> Make asm_cpu_bringup_and_idle() terminate on it's own, by making the
> function it calls as a dead-end. This way we no longer rely on what
> code happens to come after.
> 
> Fixes: c3881eb58d56 ("x86/xen: Make the secondary CPU idle tasks reliable")
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Looks right.  Only problem is, with my assembler I get this:

  arch/x86/kernel/head_64.o: warning: objtool: .text+0x5: unreachable instruction

Because gas insists on jumping over the page of nops...

0000000000000000 <asm_cpu_bringup_and_idle>:
       0:	e8 00 00 00 00       	callq  5 <asm_cpu_bringup_and_idle+0x5>
			1: R_X86_64_PLT32	cpu_bringup_and_idle-0x4
       5:	e9 f6 0f 00 00       	jmpq   1000 <xen_hypercall_set_trap_table>
       a:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
      11:	00 00 00 00 
      15:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
      1c:	00 00 00 00 
      20:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
      27:	00 00 00 00 
      2b:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
      32:	00 00 00 00 
      36:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
      3d:	00 00 00 00 

-- 
Josh

