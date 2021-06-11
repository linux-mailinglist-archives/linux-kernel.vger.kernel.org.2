Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146453A439F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 15:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbhFKOAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 10:00:21 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:32813 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbhFKOAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 10:00:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1623419902; x=1654955902;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=BVa8dCIXdhHLUqpBplTYlwUjgrxEgZUsmYcBq30zA3M=;
  b=tYzSmKZsjnPwj1G2oS2TFhIdxRU64ZvbATCEFG6lwgAGju/zOpi+J9Bi
   Uuii91Yr3fQIjyHgbK8aFll3+10GIcxgqE09PEMqTuBqb88b3wPrFMgEz
   xqo7BAyoLBKTxR81fyCmHc+XdJuDkLGTwUvsLhlf6A47NBS0ZcKj6lLeS
   A=;
X-IronPort-AV: E=Sophos;i="5.83,265,1616457600"; 
   d="scan'208";a="115269106"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-22cc717f.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP; 11 Jun 2021 13:58:10 +0000
Received: from EX13MTAUEE001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2a-22cc717f.us-west-2.amazon.com (Postfix) with ESMTPS id BD792A1C38;
        Fri, 11 Jun 2021 13:58:08 +0000 (UTC)
Received: from EX13D08UEB004.ant.amazon.com (10.43.60.142) by
 EX13MTAUEE001.ant.amazon.com (10.43.62.226) with Microsoft SMTP Server (TLS)
 id 15.0.1497.18; Fri, 11 Jun 2021 13:57:44 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D08UEB004.ant.amazon.com (10.43.60.142) with Microsoft SMTP Server (TLS)
 id 15.0.1497.18; Fri, 11 Jun 2021 13:57:43 +0000
Received: from dev-dsk-mheyne-60001.pdx1.corp.amazon.com (10.184.85.242) by
 mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1497.18 via Frontend Transport; Fri, 11 Jun 2021 13:57:43 +0000
Received: by dev-dsk-mheyne-60001.pdx1.corp.amazon.com (Postfix, from userid 5466572)
        id 3BF0021D11; Fri, 11 Jun 2021 13:57:41 +0000 (UTC)
From:   Maximilian Heyne <mheyne@amazon.de>
To:     SeongJae Park <sj38.park@gmail.com>
CC:     <akpm@linux-foundation.org>, SeongJae Park <sjpark@amazon.de>,
        <Jonathan.Cameron@Huawei.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendanhiggins@google.com>,
        <corbet@lwn.net>, <david@redhat.com>, <dwmw@amazon.com>,
        <elver@google.com>, <fan.du@intel.com>, <foersleo@amazon.de>,
        <greg@kroah.com>, <gthelen@google.com>,
        <guoju.fgj@alibaba-inc.com>, <mgorman@suse.de>,
        <minchan@kernel.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
        <peterz@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <rppt@kernel.org>, <shakeelb@google.com>,
        <shuah@kernel.org>, <snu@amazon.de>, <vbabka@suse.cz>,
        <vdavydov.dev@gmail.com>, <zgf574564920@gmail.com>,
        <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v29 12/13] mm/damon: Add user space selftests
Date:   Fri, 11 Jun 2021 13:57:37 +0000
Message-ID: <20210611135737.104838-1-mheyne@amazon.de>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20210520075629.4332-13-sj38.park@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 May 2021 07:56:28 +0000 SeongJae Park <sj38.park@gmail.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> This commit adds a simple user space tests for DAMON.  The tests are
> using kselftest framework.
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---
>  tools/testing/selftests/damon/Makefile        |  7 ++
>  .../selftests/damon/_chk_dependency.sh        | 28 ++++++
>  .../testing/selftests/damon/debugfs_attrs.sh  | 98 +++++++++++++++++++
>  3 files changed, 133 insertions(+)
>  create mode 100644 tools/testing/selftests/damon/Makefile
>  create mode 100644 tools/testing/selftests/damon/_chk_dependency.sh
>  create mode 100755 tools/testing/selftests/damon/debugfs_attrs.sh
> 
> diff --git a/tools/testing/selftests/damon/Makefile b/tools/testing/selftests/damon/Makefile
> new file mode 100644
> index 000000000000..8a3f2cd9fec0
> --- /dev/null
> +++ b/tools/testing/selftests/damon/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Makefile for damon selftests
> +
> +TEST_FILES = _chk_dependency.sh
> +TEST_PROGS = debugfs_attrs.sh
> +
> +include ../lib.mk
> diff --git a/tools/testing/selftests/damon/_chk_dependency.sh b/tools/testing/selftests/damon/_chk_dependency.sh
> new file mode 100644
> index 000000000000..e090836c2bf7
> --- /dev/null
> +++ b/tools/testing/selftests/damon/_chk_dependency.sh
> @@ -0,0 +1,28 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# Kselftest framework requirement - SKIP code is 4.
> +ksft_skip=4
> +
> +DBGFS=/sys/kernel/debug/damon
> +
> +if [ $EUID -ne 0 ];
> +then
> +	echo "Run as root"
> +	exit $ksft_skip
> +fi
> +
> +if [ ! -d $DBGFS ]
> +then
> +	echo "$DBGFS not found"
> +	exit $ksft_skip
> +fi
> +
> +for f in attrs target_ids monitor_on
> +do
> +	if [ ! -f "$DBGFS/$f" ]
> +	then
> +		echo "$f not found"
> +		exit 1
> +	fi
> +done
> diff --git a/tools/testing/selftests/damon/debugfs_attrs.sh b/tools/testing/selftests/damon/debugfs_attrs.sh
> new file mode 100755
> index 000000000000..4a8ab4910ee4
> --- /dev/null
> +++ b/tools/testing/selftests/damon/debugfs_attrs.sh
> @@ -0,0 +1,98 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +source ./_chk_dependency.sh
> +
> +# Test attrs file
> +file="$DBGFS/attrs"
> +
> +ORIG_CONTENT=$(cat $file)

Missing quotes around $file. Can you run shellcheck on this code and fix all
reportings, please?

> +
> +echo 1 2 3 4 5 > $file
> +if [ $? -ne 0 ]
> +then
> +	echo "$file write failed"
> +	echo $ORIG_CONTENT > $file
> +	exit 1
> +fi
> +
> +echo 1 2 3 4 > $file
> +if [ $? -eq 0 ]
> +then
> +	echo "$file write success (should failed)"
> +	echo $ORIG_CONTENT > $file
> +	exit 1
> +fi
> +
> +CONTENT=$(cat $file)
> +if [ "$CONTENT" != "1 2 3 4 5" ]
> +then
> +	echo "$file not written"
> +	echo $ORIG_CONTENT > $file
> +	exit 1
> +fi

I'd add test cases for the contents written to the attrs, like checking that
input min_nr_regions is actually smaller than the input max_nr_regions values.

> +
> +echo $ORIG_CONTENT > $file
> +
> +# Test target_ids file
> +file="$DBGFS/target_ids"
> +
> +ORIG_CONTENT=$(cat $file)
> +
> +echo "1 2 3 4" > $file
> +if [ $? -ne 0 ]
> +then
> +	echo "$file write fail"
> +	echo $ORIG_CONTENT > $file
> +	exit 1
> +fi
> +
> +echo "1 2 abc 4" > $file
> +if [ $? -ne 0 ]
> +then
> +	echo "$file write fail"
> +	echo $ORIG_CONTENT > $file
> +	exit 1
> +fi

I've seen this construct more than once. Any chance to refactor this code? Or is
this selftest not expected to grow in the future?

> +
> +CONTENT=$(cat $file)
> +if [ "$CONTENT" != "1 2" ]
> +then
> +	echo "$file not written"
> +	echo $ORIG_CONTENT > $file
> +	exit 1
> +fi
> +
> +echo abc 2 3 > $file
> +if [ $? -ne 0 ]
> +then
> +	echo "$file wrong value write fail"
> +	echo $ORIG_CONTENT > $file
> +	exit 1
> +fi
> +
> +if [ ! -z "$(cat $file)" ]
> +then
> +	echo "$file not cleared"
> +	echo $ORIG_CONTENT > $file
> +	exit 1
> +fi
> +
> +echo > $file
> +if [ $? -ne 0 ]
> +then
> +	echo "$file init fail"
> +	echo $ORIG_CONTENT > $file
> +	exit 1
> +fi
> +
> +if [ ! -z "$(cat $file)" ]
> +then
> +	echo "$file not initialized"
> +	echo $ORIG_CONTENT > $file
> +	exit 1
> +fi
> +
> +echo $ORIG_CONTENT > $file
> +
> +echo "PASS"
> -- 
> 2.17.1
> 
> 
> 
> 



Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



