Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B09D930BC78
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 12:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhBBLBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 06:01:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhBBLBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 06:01:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C214CC061573
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 03:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=IL2Knb5QEF5H4mAZFRzw44CtmAc8icDXSeOKMFeOllU=; b=GSnqgCWof+NzFOi3Z8uRlKL+oF
        /X4unuZVBP2xzCgAp8vNYA6+zS6VOm5ddW2y+cGusnphgVS+otijEKOem85Rsm2XmTPvwQSRqwOfE
        JwXntW4FNkdYUc4CBtf7dRGrf6H4fpa77mSdso4J1c4sNyvYcJQ00EqcBzl9EnBEKLWrmSLFUdpEW
        lMyGS4KXFfPHuM0i+q3XXK1sxYnGKsbTM53QIebeNUhr1jopK6c55KiEMHRaULBbqPOzbsEFMt805
        zNzBEBHnmEyuscR/Dga/RWkJqGoU2vZgYkmAlp8TmsSnXLJ027zTh+kCcUtia/v3yntgaG52NmUm0
        bES6fOfg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l6tQ3-00F5Ui-BO; Tue, 02 Feb 2021 11:00:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E21723011FE;
        Tue,  2 Feb 2021 12:00:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C42B6299C9F7C; Tue,  2 Feb 2021 12:00:24 +0100 (CET)
Date:   Tue, 2 Feb 2021 12:00:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, x86@kernel.org
Subject: Re: [RFC 01/20] mm/tlb: fix fullmm semantics
Message-ID: <YBkwyEL2FKxlsgZ5@hirez.programming.kicks-ass.net>
References: <20210131001132.3368247-1-namit@vmware.com>
 <20210131001132.3368247-2-namit@vmware.com>
 <YBfntzMgNlMDOP9s@hirez.programming.kicks-ass.net>
 <52673507-2C30-4AC6-8EBC-B5A313827FB0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <52673507-2C30-4AC6-8EBC-B5A313827FB0@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 01:32:36AM -0800, Nadav Amit wrote:
> > On Feb 1, 2021, at 3:36 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > 
> > https://lkml.kernel.org/r/20210127235347.1402-1-will@kernel.org
> 
> I have seen this series, and applied my patches on it.
> 
> Despite Will’s patches, there were still inconsistencies between fullmm
> and need_flush_all.
> 
> Am I missing something?

I wasn't aware you were on top. I'll look again.
