Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73D1395C55
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 15:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbhEaNbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 09:31:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:53336 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232322AbhEaNXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 09:23:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622467282; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cn+663xg9Fnis1kPt/caWzCnnri9r67XIbRUjlSvtGg=;
        b=cORQ88Jay6syGjcqRdfEdiKuMErohocMbegu0uQxg/gOnWoEEFeClHuWZyhAOXqHNYNuMq
        zkjxd+kSWelM5SgM+QYkH009HIWEyDzEiVknEJpniLx2YmKyfc7pDP2n0hUUzNfvwQMDnx
        8E7hhMWNfu9JNJIZQar+kDfdVb0X3Ns=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E200EB4C1;
        Mon, 31 May 2021 13:21:21 +0000 (UTC)
Date:   Mon, 31 May 2021 15:21:21 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Aaron Tomlin <atomlin@redhat.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, willy@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] mm/page_alloc: bail out on fatal signal during
 reclaim/compaction retry attempt
Message-ID: <YLTi0XXHbntlCNuS@dhcp22.suse.cz>
References: <YKZObDpduqwWi/Zm@casper.infradead.org>
 <20210520142901.3371299-1-atomlin@redhat.com>
 <YLTJjJqemt5Uv9vP@dhcp22.suse.cz>
 <c7b69523-c141-d06c-bc02-953c7a939d91@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7b69523-c141-d06c-bc02-953c7a939d91@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 31-05-21 13:35:31, Vlastimil Babka wrote:
> On 5/31/21 1:33 PM, Michal Hocko wrote:
> > On Thu 20-05-21 15:29:01, Aaron Tomlin wrote:
> >> A customer experienced a low-memory situation and decided to issue a
> >> SIGKILL (i.e. a fatal signal). Instead of promptly terminating as one
> >> would expect, the aforementioned task remained unresponsive.
> >> 
> >> Further investigation indicated that the task was "stuck" in the
> >> reclaim/compaction retry loop. Now, it does not make sense to retry
> >> compaction when a fatal signal is pending.
> > 
> > Is this really true in general? The memory reclaim is retried even when
> > fatal signals are pending. Why should be compaction different? I do
> > agree that retrying way too much is bad but is there any reason why this
> > special case doesn't follow the max retry logic?
> 
> Compaction doesn't do anything if fatal signal is pending, it bails out
> immediately and the checks are rather frequent. So why retry?

OK, I was not aware of that and it would be helpful to have that
mentioned in the changelog.

-- 
Michal Hocko
SUSE Labs
