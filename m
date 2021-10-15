Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFC042EEB3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 12:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237973AbhJOKWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 06:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbhJOKWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 06:22:43 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F761C061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 03:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vslPbRrk4h1A3X/DwAfvRfy4Qab+SeGx3d56Sg8BvDE=; b=GXVadxGcEZ2KlI9U/DOWnxXKsn
        SWKgLvNGqHWoDz6Q+0ka9MqKyP0AnEAd2/cDEG18YfBC8YqQMAnQpeAybXhuUAwQelMWOAZ9er9IA
        1xpFh165GBy0osLDo8tDtDfAqGGLlSE6NIEAOC55D7Jpbn1cBL9+NArj2C9pvVO/sxjLW9517MDR7
        UkgYBhVAKBwxyAjzBnt2toP1j+yx2/bckWTiF3ga6hdFHwRINLWCzFcBpLsCWaauThpG7DReTlD0X
        2alRAoludIyYF0jofxP/erTe+ey8fPvty4oCwiCw6EaNdSruMf0dRWkj8tK95/D2yTC78GO2ildse
        y6uZmZKA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mbKKF-009z7h-4P; Fri, 15 Oct 2021 10:20:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 94021300288;
        Fri, 15 Oct 2021 12:20:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7608720AC5B6B; Fri, 15 Oct 2021 12:20:30 +0200 (CEST)
Date:   Fri, 15 Oct 2021 12:20:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yanfei Xu <yanfei.xu@windriver.com>
Cc:     mingo@redhat.com, will@kernel.org, longman@redhat.com,
        boqun.feng@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] locking/rwsem: disable preemption for spinning
 region
Message-ID: <YWlV7gVnPColm61C@hirez.programming.kicks-ass.net>
References: <20211013134154.1085649-1-yanfei.xu@windriver.com>
 <20211013134154.1085649-3-yanfei.xu@windriver.com>
 <YWlUZ5BlUZRA7LGR@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWlUZ5BlUZRA7LGR@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 12:13:59PM +0200, Peter Zijlstra wrote:
> On Wed, Oct 13, 2021 at 09:41:53PM +0800, Yanfei Xu wrote:
> > The spinning region rwsem_spin_on_owner() should not be preempted,
> > however the rwsem_down_write_slowpath() invokes it and don't disable
> > preemption. Fix it by adding a pair of preempt_disable/enable().
> 
> I'm thinking we should do this patch before #1, otherwise we have a
> single patch window where we'll trigger the assertion, no?

Anyway, I've stuck the lot (reordered) into my locking/core branch, lets
see what the robots make of it ;-)
