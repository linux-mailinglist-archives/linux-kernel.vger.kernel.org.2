Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00F393A5E1E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 10:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbhFNIMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 04:12:14 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:29388 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbhFNIML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 04:12:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1623658210; x=1655194210;
  h=to:cc:references:subject:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=xEflTEyJ3ZXntxi3JP2PbSWowPZDRRzwaez53lJXRfI=;
  b=sKki8mMkfjAp6MIATVod7qaUDIEJQxPYQAsdhGpQxZQvhQHJE0FC6Iiv
   WbE1x6tVI0Z0Qn64RSvdJ7csgcQYckBhuNyWwBmS/tMGu8M+nf0TR+kKZ
   sLZSWJ8/MnOVIDUfzz7XjQyQpl0BNTYXIezZoDs0l4G/IezycH6W5pID4
   s=;
X-IronPort-AV: E=Sophos;i="5.83,272,1616457600"; 
   d="scan'208";a="139960241"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-2b-c300ac87.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP; 14 Jun 2021 08:10:02 +0000
Received: from EX13D31EUB003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2b-c300ac87.us-west-2.amazon.com (Postfix) with ESMTPS id 9F6ACA18B2;
        Mon, 14 Jun 2021 08:09:59 +0000 (UTC)
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13D31EUB003.ant.amazon.com (10.43.166.177) with Microsoft SMTP Server (TLS)
 id 15.0.1497.18; Mon, 14 Jun 2021 08:09:57 +0000
Received: from u898248c994d452.ant.amazon.com (10.50.205.34) by
 mail-relay.amazon.com (10.43.61.169) with Microsoft SMTP Server (TLS) id
 15.0.1497.18 via Frontend Transport; Mon, 14 Jun 2021 08:09:48 +0000
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
References: <20210520075629.4332-1-sj38.park@gmail.com>
Subject: Re: [PATCH v29 00/13] Introduce Data Access MONitor (DAMON)
From:   <sieberf@amazon.com>
Message-ID: <76be5866-ab27-2478-1fd3-89a75870802a@amazon.com>
Date:   Mon, 14 Jun 2021 10:09:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210520075629.4332-1-sj38.park@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For patches 00 to 07,
Reviewed-by: Fernand Sieber <sieberf@amazon.com>

