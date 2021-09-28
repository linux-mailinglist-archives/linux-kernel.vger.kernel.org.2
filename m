Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDD541AE74
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 14:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240536AbhI1MJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 08:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240458AbhI1MJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 08:09:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AF1C061575
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 05:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=c23zswK9ANwThDRQl4nW53akkUWxcJ1VY9cYgeLMJuw=; b=bTsJeJrdv5GIjRUbslEdSR12rC
        7eZuYxrSkAlpwYk/qHgsIGaJQmdLr+OlBlMcCE4e7SCgQZxikwXe6W4zoAZStkHpKM3/RSQZ6L6OE
        pCNZXIUKGDYT7+OJZVn/O3NMMuwDzniYm4V03s0FL7wbL2CDWzR8sD6w4lihtglY3zq88zNlM2p+z
        2hsWInqC5s0zAk9USyp/Z6eGK7siTWGSyf/fBqHA8+fnOxGYISJ/ox7NZZuj2SCw5xZT0GSWAKqT9
        BeCYN6ESPQtWcbRXAbVDc5TM/U5LeVyaB8xEYuCNdbnN81Fnf7svvPa3MsrDycFtMkTbtgkqgo+PD
        zXDe340w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mVBsd-00ApTi-Go; Tue, 28 Sep 2021 12:06:58 +0000
Date:   Tue, 28 Sep 2021 13:06:39 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Song Liu <song@kernel.org>
Cc:     Rongwei Wang <rongwei.wang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        William Kucharski <william.kucharski@oracle.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v2 1/2] mm, thp: check page mapping when truncating page
 cache
Message-ID: <YVMFT+hrePumXlDU@casper.infradead.org>
References: <20210906121200.57905-1-rongwei.wang@linux.alibaba.com>
 <20210922070645.47345-2-rongwei.wang@linux.alibaba.com>
 <YUsVcEDcQ2vEzjGg@casper.infradead.org>
 <BC145393-93AC-4DF4-9CF4-2FB1C736B70C@linux.alibaba.com>
 <20210923194343.ca0f29e1c4d361170343a6f2@linux-foundation.org>
 <9e41661d-9919-d556-8c49-610dae157553@linux.alibaba.com>
 <CAPhsuW4cP4qV2c_wXP89-2fa+mALv-uEe+Qdqr_MD3Ptw03Wng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW4cP4qV2c_wXP89-2fa+mALv-uEe+Qdqr_MD3Ptw03Wng@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 03:24:47PM -0700, Song Liu wrote:
> OTOH, does it make sense to block writes within khugepaged, like:
> @@ -1652,6 +1653,11 @@ static void collapse_file(struct mm_struct *mm,
>         /* Only allocate from the target node */
>         gfp = alloc_hugepage_khugepaged_gfpmask() | __GFP_THISNODE;
> 
> +       if (deny_write_access(file)) {
> +               result = SCAN_BUSY_WRITE;
> +               return;
> +       }

The problem is that it denies, rather than blocking.  That means that the
writer gets ETXTBSY instead of waiting until khugepaged is done.

