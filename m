Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 531AB3BDB38
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 18:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhGFQST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 12:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbhGFQSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 12:18:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A410C061574
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 09:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=z9qBV+8yQywjnr/4m/XD3TNlrsIbjWArlkEXhe7Hso4=; b=uTcHLO2iE4gcad6oNx+qi1y2tw
        nOA8vR33HWE2re49H+UFYco+LIw4xed7vt/288EsYhpv37A9Hx6aZXtLWoz0qTGTan7ZL7KjQyS3J
        6qsAKBeqHA5aXuC8bDJiHqKuxiUGUc49x1tUBJMdJpaCU+72TKYR8STkkHAzjyvbVzUOrxnY7QU4b
        xXJz5WiZXttA3evmrv3M7FsehVqDkaCGOgHGW8I/HkQd3kUVIaBEwrzzIKUblicg/L1JZG8A4BwJI
        yUfQuleGZidjWhF2d5Q6QH4Ev9udYEcNikwHTyDh6Cb5+r6dqTUn0vGZsX+0QVVx8dcrfgpJRD6iT
        kOAXwJFA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m0njJ-00BYlR-O1; Tue, 06 Jul 2021 16:15:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 49EA0300130;
        Tue,  6 Jul 2021 18:15:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 36EED201C57F9; Tue,  6 Jul 2021 18:15:24 +0200 (CEST)
Date:   Tue, 6 Jul 2021 18:15:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Nitesh Lal <nilal@redhat.com>
Subject: Re: [patch 0/5] optionally sync per-CPU vmstats counter on return to
 userspace
Message-ID: <YOSBnMNNeVseeGZK@hirez.programming.kicks-ass.net>
References: <20210701210336.358118649@fuller.cnet>
 <20210702123032.GA72061@lothringen>
 <20210702152816.GA4122@fuller.cnet>
 <20210706130925.GC107277@lothringen>
 <20210706140550.GA64308@fuller.cnet>
 <20210706140920.GA68399@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706140920.GA68399@fuller.cnet>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2021 at 11:09:20AM -0300, Marcelo Tosatti wrote:
> Peter, was that the only problem you saw with isolcpus interface?

It needs to die, it's a piece of crap. Use cpusets already.
