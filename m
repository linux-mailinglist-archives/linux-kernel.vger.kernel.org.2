Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F97B333FB1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 14:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbhCJNzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 08:55:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:55996 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231790AbhCJNy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 08:54:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615384498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ynb5w72NY+rJnL7ZUNtb0DAziwv6ypIpu01j5U3oDF0=;
        b=dtf9xoa8uw+8wPnmhFPI4ktZchNiqWASPNhgFUR1Ci6SA0fkRACyCFyk6Ct5InbOsphh6n
        Umh4jvgMUcVOyU9qJTE1HxlERdH1YllpJEmJ+NVGVgq0T0QMZSRIhOMbn3l0jL/KqhgDsk
        n2yeETOVKtHmQyZnOreOVwE5pMiZ9k4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 69530AEE5;
        Wed, 10 Mar 2021 13:54:58 +0000 (UTC)
Date:   Wed, 10 Mar 2021 14:54:57 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Baron <jbaron@akamai.com>
Subject: Re: [PATCH v2] mm: page_alloc: dump migrate-failed pages
Message-ID: <YEjPsfAApvVmO4Jb@dhcp22.suse.cz>
References: <20210308202047.1903802-1-minchan@kernel.org>
 <YEdAw6gnp9XxoWUQ@dhcp22.suse.cz>
 <20210310132623.GO3479805@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310132623.GO3479805@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 10-03-21 13:26:23, Matthew Wilcox wrote:
> On Tue, Mar 09, 2021 at 10:32:51AM +0100, Michal Hocko wrote:
> > Apart from the above, do we have to warn for something that is a
> > debugging aid? A similar concern wrt dump_page which uses pr_warn and
> > page owner is using even pr_alert.
> > Would it make sense to add a loglevel parameter both into __dump_page
> > and dump_page_owner?
> 
> No.  What would make sense is turning __dump_page() inside-out.
> Something like printk("%pP\n");
> 
> In lib/vsprintf.c, there's a big switch statement in the function
> pointer() that handles printing things like IPv6 addresses, dentries,
> and function symbols.
> 
> Then we can do whatever we want around the new %pP, including choosing
> the log level, adding additional information, choosing to dump the page
> to a sysfs file, etc, etc.

Hmm, __dump_page has grown quite some heavy lifting over time and I am
not sure this is a good candidate to put into printk proper (e.g. is it
safe/reasonable to call get_kernel_nofault from printk - aka arbitrary
context)?.

But you've got a point that such a printk format wouldn't need to be 1:1
with the existing __dump_page. There is quite a lot to infer from page
count, map count, flags, page type already. Then a question would be
what is an actual advantage of %pP over dump_page_info(loglvl, p). One I
can see is that %pP would allow to dump the state into a string and so
it would be more versatile but I am not aware of a usecase for that
(maybe tracing?).
-- 
Michal Hocko
SUSE Labs
