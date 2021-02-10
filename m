Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB94C316D02
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 18:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbhBJRlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 12:41:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:55482 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232212AbhBJRlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 12:41:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612978859; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mx3tg4rBq7bjCmW9+vOP6UmYfR5RusC/qOPIIHBwRDA=;
        b=dWzRg73qyAJPgmBG1X9h5D/M3UEAoTAw9Rkpruso/wSLvpd6K/TbgyrbyckYBIha1QRStm
        DcBZj0pykSFNUERVTHFZNlnrVrQ0FeLKNBwiC1Ot7Olyrfao5FIjyiFgLEkLHeyG2ONag/
        Fef4JsEwVu9HjGgh3LC68hovuHhTZjA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 376CCAE6E;
        Wed, 10 Feb 2021 17:40:59 +0000 (UTC)
Date:   Wed, 10 Feb 2021 18:40:57 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Milan Broz <gmazyland@gmail.com>, linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: Very slow unlockall()
Message-ID: <YCQaqRGjZKYe64zR@dhcp22.suse.cz>
References: <70885d37-62b7-748b-29df-9e94f3291736@gmail.com>
 <20210108134140.GA9883@dhcp22.suse.cz>
 <abb752ce-4447-74cb-dfbc-03af1b38edfc@gmail.com>
 <9474cd07-676a-56ed-1942-5090e0b9a82f@suse.cz>
 <e6f84b27-ed29-0fa4-e466-536b529c5720@gmail.com>
 <6eebb858-d517-b70d-9202-f4e84221ed89@suse.cz>
 <dfc3fe66-07ac-6aba-e10b-c940cdb01ec1@gmail.com>
 <273db3a6-28b1-6605-1743-ef86e7eb2b72@suse.cz>
 <YCQQad+rzpPiDmjL@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCQQad+rzpPiDmjL@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 10-02-21 17:57:29, Michal Hocko wrote:
> On Wed 10-02-21 16:18:50, Vlastimil Babka wrote:
[...]
> > And the munlock (munlock_vma_pages_range()) is slow, because it uses
> > follow_page_mask() in a loop incrementing addresses by PAGE_SIZE, so that's
> > always traversing all levels of page tables from scratch. Funnily enough,
> > speeding this up was my first linux-mm series years ago. But the speedup only
> > works if pte's are present, which is not the case for unpopulated PROT_NONE
> > areas. That use case was unexpected back then. We should probably convert this
> > code to a proper page table walk. If there are large areas with unpopulated pmd
> > entries (or even higher levels) we would traverse them very quickly.
> 
> Yes, this is a good idea. I suspect it will be little bit tricky without
> duplicating a large part of gup page table walker.

Thinking about it some more, unmap_page_range would be a better model
for this operation.
-- 
Michal Hocko
SUSE Labs
