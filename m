Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E1C38F22E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 19:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbhEXRVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 13:21:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46493 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233218AbhEXRVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 13:21:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621876811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UzCZytVjnX8P30k0RWzX+SdhBSGT32a9c2DZNLMU4ZE=;
        b=F5RCGhQ4+ECa/dZZfIfZYuJO5lTDgSY6pII/WalCgC3aiaHQyP/3g0kdVe7phhaGBEwbXv
        HKuZFeGDDF6V/p6GBwSqfRZrb0TmddFGLSf0K+1tChyQ0V6tH9RqI87cBqer8ZyY0296O3
        UDTWmDXHaECMtXM9DCtbGq/vlz62Ku4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-0Z7nSFUyMkeTx6JZ3RfWfw-1; Mon, 24 May 2021 13:20:10 -0400
X-MC-Unique: 0Z7nSFUyMkeTx6JZ3RfWfw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91FF6501ED;
        Mon, 24 May 2021 17:20:08 +0000 (UTC)
Received: from krava (unknown [10.40.195.130])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3D9F9F6CD;
        Mon, 24 May 2021 17:20:03 +0000 (UTC)
Date:   Mon, 24 May 2021 19:20:02 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v1 2/5] perf tools: Support pmu name in
 perf_mem_events__name
Message-ID: <YKvgQiJrrn/1Rh23@krava>
References: <20210520070040.710-1-yao.jin@linux.intel.com>
 <20210520070040.710-3-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520070040.710-3-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 03:00:37PM +0800, Jin Yao wrote:

SNIP

> --- a/tools/perf/arch/x86/util/mem-events.c
> +++ b/tools/perf/arch/x86/util/mem-events.c
> @@ -4,10 +4,10 @@
>  #include "mem-events.h"
>  
>  static char mem_loads_name[100];
> -static bool mem_loads_name__init;
> +static char mem_stores_name[100];
>  
>  #define MEM_LOADS_AUX		0x8203
> -#define MEM_LOADS_AUX_NAME	"{cpu/mem-loads-aux/,cpu/mem-loads,ldlat=%u/pp}:S"
> +#define MEM_LOADS_AUX_NAME     "{%s/mem-loads-aux/,%s/mem-loads,ldlat=%u/}:P"
>  
>  bool is_mem_loads_aux_event(struct evsel *leader)
>  {
> @@ -22,28 +22,34 @@ bool is_mem_loads_aux_event(struct evsel *leader)
>  	return leader->core.attr.config == MEM_LOADS_AUX;
>  }
>  
> -char *perf_mem_events__name(int i)
> +char *perf_mem_events__name(int i, char *pmu_name)
>  {
>  	struct perf_mem_event *e = perf_mem_events__ptr(i);
>  
>  	if (!e)
>  		return NULL;
>  
> -	if (i == PERF_MEM_EVENTS__LOAD) {
> -		if (mem_loads_name__init)
> -			return mem_loads_name;
> -
> -		mem_loads_name__init = true;
> +	if (!pmu_name)
> +		pmu_name = (char *)"cpu";
>  
> -		if (pmu_have_event("cpu", "mem-loads-aux")) {
> +	if (i == PERF_MEM_EVENTS__LOAD) {
> +		if (pmu_have_event(pmu_name, "mem-loads-aux")) {
>  			scnprintf(mem_loads_name, sizeof(mem_loads_name),
> -				  MEM_LOADS_AUX_NAME, perf_mem_events__loads_ldlat);
> +				  MEM_LOADS_AUX_NAME, pmu_name, pmu_name,
> +				  perf_mem_events__loads_ldlat);
>  		} else {
>  			scnprintf(mem_loads_name, sizeof(mem_loads_name),
> -				  e->name, perf_mem_events__loads_ldlat);
> +				  e->name, pmu_name,
> +				  perf_mem_events__loads_ldlat);
>  		}
>  		return mem_loads_name;
>  	}
>  
> +	if (i == PERF_MEM_EVENTS__STORE) {
> +		scnprintf(mem_stores_name, sizeof(mem_stores_name),
> +			  e->name, pmu_name);
> +		return mem_stores_name;
> +	}

so the patch also adds mem_stores_name and removes mem_loads_name__init,
that should be explained or more likely in separated patches

jirka

