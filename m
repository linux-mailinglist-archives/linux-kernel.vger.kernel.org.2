Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B262D3B79B3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 23:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235326AbhF2VLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 17:11:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54795 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234958AbhF2VL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 17:11:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625000939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FrqFQPQ1Ye3XKJAdpfCoReQR+zXi3R08N7WEX3DldRo=;
        b=hi1jAmwRj1voBEnxNwO7SloihATaQvl7njgWjQ03Aawh/xgq8gPjWF7nOHh1iTUWFle2EX
        vOkOYJTMsBVv3iv56wx7jQaAMWepyXr456IvwisSYrzivpCgddRWzYab14y/3qNp6qzcBE
        qXP3jUHX1YCH1F4gU7qd3J2UJVKVQMI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-77-cmkEcaZJMZuVAXDALpSxeA-1; Tue, 29 Jun 2021 17:08:57 -0400
X-MC-Unique: cmkEcaZJMZuVAXDALpSxeA-1
Received: by mail-ej1-f69.google.com with SMTP id u4-20020a1709061244b02904648b302151so39461eja.17
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 14:08:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FrqFQPQ1Ye3XKJAdpfCoReQR+zXi3R08N7WEX3DldRo=;
        b=r7g6xmAD5ewLeaVNIJdXqSmL+hXdBq2bCPb6AZJMDyCu2fGLy5+ln07RlJ5w9k6gmV
         y2eFSHEEWWV8b6ysmRizGkI8E1ct0OTFSkQkCWWVIhOlpRA7PFNzTmkwmekQ2bKyMi8I
         9nwn6UajVRyqJpSqU9mKPqaqihc/OWTcKEWdoZ/5HD40Yls0jeu1M+qV9YNbT9Mr1I6T
         Pd9DMkSeC+JriXAwsvYFSLDeaBsyjYpe45uCSJnpHVY3rjgYsKHJlcboI9PdRqr/T8qT
         diS8xBN6tQjGAXm3j05VlhQTVH+yhN7qUEvEYBIQbkZH4TgNW8rQC5sC+342jEhEDwmp
         DLKw==
X-Gm-Message-State: AOAM531a4JyGWH/Fg9BF9BBt8b5UPH8sIYMHokonSHXGID7sPnb1XmKB
        oEshP+/k46SOfmPHCIazfzYCjjng0DWxNhIw09Lhvt6uTvACzCzmNbhve8btBKfkoQxA9ZhomNO
        pJywmTG08DOtOM5oiMRErrgbB
X-Received: by 2002:a17:907:2d0e:: with SMTP id gs14mr4894496ejc.49.1625000935279;
        Tue, 29 Jun 2021 14:08:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxgVqYGw0cntoN8bP11pixrtT7RyyQFMeavTfTRNndw6djx/6QtE2/5gO1KJxucWadFgbCt4Q==
X-Received: by 2002:a17:907:2d0e:: with SMTP id gs14mr4894468ejc.49.1625000935004;
        Tue, 29 Jun 2021 14:08:55 -0700 (PDT)
Received: from krava ([185.153.78.55])
        by smtp.gmail.com with ESMTPSA id hz14sm8669156ejc.107.2021.06.29.14.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 14:08:54 -0700 (PDT)
Date:   Tue, 29 Jun 2021 23:08:51 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Brendan Jackman <jackmanb@google.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        John Fastabend <john.fastabend@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Sandipan Das <sandipan@linux.ibm.com>
Subject: Re: [BUG soft lockup] Re: [PATCH bpf-next v3] bpf: Propagate stack
 bounds to registers in atomics w/ BPF_FETCH
Message-ID: <YNuL442y2yn5RRdc@krava>
References: <20210202135002.4024825-1-jackmanb@google.com>
 <YNiadhIbJBBPeOr6@krava>
 <CA+i-1C0DAr5ecAOV06_fqeCooic4AF=71ur63HJ6ddbj9ceDpQ@mail.gmail.com>
 <YNspwB8ejUeRIVxt@krava>
 <YNtEcjYvSvk8uknO@krava>
 <CA+i-1C3RDT1Y=A7rAitfbrUUDXxCJeXJLw1oABBCpBubm5De6A@mail.gmail.com>
 <YNtNMSSZh3LTp2we@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNtNMSSZh3LTp2we@krava>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2021 at 06:41:24PM +0200, Jiri Olsa wrote:
> On Tue, Jun 29, 2021 at 06:25:33PM +0200, Brendan Jackman wrote:
> > On Tue, 29 Jun 2021 at 18:04, Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > On Tue, Jun 29, 2021 at 04:10:12PM +0200, Jiri Olsa wrote:
> > > > On Mon, Jun 28, 2021 at 11:21:42AM +0200, Brendan Jackman wrote:
> > > > > On Sun, 27 Jun 2021 at 17:34, Jiri Olsa <jolsa@redhat.com> wrote:
> > > > > >
> > > > > > On Tue, Feb 02, 2021 at 01:50:02PM +0000, Brendan Jackman wrote:
> > [snip]
> > > > > Hmm, is the test prog from atomic_bounds.c getting JITed there (my
> > > > > dumb guess at what '0xc0000000119efb30 (unreliable)' means)? That
> > > > > shouldn't happen - should get 'eBPF filter atomic op code %02x (@%d)
> > > > > unsupported\n' in dmesg instead. I wonder if I missed something in
> > > > > commit 91c960b0056 (bpf: Rename BPF_XADD and prepare to encode other
> > >
> > > I see that for all the other atomics tests:
> > >
> > > [root@ibm-p9z-07-lp1 bpf]# ./test_verifier 21
> > > #21/p BPF_ATOMIC_AND without fetch FAIL
> > > Failed to load prog 'Unknown error 524'!
> > > verification time 32 usec
> > > stack depth 8
> > > processed 10 insns (limit 1000000) max_states_per_insn 0 total_states 1 peak_states 1 mark_read 1
> > > Summary: 0 PASSED, 0 SKIPPED, 2 FAILED
> > 
> > Hm that's also not good - failure to JIT shouldn't mean failure to
> > load. Are there other test_verifier failures or is it just the atomics
> > ones?
> 
> I have CONFIG_BPF_JIT_ALWAYS_ON=y so I think that's fine
> 
> > 
> > > console:
> > >
> > >         [   51.850952] eBPF filter atomic op code db (@2) unsupported
> > >         [   51.851134] eBPF filter atomic op code db (@2) unsupported
> > >
> > >
> > > [root@ibm-p9z-07-lp1 bpf]# ./test_verifier 22
> > > #22/u BPF_ATOMIC_AND with fetch FAIL
> > > Failed to load prog 'Unknown error 524'!
> > > verification time 38 usec
> > > stack depth 8
> > > processed 14 insns (limit 1000000) max_states_per_insn 0 total_states 1 peak_states 1 mark_read 1
> > > #22/p BPF_ATOMIC_AND with fetch FAIL
> > > Failed to load prog 'Unknown error 524'!
> > > verification time 26 usec
> > > stack depth 8
> > > processed 14 insns (limit 1000000) max_states_per_insn 0 total_states 1 peak_states 1 mark_read 1
> > >
> > > console:
> > >         [  223.231420] eBPF filter atomic op code db (@3) unsupported
> > >         [  223.231596] eBPF filter atomic op code db (@3) unsupported
> > >
> > > ...
> > >
> > >
> > > but no such console output for:
> > >
> > > [root@ibm-p9z-07-lp1 bpf]# ./test_verifier 24
> > > #24/u BPF_ATOMIC bounds propagation, mem->reg OK
> > >
> > >
> > > > > atomics in .imm). Any idea if this test was ever passing on PowerPC?
> > > > >
> > > >
> > > > hum, I guess not.. will check
> > >
> > > nope, it locks up the same:
> > 
> > Do you mean it locks up at commit 91c960b0056 too?
> > 
> 
> I tried this one:
>   37086bfdc737 bpf: Propagate stack bounds to registers in atomics w/ BPF_FETCH
> 
> I will check also 91c960b0056, but I think it's the new test issue

for i91c960b0056 in HEAD I'm getting just 2 fails:

	#1097/p xadd/w check whether src/dst got mangled, 1 FAIL
	Failed to load prog 'Unknown error 524'!
	verification time 25 usec
	stack depth 8
	processed 12 insns (limit 1000000) max_states_per_insn 0 total_states 1 peak_states 1 mark_read 0
	#1098/p xadd/w check whether src/dst got mangled, 2 FAIL
	Failed to load prog 'Unknown error 524'!
	verification time 30 usec
	stack depth 8
	processed 12 insns (limit 1000000) max_states_per_insn 0 total_states 1 peak_states 1 mark_read 0

with console output:

	[  289.499341] eBPF filter atomic op code db (@4) unsupported
	[  289.499510] eBPF filter atomic op code c3 (@4) unsupported

no lock up

jirka

