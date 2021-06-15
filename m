Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6DF3A8687
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 18:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhFOQdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 12:33:05 -0400
Received: from smtp-fw-80006.amazon.com ([99.78.197.217]:43466 "EHLO
        smtp-fw-80006.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhFOQdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 12:33:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1623774658; x=1655310658;
  h=to:cc:references:subject:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=SrhbQXI4828ff0Vq+9igXIvtw28JGPyv98z43LF5s5I=;
  b=hhCmgVes86V6rBBFsCc4adLjwcjB3flSB8D/dsfXPFLVqnhigeJYa1oh
   qHA4hgP3I0M/PsQP43jKHZQtskYjeY4RF64Nm0ZcmjQSYxiJ8a6mzP5ID
   FBCxegtISqYDp+RvHV0ZTFrUljTTh4BVmxe+NdIaj0a7iyHqa8SVu+qKn
   4=;
X-IronPort-AV: E=Sophos;i="5.83,275,1616457600"; 
   d="scan'208";a="6789575"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-2c-76e0922c.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP; 15 Jun 2021 16:30:50 +0000
Received: from EX13D31EUB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2c-76e0922c.us-west-2.amazon.com (Postfix) with ESMTPS id 8D643A00C1;
        Tue, 15 Jun 2021 16:30:48 +0000 (UTC)
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D31EUB001.ant.amazon.com (10.43.166.210) with Microsoft SMTP Server (TLS)
 id 15.0.1497.18; Tue, 15 Jun 2021 16:30:46 +0000
Received: from u898248c994d452.ant.amazon.com (10.50.204.228) by
 mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP Server (TLS) id
 15.0.1497.18 via Frontend Transport; Tue, 15 Jun 2021 16:30:36 +0000
To:     <sieberf@amazon.com>
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
        <sj38.park@gmail.com>, <sjpark@amazon.de>, <snu@amazon.de>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <zgf574564920@gmail.com>
References: <76be5866-ab27-2478-1fd3-89a75870802a@amazon.com>
Subject: Re: [PATCH v29 00/13] Introduce Data Access MONitor (DAMON)
From:   <sieberf@amazon.com>
Message-ID: <a685b2dd-04d2-34c3-5c36-a3f49e1a8d39@amazon.com>
Date:   Tue, 15 Jun 2021 18:30:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <76be5866-ab27-2478-1fd3-89a75870802a@amazon.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For patches 08 to 10: Reviewed-by: Fernand Sieber <sieberf@amazon.com>

