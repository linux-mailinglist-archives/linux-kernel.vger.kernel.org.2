Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A091305971
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 12:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236264AbhA0LTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 06:19:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:36900 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235993AbhA0Klz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 05:41:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611744069; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0GlmsEPWKXNw1rpLHusG7ElAfhH+TNGsTcqswy3UqLA=;
        b=BYfPNqbkO+KR0/BZR9p+qudZQZUZYIh1es90gu1TBEcAHrSmgsvTGnPaOBytvE3yOFBEtr
        9XP4oeapS9df17OSxPlDawecNoCK3bce8Fez4f2Zq39CxviFlpg58JFgSBvLR2QC1eTZSd
        eop7Um514wzfO6LO2iDX6aRIlPre8Qw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D8B9CACBA;
        Wed, 27 Jan 2021 10:41:08 +0000 (UTC)
Date:   Wed, 27 Jan 2021 11:41:06 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 5/5] hugetlb: convert PageHugeFreed to HPageFreed flag
Message-ID: <20210127104106.GK827@dhcp22.suse.cz>
References: <20210122195231.324857-1-mike.kravetz@oracle.com>
 <20210122195231.324857-6-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122195231.324857-6-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 22-01-21 11:52:31, Mike Kravetz wrote:
> Use new hugetlb specific HPageFreed flag to replace the
> PageHugeFreed interfaces.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Again I would love to see locking that is required to gain a stable
value.

Thanks!
-- 
Michal Hocko
SUSE Labs
