Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 347BB3B91F9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 15:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236606AbhGANHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 09:07:52 -0400
Received: from mga02.intel.com ([134.134.136.20]:32708 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236580AbhGANHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 09:07:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10031"; a="195694218"
X-IronPort-AV: E=Sophos;i="5.83,314,1616482800"; 
   d="scan'208";a="195694218"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2021 06:05:14 -0700
X-IronPort-AV: E=Sophos;i="5.83,314,1616482800"; 
   d="scan'208";a="457650190"
Received: from abaydur-mobl1.ccr.corp.intel.com (HELO [10.249.231.202]) ([10.249.231.202])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2021 06:05:11 -0700
Subject: Re: [PATCH v8 01/22] perf record: Introduce thread affinity and mmap
 masks
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
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
 <ab1e7917845cc175a9e1d7f149e07b000d24c881.1625065643.git.alexey.v.bayduraev@linux.intel.com>
 <YNyZCZ92W39inSD2@kernel.org>
From:   "Bayduraev, Alexey V" <alexey.v.bayduraev@linux.intel.com>
Organization: Intel Corporation
Message-ID: <b4e43f46-71d5-457b-dcbf-aada28d7ba95@linux.intel.com>
Date:   Thu, 1 Jul 2021 16:05:09 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNyZCZ92W39inSD2@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 30.06.2021 19:17, Arnaldo Carvalho de Melo wrote:
> Em Wed, Jun 30, 2021 at 06:54:40PM +0300, Alexey Bayduraev escreveu:
[SNIP]
>> +static void record__mmap_cpu_mask_free(struct mmap_cpu_mask *mask)
>> +{
>> +	bitmap_free(mask->bits);
>> +	mask->nbits = 0;
> 
> Plese use NULL, as 'mask->nbits' is a pointer.

In perf/util/mmap.h "nbits" is size_t:

struct mmap_cpu_mask {
        unsigned long *bits;
        size_t nbits;
};

Regards,
Alexey

> 
>> +}
>> +
>> +static void record__thread_mask_clear(struct thread_mask *mask)
>> +{
>> +	bitmap_zero(mask->maps.bits, mask->maps.nbits);
>> +	bitmap_zero(mask->affinity.bits, mask->affinity.nbits);
>> +}
>> +
>> +static int record__thread_mask_alloc(struct thread_mask *mask, int nr_bits)
>> +{
>> +	int ret;
>> +
>> +	ret = record__mmap_cpu_mask_alloc(&mask->maps, nr_bits);
> 
> 
> please combine such decl + assign into one line, i.e.:
> 
> 	int ret = record__mmap_cpu_mask_alloc(&mask->maps, nr_bits);
> 
>> +	if (ret) {
>> +		mask->affinity.bits = NULL;
>> +		return ret;
>> +	}
>> +
>> +	ret = record__mmap_cpu_mask_alloc(&mask->affinity, nr_bits);
>> +	if (ret) {
>> +		record__mmap_cpu_mask_free(&mask->maps);
>> +		mask->maps.bits = NULL;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static void record__thread_mask_free(struct thread_mask *mask)
>> +{
>> +	record__mmap_cpu_mask_free(&mask->maps);
>> +	record__mmap_cpu_mask_free(&mask->affinity);
>> +}
>> +
>>  static int parse_output_max_size(const struct option *opt,
>>  				 const char *str, int unset)
>>  {
>> @@ -2664,6 +2720,70 @@ static struct option __record_options[] = {
>>  
>>  struct option *record_options = __record_options;
>>  
>> +static void record__mmap_cpu_mask_init(struct mmap_cpu_mask *mask, struct perf_cpu_map *cpus)
>> +{
>> +	int c;
>> +
>> +	for (c = 0; c < cpus->nr; c++)
>> +		set_bit(cpus->map[c], mask->bits);
>> +}
>> +
>> +static int record__alloc_thread_masks(struct record *rec, int nr_threads, int nr_bits)
>> +{
>> +	int t, ret;
>> +
>> +	rec->thread_masks = zalloc(nr_threads * sizeof(*(rec->thread_masks)));
>> +	if (!rec->thread_masks) {
>> +		pr_err("Failed to allocate thread masks\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	for (t = 0; t < nr_threads; t++) {
>> +		ret = record__thread_mask_alloc(&rec->thread_masks[t], nr_bits);
> 
> Usually when we don't manage to allocate all that we need we go on and
> free the partially allocated resources.
> 
>> +		if (ret)
>> +			return ret;
>> +		record__thread_mask_clear(&rec->thread_masks[t]);
>> +	}
>> +
>> +	return 0;
>> +}
>> +static int record__init_thread_default_masks(struct record *rec, struct perf_cpu_map *cpus)
>> +{
>> +	int ret;
>> +
>> +	ret = record__alloc_thread_masks(rec, 1, cpu__max_cpu());
> 
> ditto
> 
>> +	if (ret)
>> +		return ret;
>> +
>> +	record__mmap_cpu_mask_init(&rec->thread_masks->maps, cpus);
>> +
>> +	rec->nr_threads = 1;
>> +
>> +	return 0;
>> +}
>> +
>> +static int record__init_thread_masks(struct record *rec)
>> +{
>> +	struct perf_cpu_map *cpus = rec->evlist->core.cpus;
>> +
>> +	return record__init_thread_default_masks(rec, cpus);
>> +}
>> +
>> +static int record__fini_thread_masks(struct record *rec)
>> +{
>> +	int t;
>> +
>> +	if (rec->thread_masks)
>> +		for (t = 0; t < rec->nr_threads; t++)
>> +			record__thread_mask_free(&rec->thread_masks[t]);
>> +
>> +	zfree(&rec->thread_masks);
>> +
>> +	rec->nr_threads = 0;
>> +
>> +	return 0;
>> +}
>> +
>>  int cmd_record(int argc, const char **argv)
>>  {
>>  	int err;
>> @@ -2912,6 +3032,12 @@ int cmd_record(int argc, const char **argv)
>>  		goto out;
>>  	}
>>  
>> +	err = record__init_thread_masks(rec);
>> +	if (err) {
>> +		pr_err("record__init_thread_masks failed, error %d\n", err);
>> +		goto out;
>> +	}
>> +
>>  	if (rec->opts.nr_cblocks > nr_cblocks_max)
>>  		rec->opts.nr_cblocks = nr_cblocks_max;
>>  	pr_debug("nr_cblocks: %d\n", rec->opts.nr_cblocks);
>> @@ -2930,6 +3056,7 @@ int cmd_record(int argc, const char **argv)
>>  	symbol__exit();
>>  	auxtrace_record__free(rec->itr);
>>  out_opts:
>> +	record__fini_thread_masks(rec);
>>  	evlist__close_control(rec->opts.ctl_fd, rec->opts.ctl_fd_ack, &rec->opts.ctl_fd_close);
>>  	return err;
>>  }
>> -- 
>> 2.19.0
>>
> 
