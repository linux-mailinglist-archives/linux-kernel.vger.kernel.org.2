Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7378F3ABB56
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 20:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbhFQSYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 14:24:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41134 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229816AbhFQSYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 14:24:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623954124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dLf5lb9pqtiFUUorIDm+A5wNwoIqKNePrs/M2mIsUMY=;
        b=Azn4JmfrmfBSW11fi34Or7vnKSXNMtx7c1URNfXjD+Owp4B1dGFoYa6dWTJ/Yhv75Mmdtq
        0951/yyz/coZxrlQWOPOoJJgkhOGpLsR9R9CdSWe2P/vBmybJlla7sGzFztXIEObp9dUGk
        qJnTe2ymbeoSaCusVUDNhQdVYj4tShQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-zF5es279Nwmmb9liYhe8Ag-1; Thu, 17 Jun 2021 14:22:02 -0400
X-MC-Unique: zF5es279Nwmmb9liYhe8Ag-1
Received: by mail-qt1-f199.google.com with SMTP id 62-20020aed30440000b029024cabef375cso4639425qte.17
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 11:22:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dLf5lb9pqtiFUUorIDm+A5wNwoIqKNePrs/M2mIsUMY=;
        b=k68mgcfAmhrTpsTE7RqMKY+M5QLLsVBy4b6tqSJLZIx57XiQWuzD4R3uLkOfpk5mCa
         ydnhed87EcMqHnpKpJ69TsuWEAzr3uEIdKcRswRAWpuJbZJS/j2uoDwJNLMP4VEgOXVa
         8/yi89ygx7kx/+qvRGoqrY1C+26YOw0ftWoAfu0pmmf7JChwNEflpZsWygwVOJ+5MLJI
         RKXr+971JyUsuWqki4FstbT/IkpVmhHl6AH2v3v/akJcbqgFA+IV3WAhiqpBb3TCcKVC
         RrpilnK7TmVJoSR0fHIFDNjFNrRHobleNkYknnlYwnMYfE8ChOC3BQjzxnCvnQ2Tjfd1
         l8rw==
X-Gm-Message-State: AOAM532C08BChhKtHQljJTePjnQFbF/FidI3jX5drvyyfrI6b0NaZSD3
        37aLfvakcUbeI4yZrj8qNSBpoW6h+u1WhPMJB3zGscv1wDHkeSK1NFdCj+56aJbYoHvn/hQ6AkY
        7N1A83ajtgjm1t4moy7OLr9pp
X-Received: by 2002:ac8:4803:: with SMTP id g3mr6508834qtq.176.1623954122443;
        Thu, 17 Jun 2021 11:22:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvs7yF1XwMKN/+3URlziDuC/xxyy+TxwhIoORXzLoREhu5g8YsnZqVt7ydq/WqRqMUIs/Gjw==
X-Received: by 2002:ac8:4803:: with SMTP id g3mr6508806qtq.176.1623954122162;
        Thu, 17 Jun 2021 11:22:02 -0700 (PDT)
Received: from treble ([68.52.236.68])
        by smtp.gmail.com with ESMTPSA id k19sm2229348qkj.89.2021.06.17.11.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 11:22:01 -0700 (PDT)
Date:   Thu, 17 Jun 2021 13:21:59 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>
Subject: Re: [PATCH -tip v7 09/13] kprobes: Setup instruction pointer in
 __kretprobe_trampoline_handler
Message-ID: <20210617182159.ka227nkmhe4yu2de@treble>
References: <162209754288.436794.3904335049560916855.stgit@devnote2>
 <162209762943.436794.874947392889792501.stgit@devnote2>
 <20210617043909.fgu2lhnkxflmy5mk@treble>
 <20210617044032.txng4enhiduacvt6@treble>
 <20210617234001.54cd2ff60410ff82a39a2020@kernel.org>
 <20210618000239.f95de17418beae6d84ce783d@kernel.org>
 <CAEf4Bzbob_M0aS-GUY5XaqePZr_prxUag3RLHtp=HY8Uu__10g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEf4Bzbob_M0aS-GUY5XaqePZr_prxUag3RLHtp=HY8Uu__10g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 10:45:41AM -0700, Andrii Nakryiko wrote:
> > > > > I know I suggested this patch, but I believe it would only be useful in
> > > > > combination with the use of UNWIND_HINT_REGS in SAVE_REGS_STRING.  But I
> > > > > think that would be tricky to pull off correctly.  Instead, we have
> > > > > UNWIND_HINT_FUNC, which is working fine.
> > > > >
> > > > > So I'd suggest dropping this patch, as the unwinder isn't actually
> > > > > reading regs->ip after all.
> > > >
> > > > ... and I guess this means patches 6-8 are no longer necessary.
> > >
> > > OK, I also confirmed that dropping those patche does not make any change
> > > on the stacktrace.
> > > Let me update the series without those.
> >
> > Oops, Andrii, can you also test the kernel without this patch?
> > (you don't need to drop patch 6-8)
> 
> Hi Masami,
> 
> Dropping this patch and leaving all the other in place breaks stack
> traces from kretprobes for BPF. I double checked with and without this
> patch. Without this patch we are back to having broken stack traces. I
> see either
> 
>   kretprobe_trampoline+0x0
> 
> or
> 
>   ftrace_trampoline+0xc8
>   kretprobe_trampoline+0x0
> 
> Is there any problem if you leave this patch as is?

Hm, I must be missing something then.  The patch is probably fine to
keep, we just may need to improve the commit log so that it makes sense
to me.

Which unwinder are you using (CONFIG_UNWINDER_*)?

-- 
Josh

