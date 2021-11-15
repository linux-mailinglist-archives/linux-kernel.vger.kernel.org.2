Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 164364523BD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 02:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345349AbhKPB3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 20:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243514AbhKOTAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 14:00:05 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582C4C04646E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 09:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=S8QU5CKAf2F09vTBEAu41rD8RMni9mSF8OXKxlexhR8=; b=eLHzUXPqJxEHueyrimRTWGKmOc
        Pl0zqL9Pkz7vJTfnlnz8cpm918KHErxdacyVEDoKnu3s6/edXUVT1gv8fZP3DcGaMiS/FX8lPbT8l
        wFBxcNQs6tbK5w+oXZi6owYmWzZiVeg+ZXVSCtWI1Pv2pqYC+vdpnfDKepmj6fg8T+3nhf6JEdzpO
        YBBSUDt1r4ToFfi/VtSELsL8yXMSGvfOPEPhD1elZ/4zD59Th773Q3RlmFtjUzv/bIQNEpqueMtpL
        +M8lCpo+iB0b+Pjk7xtO6oGRBXBzH7hu1hTG883LAE/l0oZ8CRUSDPXA99ojFgWyPvehdSTAqoUDi
        JQXZ293Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mmgCd-005uGj-0d; Mon, 15 Nov 2021 17:55:35 +0000
Date:   Mon, 15 Nov 2021 17:55:34 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     akpm@linux-foundation.org, dhowells@redhat.com, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        jglisse@redhat.com, jgg@nvidia.com, rcampbell@nvidia.com,
        jhubbard@nvidia.com
Subject: Re: [PATCH v3] mm/migrate.c: Rework migration_entry_wait() to not
 take a pageref
Message-ID: <YZKfFoHAhCJC4/75@casper.infradead.org>
References: <20211115105222.4183286-1-apopple@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115105222.4183286-1-apopple@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 09:52:22PM +1100, Alistair Popple wrote:
> +#ifdef CONFIG_MIGRATION
> +/**
> + * migration_entry_wait_on_locked - Wait for a migration entry to be removed
> + * @page: page referenced by the migration entry.

This should be @folio (you can test by running 'make htmldocs', or even
'make W=1'

> + * @ptep: mapped pte pointer. This function will return with the ptep unmapped.
> + * @ptl: already locked ptl. This function will drop the lock.
> + *
> + * Wait for a migration entry referencing the given page to be removed. This is
> + * equivalent to put_and_wait_on_page_locked(page, TASK_UNINTERRUPTIBLE) except
> + * this can be called without taking a reference on the page. Instead this
> + * should be called while holding the ptl for the migration entry referencing
> + * the page.

The tool won't tell you to update these page references to be folio
references ... so I will ;-)

> +++ b/mm/migrate.c
> @@ -305,15 +305,7 @@ void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
>  	page = pfn_swap_entry_to_page(entry);
>  	page = compound_head(page);

I think this whole function should be folio-based.  That is:

-	struct page *page;
+	struct folio *folio;

and
	folio = page_folio(pfn_swap_entry_to_page(entry));

