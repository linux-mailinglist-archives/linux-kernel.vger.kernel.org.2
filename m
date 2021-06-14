Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7813A5F1E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 11:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbhFNJcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 05:32:48 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:24875 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbhFNJcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 05:32:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1623663046; x=1655199046;
  h=to:cc:references:subject:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=dIhrAnH9FPYcbc8v2HeH9/J0qmUD70Of8p6cMMcu+c0=;
  b=VvnRSB56ApRqYP44CDiOVN4p7QVtLpAQgNwS2YuI8/5vGejzoMmw6mby
   MmrB9ZnPhj3cOKfatrxTcjDEvqNjLOe1jWCuOjZhq8ImJhEptJg5/2m6F
   fxCQjKE0YEf/g0EMDO6eHzSQRb0BklWna9f/lZCwTFGQORTw99RQCYVMC
   I=;
X-IronPort-AV: E=Sophos;i="5.83,273,1616457600"; 
   d="scan'208";a="115620062"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP; 14 Jun 2021 09:30:34 +0000
Received: from EX13D31EUA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com (Postfix) with ESMTPS id D89FFA175D;
        Mon, 14 Jun 2021 09:30:31 +0000 (UTC)
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.18; Mon, 14 Jun 2021 09:30:30 +0000
Received: from u898248c994d452.ant.amazon.com (10.50.205.34) by
 mail-relay.amazon.com (10.43.60.234) with Microsoft SMTP Server (TLS) id
 15.0.1497.18 via Frontend Transport; Mon, 14 Jun 2021 09:30:14 +0000
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
References: <20210520075629.4332-10-sj38.park@gmail.com>
Subject: Re: [PATCH v29 09/13] mm/damon/dbgfs: Support multiple contexts
From:   <sieberf@amazon.com>
Message-ID: <98a75d0c-2d1a-807e-050b-fb8e7d92f447@amazon.com>
Date:   Mon, 14 Jun 2021 11:30:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210520075629.4332-10-sj38.park@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+    new_dir = debugfs_create_dir(name, root);
+    dbgfs_dirs[dbgfs_nr_ctxs] = new_dir;

debugfs_create_dir might return ERR_PTR, should this be checked?

