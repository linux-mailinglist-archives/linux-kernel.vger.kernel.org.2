Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE6AD43C259
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 07:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239704AbhJ0Fyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 01:54:43 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51288 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236625AbhJ0Fym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 01:54:42 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DEDA61FD4A;
        Wed, 27 Oct 2021 05:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1635313936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eYetLBlAcojUYZGAtj4Ll7PYw0ihUehplkOn+pQk5fc=;
        b=swdqjHjYrEFfj86WvsqxVcWvw+ioDZFBJ7EV0euU5G1mrIpIlxmfjTj4ht6sndtLQLptFU
        rkEu+ZmOXM5O7BNVDt//B8nj79qjSH5rf96Y2da0C7ZheP+88pyIQZ6VNTiRD80K9gwIxg
        0AKo9uvODwqOK/Bg1nOle5quATMEfqs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1635313936;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eYetLBlAcojUYZGAtj4Ll7PYw0ihUehplkOn+pQk5fc=;
        b=RIl8BhaNn++LlFjZld6LWwAiEqkOWUR/wXzVAID0U8YP1x2WZ+n8mleOJhxi9+iw6/t8M2
        J0ibryUAR6vb9zDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 728A513E6D;
        Wed, 27 Oct 2021 05:52:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BycVGRDpeGEnTgAAMHmgww
        (envelope-from <osalvador@suse.de>); Wed, 27 Oct 2021 05:52:16 +0000
Date:   Wed, 27 Oct 2021 07:52:14 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: Re: [PATCH] hugetlb: remove unnecessary set_page_count in
 prep_compound_gigantic_page
Message-ID: <YXjpDoa9yvtlBuJl@localhost.localdomain>
References: <20211026220635.35187-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211026220635.35187-1-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 03:06:35PM -0700, Mike Kravetz wrote:
> In commit 7118fc2906e29 ("hugetlb: address ref count racing in
> prep_compound_gigantic_page"), page_ref_freeze is used to atomically
> zero the ref count of tail pages iff they are 1.  The unconditional
> call to set_page_count(0) was left in the code.  This call is after
> page_ref_freeze so it is really a noop.
> 
> Remove redundant and unnecessary set_page_count call.
> 
> Fixes: 7118fc2906e29 ("hugetlb: address ref count racing in prep_compound_gigantic_page")
> Suggested-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  mm/hugetlb.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 906fe8a3b93d..88047a367080 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1795,7 +1795,6 @@ static bool __prep_compound_gigantic_page(struct page *page, unsigned int order,
>  		} else {
>  			VM_BUG_ON_PAGE(page_count(p), p);
>  		}
> -		set_page_count(p, 0);
>  		set_compound_head(p, page);
>  	}
>  	atomic_set(compound_mapcount_ptr(page), -1);
> -- 
> 2.31.1
> 
> 

-- 
Oscar Salvador
SUSE Labs
