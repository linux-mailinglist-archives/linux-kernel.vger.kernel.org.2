Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B16D23F747D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 13:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240154AbhHYLmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 07:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbhHYLma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 07:42:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639DBC061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 04:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5AGmS7Eto84KUFGC/AvW0gjgsXpaZ6zscw0Pb6A8pag=; b=bk17sYXHoy2Kam2mQ+T3GH6ox0
        bk9tX7PigMoy3fek63Rzuk7af2j4iTv8x7nQUEh+n0h3Jpa7LrJibOmNSC2Dr8Mnlog5SxEmSABrH
        uDT3lIKwfKd+J0VR16z50udX2Qj9KD0wPk53d8T44WSrC2nuvtgZkovBneJpp7d//o8qOT10UUEYC
        4FvgtxDTqLUKUCtJnfCv/jMwlt/Fv0OCfpcGNQk2qW/kCP3DU8MEL6R+AwPwPl92lss+MK4TCoiFt
        7hqh7Qjdzev04H+FAXnFPp0JscekRGNFTfldo9dTisv8Mo1euwikfUvH6TlWhjhdpGomwvzI5eXFF
        shUbrd/g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mIrGb-00CFtA-MM; Wed, 25 Aug 2021 11:40:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 628D7300252;
        Wed, 25 Aug 2021 13:40:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1E06120EEFE50; Wed, 25 Aug 2021 13:40:24 +0200 (CEST)
Date:   Wed, 25 Aug 2021 13:40:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Waiman Long <longman@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [patch 0/2] locking/rtmutex: Cure two subtle bugs
Message-ID: <YSYsKMlkEIpRBv34@hirez.programming.kicks-ass.net>
References: <20210825101857.420032248@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825101857.420032248@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 12:33:11PM +0200, Thomas Gleixner wrote:
> The recent updates to rtmutex introduced two subtle bugs:
> 
>   1) The spinwait mechanism added a UAF which triggers a BUG_ON()
> 
>   2) The ww_mutex addition leaves a waiter queued in the error exit path
>      resulting in rb tree corruption
> 
> The fixes are straight forward, but the rtmutex based ww_mutex
> implementation still has some more rough egdes which need to be ironed out.

Thanks!
