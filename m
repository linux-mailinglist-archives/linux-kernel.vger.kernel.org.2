Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC77410B23
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 12:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbhISK3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 06:29:13 -0400
Received: from ozlabs.org ([203.11.71.1]:53725 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230020AbhISK3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 06:29:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1632047266;
        bh=eg+HaWYEym9ygfON7zYGQuEU/muaYg2T01YdLRXZb/k=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=GV/DbLxVqgRdJa2+0usn1hfgMVXOxB11kR1RM6L7gcdeqdFK/FmWzwivtgTnPqzJU
         QnbdWbAg1nxE4Yf6VY4cRBruLLqwf4h6q62Bd0rgcaXVbf4QuC5UlAdiaTkr5R0yIp
         ++LTbTH4IHHjo8WYQtpSsxxcca7WedKOme6+yAqFP5nSdxyLNCCPTfqnyvwCb5kWnw
         J4g2W5qWILsMoZLvwiBK8CgszIkrIwkELujrEgNpodaT+v5+I65bOVoBDv5sgsMcdV
         mgUbLFS57/De9IUwAjnLCdgRP7Jo25GczD3d/raGl4WEHRu9R9aF9e4cMnfgKiDS5Z
         Aw+Y3KylXh3Vg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4HC3mK1mxqz9sW8;
        Sun, 19 Sep 2021 20:27:45 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Stephane Eranian <eranian@google.com>
Cc:     Madhavan Srinivasan <maddy@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, acme@redhat.com, jolsa@redhat.com,
        kim.phillips@amd.com, namhyung@kernel.org, irogers@google.com,
        atrajeev@linux.vnet.ibm.com,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v1 01/13] perf/core: add union to struct perf_branch_entry
In-Reply-To: <CABPqkBQ=9pev4=iF+JwB8DZ391GGAkFbtBidkFeOt2MPeC0hyg@mail.gmail.com>
References: <20210909075700.4025355-1-eranian@google.com>
 <20210909075700.4025355-2-eranian@google.com>
 <20210909190342.GE4323@worktop.programming.kicks-ass.net>
 <878s04my3b.fsf@mpe.ellerman.id.au> <875yv8ms7f.fsf@mpe.ellerman.id.au>
 <CABPqkBQZ48b51vh1vqafOwVK2tBqYFNFGJT2x-a39Ma0TbS=tA@mail.gmail.com>
 <b21bf42e-377d-36d0-49c3-af1e4edf5496@linux.ibm.com>
 <CABPqkBQvvNQa=hb4OnYqH-f=DJiRWE+bTmv4i+gNvEdoSEHM4w@mail.gmail.com>
 <878rzvk7h0.fsf@mpe.ellerman.id.au>
 <CABPqkBRrx5vnPqTEnuQOeoJxyjiszCG7EMdK35ES=rHKYUNBpQ@mail.gmail.com>
 <874kajjs1e.fsf@mpe.ellerman.id.au>
 <CABPqkBQ=9pev4=iF+JwB8DZ391GGAkFbtBidkFeOt2MPeC0hyg@mail.gmail.com>
Date:   Sun, 19 Sep 2021 20:27:38 +1000
Message-ID: <87r1dkj1wl.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephane Eranian <eranian@google.com> writes:
> On Fri, Sep 17, 2021 at 5:38 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>> Stephane Eranian <eranian@google.com> writes:
>> > Hi,
>> >
>> > On Fri, Sep 17, 2021 at 12:05 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>> >>
>> >> Stephane Eranian <eranian@google.com> writes:
>> >> > Hi,
>> >> >
>> >> > Thanks for fixing this in the perf tool. But what about the struct
>> >> > branch_entry in the header?
>> >>
>> >> I'm not sure what you mean.
>> >>
>> >> We can't change the order of the fields in the header, without breaking
>> >> existing userspace on BE systems.
>> >>
>> > Ok, I think I had missed that. You are saying that the
>> > #ifdef (__BIG_ENDIAN_BITFIELD) vs __LITTLE_ENDIAN_BITFIELD
>> >
>> > is only added to kernel-only data structures?
>>
>> No, we *should* have used __BIG/LITTLE_ENDIAN_BITFIELD for the uapi
>> definition, but we forgot.
>>
> But are you suggesting it cannot be fixed?

I'm not saying it *cannot* be fixed

But I don't think it's sufficiently broken to warrant fixing.

Just adding the __BIG/LITTLE_ENDIAN_BITFIELD ifdefs would break the ABI
for existing users.

So we'd have to continue to support the existing bitfield layout, and
then add a flag for userspace to request a new bitfield layout where the
bit numbers are stable across endian.

But that's way too much effort IMHO.

The existing definition works fine, *except* when perf.data files are
moved between machines of different endianness. That is pretty rare
these days, and can be handled in the perf tool easily enough.

>> >> It's annoying that the bit numbers are different between LE & BE, but I
>> >> think it's too late to change that.
>> >>
>> > I agree.
>> >
>> >> So nothing should change in the branch_entry definition in the header.
>> >>
>> >> My comment on your patch was that adding the union with val, makes it
>> >> easier to misuse the bitfields, because now the values can be accessed
>> >> via the bitfields and also via val, but when using val you have to know
>> >> that the bit numbers differ between BE/LE.
>> >>
>> > Ok, I get it now. We do not need to expose val to user. This is added
>> > for kernel code convenience only.
>>
>> Yeah. Putting the union with val in the uapi encourages userspace to
>> misuse val to bypass the bitfields, and that risks causing endian bugs.
>>
>> > But if we keep it in kernel, that may break some other rules about
>> > uapi headers.
>>
>> I don't follow what you mean there.
>>
>> We could use #ifdef __KERNEL__ in the uapi header to make the union
>> kernel-only, see below, but it's pretty gross.
>>
>>  struct perf_branch_entry {
>>         __u64   from;
>>         __u64   to;
>>  #ifdef __KERNEL__
>>         union {
>>                 __u64   val;        /* to make it easier to clear all fields */
>>                 struct {
>>  #endif
>>                         __u64   mispred:1,  /* target mispredicted */
>>                                 predicted:1,/* target predicted */
>>                                 in_tx:1,    /* in transaction */
>>                                 abort:1,    /* transaction abort */
>>                                 cycles:16,  /* cycle count to last branch */
>>                                 type:4,     /* branch type */
>>                                 reserved:40;
>>  #ifdef __KERNEL__
>>                 };
>>         };
>>  #endif
>>  };
>>
>>
>> If we just do the inline I suggested we can clear the flags in a single
>> source line, and the generated code seems fine too, eg:
>>
>> static inline void clear_perf_branch_entry_flags(struct perf_branch_entry *e)
>> {
>>         e->mispred = 0;
>>         e->predicted = 0;
>>         e->in_tx = 0;
>>         e->abort = 0;
>>         e->cycles = 0;
>>         e->type = 0;
>>         e->reserved = 0;
>> }
>>
> Ok, let's do the inline then. That looks like a cleaner solution to me
> assuming the compiler does the right thing.

It did when I checked with GCC 10.

cheers
