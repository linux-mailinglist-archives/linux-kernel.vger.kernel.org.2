Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7114390515
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 17:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234245AbhEYPUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 11:20:03 -0400
Received: from smtp-fw-9103.amazon.com ([207.171.188.200]:25083 "EHLO
        smtp-fw-9103.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbhEYPTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 11:19:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1621955850; x=1653491850;
  h=to:cc:references:subject:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=yTek0pizCvLcTlNuueaRKn+sp3Yn2EKx4lOHoX8AyXg=;
  b=jHiYF7Mt1ezN+EezA3s2X3DKHCnpoo4QxFxlHXSk4ZyEr46Uskaf1NNC
   iIUy8xnGUo/IyOqpDdW378nxXCTyojFIUJ5EdvPnzTJjgDD2wiDtBcZhU
   /vp/IDQn37lJQOiAl497vEbRKkfEYQDaEEj9//fwMdn7F63tGcpeCq25O
   g=;
X-IronPort-AV: E=Sophos;i="5.82,328,1613433600"; 
   d="scan'208";a="934958672"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-2b-c7131dcf.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP; 25 May 2021 15:17:23 +0000
Received: from EX13D31EUA003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2b-c7131dcf.us-west-2.amazon.com (Postfix) with ESMTPS id 5731EA1C5D;
        Tue, 25 May 2021 15:17:21 +0000 (UTC)
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D31EUA003.ant.amazon.com (10.43.165.95) with Microsoft SMTP Server (TLS)
 id 15.0.1497.18; Tue, 25 May 2021 15:17:19 +0000
Received: from u8803c614af8f5a.ant.amazon.com (172.31.190.190) by
 mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS) id
 15.0.1497.18 via Frontend Transport; Tue, 25 May 2021 15:17:07 +0000
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
References: <20210520075629.4332-4-sj38.park@gmail.com>
Subject: Re: [PATCH v29 03/13] mm/damon: Adaptively adjust regions
From:   <sieberf@amazon.com>
Message-ID: <1b30265d-7440-1c94-f625-0087215433ee@amazon.com>
Date:   Tue, 25 May 2021 17:17:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210520075629.4332-4-sj38.park@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi SeongJae,

The code looks good. Some questions for this patch:

The region merge threshold is computed on the access diff. Should the 
diff threshold be exponential as diffs in low number of access are 
likely to be more important? I.e if the threshold is 5, a region A with 
0 accesses will be merged with a region B with 4 accesses (diff=4), but 
a region C with 50 access won't be merged with a region D with 60 
accesses (diff=10), however it seems to me that keeping a good 
granularity between A and B is more important than between C and D for 
FPR. What do you think?

When the number of regions is less than half max region, region split 
kicks in and doubles the number of region. This means that the number of 
region will grow close to max region, then slowly decay as region 
merges, until it reaches half max regions, then double again. This seems 
to create a non-uniform region number distribution over time, with large 
cycles. Also we do a lot of work when we double and no work otherwise. 
Not sure what's the impact on measurement quality but intuitively seems 
like keeping the number of regions constant over time would yield more 
consistent metrics? How about we rather always split regions at each 
iteration, and for each region we give a split probability?

Kind regards,

--Fernand

