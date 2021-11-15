Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F65452358
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 02:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379771AbhKPBYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 20:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377418AbhKPBQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 20:16:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22AFC081976
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 15:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0WzNlGDXP4JUgWCiGvStafi6U6pBvQ13D9YwWj3YiqU=; b=kykCinfG8WiT/5wuD591E5CG2I
        QE7WNZrfdYqr5I1Cdn9LM1KYvAwXuPriPwkFkJo31gemJiCMIByehjdptcRxRP2QCjYnjC0vhdIl0
        hwhm/lpBtlJenAN7tnekQOGBqgy44iGuuQcj83B+m/eyt6eLzDYk9U1r+4akCvxAukI8vXw7Vdq3Z
        msfpgFLp+vRvnILpcVBlIDJH21E4CVgnpeFLZUFt028Vmq9Mo16eynhiKGrEhewPa6qmi+82hS4Qd
        zeMa0ZmDggIxZbjRk/eNGfjpybESEQD3j/4hDrsD5MeTNmo07VUS/6LSvvwrdH912XkBTt/IsvYEs
        7dM8A7RQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mml4S-0069Yt-UG; Mon, 15 Nov 2021 23:07:29 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 553639866D2; Tue, 16 Nov 2021 00:07:28 +0100 (CET)
Date:   Tue, 16 Nov 2021 00:07:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        mazhenhua <mazhenhua@xiaomi.com>,
        Hillf Danton <hdanton@sina.com>,
        Maria Yu <quic_aiquny@quicinc.com>
Subject: Re: [PATCH v4] locking/rwsem: Make handoff bit handling more
 consistent
Message-ID: <20211115230728.GS174703@worktop.programming.kicks-ass.net>
References: <20211112040753.389380-1-longman@redhat.com>
 <YY5Z009P2jJ4X484@hirez.programming.kicks-ass.net>
 <a141b93d-1945-a44d-467f-54b648cbf4d0@redhat.com>
 <YZKEc+SgijOcB+0W@hirez.programming.kicks-ass.net>
 <ce034084-364b-e30f-cb7c-d6434afe3a7d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce034084-364b-e30f-cb7c-d6434afe3a7d@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 05:29:10PM -0500, Waiman Long wrote:
> 
> The handoff_set flag can only be true for a first waiter. A random waiter in
> the middle of a wait queue will never has this flag set.
> 
> This flag is set in two places in rwsem_try_write_lock():

Bah, I thought it would unconditionally propagate the bit from @count. I
missed the early exit :/
