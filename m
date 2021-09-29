Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7944241C0C7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 10:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244811AbhI2Ikv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 04:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244582AbhI2Iku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 04:40:50 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAF9C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 01:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qC5xyEq6Uf+MHsz7r6gwv9ESApeOnP2XqXKAr5bxjVA=; b=ekhSDMDuFJNir0p/M7z3txFWx6
        MTWQhwsy7kceqrIUpOSUMPKapvCO5zCtXkElqnfmR0jtAI0v8XhmlEObSR4GEOw117jqqHYBvXMNA
        JnuiA/2DQWEQyV45PQXuot+3FPQrJffo0MXrYGXJ5NRx+XP/lN6C3Rjg4ka2KvVtaVoVyynQ+wjMr
        P12EEqV8J67XOEOFSZK4osNRqBjeHOoshqPNU10+kjylgwPQE0SXNbyfzJ6HGjVaf7IhabaufMlg1
        D/MbCvipUCZcxrJkbmh5+f0UZrDNwKvZD1HGonHOtc0pES9XiFiP+IyvoRKJZRH8EomI2FkpRCZ7Z
        Fyp2TOBQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mVV7H-006fut-Tv; Wed, 29 Sep 2021 08:39:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1F827300328;
        Wed, 29 Sep 2021 10:39:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6408329AD1D57; Wed, 29 Sep 2021 10:39:02 +0200 (CEST)
Date:   Wed, 29 Sep 2021 10:39:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     tglx@linutronix.de, sfr@canb.auug.org.au,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] rcu,sched: noinstr fixes
Message-ID: <YVQmJqTiplH+/0qL@hirez.programming.kicks-ass.net>
References: <20210928084020.819856223@infradead.org>
 <20210928181559.GD880162@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928181559.GD880162@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 11:15:59AM -0700, Paul E. McKenney wrote:
> On Tue, Sep 28, 2021 at 10:40:20AM +0200, Peter Zijlstra wrote:
> > A few noinstr fixes.. I'll stick the sched one in sched/urgent, Paul could you pick up the other two?
> 
> I queued those two, thank you!  I am guessing that you are looking for
> me to send them ASAP.  If so, not a problem, but please confirm.

Either way works, but given syzcaller could potentially trigger these
holes (it did find a whole bunch of 'interesting' problems in the early
noinstr days) I'd prefer them earlier rather than later.

OTOH, the objtool patches that keep triggering them all over the place
are still in objtool/core for the next cycle.
