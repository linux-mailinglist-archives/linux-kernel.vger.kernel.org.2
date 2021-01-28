Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B55C9306A56
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 02:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbhA1B1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 20:27:52 -0500
Received: from mga12.intel.com ([192.55.52.136]:27363 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229709AbhA1B1s (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 20:27:48 -0500
IronPort-SDR: 0uzsh/dP5+qR7PH2N15E4H15miijJkH/O5K6eNFhlazMqaMhxE2rv+WpVVXzR5M4Uq4YyMP2La
 1OnpwSXzkMkg==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="159335530"
X-IronPort-AV: E=Sophos;i="5.79,381,1602572400"; 
   d="scan'208";a="159335530"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 17:26:02 -0800
IronPort-SDR: Kq78ATGb6zSuQed5PKw0bvAiX9cHwz4b4UTgafQsDmhHO9VX4lPah7PJoWsjLn9GScl4l4mH9v
 T0778ZGgfMug==
X-IronPort-AV: E=Sophos;i="5.79,381,1602572400"; 
   d="scan'208";a="362651210"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.27]) ([10.238.4.27])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 17:25:59 -0800
Subject: Re: [PATCH v8] perf stat: Fix wrong skipping for per-die aggregation
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com, ying.huang@intel.com
References: <20210125233525.13706-1-yao.jin@linux.intel.com>
 <20210127220827.GB284633@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <58796d6e-fceb-ea1f-3a83-543569d5625c@linux.intel.com>
Date:   Thu, 28 Jan 2021 09:25:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210127220827.GB284633@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 1/28/2021 6:08 AM, Jiri Olsa wrote:
>> @@ -1385,7 +1386,8 @@ void evsel__exit(struct evsel *evsel)
>>   	zfree(&evsel->group_name);
>>   	zfree(&evsel->name);
>>   	zfree(&evsel->pmu_name);
>> -	zfree(&evsel->per_pkg_mask);
> sorry I did not notice before, but I think we need to call
> zero_per_pkg in here, otherwise we're leaking keys
> 
> jirka
> 

Sorry, I forgot to add the release code here. :(

I will rename zero_per_pkg to evsel__zero_per_pkg and move it to evsel.c and call 
evsel__zero_per_pkg in evsel__exit().

Thanks
Jin Yao


