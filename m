Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8E342B2CC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 04:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236107AbhJMCnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 22:43:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53849 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235988AbhJMCnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 22:43:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634092868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ft1VC9zrQcW79FB0tNwhaRoMQpMWx16xNlQ9+j3yL0Q=;
        b=OLZfSMJwGcdFd1OaJkhLELknSJA0auwbTqfYT0N1wHlArQNNKYh0mNK+eAjJyUJq4NJ9p8
        5imoQ4BvilBjjuTBKmdt3OgVxnLdlg1/KGEWTcwblYB6w/wwjIgvYKf3FYCx5b13yRf+xr
        gnEsIFAXhEiHqwgCaHLRHznK2vGyjas=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-4Ol1YUJANdupyNHWOQNPyA-1; Tue, 12 Oct 2021 22:41:06 -0400
X-MC-Unique: 4Ol1YUJANdupyNHWOQNPyA-1
Received: by mail-pg1-f197.google.com with SMTP id s19-20020a63e813000000b00287d976d152so633192pgh.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 19:41:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ft1VC9zrQcW79FB0tNwhaRoMQpMWx16xNlQ9+j3yL0Q=;
        b=NezRmWgYvti+WkM+MLRp2YwyDRZdMumAxK+PRFG84RccqW906T7zdDyI7CNnds7Wls
         8qLFj3c0rSMKf57Tp1OGbbKmgL0nQF8MPTGizWdCmXimXu37duyMH/IggxvMeDZ+yxZ4
         2sXq/tQ7psUr5dBuTC0CZn31CCquRGZ1rHQQVT6Hyt247fiUk/OFQxi2hL9JrMbZSi59
         YAISo/+ZExL10I0w8UG06uAnQuuWeh9LJx8EsHwmjOqj8WEOq2sw+cuukqRtlS+5jV72
         ooQpniJl7ZNIhzG4pw08s6Tm/JWuJueBD8KhlMS6aiSkjEQ5iRFKGj5jmK5yMGwKSiuM
         80Pg==
X-Gm-Message-State: AOAM531d7w1ZFsgkJCmaAm0BJMSeveUXHEEfi0ZKN1GsFYd/HTX9iGSu
        9Y4gUCsAR52EDR5sQfdB138ipBMksP3xn4g7xrF3s4woHnRiOW1mzN1jsLTZeKw/VbEExiTY9RB
        HpapVD+9K8SMihVgddbxoG2+B
X-Received: by 2002:a17:90a:8b89:: with SMTP id z9mr10389115pjn.89.1634092865741;
        Tue, 12 Oct 2021 19:41:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzv4fE/XpKqdSojl1JvafE8JRzpy63XtSbqmEDaHX4njX6bFnlJqEI2qmA63YhiSVFaEXHm+w==
X-Received: by 2002:a17:90a:8b89:: with SMTP id z9mr10389092pjn.89.1634092865381;
        Tue, 12 Oct 2021 19:41:05 -0700 (PDT)
Received: from t490s ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id p18sm12844157pgk.28.2021.10.12.19.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 19:41:04 -0700 (PDT)
Date:   Wed, 13 Oct 2021 10:40:57 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     naoya.horiguchi@nec.com, hughd@google.com,
        kirill.shutemov@linux.intel.com, willy@infradead.org,
        osalvador@suse.de, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v3 PATCH 0/5] Solve silent data loss caused by poisoned
 page cache (shmem/tmpfs)
Message-ID: <YWZHOYgFrMYbmNA/@t490s>
References: <20210930215311.240774-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210930215311.240774-1-shy828301@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 02:53:06PM -0700, Yang Shi wrote:
> Yang Shi (5):
>       mm: hwpoison: remove the unnecessary THP check
>       mm: filemap: check if THP has hwpoisoned subpage for PMD page fault
>       mm: hwpoison: refactor refcount check handling
>       mm: shmem: don't truncate page if memory failure happens
>       mm: hwpoison: handle non-anonymous THP correctly

Today I just noticed one more thing: unpoison path has (unpoison_memory):

	if (page_mapping(page)) {
		unpoison_pr_info("Unpoison: the hwpoison page has non-NULL mapping %#lx\n",
				 pfn, &unpoison_rs);
		return 0;
	}

I _think_ it was used to make sure we ignore page that was not successfully
poisoned/offlined before (for anonymous), so raising this question up on
whether we should make sure e.g. shmem hwpoisoned pages still can be unpoisoned
for debugging purposes.

-- 
Peter Xu

