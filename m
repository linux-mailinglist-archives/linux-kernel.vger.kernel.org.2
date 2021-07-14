Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619113C8216
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 11:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238948AbhGNJzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 05:55:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60104 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238271AbhGNJzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 05:55:16 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626256344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MbUQUCpVZzVTeAwwBVXsXlqG1eZTE1mIoo7MKetGYYU=;
        b=tY5xdNH40ejOXT4ihZ+bAffwJIXS9TAUjQuKQ7w+95mvqVEaOMt2qJ3dkhmpZbxD4IvfCU
        F80paMTPOEUxc5bY7EdJucLGiq8uG2R6EOviOEyGYS1g0LC+9NlXgAl9KMdMS0wY5z5L4u
        BFazfDmaSbtNZ/L1IKoiTFhQqQpSzjqk3xxih2Viu6hWUaDfiRKpMxt62lB4aRbG8j8UHa
        gl1SBpn0T59wmzjXSLPFHmqS/YUa9i2HbkOnIYeHGpG70W14Ph1cmlZz3LgCIkB+a6wZxM
        6T1QTYA5zBd0tks+P0jNuBW7o/CP/IbVNaVZxsV4bibpF48hki1xxkm/1KXOJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626256344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MbUQUCpVZzVTeAwwBVXsXlqG1eZTE1mIoo7MKetGYYU=;
        b=jcCh6NzssCLk8XyoRtewZyZiYRkL9WA1DDgokFAYoMwW7qoztLvp5MN6lr9+sy3y0P92sA
        ARjjf3gLG7DTUTCg==
To:     Peter Zijlstra <peterz@infradead.org>
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
Subject: Re: [patch 17/50] locking/rtmutex: Prepare RT rt_mutex_wake_q for RT locks
In-Reply-To: <20210714085507.GC2725@worktop.programming.kicks-ass.net>
References: <20210713151054.700719949@linutronix.de> <20210713160747.601687056@linutronix.de> <20210714085507.GC2725@worktop.programming.kicks-ass.net>
Date:   Wed, 14 Jul 2021 11:52:24 +0200
Message-ID: <87sg0hb4tj.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14 2021 at 10:55, Peter Zijlstra wrote:
>
> This is a bit asymmetric, something like the below perhaps?

Way better :)
