Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACCB391536
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 12:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbhEZKoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 06:44:19 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50136 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbhEZKoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 06:44:14 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7B82C218C1;
        Wed, 26 May 2021 10:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622025761; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tEOJgnOm/Wipasy6f8xTh9sBsKCpMelCtT3VUd1dFrE=;
        b=Ha6qc9owwwnqiayK2Qnn9P9aqEsoXtCoBP/TliYu0zLNE0pY9qAgDJKG4Z07URSzXHR6e2
        Ny2OG0a2FOjWrVfcg7YkpyCa5NdKXilx2IdDn4j1IZcz/wwsnIdIcNz/Nc87rZXy/oWoYb
        X12+9KKRkMEmWjZD71cYoXdI7Q6Qivo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622025761;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tEOJgnOm/Wipasy6f8xTh9sBsKCpMelCtT3VUd1dFrE=;
        b=s5WgwK1dc7HykASzT9ZawaZ2+qJIvc7AZRCxq4nS3xNzS76Jsv4MxcdpCSzQIU9ArkI740
        ZxvbAoHbRlJHbmCA==
Received: from director2.suse.de (director2.suse-dmz.suse.de [192.168.254.72])
        by imap.suse.de (Postfix) with ESMTPSA id 0889311A98;
        Wed, 26 May 2021 10:42:40 +0000 (UTC)
Date:   Wed, 26 May 2021 12:42:39 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Ding Hui <dinghui@sangfor.com.cn>
Cc:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        david@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3] mm/page_alloc: fix counting of free pages after take
 off from buddy
Message-ID: <20210526104238.GC1656@linux>
References: <20210526075247.11130-1-dinghui@sangfor.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526075247.11130-1-dinghui@sangfor.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 03:52:47PM +0800, Ding Hui wrote:
> Recently we found that there is a lot MemFree left in /proc/meminfo
> after do a lot of pages soft offline, it's not quite correct.
> 
> Before Oscar rework soft offline for free pages [1], if we soft
> offline free pages, these pages are left in buddy with HWPoison
> flag, and NR_FREE_PAGES is not updated immediately. So the difference
> between NR_FREE_PAGES and real number of available free pages is
> also even big at the beginning.
> 
> However, with the workload running, when we catch HWPoison page in
> any alloc functions subsequently, we will remove it from buddy,
> meanwhile update the NR_FREE_PAGES and try again, so the NR_FREE_PAGES
> will get more and more closer to the real number of available free pages.
> (regardless of unpoison_memory())
> 
> Now, for offline free pages, after a successful call take_page_off_buddy(),
> the page is no longer belong to buddy allocator, and will not be
> used any more, but we missed accounting NR_FREE_PAGES in this situation,
> and there is no chance to be updated later.
> 
> Do update in take_page_off_buddy() like rmqueue() does, but avoid
> double counting if some one already set_migratetype_isolate() on the
> page.
> 
> [1]: commit 06be6ff3d2ec ("mm,hwpoison: rework soft offline for free pages")
> 
> Suggested-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE L3
