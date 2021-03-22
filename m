Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B9F343C3A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 10:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhCVJBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 05:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbhCVJBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 05:01:37 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F90C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 02:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8sItCnyIcck+lptyUziWI9fd9hb9cv69jnIU5uaoL74=; b=h8Ni7PCO79d5xFJzv8hc9HxzsB
        6plktdOCEJkrx/D/QX2ltnoiBI3h/peiNaWkrZJ2Hi7mJs21W0SwdiIPn3lRLMxyQTt8HIlu8WKW7
        Mj98O3Gz3LW8UgyVupoIyklZOpJEMu/yQCXdQl6siAMMFrjA4CGsR3pEx1SpL9mQum/g2wx+XliA8
        09fxgNQMYEj1NJT96GnXfqZMMDpu9nGFcjSb4qaxTwhfU7m2B4o4qqGvleB1oPuhcVki+TkPKdnDl
        IQ54a4Cmn492a0AKBPLSnJLlwMWN2hZmKpyVGCsvna8NbuhdkyaTFu4Zgwf+6JHKMYsZ4XBrR6X/8
        S5pERiFg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOGRI-00BDXu-Kg; Mon, 22 Mar 2021 09:01:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2AAC73010C8;
        Mon, 22 Mar 2021 10:01:32 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 148692BA3A2FC; Mon, 22 Mar 2021 10:01:32 +0100 (CET)
Date:   Mon, 22 Mar 2021 10:01:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: locking/mutex: Fix non debug version of mutex_lock_io_nested()
Message-ID: <YFhc7CvSdPULqZ/Q@hirez.programming.kicks-ass.net>
References: <878s6fshii.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878s6fshii.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 09:46:13AM +0100, Thomas Gleixner wrote:
> If CONFIG_DEBUG_LOCK_ALLOC=n then mutex_lock_io_nested() maps to
> mutex_lock() which is clearly wrong because mutex_lock() lacks the
> io_schedule_prepare()/finish() invocations.
> 
> Map it to mutex_lock_io().

Thanks!
