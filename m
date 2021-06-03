Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC29539A239
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 15:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhFCNcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 09:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbhFCNcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 09:32:15 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8C2C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 06:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=H4b+sTaQWkMSgAowsiSQZwe82cw1/ekr/YTtV4myhm4=; b=o8mWWp95+l+vEZtzREPKMmX8eY
        aqd2bTCysqZhYkGkbsWNktnrECuraahRZ0cX8F+cfV2f+M9jpNv5VL0oL+IQZRduv8AQFSynpGmqh
        Q4+rEymD32IjsUNqFmTjmfNsALLEiqqOxPYemfWmjCd/fULhHMRFObbHntlulMyWI2+m3Adt1O8+q
        4T/xNbGtZuqWzoiv5sGrY1Qf31ktrVMtp4bUDGIvcTOphzugZspfIssXCYe2Vv+p3kmKwyW9eydgp
        qJSfBOWnkoZ3//ywInVtHKDkPs1wAz+Y4WRT1Zb54GIVUc9XvN5yjpJ9oEFo29VuyBIvPscUaGQoY
        Ub+2IRNQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lonQD-0039bJ-Bx; Thu, 03 Jun 2021 13:30:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 97CE2300269;
        Thu,  3 Jun 2021 15:30:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7D8422BE84B50; Thu,  3 Jun 2021 15:30:10 +0200 (CEST)
Date:   Thu, 3 Jun 2021 15:30:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        syzbot <syzbot+84fe685c02cd112a2ac3@syzkaller.appspotmail.com>,
        bp@alien8.de, hpa@zytor.com, inglorion@google.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        x86@kernel.org, Andy Lutomirski <luto@kernel.org>
Subject: Re: [syzbot] KASAN: stack-out-of-bounds Read in profile_pc
Message-ID: <YLjZYvXnuPnbXzOm@hirez.programming.kicks-ass.net>
References: <00000000000030293b05c39afd6f@google.com>
 <20210602230054.vyqama2q3koc4bpo@treble>
 <527ad07e-eec2-a211-03e7-afafe5196100@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <527ad07e-eec2-a211-03e7-afafe5196100@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 04:35:11PM -0700, Andi Kleen wrote:

> > We could just use ORC to unwind to the next frame.  Though, isn't
> > /proc/profile redundant, compared to all the more sophisticated options
> > nowadays?  Is there still a distinct use case for it or can we just
> > remove it?
> 
> It's still needed for some special cases. For example there is no other
> viable way to profile early boot without a VM
> 
> I would just drop the hack to unwind, at least for the early boot profile
> use case locking profiling is usually not needed.

Surely we can cook up something else there and delete this thing? ftrace
buffers are available really early, it shouldn't be hard to dump some
data in there during boot.
