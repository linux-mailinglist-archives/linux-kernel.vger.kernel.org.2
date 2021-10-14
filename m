Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0EF542D8DD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 14:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbhJNMKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 08:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbhJNMKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 08:10:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90785C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 05:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hH5UMRaxYgGEu1UnuovaeWTRlAQ8d4MJU3Qaco30nXM=; b=STj+i2I0I9isIXfM1cHJyzkxjS
        1WGpZX411ETrIv8coMsdeRJOdqFKgfL7uWXTdSiXULdQf3apLFdGGLwy5KdUJSoUHR51sFH6+2ykj
        rXsF8CmBC7qZ0vhMr3gdBgQJK+irQEqinfbKRMIWv/Ytde4c8k/MYiJO+J9Ar/m9mTidvMxHUG5on
        1CbJz+vbeaWXWE8FBeCeYcTokrOfXokX8bpW3wzXwZ+UT0TJ9KzFdLvHlMYgm6KeaZO0wY8wQqdMR
        xmF73fgKlprTDqWoKInPPZTRQFF1v/YryTqHrXzt5Oy00Vt7tsmGVz/KqUPjLOqc55V4TvLg05bG6
        ZTvxxtUA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mazUp-008JXb-NB; Thu, 14 Oct 2021 12:06:35 +0000
Date:   Thu, 14 Oct 2021 13:06:03 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Zqiang <qiang.zhang1211@gmail.com>
Cc:     akpm@linux-foundation.org, sunhao.th@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: backing-dev: use kfree_rcu() instead of
 synchronize_rcu_expedited()
Message-ID: <YWgdK9OhXa/9N82Y@infradead.org>
References: <20211014082433.30733-1-qiang.zhang1211@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014082433.30733-1-qiang.zhang1211@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 04:24:33PM +0800, Zqiang wrote:
> <IRQ>
>  __init_work+0x2d/0x50
>  synchronize_rcu_expedited+0x3af/0x650
>  bdi_remove_from_list [inline]
>  bdi_unregister+0x17f/0x5c0
>  release_bdi+0xa1/0xc0
>  kref_put [inline]
>  bdi_put+0x72/0xa0
>  bdev_free_inode+0x11e/0x220
>  i_callback+0x3f/0x70
>  rcu_do_batch [inline]
>  rcu_core+0x76d/0x16c0
>  __do_softirq+0x1d7/0x93b
>  invoke_softirq [inline]
>  __irq_exit_rcu [inline]
>  irq_exit_rcu+0xf2/0x130
>  sysvec_apic_timer_interrupt+0x93/0xc0
> 
> The bdi_remove_from_list() is called in RCU softirq, however the
> synchronize_rcu_expedited() will produce sleep action, use kfree_rcu()
> instead of it.

What workload is this running?  If we hit the RCU unregister path
from inode freeing we have a lifetime problem somewhere that we need
to fix first.
