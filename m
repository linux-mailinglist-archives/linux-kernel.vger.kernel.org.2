Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBAC372459
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 04:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhEDCEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 22:04:24 -0400
Received: from mga18.intel.com ([134.134.136.126]:27162 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229488AbhEDCEW (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 22:04:22 -0400
IronPort-SDR: 6jNDzmw/rGGsAXc9fLG2ntsxFHhf0PtvPHJXCQF7hcLfOBRXWFnO96ZvPCcFoi9C+fEahFuBo9
 u86ecBgNdN+w==
X-IronPort-AV: E=McAfee;i="6200,9189,9973"; a="185348780"
X-IronPort-AV: E=Sophos;i="5.82,271,1613462400"; 
   d="scan'208";a="185348780"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2021 19:03:28 -0700
IronPort-SDR: d5jsPQ8h5FDb/FoQdEPiVvgMOgFh4gPv0//U+PpKmaJWbJOnwukGY1yxkXfaGdCI4zEeFlovQz
 nWNgZsNfJb+g==
X-IronPort-AV: E=Sophos;i="5.82,271,1613462400"; 
   d="scan'208";a="433047466"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.255.31.225]) ([10.255.31.225])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2021 19:03:25 -0700
Subject: Re: [PATCH v1 1/2] perf header: Support HYBRID_TOPOLOGY feature
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
References: <20210430074602.3028-1-yao.jin@linux.intel.com>
 <YJAUTxgXCCcFOMTe@kernel.org>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <7a619154-9a41-da68-81b4-bcf4dc6b487c@linux.intel.com>
Date:   Tue, 4 May 2021 10:03:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YJAUTxgXCCcFOMTe@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On 5/3/2021 11:18 PM, Arnaldo Carvalho de Melo wrote:
> Em Fri, Apr 30, 2021 at 03:46:01PM +0800, Jin Yao escreveu:
>> +struct hybrid_topology *hybrid_topology__new(void)
>> +{
>> +	struct perf_pmu *pmu;
>> +	struct hybrid_topology *tp = NULL;
>> +	u32 nr = 0, i = 0;
>> +
>> +	nr = perf_pmu__hybrid_pmu_num();
> 
> Initialize it to zero and right away overwrite it with a function
> return?
> 

Hmm, yes, the 'nr' doesn't need to be initialized to 0, sorry about that.

>> +	u32 nr = 0, i = 0;
> 
> 	u32 nr = perf_pmu__hybrid_pmu_num(), i;
> 
>> +	if (nr == 0)
>> +		return NULL;
>> +
>> +	tp = zalloc(sizeof(*tp) + sizeof(tp->nodes[0]) * nr);
>> +	if (!tp)
>> +		return NULL;
>> +
>> +	tp->nr = nr;
> 
> 	i = 0;
> 
> Please fix these and add an entry to
> tools/perf/Documentation/perf.data-file-format.txt for this new feature,
> then submit v2.
> 
> And on 2/2 please update the CPU_PMU_CAPS entry in
> tools/perf/Documentation/perf.data-file-format.txt.
> 
> Thanks,
> 

OK, I will add these features to perf.data-file-format.txt and then post v2.

Thanks
Jin Yao

> - Arnaldo
> 
> 
>> +	perf_pmu__for_each_hybrid_pmu(pmu) {
>> +		if (load_hybrid_node(&tp->nodes[i], pmu)) {
>> +			hybrid_topology__delete(tp);
>> +			return NULL;
>> +		}
>> +		i++;
>> +	}
>> +
>> +	return tp;
>> +}
>> +
>> +void hybrid_topology__delete(struct hybrid_topology *tp)
>> +{
>> +	u32 i;
>> +
>> +	for (i = 0; i < tp->nr; i++) {
>> +		zfree(&tp->nodes[i].pmu_name);
>> +		zfree(&tp->nodes[i].cpus);
>> +	}
>> +
>> +	free(tp);
>> +}
>> diff --git a/tools/perf/util/cputopo.h b/tools/perf/util/cputopo.h
>> index 6201c3790d86..d9af97177068 100644
>> --- a/tools/perf/util/cputopo.h
>> +++ b/tools/perf/util/cputopo.h
>> @@ -25,10 +25,23 @@ struct numa_topology {
>>   	struct numa_topology_node	nodes[];
>>   };
>>   
>> +struct hybrid_topology_node {
>> +	char		*pmu_name;
>> +	char		*cpus;
>> +};
>> +
>> +struct hybrid_topology {
>> +	u32				nr;
>> +	struct hybrid_topology_node	nodes[];
>> +};
>> +
>>   struct cpu_topology *cpu_topology__new(void);
>>   void cpu_topology__delete(struct cpu_topology *tp);
>>   
>>   struct numa_topology *numa_topology__new(void);
>>   void numa_topology__delete(struct numa_topology *tp);
>>   
>> +struct hybrid_topology *hybrid_topology__new(void);
>> +void hybrid_topology__delete(struct hybrid_topology *tp);
>> +
>>   #endif /* __PERF_CPUTOPO_H */
>> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
>> index 9130f6fad8d5..9e05eca324a1 100644
>> --- a/tools/perf/util/env.c
>> +++ b/tools/perf/util/env.c
>> @@ -202,6 +202,12 @@ void perf_env__exit(struct perf_env *env)
>>   	for (i = 0; i < env->nr_memory_nodes; i++)
>>   		zfree(&env->memory_nodes[i].set);
>>   	zfree(&env->memory_nodes);
>> +
>> +	for (i = 0; i < env->nr_hybrid_nodes; i++) {
>> +		perf_cpu_map__put(env->hybrid_nodes[i].map);
>> +		zfree(&env->hybrid_nodes[i].pmu_name);
>> +	}
>> +	zfree(&env->hybrid_nodes);
>>   }
>>   
>>   void perf_env__init(struct perf_env *env __maybe_unused)
>> diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
>> index ca249bf5e984..9ca7633787e1 100644
>> --- a/tools/perf/util/env.h
>> +++ b/tools/perf/util/env.h
>> @@ -37,6 +37,11 @@ struct memory_node {
>>   	unsigned long	*set;
>>   };
>>   
>> +struct hybrid_node {
>> +	char	*pmu_name;
>> +	struct perf_cpu_map	*map;
>> +};
>> +
>>   struct perf_env {
>>   	char			*hostname;
>>   	char			*os_release;
>> @@ -59,6 +64,7 @@ struct perf_env {
>>   	int			nr_pmu_mappings;
>>   	int			nr_groups;
>>   	int			nr_cpu_pmu_caps;
>> +	int			nr_hybrid_nodes;
>>   	char			*cmdline;
>>   	const char		**cmdline_argv;
>>   	char			*sibling_cores;
>> @@ -77,6 +83,7 @@ struct perf_env {
>>   	struct numa_node	*numa_nodes;
>>   	struct memory_node	*memory_nodes;
>>   	unsigned long long	 memory_bsize;
>> +	struct hybrid_node	*hybrid_nodes;
>>   #ifdef HAVE_LIBBPF_SUPPORT
>>   	/*
>>   	 * bpf_info_lock protects bpf rbtrees. This is needed because the
>> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
>> index aa1e42518d37..dff89c0be79c 100644
>> --- a/tools/perf/util/header.c
>> +++ b/tools/perf/util/header.c
>> @@ -932,6 +932,40 @@ static int write_clock_data(struct feat_fd *ff,
>>   	return do_write(ff, data64, sizeof(*data64));
>>   }
>>   
>> +static int write_hybrid_topology(struct feat_fd *ff,
>> +				 struct evlist *evlist __maybe_unused)
>> +{
>> +	struct hybrid_topology *tp;
>> +	int ret;
>> +	u32 i;
>> +
>> +	tp = hybrid_topology__new();
>> +	if (!tp)
>> +		return -1;
>> +
>> +	ret = do_write(ff, &tp->nr, sizeof(u32));
>> +	if (ret < 0)
>> +		goto err;
>> +
>> +	for (i = 0; i < tp->nr; i++) {
>> +		struct hybrid_topology_node *n = &tp->nodes[i];
>> +
>> +		ret = do_write_string(ff, n->pmu_name);
>> +		if (ret < 0)
>> +			goto err;
>> +
>> +		ret = do_write_string(ff, n->cpus);
>> +		if (ret < 0)
>> +			goto err;
>> +	}
>> +
>> +	ret = 0;
>> +
>> +err:
>> +	hybrid_topology__delete(tp);
>> +	return ret;
>> +}
>> +
>>   static int write_dir_format(struct feat_fd *ff,
>>   			    struct evlist *evlist __maybe_unused)
>>   {
>> @@ -1623,6 +1657,19 @@ static void print_clock_data(struct feat_fd *ff, FILE *fp)
>>   		    clockid_name(clockid));
>>   }
>>   
>> +static void print_hybrid_topology(struct feat_fd *ff, FILE *fp)
>> +{
>> +	int i;
>> +	struct hybrid_node *n;
>> +
>> +	for (i = 0; i < ff->ph->env.nr_hybrid_nodes; i++) {
>> +		n = &ff->ph->env.hybrid_nodes[i];
>> +
>> +		fprintf(fp, "# %s cpu list : ", n->pmu_name);
>> +		cpu_map__fprintf(n->map, fp);
>> +	}
>> +}
>> +
>>   static void print_dir_format(struct feat_fd *ff, FILE *fp)
>>   {
>>   	struct perf_session *session;
>> @@ -2849,6 +2896,50 @@ static int process_clock_data(struct feat_fd *ff,
>>   	return 0;
>>   }
>>   
>> +static int process_hybrid_topology(struct feat_fd *ff,
>> +				   void *data __maybe_unused)
>> +{
>> +	struct hybrid_node *nodes, *n;
>> +	u32 nr, i;
>> +	char *str;
>> +
>> +	/* nr nodes */
>> +	if (do_read_u32(ff, &nr))
>> +		return -1;
>> +
>> +	nodes = zalloc(sizeof(*nodes) * nr);
>> +	if (!nodes)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < nr; i++) {
>> +		n = &nodes[i];
>> +
>> +		n->pmu_name = do_read_string(ff);
>> +		if (!n->pmu_name)
>> +			goto error;
>> +
>> +		str = do_read_string(ff);
>> +		if (!str)
>> +			goto error;
>> +
>> +		n->map = perf_cpu_map__new(str);
>> +		free(str);
>> +		if (!n->map)
>> +			goto error;
>> +	}
>> +
>> +	ff->ph->env.nr_hybrid_nodes = nr;
>> +	ff->ph->env.hybrid_nodes = nodes;
>> +	return 0;
>> +
>> +error:
>> +	for (i = 0; i < nr; i++)
>> +		free(nodes[i].pmu_name);
>> +
>> +	free(nodes);
>> +	return -1;
>> +}
>> +
>>   static int process_dir_format(struct feat_fd *ff,
>>   			      void *_data __maybe_unused)
>>   {
>> @@ -3117,6 +3208,7 @@ const struct perf_header_feature_ops feat_ops[HEADER_LAST_FEATURE] = {
>>   	FEAT_OPR(COMPRESSED,	compressed,	false),
>>   	FEAT_OPR(CPU_PMU_CAPS,	cpu_pmu_caps,	false),
>>   	FEAT_OPR(CLOCK_DATA,	clock_data,	false),
>> +	FEAT_OPN(HYBRID_TOPOLOGY,	hybrid_topology,	true),
>>   };
>>   
>>   struct header_print_data {
>> diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
>> index 2aca71763ecf..3f12ec0eb84e 100644
>> --- a/tools/perf/util/header.h
>> +++ b/tools/perf/util/header.h
>> @@ -45,6 +45,7 @@ enum {
>>   	HEADER_COMPRESSED,
>>   	HEADER_CPU_PMU_CAPS,
>>   	HEADER_CLOCK_DATA,
>> +	HEADER_HYBRID_TOPOLOGY,
> Return-Path: <linux-kernel-owner@vger.kernel.org>
> X-Original-To: yao.jin@linux.intel.com
> Delivered-To: yao.jin@linux.intel.com
> Received: from fmsmga001.fm.intel.com (fmsmga001.fm.intel.com [10.253.24.23])
> 	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
> 	(No client certificate requested)
> 	by linux.intel.com (Postfix) with ESMTPS id 36D9D580906;
> 	Mon,  3 May 2021 14:36:22 -0700 (PDT)
> IronPort-SDR: esi0FcPI009YsspGtVZcbgLx4B9FM+DVeKXdx+v+ajHsniBl02v1XF8B+GMpGwaPP2H9NXBHuF
>   joSEEGiTA5aJAoGf5ZBZFiJIiA6enxguk=
> X-IronPort-AV: E=McAfee;i="6200,9189,9973"; a="530707860"
> X-IronPort-AV: E=Sophos;i="5.82,271,1613462400";
>     d="scan'208";a="530707860"
> Received: from orsmga105.jf.intel.com ([10.7.208.20])
>    by fmsmga001-1.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2021 14:36:20 -0700
> IronPort-SDR: 1MJbwfsAApKPsXRZYJaw3MaQlazYe6d7MM5ej4rEMjuYIk6Y+2Z9DqulfOSCsHkn0nZr0G2HbP
>   q+BNQ+kZ+1D8MTqu9shQXHRg9QFF2M1HE=
> X-SG-BADATTACHMENTNOREPLY: True
> X-IPAS-Result: =?us-ascii?q?A0FLAAAhbJBghxJggBdaHAEBAQEBAQcBARIBAQQEAQGCA?=
>   =?us-ascii?q?wcBAQsBg3gBASUSMYxoYIcDgR8qJQOBDJlzFIFfFAEBAQEBAQEBAQkdFAECB?=
>   =?us-ascii?q?AEBhk4CJTQJDQECBAEBAQMCAQIBAQEBAQECAgEBAQIBAQUCAQEBAQIQAQEBA?=
>   =?us-ascii?q?YEFAWBjAYFGAYFxBgQ9gjgig3QDAwECJAsBRgYJAR8yA1QHEgWCbIMIBapPM?=
>   =?us-ascii?q?4EBiDmBRIE6AYhzdIN4J4EEgSOBFTOCOXSEKIYSBII3DwEqE1EBMBI9eEcTB?=
>   =?us-ascii?q?UkDnlCcPgeDE4Eom3YQJ4NUkSmQJZUvghadQ4QwgVQ4gVwzGiODOU0BAgECA?=
>   =?us-ascii?q?QwBAgIDAQIBAgEHAQECAY4nFo5LIQEBMAI2AgYKAQEDCVkBAYw0AQE?=
> IronPort-PHdr: A9a23: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
> IronPort-HdrOrdr: A9a23:t4aaUaA+6hlJPGHlHejssceALOonbusQ8zAX/mp6ICYlFvCwvc
>   aogfgdyFvIkz4XQn4tgpStP6OHTHPa+/dOkPUsFJqrQQWOghrPEKhM9o3nqgeQeRHW1ukY7q
>   t4drg7NduYNykAse/b+w++KtA63Z283ZvAv4q+815JTRt2L4FMhj0JdDqzNm1TaE14CYEiFJ
>   yaj/A32gaIXXgMdMy0Cj0kUoH41qT2vav8bRQLChIh4gXmt0LW1JfAHxKV3ggTXlp0qN9Imw
>   a18DDR3amtv+q2zRXRzQbonu5rseH8wdhODtHksLlzFhzQjG+TFeFccozHnCsyp9io80tvuO
>   akmXtOX/hb2jf0dmGxrQCF4XiZ7B8er1vryVqZhnWmhMziWVsBert8ub4=
> X-IronPort-Anti-Spam-Filtered: true
> X-IronPort-AV: E=McAfee;i="6200,9189,9973"; a="261790135"
> X-IronPort-AV: E=Sophos;i="5.82,271,1613462400";
>     d="scan'208";a="261790135"
> X-Amp-Result: SKIPPED(no attachment in message)
> X-Amp-File-Uploaded: False
> Received: from vger.kernel.org ([23.128.96.18])
>    by mtab.intel.com with ESMTP; 03 May 2021 14:36:07 -0700
> Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
>          id S229846AbhECVg4 (ORCPT <rfc822;bingbu.cao@linux.intel.com>
>          + 29 others); Mon, 3 May 2021 17:36:56 -0400
> Received: from mga18.intel.com ([134.134.136.126]:6730 "EHLO mga18.intel.com"
>          rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
>          id S229764AbhECVgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
>          Mon, 3 May 2021 17:36:52 -0400
> IronPort-SDR: 1csj0DEIMG/4QUsFu3BmUbvFdT7jBonCObhRz0qmqggHKb35l90RoafgGQbJRBABy2bIFj1oyz
>   QE6rWT57N1bw==
> X-IronPort-AV: E=McAfee;i="6200,9189,9973"; a="185312154"
> X-IronPort-AV: E=Sophos;i="5.82,271,1613462400";
>     d="scan'208";a="185312154"
> Received: from fmsmga008.fm.intel.com ([10.253.24.58])
>    by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2021 14:35:57 -0700
> IronPort-SDR: /v7zWWgeCpbkRPEz3SQB9i9+7fEAMEScp2HIQ7R0gaTFo8YKVYigkoddcEJ3InSW9wC39KNvod
>   e9jWlQq2QaDQ==
> X-IronPort-AV: E=Sophos;i="5.82,271,1613462400";
>     d="scan'208";a="428548807"
> Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.212.218.202])
>    by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2021 14:35:56 -0700
> From:   Russ Weight <russell.h.weight@intel.com>
> To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
>          linux-kernel@vger.kernel.org
> Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
>          hao.wu@intel.com, matthew.gerlach@intel.com,
>          richard.gong@intel.com, Russ Weight <russell.h.weight@intel.com>
> Subject: [PATCH v12 3/7] fpga: sec-mgr: expose sec-mgr update status
> Date:   Mon,  3 May 2021 14:35:42 -0700
> Message-Id: <20210503213546.316439-4-russell.h.weight@intel.com>
> X-Mailer: git-send-email 2.25.1
> In-Reply-To: <20210503213546.316439-1-russell.h.weight@intel.com>
> References: <20210503213546.316439-1-russell.h.weight@intel.com>
> MIME-Version: 1.0
> Content-Transfer-Encoding: 8bit
> Precedence: bulk
> List-ID: <linux-kernel.vger.kernel.org>
> X-Mailing-List: linux-kernel@vger.kernel.org
> 
> Extend the FPGA Security Manager class driver to
> include an update/status sysfs node that can be polled
> and read to monitor the progress of an ongoing secure
> update. Sysfs_notify() is used to signal transitions
> between different phases of the update process.
> 
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Reviewed-by: Tom Rix <trix@redhat.com>
> ---
> v12:
>    - Updated Date and KernelVersion fields in ABI documentation
>    - Changed syntax of sec_mgr_prog_str[] array definition from:
> 	"idle",			/* FPGA_SEC_PROG_IDLE */
>      to:
> 	[FPGA_SEC_PROG_IDLE]	    = "idle",
> v11:
>    - No change
> v10:
>    - Rebased to 5.12-rc2 next
>    - Updated Date and KernelVersion in ABI documentation
> v9:
>    - Updated Date and KernelVersion in ABI documentation
> v8:
>    - No change
> v7:
>    - Changed Date in documentation file to December 2020
> v6:
>    - No change
> v5:
>    - Use new function sysfs_emit() in the status_show() function
> v4:
>    - Changed from "Intel FPGA Security Manager" to FPGA Security Manager"
>      and removed unnecessary references to "Intel".
>    - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
> v3:
>    - Use a local variable to read progress once in status_show()
>    - Use dev_err to report invalid progress status
> v2:
>    - Bumped documentation date and version
>    - Changed progress state "read_file" to "reading"
> ---
>   .../ABI/testing/sysfs-class-fpga-sec-mgr      | 11 +++++
>   drivers/fpga/fpga-sec-mgr.c                   | 42 +++++++++++++++++--
>   2 files changed, 49 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr b/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
> index 36d1b6ba8d76..b962ad2cf18d 100644
> --- a/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
> +++ b/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
> @@ -16,3 +16,14 @@ Description:	Write only. Write the filename of an image
>   		BMC images, BMC firmware, Static Region images,
>   		and Root Entry Hashes, and to cancel Code Signing
>   		Keys (CSK).
> +
> +What: 		/sys/class/fpga_sec_mgr/fpga_secX/update/status
> +Date:		June 2021
> +KernelVersion:	5.14
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Read-only. Returns a string describing the current
> +		status of an update. The string will be one of the
> +		following: idle, reading, preparing, writing,
> +		programming. Userspace code can poll on this file,
> +		as it will be signaled by sysfs_notify() on each
> +		state change.
> diff --git a/drivers/fpga/fpga-sec-mgr.c b/drivers/fpga/fpga-sec-mgr.c
> index fe82feda6b3c..dec52c68fe16 100644
> --- a/drivers/fpga/fpga-sec-mgr.c
> +++ b/drivers/fpga/fpga-sec-mgr.c
> @@ -23,6 +23,13 @@ struct fpga_sec_mgr_devres {
>   
>   #define to_sec_mgr(d) container_of(d, struct fpga_sec_mgr, dev)
>   
> +static void update_progress(struct fpga_sec_mgr *smgr,
> +			    enum fpga_sec_prog new_progress)
> +{
> +	smgr->progress = new_progress;
> +	sysfs_notify(&smgr->dev.kobj, "update", "status");
> +}
> +
>   static void fpga_sec_dev_error(struct fpga_sec_mgr *smgr,
>   			       enum fpga_sec_err err_code)
>   {
> @@ -33,7 +40,7 @@ static void fpga_sec_dev_error(struct fpga_sec_mgr *smgr,
>   static void progress_complete(struct fpga_sec_mgr *smgr)
>   {
>   	mutex_lock(&smgr->lock);
> -	smgr->progress = FPGA_SEC_PROG_IDLE;
> +	update_progress(smgr, FPGA_SEC_PROG_IDLE);
>   	complete_all(&smgr->update_done);
>   	mutex_unlock(&smgr->lock);
>   }
> @@ -61,14 +68,14 @@ static void fpga_sec_mgr_update(struct work_struct *work)
>   		goto release_fw_exit;
>   	}
>   
> -	smgr->progress = FPGA_SEC_PROG_PREPARING;
> +	update_progress(smgr, FPGA_SEC_PROG_PREPARING);
>   	ret = smgr->sops->prepare(smgr);
>   	if (ret != FPGA_SEC_ERR_NONE) {
>   		fpga_sec_dev_error(smgr, ret);
>   		goto modput_exit;
>   	}
>   
> -	smgr->progress = FPGA_SEC_PROG_WRITING;
> +	update_progress(smgr, FPGA_SEC_PROG_WRITING);
>   	while (smgr->remaining_size) {
>   		ret = smgr->sops->write_blk(smgr, offset);
>   		if (ret != FPGA_SEC_ERR_NONE) {
> @@ -79,7 +86,7 @@ static void fpga_sec_mgr_update(struct work_struct *work)
>   		offset = fw->size - smgr->remaining_size;
>   	}
>   
> -	smgr->progress = FPGA_SEC_PROG_PROGRAMMING;
> +	update_progress(smgr, FPGA_SEC_PROG_PROGRAMMING);
>   	ret = smgr->sops->poll_complete(smgr);
>   	if (ret != FPGA_SEC_ERR_NONE)
>   		fpga_sec_dev_error(smgr, ret);
> @@ -107,6 +114,32 @@ static void fpga_sec_mgr_update(struct work_struct *work)
>   	progress_complete(smgr);
>   }
>   
> +static const char * const sec_mgr_prog_str[] = {
> +	[FPGA_SEC_PROG_IDLE]	    = "idle",
> +	[FPGA_SEC_PROG_READING]	    = "reading",
> +	[FPGA_SEC_PROG_PREPARING]   = "preparing",
> +	[FPGA_SEC_PROG_WRITING]	    = "writing",
> +	[FPGA_SEC_PROG_PROGRAMMING] = "programming"
> +};
> +
> +static ssize_t
> +status_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct fpga_sec_mgr *smgr = to_sec_mgr(dev);
> +	const char *status = "unknown-status";
> +	enum fpga_sec_prog progress;
> +
> +	progress = smgr->progress;
> +	if (progress < FPGA_SEC_PROG_MAX)
> +		status = sec_mgr_prog_str[progress];
> +	else
> +		dev_err(dev, "Invalid status during secure update: %d\n",
> +			progress);
> +
> +	return sysfs_emit(buf, "%s\n", status);
> +}
> +static DEVICE_ATTR_RO(status);
> +
>   static ssize_t filename_store(struct device *dev, struct device_attribute *attr,
>   			      const char *buf, size_t count)
>   {
> @@ -141,6 +174,7 @@ static DEVICE_ATTR_WO(filename);
>   
>   static struct attribute *sec_mgr_update_attrs[] = {
>   	&dev_attr_filename.attr,
> +	&dev_attr_status.attr,
>   	NULL,
>   };
>   
> 
