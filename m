Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07FFB3ABCAA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 21:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhFQT2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 15:28:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41256 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229784AbhFQT2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 15:28:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623957973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=shbYLoohryqH6/R4MBpUAe6sg2YajDW8HCMUBWA860I=;
        b=XznvKXLoqXNwex5Dg7kSKwHyHiN8e+nBphLzKHDV8mmgB8zus5Xz4AGAgfyUFgnieVF98Q
        pUWld6idAI/n7tbgydXegRXbcLEGbKZjLZKZErJoLKvX2QuotGXrPAHz412Tw9wl1ieBaZ
        HD3eQ1y6kHII3CCwE2jdev9EOuHGXSE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588-NoP7XK5eNHOSTzKB4kgmAQ-1; Thu, 17 Jun 2021 15:26:12 -0400
X-MC-Unique: NoP7XK5eNHOSTzKB4kgmAQ-1
Received: by mail-qt1-f200.google.com with SMTP id f13-20020ac85d0d0000b029024ba963cb08so4873013qtx.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 12:26:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=shbYLoohryqH6/R4MBpUAe6sg2YajDW8HCMUBWA860I=;
        b=luHCrvkiM1S9q8w/8nw7f7k5DjMUSGJYdF1Q9zELqRmk8P/6S7R/XUBSEebdzdgnu4
         DeAbTSBKvW9/L9NQUBZjKiCsbz8vdSLDsVAxskn3M9W4y8OW7m+0nFa/GzyA8AcsV0Ct
         QBjE8y2BASVNrzMAsgORQ6OKpmIAVSID9hS2k0+6hQIU4gQKLPOVyUMFEN/coE4AW4PL
         YvnXqjEWNApnu+LcNtaHTEHAcz23zBlP3Mpqi+nweI3DnU8dbCM+HDTnOijS1GjWLxXz
         pSnZC/d6Ft27nVdb99KHvmLdatXX91fgs09/vqDkMVIFGL28uf7yjP+P4R1xLOa8aeo0
         w1YQ==
X-Gm-Message-State: AOAM532qyXA7v/sXpphUmmmWDcIa0OtRskX+k1pM4pHM+7qw5DoyVQIt
        SHWO5YAg1gvz74cy8qBVfVqvrZAagJ6HQ0a8DaDJUmF8CntcijlxUFH2wK8ZShpzZ7hxsz+xCvK
        /YES7pqiyH5HFCGQH7LTYrRKC
X-Received: by 2002:a05:620a:5b5:: with SMTP id q21mr5405618qkq.58.1623957971790;
        Thu, 17 Jun 2021 12:26:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6eeI4g6lsrMZ8thV4evhhAYVuOqxHtre6BqUjNgVh3smQXBZnMjvBrTJlvStH1PgD5Oskyg==
X-Received: by 2002:a05:620a:5b5:: with SMTP id q21mr5405600qkq.58.1623957971566;
        Thu, 17 Jun 2021 12:26:11 -0700 (PDT)
Received: from treble ([68.52.236.68])
        by smtp.gmail.com with ESMTPSA id s69sm2242882qke.115.2021.06.17.12.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 12:26:11 -0700 (PDT)
Date:   Thu, 17 Jun 2021 14:26:08 -0500
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
Message-ID: <20210617192608.4nt6sdass6gw5ehl@treble>
References: <162209754288.436794.3904335049560916855.stgit@devnote2>
 <162209762943.436794.874947392889792501.stgit@devnote2>
 <20210617043909.fgu2lhnkxflmy5mk@treble>
 <20210617044032.txng4enhiduacvt6@treble>
 <20210617234001.54cd2ff60410ff82a39a2020@kernel.org>
 <20210618000239.f95de17418beae6d84ce783d@kernel.org>
 <CAEf4Bzbob_M0aS-GUY5XaqePZr_prxUag3RLHtp=HY8Uu__10g@mail.gmail.com>
 <20210617182159.ka227nkmhe4yu2de@treble>
 <CAEf4BzbQxxAWEvE7BfrBPCPzBjrAEVL9cg-duwbFNzEmbPPW2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEf4BzbQxxAWEvE7BfrBPCPzBjrAEVL9cg-duwbFNzEmbPPW2w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 11:31:03AM -0700, Andrii Nakryiko wrote:
> On Thu, Jun 17, 2021 at 11:22 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > On Thu, Jun 17, 2021 at 10:45:41AM -0700, Andrii Nakryiko wrote:
> > > > > > > I know I suggested this patch, but I believe it would only be useful in
> > > > > > > combination with the use of UNWIND_HINT_REGS in SAVE_REGS_STRING.  But I
> > > > > > > think that would be tricky to pull off correctly.  Instead, we have
> > > > > > > UNWIND_HINT_FUNC, which is working fine.
> > > > > > >
> > > > > > > So I'd suggest dropping this patch, as the unwinder isn't actually
> > > > > > > reading regs->ip after all.
> > > > > >
> > > > > > ... and I guess this means patches 6-8 are no longer necessary.
> > > > >
> > > > > OK, I also confirmed that dropping those patche does not make any change
> > > > > on the stacktrace.
> > > > > Let me update the series without those.
> > > >
> > > > Oops, Andrii, can you also test the kernel without this patch?
> > > > (you don't need to drop patch 6-8)
> > >
> > > Hi Masami,
> > >
> > > Dropping this patch and leaving all the other in place breaks stack
> > > traces from kretprobes for BPF. I double checked with and without this
> > > patch. Without this patch we are back to having broken stack traces. I
> > > see either
> > >
> > >   kretprobe_trampoline+0x0
> > >
> > > or
> > >
> > >   ftrace_trampoline+0xc8
> > >   kretprobe_trampoline+0x0

Do the stack traces end there?  Or do they continue normally after that?

-- 
Josh

