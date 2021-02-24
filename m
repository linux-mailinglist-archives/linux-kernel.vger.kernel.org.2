Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEC132415E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 17:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236631AbhBXPtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 10:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235144AbhBXPlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 10:41:15 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC305C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 07:40:32 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614181224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KuEArnJDZcZaDgSDX5/Jl/hUB3QBLTeDqaL/WpUed8Q=;
        b=NxWBgzelLXW5lBZUKy34rybtn/aJGItegqH441WqEG2Bqu/A9o+ZydKjQmetkicjGxZVw6
        yyvSEVhbAZZfW11KvkOKzLt8//ZCb9E/Cd7MPppKVHYY5x/j8rgMYoyLZTmwQtbv0+1SU4
        1xOImHC1h3xFLm81XjYvrmGFVYN6Tcce6Bj3I3RAmYWAjCsCjcorNT/aqIt8YK9F+IwFBz
        k39SWwyUkuliwKnWYDGmHwmNi0xOxzf60fclpmfFMIMzLSEQDC1hwCKZovsdb1Z3ow+WUi
        JpR31ZZgshU4nznbpL/yZZI/QK5KQYSJrQc/7eAVpK0gd4cKbBknn2BqJ9Hj7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614181224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KuEArnJDZcZaDgSDX5/Jl/hUB3QBLTeDqaL/WpUed8Q=;
        b=9fRQ8NbeXZc3jc2GRuKG/n2w8m1sYkW+ffBCX/qKNFn8W9xLloFDmsiDWVSdcSEE8mUTxR
        VZX+PQGPMRvqOwBg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: synchronization model: was: Re: [PATCH printk-rework 09/14] printk: introduce a kmsg_dump iterator
In-Reply-To: <87eeh51wht.fsf@jogness.linutronix.de>
References: <20210218081817.28849-1-john.ogness@linutronix.de> <20210218081817.28849-10-john.ogness@linutronix.de> <YC/79JPVKcVaSEEH@alley> <87eeh51wht.fsf@jogness.linutronix.de>
Date:   Wed, 24 Feb 2021 16:40:24 +0100
Message-ID: <878s7d1nkn.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-24, John Ogness <john.ogness@linutronix.de> wrote:
> The @active flag is useless. It should be removed.

I would like to clarify my statement, because the @active flag _did_
protect the arch/um dumper until now. (Although it didn't actually
matter because arch/um does not have SMP or preemption support.)

In mainline we have 6 dumpers. They can be classified as follows:

1. Dumpers that provide their own synchronization to protect against
   parallel or nested dump() calls.

   - arch/powerpc/kernel/nvram_64.c
   - fs/pstore/platform.c
   - arch/um/kernel/kmsg_dump.c (after this series)

2. Dumpers that are safe because they only dump on KMSG_DUMP_PANIC,
   which (currently) can never happen in parallel or nested.

   - arch/powerpc/platforms/powernv/opal-kmsg.c
   - drivers/hv/vmbus_drv.c

3. Dumpers that are unsafe and even @active did not provide the needed
   synchronization.

   - drivers/mtd/mtdoops.c

In all 6 dumpers, @action does not provide any help. That is why it can
be removed.

But I am concerned about drivers/mtd/mtdoops.c that does not have any
synchronization. Since my series is adding sychronization to
arch/um/kernel/kmsg_dump.c, I suppose it should also add it to
drivers/mtd/mtdoops.c also.

And rather than moving the useless @active from kmsg_dumper to
kmsg_dump_iter, I should just drop it.

Unless there are any objections, I will make these changes for my v3.

John Ogness
