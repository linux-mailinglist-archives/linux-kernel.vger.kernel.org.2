Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA5545E914
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 09:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346974AbhKZIUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 03:20:23 -0500
Received: from smtprelay0213.hostedemail.com ([216.40.44.213]:56532 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1359299AbhKZISW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 03:18:22 -0500
Received: from omf17.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 9666E180A25C8;
        Fri, 26 Nov 2021 08:15:06 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf17.hostedemail.com (Postfix) with ESMTPA id 8825EE00036E;
        Fri, 26 Nov 2021 08:15:02 +0000 (UTC)
Message-ID: <aa7ad39528c768dfd3a33890cf7d14b59ba3a5fc.camel@perches.com>
Subject: Re: [PATCH][next] hugetlb: Fix spelling mistake "hierarichal" ->
 "hierarchical"
From:   Joe Perches <joe@perches.com>
To:     Colin Ian King <colin.i.king@googlemail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 26 Nov 2021 00:15:04 -0800
In-Reply-To: <20211125090635.23508-1-colin.i.king@gmail.com>
References: <20211125090635.23508-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.60
X-Stat-Signature: zduh9f8tp1nobnocxexjweddxcud9wtu
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 8825EE00036E
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+gfAvX6ESF28PxboOQwQbTRp4ragM60F4=
X-HE-Tag: 1637914502-589088
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-11-25 at 09:06 +0000, Colin Ian King wrote:
> There is a spelling mistake in a literal string and a comment. Fix them.
[]
> diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
[]
> @@ -495,11 +495,11 @@ static int hugetlb_cgroup_read_numa_stat(struct seq_file *seq, void *dummy)
>  	 * The hierarchical total is pretty much the value recorded by the
>  	 * counter, so use that.
>  	 */
> -	seq_printf(seq, "%stotal=%lu", legacy ? "hierarichal_" : "",
> +	seq_printf(seq, "%stotal=%lu", legacy ? "hierarchical_" : "",
>  		   page_counter_read(&h_cg->hugepage[idx]) * PAGE_SIZE);

Not sure this should be changed as seq output is nominally ABI.

>  
>  	/*
> -	 * For each node, transverse the css tree to obtain the hierarichal
> +	 * For each node, transverse the css tree to obtain the hierarchical

Fixing the comment typo is good.  Thanks.


