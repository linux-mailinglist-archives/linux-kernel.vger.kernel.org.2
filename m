Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A693804F1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 10:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbhENIRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 04:17:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33362 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229654AbhENIRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 04:17:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620980185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=stz2FlrrbVRueZmGLigfweSMJBvWFuUwkpvytAfGa/w=;
        b=B27ZhwMt3KUBKfUMRzaLlGX7MdTyK1LhjAAeWSjn9wY2AddlYUFPwrrBvm3FMFkobvIVlk
        SN3v2unLxkKT5g91iPRWkTMt4pM26nT31ltOmObbvhJGz8/t+T2iw/rwZeAzjjeAUOmKJf
        8+wm/tiyu9VuadmxVqznZc7WHc3uRRM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-567-6Wqg9IEhMcO1ul08qEOOog-1; Fri, 14 May 2021 04:16:23 -0400
X-MC-Unique: 6Wqg9IEhMcO1ul08qEOOog-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0455A1883527;
        Fri, 14 May 2021 08:16:22 +0000 (UTC)
Received: from krava (unknown [10.40.193.71])
        by smtp.corp.redhat.com (Postfix) with SMTP id B88E867895;
        Fri, 14 May 2021 08:16:19 +0000 (UTC)
Date:   Fri, 14 May 2021 10:16:18 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v3 2/2] perf header: Support HYBRID_CPU_PMU_CAPS feature
Message-ID: <YJ4x0usa1ljPT5DV@krava>
References: <20210511053003.27015-1-yao.jin@linux.intel.com>
 <20210511053003.27015-3-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511053003.27015-3-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 01:30:03PM +0800, Jin Yao wrote:

SNIP

> diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
> index fbee9e580ee4..e6ff8c898ada 100644
> --- a/tools/perf/Documentation/perf.data-file-format.txt
> +++ b/tools/perf/Documentation/perf.data-file-format.txt
> @@ -419,6 +419,22 @@ Example:
>    cpu_core cpu list : 0-15
>    cpu_atom cpu list : 16-23
>  
> +	HEADER_HYBRID_CPU_PMU_CAPS = 31,
> +
> +	A list of hybrid CPU PMU capabilities.
> +
> +struct {
> +	u32 nr_pmu;
> +	struct {
> +		u32 nr_cpu_pmu_caps;
> +		{
> +			char	name[];
> +			char	value[];
> +		} [nr_cpu_pmu_caps];
> +		char pmu_name[];
> +	} [nr_pmu];
> +};

when I saw it's similar to the previous one I thought we could have
one big hybrid feature.. but that would be probably more complex and
we might not be able to reuse the code as much as you did


>  free_value:
> @@ -3142,6 +3208,64 @@ static int process_cpu_pmu_caps(struct feat_fd *ff,
>  	return -1;
>  }
>  
> +static int process_cpu_pmu_caps(struct feat_fd *ff,
> +				void *data __maybe_unused)
> +{
> +	int ret;
> +
> +	ret = process_per_cpu_pmu_caps(ff, &ff->ph->env.nr_cpu_pmu_caps,
> +				       &ff->ph->env.cpu_pmu_caps,
> +				       &ff->ph->env.max_branches);
> +	return ret;

why the 'ret' var? could be just:

   return process_per_cpu_pmu_caps(...

> +}
> +
> +static int process_hybrid_cpu_pmu_caps(struct feat_fd *ff,
> +				       void *data __maybe_unused)
> +{
> +	struct hybrid_cpc_node *nodes;
> +	u32 nr_pmu, i;
> +	int ret;
> +
> +	if (do_read_u32(ff, &nr_pmu))
> +		return -1;
> +
> +	if (!nr_pmu) {
> +		pr_debug("hybrid cpu pmu capabilities not available\n");
> +		return 0;
> +	}
> +
> +	nodes = zalloc(sizeof(*nodes) * nr_pmu);
> +	if (!nodes)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < nr_pmu; i++) {
> +		struct hybrid_cpc_node *n = &nodes[i];
> +
> +		ret = process_per_cpu_pmu_caps(ff, &n->nr_cpu_pmu_caps,
> +					       &n->cpu_pmu_caps,
> +					       &n->max_branches);
> +		if (ret)
> +			goto err;
> +
> +		n->pmu_name = do_read_string(ff);
> +		if (!n->pmu_name)

should you set 'ret = -1' in here?

other than this both patches look good to me

thanks,
jirka

> +			goto err;
> +	}
> +
> +	ff->ph->env.nr_hybrid_cpc_nodes = nr_pmu;
> +	ff->ph->env.hybrid_cpc_nodes = nodes;
> +	return 0;
> +
> +err:
> +	for (i = 0; i < nr_pmu; i++) {
> +		free(nodes[i].cpu_pmu_caps);

SNIP

