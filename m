Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B23C7393DED
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 09:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236042AbhE1HcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 03:32:10 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59252 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhE1HcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 03:32:07 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 861F7218AA;
        Fri, 28 May 2021 07:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622187032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QzwpghMPSyXPE8aVb0KihyUhKxp1rY1kHmNhoCq/Ne0=;
        b=qnuIf3S9mGXbwUlt2flNzfWSd1iyT4jFy/FgZGPmInZaGz/h00o2VgQyHKco2ulKCMgi5r
        Up9ecSds+85MjqQO3bpT2p0P4R2W2NulbYh7ma3vXStuMYitso0G5ke6mm30j7wMWcWTJ7
        BQYPyACsqxZVyxcgmH4p7wYaG3UgwtY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622187032;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QzwpghMPSyXPE8aVb0KihyUhKxp1rY1kHmNhoCq/Ne0=;
        b=5gMuCTtDBGoH7Cw/z7hMQVISIF/HE9Sp1bTh7n9r3OhKwnOm7Yg5EiH43hYe+Aivi2DBdd
        BFC39Mvcx/Pp6FAw==
Received: from director2.suse.de (director2.suse-dmz.suse.de [192.168.254.72])
        by imap.suse.de (Postfix) with ESMTPSA id 04F1011A98;
        Fri, 28 May 2021 07:30:31 +0000 (UTC)
Date:   Fri, 28 May 2021 09:30:30 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Linux-MM <linux-mm@kvack.org>, lkml <linux-kernel@vger.kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: hugetlb: fix dissolve_free_huge_page use of
 tail/head page
Message-ID: <20210528073024.GA32375@linux>
References: <20210527231225.226987-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527231225.226987-1-mike.kravetz@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 04:12:25PM -0700, Mike Kravetz wrote:
> The routine dissolve_free_huge_page can be passed the tail page of a
> hugetlb page.  The tail page is incorrectly passed on to the routines
> alloc_huge_page_vmemmap and add_hugetlb_page which expect a hugetlb
> head page.
> 
> Operating on a tail page instead of head page could result in addressing
> exceptions or vmemmap corruption.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

I guess Andrew will squash the changes, but fwiw:

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE L3
