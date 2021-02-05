Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70BE7311730
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 00:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhBEXgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 18:36:06 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:24639 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbhBEOVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:21:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1612540829; x=1644076829;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=TBohInsGRwLMOnqJDl8Pqhxj7U/fXFbfpMKPhnZcUFw=;
  b=jgYImARJD6qkBQV5QsAiU36i737f/WHvRPDZ28run0cIE4FTZ8ks4Jn8
   GyOSqHmIGskwEXAHpLVo3laroKOZolM7mIV/Fcrpf5bUZzk7nuh93Bojd
   YT2CYWqYhsU+6iqwlVGmn8eK14yOvhhs7DyE8hGq1ttOyjvQH9Q7XOrd0
   I=;
X-IronPort-AV: E=Sophos;i="5.81,155,1610409600"; 
   d="scan'208";a="82731861"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2b-81e76b79.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 05 Feb 2021 15:59:38 +0000
Received: from EX13D31EUA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2b-81e76b79.us-west-2.amazon.com (Postfix) with ESMTPS id 0A050A1D83;
        Fri,  5 Feb 2021 15:59:34 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.162.194) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 5 Feb 2021 15:59:17 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Greg KH <greg@kroah.com>
CC:     SeongJae Park <sjpark@amazon.com>,
        SeongJae Park <sjpark@amazon.de>,
        <Jonathan.Cameron@huawei.com>, <aarcange@redhat.com>,
        <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <amit@kernel.org>, <benh@kernel.crashing.org>,
        <brendan.d.gregg@gmail.com>, <brendanhiggins@google.com>,
        <cai@lca.pw>, <colin.king@canonical.com>, <corbet@lwn.net>,
        <david@redhat.com>, <dwmw@amazon.com>, <elver@google.com>,
        <fan.du@intel.com>, <foersleo@amazon.de>, <gthelen@google.com>,
        <irogers@google.com>, <jolsa@redhat.com>, <kirill@shutemov.name>,
        <mark.rutland@arm.com>, <mgorman@suse.de>, <minchan@kernel.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <rppt@kernel.org>, <sblbir@amazon.com>,
        <shakeelb@google.com>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <snu@amazon.de>, <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <zgf574564920@gmail.com>, <linux-damon@amazon.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v24 07/14] mm/damon: Implement a debugfs-based user space interface
Date:   Fri, 5 Feb 2021 16:59:02 +0100
Message-ID: <20210205155902.31102-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <YB1kZaD/7omxXztF@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.194]
X-ClientProxiedBy: EX13D11UWB002.ant.amazon.com (10.43.161.20) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Feb 2021 16:29:41 +0100 Greg KH <greg@kroah.com> wrote:

> On Thu, Feb 04, 2021 at 04:31:43PM +0100, SeongJae Park wrote:
> > From: SeongJae Park <sjpark@amazon.de>
> > 
> > DAMON is designed to be used by kernel space code such as the memory
> > management subsystems, and therefore it provides only kernel space API.
> > That said, letting the user space control DAMON could provide some
> > benefits to them.  For example, it will allow user space to analyze
> > their specific workloads and make their own special optimizations.
> > 
> > For such cases, this commit implements a simple DAMON application kernel
> > module, namely 'damon-dbgfs', which merely wraps the DAMON api and
> > exports those to the user space via the debugfs.
> > 
> > 'damon-dbgfs' exports three files, ``attrs``, ``target_ids``, and
> > ``monitor_on`` under its debugfs directory, ``<debugfs>/damon/``.
[...]
> > ---
> >  include/linux/damon.h |   3 +
> >  mm/damon/Kconfig      |   9 +
> >  mm/damon/Makefile     |   1 +
> >  mm/damon/core.c       |  47 +++++
> >  mm/damon/dbgfs.c      | 387 ++++++++++++++++++++++++++++++++++++++++++
> >  5 files changed, 447 insertions(+)
> >  create mode 100644 mm/damon/dbgfs.c
[...]
> > diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
> > new file mode 100644
> > index 000000000000..db15380737d1
> > --- /dev/null
> > +++ b/mm/damon/dbgfs.c
[...]
> > +
> > +static int dbgfs_fill_ctx_dir(struct dentry *dir, struct damon_ctx *ctx)
> > +{
> > +	const char * const file_names[] = {"attrs", "target_ids"};
> > +	const struct file_operations *fops[] = {&attrs_fops, &target_ids_fops};
> > +	int i;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(file_names); i++) {
> > +		if (!debugfs_create_file(file_names[i], 0600, dir,
> > +					ctx, fops[i])) {
> > +			pr_err("failed to create %s file\n", file_names[i]);
> > +			return -ENOMEM;
> 
> No need to check the return value of this function, just keep going and
> ignore it as there's nothing to do and kernel code should not do
> different things based on the output of any debugfs calls.
> 
> Also, this check is totally wrong and doesn't do what you think it is
> doing...

Ok, I will drop the check.

> 
> > +static int __init __damon_dbgfs_init(void)
> > +{
> > +	struct dentry *dbgfs_root;
> > +	const char * const file_names[] = {"monitor_on"};
> > +	const struct file_operations *fops[] = {&monitor_on_fops};
> > +	int i;
> > +
> > +	dbgfs_root = debugfs_create_dir("damon", NULL);
> > +	if (IS_ERR(dbgfs_root)) {
> > +		pr_err("failed to create the dbgfs dir\n");
> > +		return PTR_ERR(dbgfs_root);
> 
> Again, no need to check anything, just pass the result of a debugfs call
> back into another one just fine.

Ok.

> 
> > +	}
> > +
> > +	for (i = 0; i < ARRAY_SIZE(file_names); i++) {
> > +		if (!debugfs_create_file(file_names[i], 0600, dbgfs_root,
> > +					NULL, fops[i])) {
> 
> Again, this isn't checking what you think it is, so please don't do it.

Got it.

I will fix those as you suggested in the next version.


Thanks,
SeongJae Park

> 
> thanks,
> 
> greg k-h
