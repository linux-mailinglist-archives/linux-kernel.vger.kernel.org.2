Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDB113BA033
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 14:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbhGBMIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 08:08:42 -0400
Received: from mga01.intel.com ([192.55.52.88]:1621 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231912AbhGBMHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 08:07:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10032"; a="230394038"
X-IronPort-AV: E=Sophos;i="5.83,317,1616482800"; 
   d="scan'208";a="230394038"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2021 05:04:30 -0700
X-IronPort-AV: E=Sophos;i="5.83,317,1616482800"; 
   d="scan'208";a="482420148"
Received: from abaydur-mobl1.ccr.corp.intel.com (HELO [10.249.228.32]) ([10.249.228.32])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2021 05:04:27 -0700
Subject: Re: [PATCH v8 20/22] perf session: Load data directory files for
 analysis
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>
References: <cover.1625065643.git.alexey.v.bayduraev@linux.intel.com>
 <fbcb2de8d7e90cbf418a5a0465f444d0d5295615.1625065643.git.alexey.v.bayduraev@linux.intel.com>
 <YN7qwOZ5UlEkZ2zv@krava>
From:   "Bayduraev, Alexey V" <alexey.v.bayduraev@linux.intel.com>
Organization: Intel Corporation
Message-ID: <7dfdebb5-c10b-7f2a-ba93-70106d9fd909@linux.intel.com>
Date:   Fri, 2 Jul 2021 15:04:24 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YN7qwOZ5UlEkZ2zv@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 02.07.2021 13:30, Jiri Olsa wrote:
> On Wed, Jun 30, 2021 at 06:54:59PM +0300, Alexey Bayduraev wrote:
> 
> SNIP
> 
>> +	while ((ret >= 0) && readers) {
>> +		if (session_done())
>> +			return 0;
>> +
>> +		if (rd[i].state.eof) {
>> +			i = (i + 1) % session->nr_readers;
>> +			continue;
>> +		}
>> +
>> +		ret = reader__read_event(&rd[i], session, &prog);
>> +		if (ret < 0)
>> +			break;
>> +		if (ret == READER_EOF) {
>> +			ret = reader__mmap(&rd[i], session);
>> +			if (ret < 0)
>> +				goto out_err;
>> +			if (ret == READER_EOF)
>> +				readers--;
>> +		}
>> +
>> +		/*
>> +		 * Processing 10MBs of data from each reader in sequence,
>> +		 * because that's the way the ordered events sorting works
>> +		 * most efficiently.
>> +		 */
>> +		if (rd[i].state.size >= 10*1024*1024) {
>> +			rd[i].state.size = 0;
>> +			i = (i + 1) % session->nr_readers;
>> +		}
> 
> hi,
> so this was sort of hack to make this faster.. we need some
> justification for this and make that configurable as well,
> if we keep it

Hi,

I am currently thinking of another round-robin read algorithm, based on
timestamps with periodical ordered_queue flushing after each round, this
might be better, but I'm not sure if this should be included in this patchset. 

Probably introduction of new constant will be enough for current implementation.

Regards,
Alexey

> 
> jirka
> 
