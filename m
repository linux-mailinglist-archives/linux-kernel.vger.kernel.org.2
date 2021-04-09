Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C79DE35A043
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 15:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbhDINsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 09:48:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46509 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231599AbhDINsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 09:48:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617976108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M8mM7RH8q/Gpk8tLBuAz+NB417KqeRzjRI1pq1qeHos=;
        b=dvzrN4rmoEjvsWRunQKcBXOqGXmWpcr31XUAZSPFN3Omk5610udXPeec1r2oKxGz+O3gTp
        omvGv1/sPwccn/xd4hzmIoKM9H7ZiKEejy4+g2u1jgAHW9wamSaUiOcgv3Kv26acJSvrFv
        O6xIcuit/cPasuS7xTiKTsQ19DheFik=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-uWWVwgWWOJWc_lAkc0uVmA-1; Fri, 09 Apr 2021 09:48:24 -0400
X-MC-Unique: uWWVwgWWOJWc_lAkc0uVmA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C491107ACC7;
        Fri,  9 Apr 2021 13:48:23 +0000 (UTC)
Received: from krava (unknown [10.40.195.216])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2322D60BE5;
        Fri,  9 Apr 2021 13:48:20 +0000 (UTC)
Date:   Fri, 9 Apr 2021 15:48:20 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v3 11/27] perf pmu: Support 'cycles' and 'branches'
 inside hybrid PMU
Message-ID: <YHBbJEKjE3DuPvZZ@krava>
References: <20210329070046.8815-1-yao.jin@linux.intel.com>
 <20210329070046.8815-12-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329070046.8815-12-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 03:00:30PM +0800, Jin Yao wrote:
> On hybrid platform, user may want to enable the hardware event
> only on one PMU. So following syntax is supported:
> 
> cpu_core/<hardware event>/
> cpu_atom/<hardware event>/
> 
>   # perf stat -e cpu_core/cpu-cycles/ -a -- sleep 1
> 
>    Performance counter stats for 'system wide':
> 
>            6,049,336      cpu_core/cpu-cycles/
> 
>          1.003577042 seconds time elapsed
> 
> It enables the event 'cpu-cycles' only on cpu_core pmu.
> 
> But for 'cycles' and 'branches', the syntax doesn't work.

because the alias is not there.. but there's:
  cpu/cpu-cycles/
  cpu/branch-instructions/

doing the same thing..  what's wrong with that?

I have a feeling we discussed this in the previous
version.. did I give up? ;-)

SNIP

> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index beff29981101..72e5ae5e868e 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -916,6 +916,35 @@ static int pmu_max_precise(const char *name)
>  	return max_precise;
>  }
>  
> +static void perf_pmu__add_hybrid_aliases(struct list_head *head)
> +{
> +	static struct pmu_event pme_hybrid_fixup[] = {
> +		{
> +			.name = "cycles",
> +			.event = "event=0x3c",
> +		},
> +		{
> +			.name = "branches",
> +			.event = "event=0xc4",
> +		},
> +		{
> +			.name = 0,
> +			.event = 0,
> +		},

if you really need to access these 2 events with special name,
why not add it through the json.. let's not have yet another
place that defines aliases ... also this should be model specific
no?

jirka

