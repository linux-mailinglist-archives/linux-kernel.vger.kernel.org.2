Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3910452F11
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 11:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234122AbhKPKbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 05:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbhKPKan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 05:30:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8B1C061766
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 02:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AdUF6ViWzscn9og7/mdrngRNLF7M0M71UElmac4YaTA=; b=R+Q26e5a3QYpMyyvSGcRDUNzs8
        WieN0A72yCBEH51BQwbwnWrN5puSr2mlBqSDLpBvOL+r2UMQqy4k7txViIOqn8P6A94B6rF9+KWOo
        IwjJiRVWxQGAN7IgRO0x7bl8Sl/70gPLDQ49dthMsTmGtWmvoSmih08pvAKW9lNjxaoCIPFC6bRAD
        zEAblgj+eis2FuoNmTHiAnRzD1c09s70BfZqGPBhTYpBNof8bUBqJ4ZXoATNh5/ys/mQIojaR4gh4
        xEoUDnCzO/jr1XFOOdJMBs3oJlxlUtzmLr3WnMsjlkjq2/hMh0N/hf1081TOtU/yqshtMO3x/eg/e
        chKGBo5Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mmvgh-006fFv-FP; Tue, 16 Nov 2021 10:27:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 022CB300093;
        Tue, 16 Nov 2021 11:27:39 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E6A292D7AEC49; Tue, 16 Nov 2021 11:27:38 +0100 (CET)
Date:   Tue, 16 Nov 2021 11:27:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 7/9] locking/rwlocks: introduce write_lock_nested
Message-ID: <YZOHmkdTM+oimFe8@hirez.programming.kicks-ass.net>
References: <20211115185909.3949505-1-minchan@kernel.org>
 <20211115185909.3949505-8-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115185909.3949505-8-minchan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 10:59:07AM -0800, Minchan Kim wrote:
> In preparation for converting bit_spin_lock to rwlock in zsmalloc
> so that multiple writers of zspages can run at the same time but
> those zspages are supposed to be different zspage instance. Thus,
> it's not deadlock. This patch adds write_lock_nested to support
> the case for LOCKDEP.
> 
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
>  include/linux/rwlock.h          |  6 ++++++
>  include/linux/rwlock_api_smp.h  |  9 +++++++++
>  include/linux/rwlock_rt.h       |  6 ++++++
>  include/linux/spinlock_api_up.h |  1 +
>  kernel/locking/spinlock.c       |  6 ++++++
>  kernel/locking/spinlock_rt.c    | 12 ++++++++++++
>  6 files changed, 40 insertions(+)

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
