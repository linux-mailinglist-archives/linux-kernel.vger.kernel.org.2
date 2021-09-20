Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A5C41160C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 15:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239772AbhITNro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 09:47:44 -0400
Received: from mga09.intel.com ([134.134.136.24]:45174 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236385AbhITNrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 09:47:43 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10112"; a="223166976"
X-IronPort-AV: E=Sophos;i="5.85,308,1624345200"; 
   d="scan'208";a="223166976"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2021 06:46:16 -0700
X-IronPort-AV: E=Sophos;i="5.85,308,1624345200"; 
   d="scan'208";a="701062486"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.252.131.200]) ([10.252.131.200])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2021 06:46:15 -0700
Subject: Re: [PATCH v8 0/8] Don't compute events that won't be used in a
 metric.
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Paul Clarke <pc@us.ibm.com>, kajoljain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Sandeep Dasgupta <sdasgup@google.com>
References: <20210918063513.2356923-1-irogers@google.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <7307f6f3-74a8-ef3e-428b-fc294454e463@linux.intel.com>
Date:   Mon, 20 Sep 2021 06:46:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210918063513.2356923-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/17/2021 11:35 PM, Ian Rogers wrote:
>      
> For a metric like:
>    EVENT1 if #smt_on else EVENT2
>      
> currently EVENT1 and EVENT2 will be measured and then when the metric
> is reported EVENT1 or EVENT2 will be printed depending on the value
> from smt_on() during the expr parsing. Computing both events is
> unnecessary and can lead to multiplexing as discussed in this thread:
> https://lore.kernel.org/lkml/20201110100346.2527031-1-irogers@google.com/
>
> This change modifies expression parsing so that constants are
> considered when building the set of ids (events) and only events not
> contributing to a constant value are measured.


The series looks good to me.


Reviewed-by: Andi Kleen <ak@linux.intel.com>


-Andi


