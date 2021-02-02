Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 013AC30B882
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 08:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbhBBHPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 02:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbhBBHPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 02:15:10 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDE4C061756;
        Mon,  1 Feb 2021 23:14:29 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id g3so11963157plp.2;
        Mon, 01 Feb 2021 23:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=1XGayTK4HPTLvC5l+72jKh59N3CTEjHrLWkQehRGI4E=;
        b=ItXmN3NR1uhvjzqMhai0oe/AOBk8yZPVZtFFUqAtmS4Dllk9QZV0DFdHv9xh0/O2lQ
         EhwVDbn/fmf58+fll9rf2Ckei2Jg23UhlL3V562Xn0HQIBHE8AbGCRVnPDQC6djDJO0I
         LMNA9yTNRRvdpn397ttKvdjjtpUhQ7fygDuMIwUeWOxAmpFxJk+imSVDvDMRu554Rxof
         aalfKn73ndZRTT62SVNi5svN9uFZZizCyZB8hf+1jf1EAK10PWlWe3OsQVebRA6Gbrs5
         D5pQvGfwDtE4eMxX5T0JAbphixa0YeBeOLqPZHp+CzYEoqvobSjJCzPc2SVosMHsPYtD
         97ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=1XGayTK4HPTLvC5l+72jKh59N3CTEjHrLWkQehRGI4E=;
        b=Q+anm/qmXpzs3pgBP5cPdjhHl7ry8fuKQ4KlxvRsSrvnAKyVTNZAOMWcN+/j8ZXcg4
         boOwHnabb7z/1F/7q3iFyF/HHfcH5Ju4ar7XgWRV+9jdiIavHLYx4iXc1EvIK1e3tQrw
         8JPYRQ0NnJlv7nuoTvJ+0PAvW8THV7W+M3zJZSGNh1i95kQtO5apj7mVihqdTTwVswv8
         eS50SLZclpk14QZwzkT+1yirMnyGMeO+3BkGQlo25o1wW7Kg1hUMZ9mp5qvSaP144zl9
         hrnSDlNJWptH11OEQnT6Rh4Eye6Qjch1wTwRW7y2dxvbreD+cmlwRt3X7vvFUOOnfJbt
         7bfw==
X-Gm-Message-State: AOAM530xCJ4llBMkX0kW2nEbT8XS2BBS/mV0/Le+64A3ZhLcoJ/vgASV
        Gub1hLTYSWIxWyaKm+nwzz8=
X-Google-Smtp-Source: ABdhPJzgPkbe03Mx8f1miu0cWw5cEuiVp4QPguObuIgvrXw4ZfAgK1E0Nl2N8P0OGZGEkqVVE7aicQ==
X-Received: by 2002:a17:90a:d714:: with SMTP id y20mr2720056pju.5.1612250069141;
        Mon, 01 Feb 2021 23:14:29 -0800 (PST)
Received: from localhost (192.156.221.203.dial.dynamic.acc50-nort-cbr.comindico.com.au. [203.221.156.192])
        by smtp.gmail.com with ESMTPSA id v31sm22096301pgl.76.2021.02.01.23.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 23:14:28 -0800 (PST)
Date:   Tue, 02 Feb 2021 17:14:23 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC 00/20] TLB batching consolidation and enhancements
To:     Nadav Amit <namit@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, X86 ML <x86@kernel.org>,
        Yu Zhao <yuzhao@google.com>
References: <20210131001132.3368247-1-namit@vmware.com>
        <1612063149.2awdsvvmhj.astroid@bobo.none>
        <A1589669-34AE-4E15-8358-79BAD7C72520@vmware.com>
        <YBf3sl3M+j3hJRoM@hirez.programming.kicks-ass.net>
In-Reply-To: <YBf3sl3M+j3hJRoM@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-Id: <1612248111.g00kf5qxrp.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Peter Zijlstra's message of February 1, 2021 10:44 pm:
> On Sun, Jan 31, 2021 at 07:57:01AM +0000, Nadav Amit wrote:
>> > On Jan 30, 2021, at 7:30 PM, Nicholas Piggin <npiggin@gmail.com> wrote=
:
>=20
>> > I'll go through the patches a bit more closely when they all come=20
>> > through. Sparc and powerpc of course need the arch lazy mode to get=20
>> > per-page/pte information for operations that are not freeing pages,=20
>> > which is what mmu gather is designed for.
>>=20
>> IIUC you mean any PTE change requires a TLB flush. Even setting up a new=
 PTE
>> where no previous PTE was set, right?

In cases of increasing permissiveness of access, yes it may want to=20
update the "TLB" (read hash table) to avoid taking hash table faults.

But whatever the reason for the flush, there may have to be more
data carried than just the virtual address range and/or physical
pages.

If you clear out the PTE then you have no guarantee of actually being
able to go back and address the the in-memory or in-hardware translation=20
structures to update them, depending on what exact scheme is used
(powerpc probably could if all page sizes were the same, but THP or=20
64k/4k sub pages would throw a spanner in those works).

> These are the HASH architectures. Their hardware doesn't walk the
> page-tables, but it consults a hash-table to resolve page translations.

Yeah, it's very cool in a masochistic way.

I actually don't know if it's worth doing a big rework of it, as much=20
as I'd like to. Rather than just keep it in place and eventually
dismantling some of the go-fast hooks from core code if we can one day
deprecate it in favour of the much easier radix mode.

The whole thing is like a big steam train, years ago Paul and Ben and=20
Anton and co got the boiler stoked up and set all the valves just right=20
so it runs unbelievably well for what it's actually doing but look at it
the wrong way and the whole thing could blow up. (at least that's what=20
it feels like to me probably because I don't know the code that well).

Sparc could probably do the same, not sure about Xen. I don't suppose
vmware is intending to add any kind of paravirt mode related to this stuff?

Thanks,
Nick
