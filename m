Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5AC8426577
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 09:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbhJHHz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 03:55:56 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38718 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbhJHHzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 03:55:52 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0FBAA22312;
        Fri,  8 Oct 2021 07:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1633679637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/owKRIBy8QtnuKnOdnRpPLlosxOa0SrXgN0hyqRt9xg=;
        b=zMUTeLKyPWEoEkWqQXJdLOA/v+Aadj6rkC6ZqDR+YcEwVg5PfKkPofIkbv9IuGhkf9JSR+
        zCMTnBltuTcX/aCAlLJjDdyjDYqltk801kr865zXewc+Y4brHpCkfTXzkUyWhO9KWX+rdc
        6PO+u+QrELHslYcat8xV8AhdB4+BAok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1633679637;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/owKRIBy8QtnuKnOdnRpPLlosxOa0SrXgN0hyqRt9xg=;
        b=3C0EexQ5YXKpYqHO2LwTUErROHz7vn8QKJe8+ZA8j/ilFhl/QFz01WLpeAkt4e+KN8I4V3
        NPoKjHvgwg/v8CAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3CC5113B56;
        Fri,  8 Oct 2021 07:53:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1eN/CxT5X2G7VQAAMHmgww
        (envelope-from <osalvador@suse.de>); Fri, 08 Oct 2021 07:53:56 +0000
Date:   Fri, 8 Oct 2021 09:53:54 +0200
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
Message-ID: <YV/5EpBcte5i0hzT@localhost.localdomain>
References: <20211007181918.136982-1-mike.kravetz@oracle.com>
 <20211007181918.136982-3-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211007181918.136982-3-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2021 at 11:19:15AM -0700, Mike Kravetz wrote:
> Add new interface cma_pages_valid() which indicates if the specified
> pages are part of a CMA region.  This interface will be used in a
> subsequent patch by hugetlb code.
> 
> In order to keep the same amount of DEBUG information, a pr_debug() call
> was added to cma_pages_valid().  In the case where the page passed to
> cma_release is not in cma region, the debug message will be printed from
> cma_pages_valid as opposed to cma_release.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> Acked-by: David Hildenbrand <david@redhat.com>

Reviewed-by: OScar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs
