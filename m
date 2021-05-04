Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACF9B372C91
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 16:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbhEDOzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 10:55:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22419 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230509AbhEDOzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 10:55:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620140051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aSb+CQGGaww4bxaTsR1HouptUaF0ugOygHnwruCt1Aw=;
        b=i0A1/vJG7+BQAycaKgCQ1SAtlW7snHx8gkKqYSWyZ4b14eZ3cWBXTgiYdoJfHUfqI66JWJ
        ADLiYOb6sYmmCpSxr2tcxsQMjl45ly2Mdt18l4xqgkTbReWpFyqEQgJnLU4mhIh/AJI5vh
        p5xNE7SvFGaiOv9H+/3RLMVS6OfIyaA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-M4sEFoJ9NhKEYq6XHC244w-1; Tue, 04 May 2021 10:54:08 -0400
X-MC-Unique: M4sEFoJ9NhKEYq6XHC244w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8B66107ACED;
        Tue,  4 May 2021 14:54:06 +0000 (UTC)
Received: from krava (unknown [10.40.192.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id D0126100EBAD;
        Tue,  4 May 2021 14:54:04 +0000 (UTC)
Date:   Tue, 4 May 2021 16:54:03 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v1 1/2] perf header: Support HYBRID_TOPOLOGY feature
Message-ID: <YJFgC9tS9m9/DJP8@krava>
References: <20210430074602.3028-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210430074602.3028-1-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 03:46:01PM +0800, Jin Yao wrote:

SNIP

> +static int write_hybrid_topology(struct feat_fd *ff,
> +				 struct evlist *evlist __maybe_unused)
> +{
> +	struct hybrid_topology *tp;
> +	int ret;
> +	u32 i;
> +
> +	tp = hybrid_topology__new();
> +	if (!tp)
> +		return -1;
> +
> +	ret = do_write(ff, &tp->nr, sizeof(u32));
> +	if (ret < 0)
> +		goto err;
> +
> +	for (i = 0; i < tp->nr; i++) {
> +		struct hybrid_topology_node *n = &tp->nodes[i];
> +
> +		ret = do_write_string(ff, n->pmu_name);
> +		if (ret < 0)
> +			goto err;
> +
> +		ret = do_write_string(ff, n->cpus);
> +		if (ret < 0)
> +			goto err;
> +	}
> +
> +	ret = 0;
> +
> +err:
> +	hybrid_topology__delete(tp);
> +	return ret;
> +}
> +
>  static int write_dir_format(struct feat_fd *ff,
>  			    struct evlist *evlist __maybe_unused)
>  {
> @@ -1623,6 +1657,19 @@ static void print_clock_data(struct feat_fd *ff, FILE *fp)
>  		    clockid_name(clockid));
>  }
>  
> +static void print_hybrid_topology(struct feat_fd *ff, FILE *fp)
> +{
> +	int i;
> +	struct hybrid_node *n;
> +
> +	for (i = 0; i < ff->ph->env.nr_hybrid_nodes; i++) {
> +		n = &ff->ph->env.hybrid_nodes[i];
> +
> +		fprintf(fp, "# %s cpu list : ", n->pmu_name);
> +		cpu_map__fprintf(n->map, fp);

do you plan to do anything else with n->map in the future?
because right now you could just print the stored cpus string no?
it should be already in the cpumask shape

jirka

