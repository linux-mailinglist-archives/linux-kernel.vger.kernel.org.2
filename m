Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9E73B664D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 17:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbhF1QAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 12:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbhF1QAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 12:00:44 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53122C061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 08:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rG1NX/+sDzX1eduBfUfZaOFDlE/1LorIyYoFI7/cQzU=; b=arVULtrj4cq1zut8yJ7w5gzBGi
        oBc0wx3fLJ8ZvaIGkUtJUH/XcbHyQ/RWlrlpvQBKDhh4rS5fm/2IJ5gfy4WUM/jG/gmBS8p51ZgeA
        lO5vrAOPNwGqgQTDWrO/xdhVWxKmD6A15ppptm+B5KmIH4yzANO9GbqTHRXLxftyAgf/NAcM26gb8
        cr/RyLFDOBDfbNWP06OlHuv4spdfRF+br5kwnvpqg+ifXGNHEB+nJEEhdl7V5hI9dPF/ye8kQ9Kor
        38egFUsyror3tvbAP0gLw4l/j1Q24zjq8mrpe3UZP/O7q+AyxZxuhadCo6Qj0LseHjIuJx0z8rkkP
        pO30FrZQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxte9-00Cb4Y-6W; Mon, 28 Jun 2021 15:58:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 72A3A3002D3;
        Mon, 28 Jun 2021 17:58:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 61A752C0F4835; Mon, 28 Jun 2021 17:58:04 +0200 (CEST)
Date:   Mon, 28 Jun 2021 17:58:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 0/7] posix-cpu-timers: Bunch of fixes v2
Message-ID: <YNnxjI7ermkZ0/Er@hirez.programming.kicks-ass.net>
References: <20210622234155.119685-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622234155.119685-1-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 01:41:48AM +0200, Frederic Weisbecker wrote:
> Frederic Weisbecker (7):
>       posix-cpu-timers: Fix rearm racing against process tick
>       posix-cpu-timers: Assert task sighand is locked while starting cputime counter
>       posix-cpu-timers: Force next_expiration recalc after timer deletion
>       posix-cpu-timers: Force next expiration recalc after itimer reset
>       posix-cpu-timers: Remove confusing error code override
>       posix-cpu-timers: Consolidate timer base accessor
>       posix-cpu-timers: Recalc next expiration when timer_settime() ends up not queueing

Looks good, Thanks!

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
