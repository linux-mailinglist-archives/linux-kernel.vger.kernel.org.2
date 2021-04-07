Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9BB1356D4A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 15:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244108AbhDGN2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 09:28:38 -0400
Received: from mga17.intel.com ([192.55.52.151]:2058 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233670AbhDGN2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 09:28:36 -0400
IronPort-SDR: BSTrGHJKA12BxZCMsVzqOhbxZ9RXjPk+Dr8+Zi/ndWKnscjnBdd+RkScCWEADv/SqGuMLAwcwO
 23woZfyLu+zw==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="173383156"
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="173383156"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 06:28:25 -0700
IronPort-SDR: RS6OVcyMxCy+wmtY5cjwJO/cIWHMA68wL2HOqH22lAAY/Vh9dEdnOI5QvdoKelxX3GikdZLLnW
 Ksf/mZeDg6vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="458369338"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by orsmga001.jf.intel.com with ESMTP; 07 Apr 2021 06:28:20 -0700
Subject: Re: [PATCH v2 0/7] perf arm-spe: Enable timestamp
To:     Leo Yan <leo.yan@linaro.org>, Al Grant <Al.Grant@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        James Clark <James.Clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210403072346.30430-1-leo.yan@linaro.org>
 <AM6PR08MB335124DC0080EA95A817D71786769@AM6PR08MB3351.eurprd08.prod.outlook.com>
 <20210407131529.GA585163@leoy-ThinkPad-X240s>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <0016288d-a490-f8fb-f108-0969b946494e@intel.com>
Date:   Wed, 7 Apr 2021 16:28:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210407131529.GA585163@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/04/21 4:15 pm, Leo Yan wrote:
> Hi Al,
> 
> On Tue, Apr 06, 2021 at 09:38:32AM +0000, Al Grant wrote:
> 
> [...]
> 
>>> This patch set is to enable timestamp for Arm SPE trace.  It reads out TSC
>>> parameters from mmap page and stores into auxtrace info structure;
>>
>> Why not synthesize a PERF_RECORD_TIME_CONV - isn't that specifically to
>> capture the TSC parameters from the mmap page? If a generic mechanism
>> exists it would be better to use it, otherwise we'll have to do this again for
>> future trace formats.
> 
> Good point!  Actually "perf record" tool has synthesized event
> PERF_RECORD_TIME_CONV.  This patch series is studying the
> implementation from Intel-PT, so the question is why the existed
> implementations (like Intel-PT, Intel-BTS) don't directly use
> PERF_RECORD_TIME_CONV for retriving TSC parameters.

PERF_RECORD_TIME_CONV was added later because the TSC information is
needed by jitdump.

