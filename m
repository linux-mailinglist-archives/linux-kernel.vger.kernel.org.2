Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A797C42A4D6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 14:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236568AbhJLMtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 08:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236281AbhJLMty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 08:49:54 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AD2C061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 05:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UyY3tWV+Y1xbSo6S2x+r6fqtpBH8zV0VEjAddpI41t0=; b=Lghn9z43zRYNjv0/6CtBmBup8e
        4X2l+Q682Xist0oOuTMRxvvN8QrYROLIer2UxBXEMfVSr09L5mozpAS2DKDj6437gM2OPMC5fm5HX
        pS6vGGN4kvv6lolc1wtZfa398Kqv7QnW7/UslniEG/ZiU4jU4EPgvINprhdti4uHwg4CVnkgj2lpd
        13Iv2x4PoKjQUXdaecBmU1nX96/ruteLKapoNa4tPcvdIfiS2EDBZHaZijvaRitab951UhV/5zqNb
        PsnflKTjXrdIO4+DX3wA0Ff1BCHUxQvEYU6w3UJKzAKDxOEvJWQ17bd3n6Si7BVzJx5XWkbR205f3
        RfGhxLZg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maHC5-009PhQ-Qf; Tue, 12 Oct 2021 12:47:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A0A5830030B;
        Tue, 12 Oct 2021 14:47:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 77BA12C8434CD; Tue, 12 Oct 2021 14:47:44 +0200 (CEST)
Date:   Tue, 12 Oct 2021 14:47:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v2] x86/apic: reduce cache line misses in
 __x2apic_send_IPI_mask()
Message-ID: <YWWD8NCCJi3kZKvq@hirez.programming.kicks-ass.net>
References: <20211007143556.574911-1-eric.dumazet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211007143556.574911-1-eric.dumazet@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2021 at 07:35:56AM -0700, Eric Dumazet wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> Using per-cpu storage for @x86_cpu_to_logical_apicid
> is not optimal.
> 
> Broadcast IPI will need at least one cache line
> per cpu to access this field.
> 
> __x2apic_send_IPI_mask() is using standard bitmask operators.
> 
> By converting x86_cpu_to_logical_apicid to an array,
> we divide by 16x number of needed cache lines, because
> we find 16 values per cache line. CPU prefetcher can
> kick nicely.
> 
> Also move @cluster_masks to READ_MOSTLY section to avoid false sharing.
> 
> Tested on a dual socket host with 256 cpus,
> cost for a full broadcast is now 11 usec instead of 33 usec.
> 
> v2: use a dynamically allocated array, as suggested by Peter.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
