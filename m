Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB04239051F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 17:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbhEYPVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 11:21:20 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:13992 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbhEYPU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 11:20:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1621955968; x=1653491968;
  h=to:cc:references:subject:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=CSuS1/6afomgRdSmx4v4U5egysYnZihhAd5HpYugzR4=;
  b=Jb4pgDYPfDT/AHs/rFeM0O8U4KhSebAbrlcVhkGfoe149qiS2ub04KJr
   JcgooiES6xkakjTYTRDn+99UuSzXT5kYUU7WvShPKHlSgxl1N5tTSkC46
   al8J3t0KehJID8vpxDEwAx1SqgTGzJAMZ/qJ930tuxklOMX82GTTspoBZ
   A=;
X-IronPort-AV: E=Sophos;i="5.82,328,1613433600"; 
   d="scan'208";a="127569130"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-2a-22cc717f.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP; 25 May 2021 15:19:21 +0000
Received: from EX13D31EUB004.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2a-22cc717f.us-west-2.amazon.com (Postfix) with ESMTPS id D372CA190A;
        Tue, 25 May 2021 15:19:19 +0000 (UTC)
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D31EUB004.ant.amazon.com (10.43.166.164) with Microsoft SMTP Server (TLS)
 id 15.0.1497.18; Tue, 25 May 2021 15:19:17 +0000
Received: from u8803c614af8f5a.ant.amazon.com (172.31.190.190) by
 mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS) id
 15.0.1497.18 via Frontend Transport; Tue, 25 May 2021 15:19:07 +0000
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
References: <20210520075629.4332-6-sj38.park@gmail.com>
Subject: Re: [PATCH v29 05/13] mm/damon: Implement primitives for the virtual
 memory address spaces
From:   <sieberf@amazon.com>
Message-ID: <3da2bb79-4448-4857-a9d1-698a360c51a2@amazon.com>
Date:   Tue, 25 May 2021 17:19:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210520075629.4332-6-sj38.park@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi SeongJae,

Some questions for this patch:

Why do we split the regions in 3 areas (heap, stack, mmaped)? I 
understand we don't want to model the whole virtual address space, but 
why don't we just use whatever is modeled by the VMAs to define the 
regions boundaries?

I am not quite understanding why we both set the page idle and young (in 
damon_ptep_mkold). For WSS computation on our end we have used 
pte_clear_young_notify. Why do we touch the page idle flag at all? What 
flags do the reclaim logic use to track access?

Kind regards,

Fernand

