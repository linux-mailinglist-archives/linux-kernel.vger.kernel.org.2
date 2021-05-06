Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD5F374D38
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 04:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhEFCCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 22:02:13 -0400
Received: from mga07.intel.com ([134.134.136.100]:28138 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230033AbhEFCCL (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 22:02:11 -0400
IronPort-SDR: MmN0zxkwQcINTTBu4Ygk/S66i6pjxjy/Ft5bGvMtVVPKxFdN2tTgw6UoohVic5Z8wjCDkBZHTT
 uub08o3hlVRg==
X-IronPort-AV: E=McAfee;i="6200,9189,9975"; a="262292467"
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; 
   d="scan'208";a="262292467"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2021 19:01:14 -0700
IronPort-SDR: aAnfqvc6IdLHlPJ3JWKllbX6KVxqknmOxdAJzqmsf/DrmPha2tRrx926OE1wu09rL97QWU0unt
 8bFwFtU0Kr6g==
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; 
   d="scan'208";a="434107824"
Received: from unknown (HELO [10.238.4.82]) ([10.238.4.82])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2021 19:01:09 -0700
Subject: Re: [PATCH v1 1/2] perf header: Support HYBRID_TOPOLOGY feature
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210430074602.3028-1-yao.jin@linux.intel.com>
 <YJFgC9tS9m9/DJP8@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <1d256f3e-14b3-0c37-610a-2b3777827d95@linux.intel.com>
Date:   Thu, 6 May 2021 10:01:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YJFgC9tS9m9/DJP8@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 5/4/2021 10:54 PM, Jiri Olsa wrote:
> On Fri, Apr 30, 2021 at 03:46:01PM +0800, Jin Yao wrote:
> 
> SNIP
> 
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
> 
> do you plan to do anything else with n->map in the future?
> because right now you could just print the stored cpus string no?
> it should be already in the cpumask shape
> 
> jirka
> 

Yes, you are right, we don't need to use n->map at least now.

Following code should be much simpler.

+struct hybrid_node {
+       char    *pmu_name;
+       char    *cpus;
+};

+static int process_hybrid_topology(struct feat_fd *ff,
+                                  void *data __maybe_unused)
+{
+       struct hybrid_node *nodes, *n;
+       u32 nr, i;
+
+       /* nr nodes */
+       if (do_read_u32(ff, &nr))
+               return -1;
+
+       nodes = zalloc(sizeof(*nodes) * nr);
+       if (!nodes)
+               return -ENOMEM;
+
+       for (i = 0; i < nr; i++) {
+               n = &nodes[i];
+
+               n->pmu_name = do_read_string(ff);
+               if (!n->pmu_name)
+                       goto error;
+
+               n->cpus = do_read_string(ff);
+               if (!n->cpus)
+                       goto error;
+       }
+
+       ff->ph->env.nr_hybrid_nodes = nr;
+       ff->ph->env.hybrid_nodes = nodes;
+       return 0;
+
+error:
...

+static void print_hybrid_topology(struct feat_fd *ff, FILE *fp)
+{
+       int i;
+       struct hybrid_node *n;
+
+       for (i = 0; i < ff->ph->env.nr_hybrid_nodes; i++) {
+               n = &ff->ph->env.hybrid_nodes[i];
+               fprintf(fp, "# %s cpu list : %s\n", n->pmu_name, n->cpus);
+       }
+}

Thanks
Jin Yao



