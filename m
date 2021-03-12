Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B038B338C22
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 13:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbhCLMAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 07:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbhCLL7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 06:59:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFDEC061761;
        Fri, 12 Mar 2021 03:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ovZ8YsJFzLoqwrRu0EFBa5oGl3k6DgLyIZQNq1m2SxM=; b=HSxuiZGxVRE1jL1Kx47CLgpfns
        Qs1SzyDGTbvHWW3F4eTB+uCt67F1OLHfSGhzs2FvMcunA5f0ugHVDtGQHHw0//1vQ9AhfeuKx/qoV
        FQloXSP79doi7B9JRlMgZO2jQki9JWG2DwigaYPEnt/0ssiOWY91jwZ6wXxBD1Mz2WHkRXnpf5YDK
        sRamyOI+vpShRNuovl++gDdhN0YJVy4i/gkKWFRm6d8G7Zo46jIef8Kq4nk+TjHuaIZxCrfPnrAud
        FMVWtwunklXYIiZwrAH7OKXx9skeQp1flkyRCZlfa949erd+j8XOrp1g+rHS851zfXEI8A8XwqVA2
        d2urk+gA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lKgRc-00AYD5-Bd; Fri, 12 Mar 2021 11:59:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 012C13010CF;
        Fri, 12 Mar 2021 12:59:02 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id DA31A2D00DEDE; Fri, 12 Mar 2021 12:59:02 +0100 (CET)
Message-ID: <20210312113253.305040674@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 12 Mar 2021 12:32:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, rostedt@goodmis.org, hpa@zytor.com,
        torvalds@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org,
        peterz@infradead.org, jpoimboe@redhat.com,
        alexei.starovoitov@gmail.com, mhiramat@kernel.org
Subject: [PATCH 0/2] x86: Remove ideal_nops[]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

A while ago Steve complained about x86 being weird for having different NOPs [1]

Having cursed the same thing before, I figured it was time to look at the NOP
situation.

32bit simply isn't a performance target anymore, so all we need is a set of
NOPs that works on all.

x86_64 has two main NOP variants, NOPL and prefix NOP. NOPL was introduced by
P6 and is architecturally mandated for x86_64. However, some uarchs made the
choice to limit NOPL decoding to a single port, which obviously limits NOPL
throughput. Other uarchs have (severe) decoding penalties for excessive (>~3)
prefixes, hobbling prefix NOP throughput.

But the thing is, all the modern uarchs can handle both without issue; that is
AMD K10 (2007) and later and Intel Ivy Bridge (2012) and later. The only
exception is Atom, which has the prefix penalty.

Since ultimate performance of a 10 year old chip (Intel Sandy Bridge, 2011) is
simply irrelevant today, remove variable NOPs and use NOPL.

This gives us deterministic NOPs and restores sanity.



[1] https://lkml.kernel.org/r/20210302105827.3403656c@gandalf.local.home

