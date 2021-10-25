Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76EA9439044
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 09:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbhJYH0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 03:26:14 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52728 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbhJYH0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 03:26:12 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AE1FB21709;
        Mon, 25 Oct 2021 07:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1635146629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mKRH8EdFpKe+IkGGQ8FHlcAmk/te4+2Ta56sNX7LB5A=;
        b=g/E70dhR8XFSUmzMohoFP6uxLBiw6v5yPqYRdCxcuCQgmuphYdnWG/qtMjWaoo1+iSkC7J
        gz1vA/pOdTXsFS6xOv4nVlOFo1zLIVHiIUp1aLPL8/Vq2s5MtKEvkx0DdAxoX3pt37fegi
        ckV1cpnuLVlvB/M7O1KlOwd39xnxKbk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1635146629;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mKRH8EdFpKe+IkGGQ8FHlcAmk/te4+2Ta56sNX7LB5A=;
        b=tC73mkywFtzUeABGS6vGp+X1G4mTwtpsuspQQu8hsw02FMD9BsX+ArZ6vmQWnw2RVJptpo
        1A3C3xH1ZdBcmmDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1035A1342A;
        Mon, 25 Oct 2021 07:23:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ftY5AYVbdmFECAAAMHmgww
        (envelope-from <osalvador@suse.de>); Mon, 25 Oct 2021 07:23:49 +0000
Date:   Mon, 25 Oct 2021 09:23:47 +0200
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
Subject: Re: [PATCH v4 4/5] hugetlb: add demote bool to gigantic page routines
Message-ID: <20211025072347.GA6338@linux>
References: <20211007181918.136982-1-mike.kravetz@oracle.com>
 <20211007181918.136982-5-mike.kravetz@oracle.com>
 <20211018075851.GB11960@linux>
 <ddd1a08f-8001-c844-5734-16476ce34d5f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddd1a08f-8001-c844-5734-16476ce34d5f@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 12:05:47PM -0700, Mike Kravetz wrote:
> How about if this commit message provides links to previous commits
> describing these issues?  There are pretty extensive descriptions in
> those previous commits, so no need to repeat here IMO.

Fine by me.

> The patch with an updated commit message is below.
> 
> From 10fcff70c809402901a93ea507d5506c87a8227d Mon Sep 17 00:00:00 2001
> From: Mike Kravetz <mike.kravetz@oracle.com>
> Date: Fri, 22 Oct 2021 11:50:31 -0700
> Subject: [PATCH v4 4/5] hugetlb: add demote bool to gigantic page routines
> 
> The routines remove_hugetlb_page and destroy_compound_gigantic_page
> will remove a gigantic page and make the set of base pages ready to be
> returned to a lower level allocator.  In the process of doing this, they
> make all base pages reference counted.
> 
> The routine prep_compound_gigantic_page creates a gigantic page from a
> set of base pages.  It assumes that all these base pages are reference
> counted.
> 
> During demotion, a gigantic page will be split into huge pages of a
> smaller size.  This logically involves use of the routines,
> remove_hugetlb_page, and destroy_compound_gigantic_page followed by
> prep_compound*_page for each smaller huge page.
> 
> When pages are reference counted (ref count >= 0), additional
> speculative ref counts could be taken as described in previous
> commits [1] and [2].  This could result in errors while demoting
> a huge page.  Quite a bit of code would need to be created to
> handle all possible issues.
> 
> Instead of dealing with the possibility of speculative ref counts, avoid
> the possibility by keeping ref counts at zero during the demote process.
> Add a boolean 'demote' to the routines remove_hugetlb_page,
> destroy_compound_gigantic_page and prep_compound_gigantic_page.  If the
> boolean is set, the remove and destroy routines will not reference count
> pages and the prep routine will not expect reference counted pages.
> 
> '*_for_demote' wrappers of the routines will be added in a subsequent
> patch where this functionality is used.
> 
> [1] https://lore.kernel.org/linux-mm/20210622021423.154662-3-mike.kravetz@oracle.com/
> [2] https://lore.kernel.org/linux-mm/20210809184832.18342-3-mike.kravetz@oracle.com/
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>
 

-- 
Oscar Salvador
SUSE Labs
