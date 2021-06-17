Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 149943AB7D6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 17:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbhFQPrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 11:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233468AbhFQPrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 11:47:49 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92A3C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 08:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UnVzt7PAszJTbRa+Jw/bLoAcN+xAospjeFIMWdvAS0k=; b=ClxJu98LX8uxdF0NEb4H11siTr
        0JScmunNj9H0IW9Z2TR4gtoLTdJlfYCpEWTuk+p++qr7Y4SKN6vi2HuKX9U/NYFsFGNp9yqcqF+OM
        czuCESzctqnMhC7AxANRB1jEKRlDJi9OLOIgQa7Za1crxt9UrSX4AFIb6oFtyc7XcrBIMxP+8NiQ8
        yGhsgchA9wqJ6xmCI7FwywqjzePzx5Ovp6+hPzbVtaXxpHbBTV5w5j7LFXzT1amWp/6P6eOqPIoJ/
        pYaOWPVzygBhpSgVFbxdULbu+788M8E5Htm4T0UeTv4cKJGP8FuaF5ydoE5VKKW5/DW6rdLVxupBm
        RCQHfxjQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltuCi-008ruZ-Dp; Thu, 17 Jun 2021 15:45:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D9FE1300252;
        Thu, 17 Jun 2021 17:45:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A3FD3220F6EAD; Thu, 17 Jun 2021 17:45:21 +0200 (CEST)
Date:   Thu, 17 Jun 2021 17:45:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [RFC][PATCH] sched: Use lightweight hazard pointers to grab lazy
 mms
Message-ID: <YMtuEWJl5xbqPnsK@hirez.programming.kicks-ass.net>
References: <cover.1623813516.git.luto@kernel.org>
 <f184d013a255a523116b692db4996c5db2569e86.1623813516.git.luto@kernel.org>
 <1623816595.myt8wbkcar.astroid@bobo.none>
 <YMmpxP+ANG5nIUcm@hirez.programming.kicks-ass.net>
 <617cb897-58b1-8266-ecec-ef210832e927@kernel.org>
 <1623893358.bbty474jyy.astroid@bobo.none>
 <58b949fb-663e-4675-8592-25933a3e361c@www.fastmail.com>
 <c3c7a1cf-1c87-42cc-b2d6-cc2df55e5b57@www.fastmail.com>
 <YMsQ82bzly2KAUsu@hirez.programming.kicks-ass.net>
 <e01859e4-2042-47fd-a3c6-fd65608b9b22@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e01859e4-2042-47fd-a3c6-fd65608b9b22@www.fastmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 07:10:41AM -0700, Andy Lutomirski wrote:
> On Thu, Jun 17, 2021, at 2:08 AM, Peter Zijlstra wrote:
> > +extern void mm_unlazy_mm_count(struct mm_struct *mm);
> 
> You didn't like mm_many_words_in_the_name_of_the_function()? :)

:-)

> > -	if (mm) {
> > -		membarrier_mm_sync_core_before_usermode(mm);
> > -		mmdrop(mm);
> > -	}
> 
> What happened here?
> 

I forced your patch ontop of tip/master without bothering about the
membarrier cleanups and figured I could live without that call for a
little while.

But yes, that needs cleaning up.
