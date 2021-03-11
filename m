Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEA03378BF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 17:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbhCKQGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 11:06:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41248 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234210AbhCKQGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 11:06:21 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615478780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+uyJbL6m3t84tc6HqpRO03oYL9f9GmOb7tQSt7z+X3Y=;
        b=1nQLZmNofMx7eBTFzbuWM5tVvQ24T9yl3tXr/jF4wsXrNU6ph15MLFTU+lRbqmKWnQmX/u
        GLKviPHuB1CUwP6Roi+7vBEGo4YCW3PpuEJLL9k/B1Oz7uLZyRzxyJZp7v/5kaWwwTGTjA
        jD+3wE7rGm443v3FBjiab1ENcPcWY7NtA54SKNBX5/rlnpce6DfcqVoBk1R6PJjO8NNbwV
        LBb6v5phR1Z0px7pcl7yFmrtPX8NTxZndkzVH9FwTFrZIYHuHh/E5/VsKQxN2nAHqntOIY
        Djlkwxd2p9oq7P7/heOaxPsEUKCXzU9mOE/L4iMf5wNEommkO8dO1yafhEHkUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615478780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+uyJbL6m3t84tc6HqpRO03oYL9f9GmOb7tQSt7z+X3Y=;
        b=DBGDf1H4SxWEJjzCgLlxbj4cG2aQ8i9cpibQUFZqka/skWX9yiE1gnGteTedyV4nc46eeP
        zcjveo1UqBKmm+BA==
To:     Xiangyang Yu <yuxiangyang4@huawei.com>, mingo@redhat.com,
        peterz@infradead.org, dvhart@infradead.org
Cc:     linux-kernel@vger.kernel.org, yuxiangyang4@Huawei.com
Subject: Re: [PATCH] kernel/futex: Change pi_state_update_owner() to an inline function
In-Reply-To: <20210309024012.1391035-1-yuxiangyang4@huawei.com>
References: <20210309024012.1391035-1-yuxiangyang4@huawei.com>
Date:   Thu, 11 Mar 2021 17:06:20 +0100
Message-ID: <874khh4qv7.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09 2021 at 10:40, Xiangyang Yu wrote:
> In our performance tests, we find that the performance of
> sysbench is descend. Function call consumes too many instructions,
> change pi_state_update_owner() to an inline function.

Serioulsy? sysbench does not use PI futexes which means that it does not
ever invoke this function. So it's completely irrelevant for that test
whether the function is marked inline or not.

Aside of that the compiler can ignore 'inline' or inline a static
function. But even if there would be an extra call, then

> Test case: https://github.com/akopytov/sysbench
> Test cmd: ./sysbench --test=threads --num-threads=$thr
>               --thread-yields=100 --thread-locks=2 run
>
> $thr    stock   non-inline   inline
> 256    0.8511     0.9254     0.8588
> 512    0.8489     0.9232     0.8503
> 1024   0.8347     0.9248     0.8495
> 2048   0.8338     0.9575     0.8402

a performance change of this magnitude is certainly not the result. I
also have no idea what these numbers actually mean. Nothing in a
sysbench output with the same parameters looks even close.

But whatever the above is, the 'inline' is neither the cause nor the
cure.

Thanks,

        tglx
