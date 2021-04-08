Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE3C3586BB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 16:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbhDHOQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 10:16:38 -0400
Received: from mga12.intel.com ([192.55.52.136]:19473 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231907AbhDHOQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 10:16:30 -0400
IronPort-SDR: qss1IFMzvbBLJnIZhb+S1BcFbyZgP/5S52WdsaiuJAbL10i4VBtFJFmCHmwuwd5xeS1qMNAP6H
 52jZNttfFrXA==
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="173025364"
X-IronPort-AV: E=Sophos;i="5.82,206,1613462400"; 
   d="scan'208";a="173025364"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 07:16:18 -0700
IronPort-SDR: dBbG1/EwCwLdU5InOJlJAC7+UvqtmNtgRKThjwidlM2l9ydQdpraMWE3qOHBesTSE5zk0uans0
 JS6eBRwsgi5g==
X-IronPort-AV: E=Sophos;i="5.82,206,1613462400"; 
   d="scan'208";a="458841825"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 07:16:18 -0700
Date:   Thu, 8 Apr 2021 07:16:17 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     "Bayduraev, Alexey V" <alexey.v.bayduraev@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>
Subject: Re: [PATCH v4 02/12] perf record: introduce thread specific data
 array
Message-ID: <20210408141617.GD3762101@tassilo.jf.intel.com>
References: <6c15adcb-6a9d-320e-70b5-957c4c8b6ff2@linux.intel.com>
 <aff91ec1-10d8-0e18-caf4-69e82179240a@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aff91ec1-10d8-0e18-caf4-69e82179240a@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +		} else {
> +			thread_data[t].tid = syscall(SYS_gettid);

That always fills in the tid of the setup thread instead of the target
threads?
