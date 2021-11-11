Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE6944DD2F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 22:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234134AbhKKVlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 16:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbhKKVlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 16:41:17 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76838C061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 13:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3lkkhLrbFiHNdf9+03ciw6IbukYuglEJPMQDkhxE4cw=; b=BCPDJh4rG8M7FoFYU8younTNO9
        mEv2pKY8z4vjqKfCTP/fKuAYzT6d6rS5qHwvif4GFqyoqmL89SwDVZsyT9ka28lDPeDlCB6XQhDwW
        dt60b7c1GJ7qDdPQflYqiSiOqzMZJMBXihq3gY4N7fNEv7aoYtXYQDtLiRuzb2CeZeXaZB1sQ7A1g
        zuJlnFdtTLvH1rOPx7sPDFUGwKIvouwM19N02ytWyZOiE44adt65e78y4Os4ivwRLUF8q+0JGcCNh
        If4QXmFk7vXHJeB52klMfVh18kwpfw8nQuTacOxuPWG+reAC6EQB1Muagu6kOwCq4JvtBrOaJDxMm
        jAHznyZg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mlHlw-00FWlu-Bh; Thu, 11 Nov 2021 21:38:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7CEF130003C;
        Thu, 11 Nov 2021 22:38:14 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 669832C25B0AA; Thu, 11 Nov 2021 22:38:14 +0100 (CET)
Date:   Thu, 11 Nov 2021 22:38:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Hillf Danton <hdanton@sina.com>,
        =?utf-8?B?6ams5oyv5Y2O?= <mazhenhua@xiaomi.com>,
        mingo <mingo@redhat.com>, will <will@kernel.org>,
        "boqun.feng" <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG]locking/rwsem: only clean RWSEM_FLAG_HANDOFF when already
 set
Message-ID: <YY2NRpg1q6hLIqpK@hirez.programming.kicks-ass.net>
References: <20211107090131.1535-1-hdanton@sina.com>
 <13d683ed-793c-b502-44ff-f28114d9386b@redhat.com>
 <02e118c0-2116-b806-2b48-b9c91dc847dd@redhat.com>
 <20211110213854.GE174703@worktop.programming.kicks-ass.net>
 <YY0x55wxO2v5HCOW@hirez.programming.kicks-ass.net>
 <61735528-141c-8d77-592d-b6b8fb75ebaa@redhat.com>
 <YY1s6v9b/tYtNnGv@hirez.programming.kicks-ass.net>
 <e16f9fc2-ce01-192b-065d-460c2ad9b317@redhat.com>
 <20211111202647.GH174703@worktop.programming.kicks-ass.net>
 <be3dc705-494a-913e-230f-9533c7404ac2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be3dc705-494a-913e-230f-9533c7404ac2@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2021 at 04:01:16PM -0500, Waiman Long wrote:

> > > +			if (has_handoff || (!waiter->rt_task &&
> > > +					    !time_after(jiffies, waiter->timeout)))
> > 
> > Does ->rt_task really help over rt_task(current) ? I suppose there's an
> > argument for locality, but that should be pretty much it, no?
> Waiting for the timeout may introduce too much latency for RT task. That is
> the only reason I am doing it. I can take it out if you think it is not
> necessary.

I meant simply calling rt_task(waiter->task) here, instead of mucking about
with the extra variable.
