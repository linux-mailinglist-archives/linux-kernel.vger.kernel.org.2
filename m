Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDAEF378E5C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 15:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238367AbhEJNPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 09:15:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32782 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351768AbhEJNND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 09:13:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620652318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BU9c48EzWCgdtReLzeaB/8ggIHyNTNlUbhBRF189oGw=;
        b=LYB365bTzYOBaTbZjwKFqTYLuobOUoBDf3FQYRDCC12QBOIkoxV5Yhr8W2lggo2FhEXuWK
        WtacfmHoa+lzQdb+L0E4Q5g84PjPiNepc896+7InBwGoncdNV5y6I9iBDn/YaFolgqi1KL
        ZrT7jTmBvwzIETPDlGJqgMsbu7Fv0Qg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-JmzA4M1zPqe3Nv9Z0_sWlA-1; Mon, 10 May 2021 09:11:57 -0400
X-MC-Unique: JmzA4M1zPqe3Nv9Z0_sWlA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A481E1922053;
        Mon, 10 May 2021 13:11:54 +0000 (UTC)
Received: from krava (unknown [10.40.194.219])
        by smtp.corp.redhat.com (Postfix) with SMTP id A784560FC2;
        Mon, 10 May 2021 13:11:52 +0000 (UTC)
Date:   Mon, 10 May 2021 15:11:51 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2 1/3] perf header: Support HYBRID_TOPOLOGY feature
Message-ID: <YJkxF8bycH8+w+N+@krava>
References: <20210507035230.3079-1-yao.jin@linux.intel.com>
 <20210507035230.3079-2-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210507035230.3079-2-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07, 2021 at 11:52:28AM +0800, Jin Yao wrote:
> It would be useful to let user know the hybrid topology.
> Adding HYBRID_TOPOLOGY feature in header to indicate the
> core cpus and the atom cpus.
> 
> With this patch,
> 
> For the perf.data generated on hybrid platform,
> reports the hybrid cpu list.
> 
>   root@otcpl-adl-s-2:~# perf report --header-only -I
>   ...
>   # hybrid cpu system:
>   # cpu_core cpu list : 0-15
>   # cpu_atom cpu list : 16-23
> 
> For the perf.data generated on non-hybrid platform,
> reports the message that HYBRID_TOPOLOGY is missing.
> 
>   root@kbl-ppc:~# perf report --header-only -I
>   ...
>   # missing features: TRACING_DATA BRANCH_STACK GROUP_DESC AUXTRACE STAT CLOCKID DIR_FORMAT COMPRESSED CLOCK_DATA HYBRID_TOPOLOGY
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  .../Documentation/perf.data-file-format.txt   | 14 +++
>  tools/perf/util/cputopo.c                     | 80 +++++++++++++++++
>  tools/perf/util/cputopo.h                     | 13 +++
>  tools/perf/util/env.c                         |  6 ++
>  tools/perf/util/env.h                         |  7 ++
>  tools/perf/util/header.c                      | 87 +++++++++++++++++++
>  tools/perf/util/header.h                      |  1 +
>  tools/perf/util/pmu-hybrid.h                  | 11 +++
>  8 files changed, 219 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
> index 9ee96640744e..d9d82ca8aeb7 100644
> --- a/tools/perf/Documentation/perf.data-file-format.txt
> +++ b/tools/perf/Documentation/perf.data-file-format.txt
> @@ -402,6 +402,20 @@ struct {
>  	u64 clockid_time_ns;
>  };
>  
> +	HEADER_HYBRID_TOPOLOGY = 30,
> +
> +Indicate the hybrid CPUs. The format of data is as below.
> +
> +struct {
> +	char *pmu_name;
> +	char *cpus;
> +};

this is missing the nr count, should be like:

struct {
	u32 nr;
	struct {
	     char *pmu_name;
	     char *cpus;
	} [nr]
}

jirka

