Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 417D9426578
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 09:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbhJHH5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 03:57:19 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39332 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbhJHH5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 03:57:17 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 48A0221D6C;
        Fri,  8 Oct 2021 07:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1633679722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=en+LBPzJUAQChT1hY8aBHGoPQmZKo+7K2K+Rm3A8uIY=;
        b=IoORjkEOs8PM2TqCeMCvyJ12zq1cv6FnYiW8lYDhu+kIC9aP58l5X/L3A0BmGRKHNOtkCN
        kbpoOvQW4jhh9sb3a4N2c8T5pM9bcSE5woIjZLwr60VICRUJEgtR0mwZZ9N4fYT6i+bqF4
        s3YzttAGNR8Y9g4dgrK4gtJvhakPMx8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1633679722;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=en+LBPzJUAQChT1hY8aBHGoPQmZKo+7K2K+Rm3A8uIY=;
        b=qrjH2ZVlXzMAfbKreDXWVNyqJYjnqm3pP0+upTQGxn8XUOy2HORMjZNPSWg7vRBhXmJCe/
        ojqnks7SGAR0QBCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9C51F13D36;
        Fri,  8 Oct 2021 07:55:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Kmh1I2n5X2GzVgAAMHmgww
        (envelope-from <osalvador@suse.de>); Fri, 08 Oct 2021 07:55:21 +0000
Date:   Fri, 8 Oct 2021 09:55:19 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Nghia Le <nghialm78@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 2/5] mm/cma: add cma_pages_valid to determine if pages
 are in CMA
Message-ID: <YV/5Z8GqtB4mA+Kj@localhost.localdomain>
References: <20211007181918.136982-1-mike.kravetz@oracle.com>
 <20211007181918.136982-3-mike.kravetz@oracle.com>
 <YV/5EpBcte5i0hzT@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YV/5EpBcte5i0hzT@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2021 at 09:53:54AM +0200, Oscar Salvador wrote:
> On Thu, Oct 07, 2021 at 11:19:15AM -0700, Mike Kravetz wrote:
> > Add new interface cma_pages_valid() which indicates if the specified
> > pages are part of a CMA region.  This interface will be used in a
> > subsequent patch by hugetlb code.
> > 
> > In order to keep the same amount of DEBUG information, a pr_debug() call
> > was added to cma_pages_valid().  In the case where the page passed to
> > cma_release is not in cma region, the debug message will be printed from
> > cma_pages_valid as opposed to cma_release.
> > 
> > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> > Acked-by: David Hildenbrand <david@redhat.com>
> 
> Reviewed-by: OScar Salvador <osalvador@suse.de>

Fat fingers: s/OScar/Oscar
 

-- 
Oscar Salvador
SUSE Labs
