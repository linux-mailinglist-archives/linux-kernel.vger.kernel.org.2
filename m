Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA8E340F60E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 12:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343696AbhIQKmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 06:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbhIQKmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 06:42:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50655C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 03:40:46 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631875243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ld2o6zZK0OVuVhEFfg2/2mMyUsX2dhU9nHxj5zadJPQ=;
        b=BwV0qJCnvIZAw4VrpMaO5od5CWTtv36FqP20MIwVfhB/18swgbUwKKPfS5pN4WqmIeyEBv
        73Pn6dSVEeIHifj7zJZy0ioipMVRitjkhQksTEzv+/5zYgWzXHmvkf3dqD9EfGpdBcPKyf
        ayXjL38BV3SIFj5dM7ITq9OnoCd+pxZkFEGDxH5CC9p5usYw2xuXDlzI7vA7DuVbyUaj/1
        MhS6TXA5lagKBrtvJZYJwnVyrEM4baGHaLf8Ckhv2mNtAdUGIIf/F78WgTnwTyx9SMrVSD
        RCF/KvtWu1A6mAYJZteU6d+MabjisM6UzwNyV1ZljHsI/D7Qcx6Mtk3E/v9ksQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631875243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ld2o6zZK0OVuVhEFfg2/2mMyUsX2dhU9nHxj5zadJPQ=;
        b=HazHRQ0v3z+ZjuPXcfNL1xAwODsrzm8BkxqHp09vG54Uolfsn84OAE7oYI+62e8MoPsqAR
        YUoF4wHHcQLMxwCQ==
To:     Peter Zijlstra <peterz@infradead.org>, Ondrej Zary <linux@zary.sk>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] x86/iopl: Fake iopl(3) CLI/STI usage
In-Reply-To: <YURdxNpH8YNQZQT7@hirez.programming.kicks-ass.net>
References: <202109151423.43604.linux@zary.sk>
 <202109162227.17415.linux@zary.sk>
 <20210916210509.GG4323@worktop.programming.kicks-ass.net>
 <202109171011.31916.linux@zary.sk>
 <YURdxNpH8YNQZQT7@hirez.programming.kicks-ass.net>
Date:   Fri, 17 Sep 2021 12:40:43 +0200
Message-ID: <87pmt78oyc.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17 2021 at 11:20, Peter Zijlstra wrote:
> Subject: x86/iopl: Fake iopl(3) CLI/STI usage
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Thu, 16 Sep 2021 23:05:09 +0200
>
> Since commit c8137ace5638 ("x86/iopl: Restrict iopl() permission
> scope") it's possible to emulate iopl(3) using ioperm(), except for
> the CLI/STI usage.
>
> Userspace CLI/STI usage is very dubious (read broken), since any
> exception taken during that window can lead to rescheduling anyway (or
> worse). The IOPL(2) manpage even states that usage of CLI/STI is highly
> discouraged and might even crash the system.
>
> Of course, that won't stop people and HP has the dubious honour of
> being the first vendor to be found using this in their hp-health
> package.
>
> In order to enable this 'software' to still 'work', have the #GP treat
> the CLI/STI instructions as NOPs when iopl(3). Warn the user that
> their program is doing dubious things.
>
> Fixes: a24ca9976843 ("x86/iopl: Remove legacy IOPL option")
> Reported-by: Ondrej Zary <linux@zary.sk>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
