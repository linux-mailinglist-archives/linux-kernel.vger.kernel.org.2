Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2302E333F46
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 14:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234321AbhCJNbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 08:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbhCJN1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 08:27:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C37C061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 05:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Zd0X1/aQ77xgvEzE/yl2zByaLdoARlJJkbsOi2BArjM=; b=c1XaZJ3ZEQ5d8H/VftDRyxonGI
        FvAVnhRLizbneVLs0ai09N7WsiHslyr0odSp4KG77tDK+ewYaji6iN21DVlSitvvs5DyxgytRad10
        oTUGNipAXr5xIKxl4eKkgh2e2QzQ3KRCt9/aUrlBQK1/MWltaqsMxAOPltwtUKVMiXeD9emq5AtY4
        8ncO1thlNgpQ8CW8WvCCt7GrCGn8sNA3FUYJBuH2G8pkwIrFI9NufDaYLncmQGbdVcdEFsHsU/jvA
        6IlIyLAN+Odfbe0yAwtgzmCkvxf+BQZT4dgYWFuLFQS77YAZnBIi4c/5EZbFsdtnaCTErbjLEIrLA
        V5fbFfSA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lJyr1-003WfB-5H; Wed, 10 Mar 2021 13:26:29 +0000
Date:   Wed, 10 Mar 2021 13:26:23 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Baron <jbaron@akamai.com>
Subject: Re: [PATCH v2] mm: page_alloc: dump migrate-failed pages
Message-ID: <20210310132623.GO3479805@casper.infradead.org>
References: <20210308202047.1903802-1-minchan@kernel.org>
 <YEdAw6gnp9XxoWUQ@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEdAw6gnp9XxoWUQ@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 10:32:51AM +0100, Michal Hocko wrote:
> Apart from the above, do we have to warn for something that is a
> debugging aid? A similar concern wrt dump_page which uses pr_warn and
> page owner is using even pr_alert.
> Would it make sense to add a loglevel parameter both into __dump_page
> and dump_page_owner?

No.  What would make sense is turning __dump_page() inside-out.
Something like printk("%pP\n");

In lib/vsprintf.c, there's a big switch statement in the function
pointer() that handles printing things like IPv6 addresses, dentries,
and function symbols.

Then we can do whatever we want around the new %pP, including choosing
the log level, adding additional information, choosing to dump the page
to a sysfs file, etc, etc.
