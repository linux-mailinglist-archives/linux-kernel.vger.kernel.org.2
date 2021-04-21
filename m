Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47957366744
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 10:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237131AbhDUIts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 04:49:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:41344 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231685AbhDUItr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 04:49:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D9E81B176;
        Wed, 21 Apr 2021 08:49:13 +0000 (UTC)
Date:   Wed, 21 Apr 2021 10:49:11 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Subject: Re: [External] Re: [PATCH] mm: hugetlb: fix a race between
 memory-failure/soft_offline and gather_surplus_pages
Message-ID: <20210421084911.GH22456@linux>
References: <20210421060259.67554-1-songmuchun@bytedance.com>
 <YH/cVoUCTKu/UkqB@dhcp22.suse.cz>
 <CAMZfGtWh4tRiMrOTLvv5GHM1JUCt9b+UHf_DwLev32S=+iLW8g@mail.gmail.com>
 <20210421082103.GE22456@linux>
 <CAMZfGtXsXViJTWrMoECCaCD+2mF7zB5n61aFJvVgpGTaUVEC4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtXsXViJTWrMoECCaCD+2mF7zB5n61aFJvVgpGTaUVEC4A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 04:41:10PM +0800, Muchun Song wrote:
 
> But softoffline does not set page hwpoison before
> __get_hwpoison_page(). So the page still can be
> allocated. Right?

Yep, soft_offline() only marks the page as hwpoison once the page has been
fully contended and no other use is possible.
But yeah, hugetlb is a bit trickier in that regard.

This needs fixing in there.


-- 
Oscar Salvador
SUSE L3
