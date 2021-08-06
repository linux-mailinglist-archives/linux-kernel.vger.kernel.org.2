Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE3B3E2020
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 02:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241818AbhHFAnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 20:43:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:49502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241490AbhHFAnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 20:43:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F13761184;
        Fri,  6 Aug 2021 00:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1628210588;
        bh=iSyRQEsIeNF4sicG4iDdhNRNXfrtXmJBuL9zRRvHZbo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CI/WU5o0NXX+lpLnneSa22rzMVR5Ow+ec2rhqWWg7D6zqdz2W0uHbrQADp9o06Qge
         D8JL9bqe1pTiEEDHdp/hYqaxLYok71uVO2CaFYGmNY486Xj9zOT0UnMj7ZCOo1L+Yl
         vV6gkNz/0uoGaOXpYZUAjyxBx2uJLRrfYHesU+aw=
Date:   Thu, 5 Aug 2021 17:43:04 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@Huawei.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
        brendanhiggins@google.com, corbet@lwn.net, david@redhat.com,
        dwmw@amazon.com, elver@google.com, fan.du@intel.com,
        foersleo@amazon.de, greg@kroah.com, gthelen@google.com,
        guoju.fgj@alibaba-inc.com, jgowans@amazon.com, joe@perches.com,
        mgorman@suse.de, mheyne@amazon.de, minchan@kernel.org,
        mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org,
        riel@surriel.com, rientjes@google.com, rostedt@goodmis.org,
        rppt@kernel.org, shakeelb@google.com, shuah@kernel.org,
        sieberf@amazon.com, snu@zelle79.org, vbabka@suse.cz,
        vdavydov.dev@gmail.com, zgf574564920@gmail.com,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v34 07/13] mm/damon: Implement a debugfs-based user
 space interface
Message-Id: <20210805174304.3c3d8c8ee971bc9ddf6988af@linux-foundation.org>
In-Reply-To: <20210716081449.22187-8-sj38.park@gmail.com>
References: <20210716081449.22187-1-sj38.park@gmail.com>
        <20210716081449.22187-8-sj38.park@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jul 2021 08:14:43 +0000 SeongJae Park <sj38.park@gmail.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> DAMON is designed to be used by kernel space code such as the memory
> management subsystems, and therefore it provides only kernel space API.
> That said, letting the user space control DAMON could provide some
> benefits to them.  For example, it will allow user space to analyze
> their specific workloads and make their own special optimizations.
> 
> For such cases, this commit implements a simple DAMON application kernel
> module, namely 'damon-dbgfs', which merely wraps the DAMON api and
> exports those to the user space via the debugfs.
> 
> ...
>
> +static int __init damon_dbgfs_init(void)
> +{
> +	int rc;
> +
> +	dbgfs_ctxs = kmalloc(sizeof(*dbgfs_ctxs), GFP_KERNEL);
> +	if (!dbgfs_ctxs) {
> +		pr_err("%s: dbgfs ctxs alloc failed\n", __func__);
> +		return -ENOMEM;
> +	}
> +	dbgfs_ctxs[0] = dbgfs_new_ctx();
> +	if (!dbgfs_ctxs[0]) {
> +		kfree(dbgfs_ctxs);
> +		pr_err("%s: dbgfs ctx alloc failed\n", __func__);
> +		return -ENOMEM;
> +	}

checkpatch points out that the "alloc failed" messages are unneeded -
kmalloc(GFP_KERNEL) will have already emitted a stack trace.  Is this
fixup OK?

--- a/mm/damon/dbgfs.c~mm-damon-implement-a-debugfs-based-user-space-interface-fix
+++ a/mm/damon/dbgfs.c
@@ -373,14 +373,11 @@ static int __init damon_dbgfs_init(void)
 	int rc;
 
 	dbgfs_ctxs = kmalloc(sizeof(*dbgfs_ctxs), GFP_KERNEL);
-	if (!dbgfs_ctxs) {
-		pr_err("%s: dbgfs ctxs alloc failed\n", __func__);
+	if (!dbgfs_ctxs)
 		return -ENOMEM;
-	}
 	dbgfs_ctxs[0] = dbgfs_new_ctx();
 	if (!dbgfs_ctxs[0]) {
 		kfree(dbgfs_ctxs);
-		pr_err("%s: dbgfs ctx alloc failed\n", __func__);
 		return -ENOMEM;
 	}
 	dbgfs_nr_ctxs = 1;
_

