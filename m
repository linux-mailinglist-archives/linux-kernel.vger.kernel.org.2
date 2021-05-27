Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07B1F3928E6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 09:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbhE0HtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 03:49:23 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54078 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234626AbhE0HtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 03:49:20 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A2330218DD;
        Thu, 27 May 2021 07:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622101666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YtO/FPGQ00p8RJySPIi3YpYdx7Hc9TaIxbimA4veYEo=;
        b=0jMjswuqM3ju6nongb+Egwt0eOKJByPjqb7MWzJneWPk7esOWKvfI99Z9LrRO7xriyF3E8
        3yYUdpK1esyrQx7xqsrdel2EUqlyGpFJv/IVrqZx9DCNe6MLRxb2sA/tfw44/doycGIPKb
        OTM2gx1Q1GWas/Qmr9g39pKls+vKInA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622101666;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YtO/FPGQ00p8RJySPIi3YpYdx7Hc9TaIxbimA4veYEo=;
        b=xYql4C3qYFxsP6Ur19ynYgw/EFoxCZSqDWVIknwMaDVd9elA0IEhTfrM0uQ065tH2JKY4a
        17aUUNincV3zEYDQ==
Received: from director2.suse.de (director2.suse-dmz.suse.de [192.168.254.72])
        by imap.suse.de (Postfix) with ESMTPSA id 0962311A98;
        Thu, 27 May 2021 07:47:45 +0000 (UTC)
Date:   Thu, 27 May 2021 09:47:44 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc:     linux-mm@kvack.org, Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] hugetlb: pass head page to remove_hugetlb_page()
Message-ID: <YK9OoPzkBB1jTpC1@localhost.localdomain>
References: <20210526235257.2769473-1-nao.horiguchi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526235257.2769473-1-nao.horiguchi@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 08:52:57AM +0900, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> When memory_failure() or soft_offline_page() is called on a tail page of
> some hugetlb page, "BUG: unable to handle page fault" error can be
> triggered.
> 
> remove_hugetlb_page() dereferences page->lru, so it's assumed that the
> page points to a head page, but one of the caller,
> dissolve_free_huge_page(), provides remove_hugetlb_page() with 'page'
> which could be a tail page.  So pass 'head' to it, instead.
> 
> Fixes: 6eb4e88a6d27 ("hugetlb: create remove_hugetlb_page() to separate functionality")
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

It is probably worth adding a comment in remove_hugetlb_page() noting
that we need a head page, so future users do not repeat the same
mistake.

Thanks 

-- 
Oscar Salvador
SUSE L3
