Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A2F324D6A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 11:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbhBYKAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 05:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235541AbhBYJzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 04:55:53 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBABC061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 01:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=ILy7hOxPlcatByP7X1y13wdKQwSGNRl/iT8aWHTE2qw=; b=ZqxKzT7/r1NE04sirOzcr608B/
        R395iSU0IRoUkHWEpfHW25yW2KdYeGsZKPTLPEdgFY7LQv6Enquz76tVioN2ipKI4aRH2MaBCyrbB
        QmbDmbkMdjh9UE5bL7mBkmJ4UFTFFJMd6Ca53jgr7FTVPqeg20DJdO53sw97uLsiyjOn2L9kwonYx
        s+oJRl2s3vjcgKC6AhV1oy56xcGmVXDXfiawqCsMaIhWEyahIq7y9jNHmstooc82BYXRB1ih/e6hr
        8gjPX/lMonfStCVM1GotQdjVure9uouOQhHu+MRtZp+NE63ljdhVpoqGziDOA3bDPtSofYNvg7NLa
        z0W34GxA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lFDMM-0000C3-H2; Thu, 25 Feb 2021 09:55:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8E33A300DB4;
        Thu, 25 Feb 2021 10:55:00 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7AEB0201C2FE0; Thu, 25 Feb 2021 10:55:00 +0100 (CET)
Date:   Thu, 25 Feb 2021 10:55:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org
Subject: Re: [RFC 0/6] x86: prefetch_page() vDSO call
Message-ID: <YDdz9JwcwuqV3GaW@hirez.programming.kicks-ass.net>
References: <20210225072910.2811795-1-namit@vmware.com>
 <YDdiZ1SFRrvRPhkR@hirez.programming.kicks-ass.net>
 <64538CCF-AD11-43C2-9632-E054301F9E6D@gmail.com>
 <D3DF6AC2-679F-4E64-B511-B1A03D1C6048@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <D3DF6AC2-679F-4E64-B511-B1A03D1C6048@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 01:32:56AM -0800, Nadav Amit wrote:
> > On Feb 25, 2021, at 12:52 AM, Nadav Amit <nadav.amit@gmail.com> wrote:

> > Can you give me a reference to the =E2=80=9Cremoving explicit prefetch =
=66rom some
> > parts of the kernel=E2=80=9D?

75d65a425c01 ("hlist: remove software prefetching in hlist iterators")
e66eed651fd1 ("list: remove prefetching from regular list iterators")

> Oh. I get it - you mean we remove we remove the use of explicit memory
> prefetch from the kernel code. Well, I don=E2=80=99t think it is really r=
elated,
> but yes, performance numbers are needed.

Right, so my main worry was that use of the prefetch instruction
actually hurt performance once the hardware prefetchers got smart
enough, this being a very similar construct (just on a different level
of the stack) should be careful not to suffer the same fate.
