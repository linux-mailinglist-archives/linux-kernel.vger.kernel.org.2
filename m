Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C10A93AAA3D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 06:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhFQEmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 00:42:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26139 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229515AbhFQEmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 00:42:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623904837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jWbrukriN6cmSfjccXk3wRAeX8U39CdrRgGKRGxuZXM=;
        b=XxU4a1Rfe1LR6d4KsjRd90E6DRDH3t/gHqzkkFNTVmZIIF9sTFUwVibgAQq843mxv3k5g/
        yW/p33O3OWJ+5UxLTiuGPQ1t9WYMKOh1yJRXwxG+cS3WWko0WH97uEEpHrnVw55G47i1f2
        Rbi4Uv25DsBNyVDf8ADGKKql0Uq2xr8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-1CnTPuaMNi65CW3nc5M-xg-1; Thu, 17 Jun 2021 00:40:35 -0400
X-MC-Unique: 1CnTPuaMNi65CW3nc5M-xg-1
Received: by mail-qv1-f71.google.com with SMTP id bt11-20020ad455cb0000b0290258c7c1acd0so1241159qvb.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 21:40:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jWbrukriN6cmSfjccXk3wRAeX8U39CdrRgGKRGxuZXM=;
        b=Uv0N3qDeslirVFV5FfFJux97QtkYNjgEMje8+76u7T8LuBrKFG5ZI9JvyMRHALtek2
         jfebnBBRUT/7PnnMyszEB54W84LGOP96OmgPN0Vx4Kh7LktgYdMBrECvrSXG8MM94PyZ
         LA+k/yk7mXmLiu6PUgtSTM4IPGm8y1AyFUbao7ZEMVAMUjoGz3hNBVvpAxsWhj+ne9ow
         m3cROYrXnqatCPPxgzIJoQCVwndFFkXKy1jUIpXOHDEUV5vumZxqmwVIXwq//r6yQckE
         jS4z7IBYGo7XNMdlblZoscY7AdvDiPK3FQ8AePjHf7Y8zmFUPS1mm8EXPDFwnThx9T53
         HhNA==
X-Gm-Message-State: AOAM533rOfW/1ErY42Ox+8GDmddBy+lkCzXUZ7iC0XGrT8QmvnVpP6NB
        OgUqUq0oD1fbQcXwr2xY3E8WaC430xYZxo2oDiLAfdGGfOItrm11eFjeyOqRRI8l9Zpqlwl6Bjp
        rGmAwV6tNdGZKC+SUyQ8RMUyU
X-Received: by 2002:a37:a5d6:: with SMTP id o205mr1862533qke.118.1623904835322;
        Wed, 16 Jun 2021 21:40:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzN00OM2lpluu5z6CTMd/YwFORQuwMDU9GwbEcWW+z+9HapLA/PPi+4f0w+tRDNwOQpgs+fzw==
X-Received: by 2002:a37:a5d6:: with SMTP id o205mr1862521qke.118.1623904835109;
        Wed, 16 Jun 2021 21:40:35 -0700 (PDT)
Received: from treble ([68.52.236.68])
        by smtp.gmail.com with ESMTPSA id g15sm50518qtq.70.2021.06.16.21.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 21:40:34 -0700 (PDT)
Date:   Wed, 16 Jun 2021 23:40:32 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH -tip v7 09/13] kprobes: Setup instruction pointer in
 __kretprobe_trampoline_handler
Message-ID: <20210617044032.txng4enhiduacvt6@treble>
References: <162209754288.436794.3904335049560916855.stgit@devnote2>
 <162209762943.436794.874947392889792501.stgit@devnote2>
 <20210617043909.fgu2lhnkxflmy5mk@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210617043909.fgu2lhnkxflmy5mk@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 11:39:11PM -0500, Josh Poimboeuf wrote:
> On Thu, May 27, 2021 at 03:40:29PM +0900, Masami Hiramatsu wrote:
> > To simplify the stacktrace with pt_regs from kretprobe handler,
> > set the correct return address to the instruction pointer in
> > the pt_regs before calling kretprobe handlers.
> > 
> > Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > Tested-by: Andrii Nakryik <andrii@kernel.org>
> > ---
> >  Changes in v3:
> >   - Cast the correct_ret_addr to unsigned long.
> > ---
> >  kernel/kprobes.c |    3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > index 54e5b89aad67..1598aca375c9 100644
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c
> > @@ -1914,6 +1914,9 @@ unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
> >  		BUG_ON(1);
> >  	}
> >  
> > +	/* Set the instruction pointer to the correct address */
> > +	instruction_pointer_set(regs, (unsigned long)correct_ret_addr);
> > +
> >  	/* Run them. */
> >  	first = current->kretprobe_instances.first;
> >  	while (first) {
> > 
> 
> Hi Masami,
> 
> I know I suggested this patch, but I believe it would only be useful in
> combination with the use of UNWIND_HINT_REGS in SAVE_REGS_STRING.  But I
> think that would be tricky to pull off correctly.  Instead, we have
> UNWIND_HINT_FUNC, which is working fine.
> 
> So I'd suggest dropping this patch, as the unwinder isn't actually
> reading regs->ip after all.

... and I guess this means patches 6-8 are no longer necessary.

-- 
Josh

