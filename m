Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6097F3969BE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 00:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbhEaWoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 18:44:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46476 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232042AbhEaWoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 18:44:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622500955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G+kDTgSvRHq3E2PGkOkEIjQiAMuybgsbAjg536oUW1k=;
        b=Is0WIbTee/lvV0FyChYfpN+OiFCDe9I/b1F5eQ/rT5REYBHsK/XysKNXnU+/xNtUeCCNAv
        hemvA1t5Rf4vG7UFjsd6YheEwBm+TTgntF+mHIIj56fRyO03FWab0ze1V+kaMwGa25U6S9
        eWREFGbvPgUqjMwd5j3bGf3BdJbh+vI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-23bn5w_qMPeyIzYVdcXwWg-1; Mon, 31 May 2021 18:42:34 -0400
X-MC-Unique: 23bn5w_qMPeyIzYVdcXwWg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91458180FD64;
        Mon, 31 May 2021 22:42:32 +0000 (UTC)
Received: from krava (unknown [10.40.195.234])
        by smtp.corp.redhat.com (Postfix) with SMTP id 350D15D6D5;
        Mon, 31 May 2021 22:42:29 +0000 (UTC)
Date:   Tue, 1 Jun 2021 00:42:28 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2 6/8] perf mem: Fix wrong verbose output for recording
 events
Message-ID: <YLVmVBDKGkSWgHwR@krava>
References: <20210527001610.10553-1-yao.jin@linux.intel.com>
 <20210527001610.10553-7-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527001610.10553-7-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 08:16:08AM +0800, Jin Yao wrote:
> Current code:
> 
> for (j = 0; j < argc; j++, i++)
>         rec_argv[i] = argv[j];
> 
> if (verbose > 0) {
>         pr_debug("calling: record ");
> 
>         while (rec_argv[j]) {
>                 pr_debug("%s ", rec_argv[j]);
>                 j++;
>         }
>         pr_debug("\n");
> }
> 
> The entries of argv[] are copied to the end of rec_argv[], not
> copied to the beginning of rec_argv[]. So the index j at
> rec_argv[] doesn't point to the first event.
> 
> Now we record the start index and end index for events in rec_argv[],
> and print them if verbose is enabled.
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
> v2:
>  - New in v2.
> 
>  tools/perf/builtin-mem.c | 8 +++++---

hi,
do we need the same in c2c as well?

jirka

>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
> index 6b633df458c2..0fd2a74dbaca 100644
> --- a/tools/perf/builtin-mem.c
> +++ b/tools/perf/builtin-mem.c
> @@ -65,6 +65,7 @@ static const char * const *record_mem_usage = __usage;
>  static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
>  {
>  	int rec_argc, i = 0, j, tmp_nr = 0;
> +	int start, end;
>  	const char **rec_argv;
>  	char **rec_tmp;
>  	int ret;
> @@ -144,9 +145,11 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
>  	if (mem->data_page_size)
>  		rec_argv[i++] = "--data-page-size";
>  
> +	start = i;
>  	ret = perf_mem_events__record_args(rec_argv, &i, rec_tmp, &tmp_nr);
>  	if (ret)
>  		goto out;
> +	end = i;
>  
>  	if (all_user)
>  		rec_argv[i++] = "--all-user";
> @@ -160,10 +163,9 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
>  	if (verbose > 0) {
>  		pr_debug("calling: record ");
>  
> -		while (rec_argv[j]) {
> +		for (j = start; j < end; j++)
>  			pr_debug("%s ", rec_argv[j]);
> -			j++;
> -		}
> +
>  		pr_debug("\n");
>  	}
>  
> -- 
> 2.17.1
> 

