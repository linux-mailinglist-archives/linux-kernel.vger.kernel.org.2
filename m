Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3275830A6AD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 12:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhBALhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 06:37:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhBALhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 06:37:18 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D17C061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 03:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yJ3roDhQpuO1g9RY91FTVy4LiD9ki1OCoNdC6uPSZVM=; b=DxrXWsJQMthUCzBxi/EeEhuc9V
        U4tz0HC5b+wHBfdXzdA5YlGS0Oyvz58nkNqVYvXG0XU8IfZoO36nNENYLFWqLTvWwk62Hdwi4tjdA
        ErkXVlkOIUZsczCxvcSePA0c9DMgIN30lR38AQ8cbAlN9Y1zL3oHLdOR6+ttplM8Fa/o3O0qfih+X
        VhnksBaymZiHgkqwPdWUl2O2U4CUxn13TXIVZxLMZDIogOPU54whdcwwfc+T5GEuFOZV3L8UaeOvW
        ZTqVS6WGO0wlMA65pf0MhwH6Ygv3owIFW5rAa5kO1JXWnjnPz+FIGa5TLSNl5B0q21+x+G6Z/0ewu
        FXrchmtQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l6XVI-00Di18-OO; Mon, 01 Feb 2021 11:36:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9BD523003D8;
        Mon,  1 Feb 2021 12:36:23 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8167E2DA8F98A; Mon,  1 Feb 2021 12:36:23 +0100 (CET)
Date:   Mon, 1 Feb 2021 12:36:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, x86@kernel.org
Subject: Re: [RFC 01/20] mm/tlb: fix fullmm semantics
Message-ID: <YBfntzMgNlMDOP9s@hirez.programming.kicks-ass.net>
References: <20210131001132.3368247-1-namit@vmware.com>
 <20210131001132.3368247-2-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210131001132.3368247-2-namit@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


https://lkml.kernel.org/r/20210127235347.1402-1-will@kernel.org
