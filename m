Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD9F3E0324
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 16:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238759AbhHDO1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 10:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234423AbhHDO1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 10:27:41 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3959C0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 07:27:27 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id n17so2093364lft.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 07:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Fr1dlkP7aFQI9DYigYyNmGxFZWQyXPk3bpvn9aswro8=;
        b=iz9UcP0VtZwV4HRpoR3PmJs1KkVe84VAxO68pKZ56paLeYA9CTDEe/zYwQoWIeBD33
         5C2dKTlCMuKWhM1PEISSKnBPM0776RaCfebEoJjtBvtX5WGrc7rYCsNcav2jkd3cilE1
         LkMBrnc8YDcgK1f7vCTf7pMPFCpSZQYQDclSI6UyqSpQBrQhrpGZn7V7sMAzstPh25L6
         oCK/mPOuAOdoLkcrQCE/gksXYd3bi3FyCayAVnrkyAVxo1H1zJxnnDTrCdGvwNek+Hot
         8PVOKMXFNOoYsglcaHQXudaWQg5Nlq87s/796svBpfYIaXLlnyuQaAoZaUKX89XCR9z7
         DhCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Fr1dlkP7aFQI9DYigYyNmGxFZWQyXPk3bpvn9aswro8=;
        b=KKutIHA8AMF/e4dzudmmHanpR/PTMoriJv9TbM0NToOe7dseJ+Fj3aSw8PDPydb1Cs
         o3428s5WXPm1yIOSer0tw2j6rn/uWcEZZDUfBatrBmo4xIpK1HbIQ46N6ntegT9zqumM
         u+GyS1AZEsZxgFBS7dltAIlq6cNNhf53yw7sKThgDOOT8WVMlwlCyErYVweMNymnPUDE
         a8ExsVl7joO4tcELgpwxK5zPNQwnaczZrCNxL29mpyX3esAi0mmTLKO4+p8tfs+AUaHh
         s1gIr2MZQlpwGrxxSL1ultAiXEqo4C2WBjYPtP0W89mcMQbNNF7sFM+2/1NSQVFxgn8G
         +gyg==
X-Gm-Message-State: AOAM531tLugxxem92eC7cqHoRQ3r1x4QCMcXTMAi1Tzh6wvOtfecgfu0
        VZAkhC/fP+o2EAfNUNgY7fURog==
X-Google-Smtp-Source: ABdhPJzEQAJa0G3rHllX/HPZXIaY9pF/05SryXj38Qjqy7g4DANEptyFwwi8wGn2BeiYxO2nEuwXhw==
X-Received: by 2002:a05:6512:2291:: with SMTP id f17mr15294373lfu.593.1628087246346;
        Wed, 04 Aug 2021 07:27:26 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id r11sm182980ljp.135.2021.08.04.07.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 07:27:25 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id D0E11102BC1; Wed,  4 Aug 2021 17:27:29 +0300 (+03)
Date:   Wed, 4 Aug 2021 17:27:29 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yu Zhao <yuzhao@google.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel@vger.kernel.org, Shuang Zhai <zhais@google.com>
Subject: Re: [PATCH 3/3] mm: don't remap clean subpages when splitting
 isolated thp
Message-ID: <20210804142729.iqtslnn3utvqgec3@box.shutemov.name>
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
> @@ -267,13 +308,19 @@ static bool remove_migration_pte(struct page *page, struct vm_area_struct *vma,
>   * Get rid of all migration entries and replace them by
>   * references to the indicated page.
>   */
> -void remove_migration_ptes(struct page *old, struct page *new, bool locked)
> +void remove_migration_ptes(struct page *old, struct page *new, bool locked, bool unmap_clean)
>  {
> +	struct rmap_walk_arg rmap_walk_arg = {
> +		.page = old,
> +		.unmap_clean = unmap_clean,
> +	};
>  	struct rmap_walk_control rwc = {
>  		.rmap_one = remove_migration_pte,
> -		.arg = old,
> +		.arg = &rmap_walk_arg,
>  	};

'old' pointer has few low always-zero bit :P

-- 
 Kirill A. Shutemov
