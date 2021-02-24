Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8875323818
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 08:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbhBXHvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 02:51:49 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:36562 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233695AbhBXHva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 02:51:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1614153089; x=1645689089;
  h=from:to:cc:subject:date:message-id:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=DXdAXbodLJFLCACHgM3UuUQ3p+oQUqas3URxarIcAkE=;
  b=mMNdKlxaExpMO2Ctz9N/56LPn07ocvRLGHt9HEAignd8c04/yX89lIHG
   DmWuQZcVvWyO3H7nVK+jlsT2L0X5d80wSGdcErxnEC85eifAkkt+Y6iwd
   RxzKjoqHemv4Mi1Ho/UAWTvHc0iuwQm52IXG6hDoMKm/KCFc4RZeHFHgW
   I=;
X-IronPort-AV: E=Sophos;i="5.81,202,1610409600"; 
   d="scan'208";a="87490840"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2b-81e76b79.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 24 Feb 2021 07:50:35 +0000
Received: from EX13D31EUA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2b-81e76b79.us-west-2.amazon.com (Postfix) with ESMTPS id 8B170A1C18;
        Wed, 24 Feb 2021 07:50:32 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.162.228) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 24 Feb 2021 07:50:14 +0000
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
Subject: Re: [PATCH v24 11/14] Documentation: Add documents for DAMON
Date:   Wed, 24 Feb 2021 08:49:55 +0100
Message-ID: <20210224074955.20173-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <20210204153150.15948-12-sjpark@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.162.228]
X-ClientProxiedBy: EX13D21UWA003.ant.amazon.com (10.43.160.184) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Feb 2021 16:31:47 +0100 SeongJae Park <sjpark@amazon.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> This commit adds documents for DAMON under
> `Documentation/admin-guide/mm/damon/` and `Documentation/vm/damon/`.
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---
>  Documentation/admin-guide/mm/damon/guide.rst | 159 ++++++++++
>  Documentation/admin-guide/mm/damon/index.rst |  15 +
>  Documentation/admin-guide/mm/damon/plans.rst |  29 ++
>  Documentation/admin-guide/mm/damon/start.rst |  97 ++++++
>  Documentation/admin-guide/mm/damon/usage.rst | 304 +++++++++++++++++++
>  Documentation/admin-guide/mm/index.rst       |   1 +
>  Documentation/vm/damon/api.rst               |  20 ++
>  Documentation/vm/damon/design.rst            | 166 ++++++++++
>  Documentation/vm/damon/eval.rst              | 232 ++++++++++++++
>  Documentation/vm/damon/faq.rst               |  58 ++++
>  Documentation/vm/damon/index.rst             |  31 ++
>  Documentation/vm/index.rst                   |   1 +
>  12 files changed, 1113 insertions(+)
>  create mode 100644 Documentation/admin-guide/mm/damon/guide.rst
>  create mode 100644 Documentation/admin-guide/mm/damon/index.rst
>  create mode 100644 Documentation/admin-guide/mm/damon/plans.rst
>  create mode 100644 Documentation/admin-guide/mm/damon/start.rst
>  create mode 100644 Documentation/admin-guide/mm/damon/usage.rst
>  create mode 100644 Documentation/vm/damon/api.rst
>  create mode 100644 Documentation/vm/damon/design.rst
>  create mode 100644 Documentation/vm/damon/eval.rst
>  create mode 100644 Documentation/vm/damon/faq.rst
>  create mode 100644 Documentation/vm/damon/index.rst
> 
[...]
> diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
> new file mode 100644
> index 000000000000..32436cf853c7
> --- /dev/null
> +++ b/Documentation/admin-guide/mm/damon/usage.rst
> @@ -0,0 +1,304 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===============
> +Detailed Usages
> +===============
> +
> +DAMON provides below three interfaces for different users.
> +
> +- *DAMON user space tool.*
> +  This is for privileged people such as system administrators who want a
> +  just-working human-friendly interface.  Using this, users can use the DAMONâ€™s
> +  major features in a human-friendly way.  It may not be highly tuned for
> +  special cases, though.  It supports only virtual address spaces monitoring.
> +- *debugfs interface.*
> +  This is for privileged user space programmers who want more optimized use of
> +  DAMON.  Using this, users can use DAMONâ€™s major features by reading
> +  from and writing to special debugfs files.  Therefore, you can write and use
> +  your personalized DAMON debugfs wrapper programs that reads/writes the
> +  debugfs files instead of you.  The DAMON user space tool is also a reference
> +  implementation of such programs.  It supports only virtual address spaces
> +  monitoring.
> +- *Kernel Space Programming Interface.*
> +  This is for kernel space programmers.  Using this, users can utilize every
> +  feature of DAMON most flexibly and efficiently by writing kernel space
> +  DAMON application programs for you.  You can even extend DAMON for various
> +  address spaces.
> +
> +This document does not describe the kernel space programming interface in
> +detail.  For that, please refer to the :doc:`/vm/damon/api`.
> +
> +
> +DAMON User Space Tool
> +=====================

This version of the patchset doesn't introduce the user space tool source code,
so putting the detailed usage here might make no sense.  I will remove this
section in the next version.  If you will review this patch, please skip this
section.
[...]
> +
> +debugfs Interface
> +=================

But, this section will not be removed.  Please review.

[...]


Thanks,
SeongJae Park
