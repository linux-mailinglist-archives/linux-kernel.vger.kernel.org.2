Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 253D0360863
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 13:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbhDOLjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 07:39:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45946 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230190AbhDOLjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 07:39:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618486728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SsVIIWV579j9hdwgaxcglkKaYM/aPZcfKX84IROT46o=;
        b=DbyAVGzjh/WduJ36C2B3rHcrbqffGvPgCRKFsRXFsNHPqQJVuy2caI41c2xXYJ24ST9EiA
        I75NoAqFhky59+JFKb4un9ve8NAOgonpP1dWXgtRN/3JS9Lf41OQCBI/+WMAutcqM9AegY
        naq12xlpftguUN3zy0fXwUzMYJWbQ6Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-xose_pJEO9q26OZ_rRaCEw-1; Thu, 15 Apr 2021 07:38:44 -0400
X-MC-Unique: xose_pJEO9q26OZ_rRaCEw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 370CF8030B5;
        Thu, 15 Apr 2021 11:38:43 +0000 (UTC)
Received: from krava (unknown [10.40.196.6])
        by smtp.corp.redhat.com (Postfix) with SMTP id 879D819801;
        Thu, 15 Apr 2021 11:38:41 +0000 (UTC)
Date:   Thu, 15 Apr 2021 13:38:40 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] perf data: Fix error return code in
 perf_data__create_dir()
Message-ID: <YHglwGXW7IV4W6qV@krava>
References: <20210415083417.3740-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415083417.3740-1-thunder.leizhen@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 04:34:16PM +0800, Zhen Lei wrote:
> Although 'ret' has been initialized to -1, but it will be reassigned by
> the "ret = open(...)" statement in the for loop. So that, the value of
> 'ret' is unknown when asprintf() failed.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/util/data.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> index f29af4fc3d09390..8fca4779ae6a8e9 100644
> --- a/tools/perf/util/data.c
> +++ b/tools/perf/util/data.c
> @@ -35,7 +35,7 @@ void perf_data__close_dir(struct perf_data *data)
>  int perf_data__create_dir(struct perf_data *data, int nr)
>  {
>  	struct perf_data_file *files = NULL;
> -	int i, ret = -1;
> +	int i, ret;
>  
>  	if (WARN_ON(!data->is_dir))
>  		return -EINVAL;
> @@ -51,7 +51,8 @@ int perf_data__create_dir(struct perf_data *data, int nr)
>  	for (i = 0; i < nr; i++) {
>  		struct perf_data_file *file = &files[i];
>  
> -		if (asprintf(&file->path, "%s/data.%d", data->path, i) < 0)
> +		ret = asprintf(&file->path, "%s/data.%d", data->path, i);
> +		if (ret < 0)
>  			goto out_err;
>  
>  		ret = open(file->path, O_RDWR|O_CREAT|O_TRUNC, S_IRUSR|S_IWUSR);
> -- 
> 2.26.0.106.g9fadedd
> 
> 

