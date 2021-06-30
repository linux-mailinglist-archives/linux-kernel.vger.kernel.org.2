Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 201523B8244
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 14:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbhF3MiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 08:38:00 -0400
Received: from mga04.intel.com ([192.55.52.120]:25771 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234664AbhF3Mh6 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 08:37:58 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10030"; a="206516485"
X-IronPort-AV: E=Sophos;i="5.83,312,1616482800"; 
   d="scan'208";a="206516485"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2021 05:35:28 -0700
X-IronPort-AV: E=Sophos;i="5.83,312,1616482800"; 
   d="scan'208";a="457216594"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.255.30.109]) ([10.255.30.109])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2021 05:35:25 -0700
Subject: Re: [PATCH v2 1/3] libperf: Add perf_cpu_map__default_new()
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210621143321.27451-1-yao.jin@linux.intel.com>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <858b4c6f-99dd-c0d8-d8ec-67f905b3287c@linux.intel.com>
Date:   Wed, 30 Jun 2021 20:35:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210621143321.27451-1-yao.jin@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

Any comments for v2 series of cpulist hybrid support? :)

Thanks
Jin Yao

On 6/21/2021 10:33 PM, Jin Yao wrote:
> The libperf already has a static function 'cpu_map__default_new()'.
> Add a new API perf_cpu_map__default_new() to export the function.
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>   tools/lib/perf/cpumap.c              | 5 +++++
>   tools/lib/perf/include/perf/cpumap.h | 1 +
>   2 files changed, 6 insertions(+)
> 
> diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
> index ca0215047c32..51b6553912e0 100644
> --- a/tools/lib/perf/cpumap.c
> +++ b/tools/lib/perf/cpumap.c
> @@ -68,6 +68,11 @@ static struct perf_cpu_map *cpu_map__default_new(void)
>   	return cpus;
>   }
>   
> +struct perf_cpu_map *perf_cpu_map__default_new(void)
> +{
> +	return cpu_map__default_new();
> +}
> +
>   static int cmp_int(const void *a, const void *b)
>   {
>   	return *(const int *)a - *(const int*)b;
> diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/include/perf/cpumap.h
> index 6a17ad730cbc..7c27766ea0bf 100644
> --- a/tools/lib/perf/include/perf/cpumap.h
> +++ b/tools/lib/perf/include/perf/cpumap.h
> @@ -9,6 +9,7 @@
>   struct perf_cpu_map;
>   
>   LIBPERF_API struct perf_cpu_map *perf_cpu_map__dummy_new(void);
> +LIBPERF_API struct perf_cpu_map *perf_cpu_map__default_new(void);
>   LIBPERF_API struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list);
>   LIBPERF_API struct perf_cpu_map *perf_cpu_map__read(FILE *file);
>   LIBPERF_API struct perf_cpu_map *perf_cpu_map__get(struct perf_cpu_map *map);
> 
