Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E42930BE2D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 13:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhBBM3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 07:29:04 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:30488 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbhBBM2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 07:28:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1612268935; x=1643804935;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=tPW+WSGCYnSNEPfsJLIzZMQfqRKCnJMi8qp6on18UiQ=;
  b=IeZp0QBOUWYLpvNHXek8NlYOW/5KChaFB1aejjGfPGPoSBvb75ozQn6O
   kr4RAvtknrGgWFAMAE+jH0AUe8QxkNzc7tHtgOm1U8TiOTkdTmhXbQfza
   dM4Rq89+J/u29cSk5bxlhC2Jin+vpRTQaPvJqz9FGRiZb7VxBJk5C5Qwe
   4=;
X-IronPort-AV: E=Sophos;i="5.79,394,1602547200"; 
   d="scan'208";a="108086815"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-456ef9c9.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 02 Feb 2021 12:28:07 +0000
Received: from EX13D31EUA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2c-456ef9c9.us-west-2.amazon.com (Postfix) with ESMTPS id 0BF0AAECFE;
        Tue,  2 Feb 2021 12:28:04 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.162.208) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 2 Feb 2021 12:27:48 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     SeongJae Park <sjpark@amazon.com>
CC:     <akpm@linux-foundation.org>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <david@redhat.com>,
        <dwmw@amazon.com>, <elver@google.com>, <fan.du@intel.com>,
        <foersleo@amazon.de>, <gthelen@google.com>, <irogers@google.com>,
        <jolsa@redhat.com>, <kirill@shutemov.name>, <mark.rutland@arm.com>,
        <mgorman@suse.de>, <minchan@kernel.org>, <mingo@redhat.com>,
        <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <rppt@kernel.org>, <sblbir@amazon.com>,
        <shakeelb@google.com>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <snu@amazon.de>, <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <zgf574564920@gmail.com>, <linux-damon@amazon.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v23 10/15] mm/damon/dbgfs: Support multiple contexts
Date:   Tue, 2 Feb 2021 13:27:34 +0100
Message-ID: <20210202122734.15627-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201215115448.25633-11-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.208]
X-ClientProxiedBy: EX13D06UWA004.ant.amazon.com (10.43.160.164) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Dec 2020 12:54:43 +0100 SeongJae Park <sjpark@amazon.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> In some use cases, users would want to run multiple monitoring context.
> For example, if a user wants a high precision monitoring and dedicating
> multiple CPUs for the job is ok, because DAMON creates one monitoring
> thread per one context, the user can split the monitoring target regions
> into multiple small regions and create one context for each region.  Or,
> someone might want to simultaneously monitor different address spaces,
> e.g., both virtual address space and physical address space.
> 
> The DAMON's API allows such usage, but 'damon-dbgfs' does not.
> Therefore, only kernel space DAMON users can do multiple contexts
> monitoring.
> 
> This commit allows the user space DAMON users to use multiple contexts
> monitoring by introducing two new 'damon-dbgfs' debugfs files,
> 'mk_context' and 'rm_context'.  Users can create a new monitoring
> context by writing the desired name of the new context to 'mk_context'.
> Then, a new directory with the name and having the files for setting of
> the context ('attrs', 'target_ids' and 'record') will be created under
> the debugfs directory.  Writing the name of the context to remove to
> 'rm_context' will remove the related context and directory.
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---
>  mm/damon/dbgfs.c | 213 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 211 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
> index a1512d3e5afe..46186b057e1a 100644
> --- a/mm/damon/dbgfs.c
> +++ b/mm/damon/dbgfs.c
[...]
> +/*
> + * Remove a context of @name and its debugfs directory.
> + *
> + * This function should be called while holding damon_dbgfs_lock.
> + *
> + * Return 0 on success, negative error code otherwise.
> + */
> +static int dbgfs_rm_context(char *name)
> +{
> +	struct dentry *root, *dir, **new_dirs;
> +	struct damon_ctx **new_ctxs;
> +	int i, j;
> +
> +	if (damon_nr_running_ctxs())
> +		return -EBUSY;
> +
> +	root = dbgfs_dirs[0];
> +	if (!root)
> +		return -ENOENT;
> +
> +	dir = debugfs_lookup(name, root);
> +	if (!dir)
> +		return -ENOENT;
> +
> +	new_dirs = kmalloc_array(dbgfs_nr_ctxs - 1, sizeof(*dbgfs_dirs),
> +			GFP_KERNEL);
> +	if (!new_dirs)
> +		return -ENOMEM;
> +
> +	new_ctxs = kmalloc_array(dbgfs_nr_ctxs - 1, sizeof(*dbgfs_ctxs),
> +			GFP_KERNEL);
> +	if (!new_ctxs) {
> +		kfree(new_dirs);
> +		return -ENOMEM;
> +	}
> +
> +	for (i = 0, j = 0; i < dbgfs_nr_ctxs; i++) {
> +		if (dbgfs_dirs[i] == dir) {
> +			debugfs_remove(dbgfs_dirs[i]);
> +			dbgfs_destroy_ctx(dbgfs_ctxs[i]);

In case of virtual address monitoring, dbgfs_destroy_ctx() calls
damon_destroy_ctx() and damon_destroy_ctx() doesn't put the target pids.  I
will fix this in the next version.

> +			continue;
> +		}
> +		new_dirs[j] = dbgfs_dirs[i];
> +		new_ctxs[j++] = dbgfs_ctxs[i];
> +	}
> +
> +	kfree(dbgfs_dirs);
> +	kfree(dbgfs_ctxs);
> +
> +	dbgfs_dirs = new_dirs;
> +	dbgfs_ctxs = new_ctxs;
> +	dbgfs_nr_ctxs--;
> +
> +	return 0;
> +}

Thanks,
SeongJae Park
[...]
