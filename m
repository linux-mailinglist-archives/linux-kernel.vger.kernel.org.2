Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC8B3A48F3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 20:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbhFKTBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 15:01:34 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:19347 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbhFKTBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 15:01:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1623437974; x=1654973974;
  h=to:cc:references:subject:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=IlXqNN4DCVLdzq7m01pXqxaNCLTpWZMZHvoFH3QaHXc=;
  b=Xoh54ZEVWECrIZt5wuLvFdbn7DlbHMzQAhEHDcopepS5SuKmF03UDf85
   XevOfCf7p45A8AOI1/AFREGVLBuT3CH/Ezjsj2DQLrrvsD21mo95xqfTP
   JoFw8Z06dom35I2Ac0tUClqexb41EwRbQEb0wnV5tlEPhqWrvlRUTslZ/
   c=;
X-IronPort-AV: E=Sophos;i="5.83,267,1616457600"; 
   d="scan'208";a="118269492"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2b-81e76b79.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP; 11 Jun 2021 18:59:24 +0000
Received: from EX13D31EUA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2b-81e76b79.us-west-2.amazon.com (Postfix) with ESMTPS id 56AE0A18A7;
        Fri, 11 Jun 2021 18:59:21 +0000 (UTC)
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.18; Fri, 11 Jun 2021 18:59:19 +0000
Received: from u898248c994d452.ant.amazon.com (10.85.45.245) by
 mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP Server (TLS) id
 15.0.1497.18 via Frontend Transport; Fri, 11 Jun 2021 18:59:06 +0000
To:     <sj38.park@gmail.com>
CC:     <Jonathan.Cameron@Huawei.com>, <acme@kernel.org>,
        <akpm@linux-foundation.org>, <alexander.shishkin@linux.intel.com>,
        <amit@kernel.org>, <benh@kernel.crashing.org>,
        <brendanhiggins@google.com>, <corbet@lwn.net>, <david@redhat.com>,
        <dwmw@amazon.com>, <elver@google.com>, <fan.du@intel.com>,
        <foersleo@amazon.de>, <greg@kroah.com>, <gthelen@google.com>,
        <guoju.fgj@alibaba-inc.com>, <linux-damon@amazon.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <mgorman@suse.de>, <minchan@kernel.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <riel@surriel.com>, <rientjes@google.com>, <rostedt@goodmis.org>,
        <rppt@kernel.org>, <shakeelb@google.com>, <shuah@kernel.org>,
        <sjpark@amazon.de>, <snu@amazon.de>, <vbabka@suse.cz>,
        <vdavydov.dev@gmail.com>, <zgf574564920@gmail.com>
References: <20210520075629.4332-8-sj38.park@gmail.com>
Subject: Re: [PATCH v29 07/13] mm/damon: Implement a debugfs-based user space
 interface
From:   <sieberf@amazon.com>
Message-ID: <e8687948-649f-348f-e4d6-2175b1c47551@amazon.com>
Date:   Fri, 11 Jun 2021 20:59:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210520075629.4332-8-sj38.park@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Returns non-empty string on success, negarive error code otherwise.

Nit: typo, 'negarive'


+    if (ctx->kdamond) {
+        if (targetid_is_pid(ctx))
+            dbgfs_put_pids(targets, nr_targets);
+        ret = -EBUSY;
+        goto unlock_out;

I don't understand this block, what does EBUSY mean in this context?

+    if (sscanf(kbuf, "%s", kbuf) != 1) {
+        kfree(kbuf);
+        return -EINVAL;
+    }

Nit, this diverts from other patterns use elsewhere where error 
conditions that need to free memory use a goto label.

