Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3095306703
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 23:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236373AbhA0WKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 17:10:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58781 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232441AbhA0WKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 17:10:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611785316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NPsnQPcDz4JrkftzsarohHJ4hyCPuT0u/xmizDUk3Fw=;
        b=EoTF9f5Fv7Ouib9sXLwBP0qZB5qKZrrZEqODQQyz24pAj1c3ECFug6V3OGNor0NF1Kx064
        QoizFHBml8trx+QFdCVlKV48TgIv0wMVGPV7yMZGrlIyoVoi40Iate4C9t6FqAY8Ww4na1
        HOCeQll+/PWPHGxetXznljK8wdkRA7w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-MCM-9g0mM1i_PILTTD8LQA-1; Wed, 27 Jan 2021 17:08:32 -0500
X-MC-Unique: MCM-9g0mM1i_PILTTD8LQA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E0E71936B61;
        Wed, 27 Jan 2021 22:08:30 +0000 (UTC)
Received: from krava (unknown [10.40.193.8])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3B13460BE5;
        Wed, 27 Jan 2021 22:08:28 +0000 (UTC)
Date:   Wed, 27 Jan 2021 23:08:27 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com, ying.huang@intel.com
Subject: Re: [PATCH v8] perf stat: Fix wrong skipping for per-die aggregation
Message-ID: <20210127220827.GB284633@krava>
References: <20210125233525.13706-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210125233525.13706-1-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 07:35:25AM +0800, Jin Yao wrote:

SNIP

> ---
> v8:
>  Jiri contributes idea and code to allocate 'uint64_t' type hash key for better
>  supporting for 64 bits platform and 32 bits platform. I merge Jiri's code in this
>  patch. Thanks Jiri!
> 
>  Rebase the patch to latest perf/core branch.
> 
> v7:
>  It reported build error on 32-bit system (such as cross build by mipsel-linux-gnu-gcc).
> 
>  In v7,
>  1. Use size_t to replace uint64_t.
>  2. The hash key is changed from 'die_id << 32 | socket_id' to 'die_id << 16 | socket_id',
>     16 bits is enough for socket id , right?
> 
> v6:
>  Fix the perf test python failure by adding hashmap.c to python-ext-sources.
> 
>  root@kbl-ppc:~# ./perf test python
>  19: 'import perf' in python                                         : Ok
> 
> v5:
>  Hash key is changed to die_id << 32 | socket.
>  In pkg_id_hash, return (int64_t)key & 0xffffffff; actually it's socket.
> 
> v4:
>  v3 used unnecessary bool allocatioin. v4 just uses the hash value '(void *)1'.
> 
>  v4 is compiled ok with tmp.perf/core.
> 
> v3:
>  Since for some cpumap functions, the return type is changed from 'int' to
>  'struct aggr_cpu_id', the patch needs to be updated as well.
> 
>  before:
>    d = cpu_map__get_die()
> 
>  after:
>    d = cpu_map__get_die().die
> 
>  v3 is compiled ok with tmp.perf/core.
> 
> v2:
>  Use hashmap to check the used socket+die pair.
>   
>  tools/perf/util/evsel.c            |  4 ++-
>  tools/perf/util/evsel.h            |  3 +-
>  tools/perf/util/python-ext-sources |  1 +
>  tools/perf/util/stat.c             | 56 ++++++++++++++++++++++++++----
>  4 files changed, 55 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 8b18ec56e266..ee9453fb379b 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -46,6 +46,7 @@
>  #include "string2.h"
>  #include "memswap.h"
>  #include "util.h"
> +#include "hashmap.h"
>  #include "../perf-sys.h"
>  #include "util/parse-branch-options.h"
>  #include <internal/xyarray.h>
> @@ -1385,7 +1386,8 @@ void evsel__exit(struct evsel *evsel)
>  	zfree(&evsel->group_name);
>  	zfree(&evsel->name);
>  	zfree(&evsel->pmu_name);
> -	zfree(&evsel->per_pkg_mask);

sorry I did not notice before, but I think we need to call
zero_per_pkg in here, otherwise we're leaking keys

jirka

> +	hashmap__free(evsel->per_pkg_mask);
> +	evsel->per_pkg_mask = NULL;
>  	zfree(&evsel->metric_events);
>  	perf_evsel__object.fini(evsel);
>  }
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index e25594494cf6..b413c3ff6fb5 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -19,6 +19,7 @@ struct perf_stat_evsel;
>  union perf_event;
>  struct bpf_counter_ops;
>  struct target;
> +struct hashmap;
>  
>  typedef int (evsel__sb_cb_t)(union perf_event *event, void *data);
>  
> @@ -112,7 +113,7 @@ struct evsel {
>  	bool			merged_stat;
>  	bool			reset_group;
>  	bool			errored;
> -	unsigned long		*per_pkg_mask;
> +	struct hashmap		*per_pkg_mask;
>  	struct evsel		*leader;
>  	struct list_head	config_terms;
>  	int			err;
> diff --git a/tools/perf/util/python-ext-sources b/tools/perf/util/python-ext-sources
> index 71b753523fac..845dd46e3c61 100644
> --- a/tools/perf/util/python-ext-sources
> +++ b/tools/perf/util/python-ext-sources
> @@ -36,3 +36,4 @@ util/symbol_fprintf.c
>  util/units.c
>  util/affinity.c
>  util/rwsem.c
> +util/hashmap.c
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index 0b3957323f66..0dc78954c335 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -13,6 +13,7 @@
>  #include "evlist.h"
>  #include "evsel.h"
>  #include "thread_map.h"
> +#include "hashmap.h"
>  #include <linux/zalloc.h>
>  
>  void update_stats(struct stats *stats, u64 val)
> @@ -275,16 +276,40 @@ void evlist__save_aggr_prev_raw_counts(struct evlist *evlist)
>  
>  static void zero_per_pkg(struct evsel *counter)
>  {
> -	if (counter->per_pkg_mask)
> -		memset(counter->per_pkg_mask, 0, cpu__max_cpu());
> +	struct hashmap_entry *cur;
> +	size_t bkt;
> +
> +	if (counter->per_pkg_mask) {
> +		hashmap__for_each_entry(counter->per_pkg_mask, cur, bkt)
> +			free((char *)cur->key);
> +
> +		hashmap__clear(counter->per_pkg_mask);
> +	}
> +}
> +
> +static size_t pkg_id_hash(const void *__key, void *ctx __maybe_unused)
> +{
> +	uint64_t *key = (uint64_t *) __key;
> +
> +	return *key & 0xffffffff;
> +}
> +
> +static bool pkg_id_equal(const void *__key1, const void *__key2,
> +			 void *ctx __maybe_unused)
> +{
> +	uint64_t *key1 = (uint64_t *) __key1;
> +	uint64_t *key2 = (uint64_t *) __key2;
> +
> +	return *key1 == *key2;
>  }
>  
>  static int check_per_pkg(struct evsel *counter,
>  			 struct perf_counts_values *vals, int cpu, bool *skip)
>  {
> -	unsigned long *mask = counter->per_pkg_mask;
> +	struct hashmap *mask = counter->per_pkg_mask;
>  	struct perf_cpu_map *cpus = evsel__cpus(counter);
> -	int s;
> +	int s, d, ret = 0;
> +	uint64_t *key;
>  
>  	*skip = false;
>  
> @@ -295,7 +320,7 @@ static int check_per_pkg(struct evsel *counter,
>  		return 0;
>  
>  	if (!mask) {
> -		mask = zalloc(cpu__max_cpu());
> +		mask = hashmap__new(pkg_id_hash, pkg_id_equal, NULL);
>  		if (!mask)
>  			return -ENOMEM;
>  
> @@ -317,8 +342,25 @@ static int check_per_pkg(struct evsel *counter,
>  	if (s < 0)
>  		return -1;
>  
> -	*skip = test_and_set_bit(s, mask) == 1;
> -	return 0;
> +	/*
> +	 * On multi-die system, die_id > 0. On no-die system, die_id = 0.
> +	 * We use hashmap(socket, die) to check the used socket+die pair.
> +	 */
> +	d = cpu_map__get_die(cpus, cpu, NULL).die;
> +	if (d < 0)
> +		return -1;
> +
> +	key = malloc(sizeof(*key));
> +	if (!key)
> +		return -ENOMEM;
> +
> +	*key = (uint64_t)d << 32 | s;
> +	if (hashmap__find(mask, (void *)key, NULL))
> +		*skip = true;
> +	else
> +		ret = hashmap__add(mask, (void *)key, (void *)1);
> +
> +	return ret;
>  }
>  
>  static int
> -- 
> 2.17.1
> 

