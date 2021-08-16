Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C963ED0F6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 11:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235432AbhHPJWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 05:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234878AbhHPJWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 05:22:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B79C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 02:21:43 -0700 (PDT)
Date:   Mon, 16 Aug 2021 11:21:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629105702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bukV+s+IOJRohZslUXFIZ8uXbP2cKKkOw+MmkFuv7LU=;
        b=1Whj2FLuLrKVIfsF0Imxzy8zEtORO3tk3CFa20VLw/sjn/EUxpVABHKwzzjldsSFYOU9qv
        4UNJAHoTVzHMAyuKq6/H0PGSZe+3SZgEbhE2kgUjXGoHLy12qZT8MKWTt4ft6GdqP+qTNJ
        QrRgCJrYfCxs6OaPbRSKUIXtUagqeJHaPcqHetT+t2Iek9ro030FiOSwOb+NC8qrCBDUHB
        4Wd7uefIYNHQo1Us8iVd7CmjlnDjpDD5BjJiT/aBVPA8Ur00+CN3WTXDQ1nZdzjL5+NLUJ
        Sonzw8WzZNRQoxLUTlVKHecXFi3rP+xJ7B5uIEBSERaW9cHWJSzTi8mOB++ITA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629105702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bukV+s+IOJRohZslUXFIZ8uXbP2cKKkOw+MmkFuv7LU=;
        b=ebmCuczcmUnLbMZ3h+4Uq4IoFxYurKPmmD0waWDYe30rgXpvHBrKFMqitmMDP9MFkE2b5v
        5IVVOm3MRQejhkBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [patch V5 00/72] locking, sched: The PREEMPT-RT locking
 infrastructure
Message-ID: <20210816092140.4yqew2byxpi6a3l3@linutronix.de>
References: <20210815203225.710392609@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210815203225.710392609@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-15 23:27:35 [+0200], Thomas Gleixner wrote:
> The series survived internal testing in RT kernels and is part of the upcoming
> v5.14-rc6-rt9 release.

v5.14-rc6-rt10 to be exact, -rt9 was an intermediate release containing
the update to -rc6.

Sebastian
