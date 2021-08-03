Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4214D3DEC4A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 13:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235677AbhHCLi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 07:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234602AbhHCLi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 07:38:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBD9C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 04:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n9mXEqpTfFK0JoG1V7B6cdn8c8+8uLuflTM6yqzd8eY=; b=RBuzJgSDVsCUrWyaubNCF/53jU
        Bq1jLXWOkOqKzACyjgGKGZh7uqcibdTYl1gXbD0O9MPsYg/TDFClSKkQGMyv4tuPSKal681jbGCHM
        qr0dUHnqAhOT4BW40IKIZVDo53klqEVaS/l8gWg+lI118bA0FmLBZTi+LQKaQs3bc6Oz0nKxcOVYs
        jlrpcfGE4SM1pjAMtTueqA/H/TwZ2EkElW2587i4n5l/2Hy718S95BbW6wMs29RiFHR1aNGV08fv/
        XkwOJpnNHIC5vWmyFOsmuoBd1S3Lb6tDrTQRXRYFpHZz3W8rtZFZ4FuEeRNMXnmDW5zHnAYhoUKqY
        61ji6XIw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mAsiY-004a5z-BJ; Tue, 03 Aug 2021 11:36:46 +0000
Date:   Tue, 3 Aug 2021 12:36:18 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel@vger.kernel.org, Shuang Zhai <zhais@google.com>
Subject: Re: [PATCH 3/3] mm: don't remap clean subpages when splitting
 isolated thp
Message-ID: <YQkqMhGsra8YCVoU@casper.infradead.org>
References: <20210731063938.1391602-1-yuzhao@google.com>
 <20210731063938.1391602-4-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210731063938.1391602-4-yuzhao@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 31, 2021 at 12:39:38AM -0600, Yu Zhao wrote:
> +++ b/include/linux/rmap.h
> @@ -243,7 +243,7 @@ int page_mkclean(struct page *);
>   */
>  void page_mlock(struct page *page);
>  
> -void remove_migration_ptes(struct page *old, struct page *new, bool locked);
> +void remove_migration_ptes(struct page *old, struct page *new, bool locked, bool unmap_clean);

I'm not a big fan of 'bool, bool'.  Could we use a flag word instead?

#define MIGRATE_REMOVE_LOCKED	1
#define MIGRATE_UNMAP_CLEAN	2

