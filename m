Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEA531B95C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 13:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhBOMgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 07:36:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47305 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230026AbhBOMgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 07:36:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613392478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v3v4gzqGCLWwc72/ZmFhajN3/IbvocJsej92j7sOSm8=;
        b=QP5aOjWkSNWTidxuFGE8sIuwvQYbeu/MS+9nUxZyOQr7KazYJn6mL235KNY7RxNZW+tJ2s
        +eJENnOrM39qscoZtphKozmRyk7pBwhjYFLk2hdQBVE+T+87ceFpH+mlkmk8fp9u5womt0
        +wizO98x4DZcrOXbJKHSLgZQGuuS060=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-5cdKoN1WNhiffgIsjL3VVg-1; Mon, 15 Feb 2021 07:34:36 -0500
X-MC-Unique: 5cdKoN1WNhiffgIsjL3VVg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6798C1937FC0;
        Mon, 15 Feb 2021 12:34:34 +0000 (UTC)
Received: from krava (unknown [10.40.195.239])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7BD3B19CAB;
        Mon, 15 Feb 2021 12:34:31 +0000 (UTC)
Date:   Mon, 15 Feb 2021 13:34:30 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Shunsuke Nakamura <nakamura.shun@jp.fujitsu.com>
Cc:     john.garry@huawei.com, will@kernel.org, mathieu.poirier@linaro.org,
        leo.yan@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/3] perf tools: Add lexical definition of event name
Message-ID: <YCpqVuneU+wWtmMC@krava>
References: <20210212090318.1522292-1-nakamura.shun@jp.fujitsu.com>
 <20210212090318.1522292-3-nakamura.shun@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212090318.1522292-3-nakamura.shun@jp.fujitsu.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 06:03:17PM +0900, Shunsuke Nakamura wrote:
> Add the lexical definition of event name so that the numbers are recognizable.
> 
> A64FX defines an event name that starts with a number.
>  - 0inst_commit
>  - 1inst_commit
>  - 2inst_commit
>  - 3inst_commit
>  - 4inst_commit
> 
> Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
> ---
>  tools/perf/util/parse-events.l | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
> index 0b36285a9435..33f627187415 100644
> --- a/tools/perf/util/parse-events.l
> +++ b/tools/perf/util/parse-events.l
> @@ -205,7 +205,7 @@ bpf_source	[^,{}]+\.c[a-zA-Z0-9._]*
>  num_dec		[0-9]+
>  num_hex		0x[a-fA-F0-9]+
>  num_raw_hex	[a-fA-F0-9]+
> -name		[a-zA-Z_*?\[\]][a-zA-Z0-9_*?.\[\]]*
> +name		[a-zA-Z0-9_*?\[\]][a-zA-Z0-9_*?.\[\]]*

I can't see anything broken because of this change,
also numbers are defined few lines before so we should
be fine

but please add test for this to tests/parse-events.c,
if you could also add test for 'VALUE:VALUE' event,
that'd be fantastic ;-)

thanks,
jirka

>  name_tag	[\'][a-zA-Z_*?\[\]][a-zA-Z0-9_*?\-,\.\[\]:=]*[\']
>  name_minus	[a-zA-Z_*?][a-zA-Z0-9\-_*?.:]*
>  drv_cfg_term	[a-zA-Z0-9_\.]+(=[a-zA-Z0-9_*?\.:]+)?
> -- 
> 2.25.1
> 

