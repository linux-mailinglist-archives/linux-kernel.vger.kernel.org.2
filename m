Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 816413C80CC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 10:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238748AbhGNI7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 04:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238716AbhGNI7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 04:59:03 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AFEC061760
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 01:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3sinN9kW03AB0B3CxuL2/XepRoV5Led8linVLdJOixg=; b=Er7mHEWNvqWm9YSRapD+wnB/Bj
        G9IFrCvtKu5qMYZtWLdaJZZ1GSAKV5tbjYUq9PIRhNT+5nvjWWAKdegBGDTLIh8xBCxZxdq3GfoxV
        OpON7b0Rv7aFDB8/E5h8drMMrrE8d52n5WXZxxTOlIBzp0dPOKCIwzFy/nUM5ShrdIoHt2wZSpbW/
        i54wUg148DWgKB2C+at1dx1WMlREF6WBkDaD4yrjoXSO4dbiR6o+8jO2YkqJy+mTAJnsAt27KjsIh
        /4iF135kKRdLeJqhEKhuLG0yGkcvJfrFXYbQnCsJW7No43I7lr1ycH+nzLhPZIIBQTdfRmG95toq3
        FaoV6X3g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3agR-00HR29-6F; Wed, 14 Jul 2021 08:55:59 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id B6D4398689D; Wed, 14 Jul 2021 10:55:57 +0200 (CEST)
Date:   Wed, 14 Jul 2021 10:55:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [patch 16/50] locking/rtmutex: Use rt_mutex_wake_q_head
Message-ID: <20210714085557.GD2725@worktop.programming.kicks-ass.net>
References: <20210713151054.700719949@linutronix.de>
 <20210713160747.508939354@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713160747.508939354@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 05:11:10PM +0200, Thomas Gleixner wrote:
> +	DEFINE_RT_MUTEX_WAKE_Q_HEAD(wqh);
> -	DEFINE_WAKE_Q(wake_q);

The naming doesn't really line up nicely... Would DEFINE_RT_WAKE_Q()
work?
