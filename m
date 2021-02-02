Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA74430BC87
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 12:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbhBBLFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 06:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhBBLFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 06:05:03 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF65DC061573;
        Tue,  2 Feb 2021 03:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=802YQyw4lVaV4w8imGbhpyRRiN1cRZRaz6c+AUsQRWs=; b=NqhZ+rxVp9Yow+TY9AI2amWfAh
        JO+yodkACrvGHvFNxEj/vf3efWCjFGugL4mcteq1H824gd9i5ZlDlIrPW8C3nbAfGuOTpze525HTe
        2xP2W+k+cutQzmlHKYn+anynD+vSanmaYnWGsOsAcw8YJSVWH5TZozhFg2UWFMS8YW0++2p3IQ5Eq
        gcLmL0kBbcttFhP+QBSlrxY3Qnu8tU9accSON4v8hKPXf6bnFbok+V5lEUQ2ZvGoXqkBFbOLEi6xv
        daHIBmL7fak+0wyrIcBNV4VTsrE3kotRk/CWyRWq5I/8320h2+GKvo3JbC3LfcvU3up/oiX+YUqqC
        SyPLOgvA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l6tTd-00F5eu-RB; Tue, 02 Feb 2021 11:04:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4BB84301179;
        Tue,  2 Feb 2021 12:04:09 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2F66D2B09FDC9; Tue,  2 Feb 2021 12:04:09 +0100 (CET)
Date:   Tue, 2 Feb 2021 12:04:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, X86 ML <x86@kernel.org>,
        Yu Zhao <yuzhao@google.com>
Subject: Re: [RFC 11/20] mm/tlb: remove arch-specific tlb_start/end_vma()
Message-ID: <YBkxqVrNnWFWmqTo@hirez.programming.kicks-ass.net>
References: <20210131001132.3368247-1-namit@vmware.com>
 <20210131001132.3368247-12-namit@vmware.com>
 <YBfvh1Imz6RRTUDV@hirez.programming.kicks-ass.net>
 <1612247956.0a1r1yjmm3.astroid@bobo.none>
 <F1C67840-C62F-4583-8593-B621706034F6@vmware.com>
 <YBkb8yKSUKTPJvxk@hirez.programming.kicks-ass.net>
 <9100B8AE-129A-4E13-8F01-7B9C14C98B4C@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9100B8AE-129A-4E13-8F01-7B9C14C98B4C@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 09:54:36AM +0000, Nadav Amit wrote:
> > On Feb 2, 2021, at 1:31 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > On Tue, Feb 02, 2021 at 07:20:55AM +0000, Nadav Amit wrote:
> >> Arm does not define tlb_end_vma, and consequently it flushes the TLB after
> >> each VMA. I suspect it is not intentional.
> > 
> > ARM is one of those that look at the VM_EXEC bit to explicitly flush
> > ITLB IIRC, so it has to.
> 
> Hmm… I don’t think Arm is doing that. At least arm64 does not use the
> default tlb_flush(), and it does not seem to consider VM_EXEC (at least in
> this path):
> 

ARM != ARM64. ARM certainly does, but you're right, I don't think ARM64
does this.


