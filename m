Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E11BC39F49F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 13:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbhFHLJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 07:09:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24270 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231488AbhFHLJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 07:09:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623150450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C/2xphIxQp4/un0lu+bFhC87YLSeVemPdQfQPjhC7ag=;
        b=Bp7aniu8g9LLtP/OwpjtK+9cKyb7t53xoJUEChnA98zqbNuofS3YP6aSrleyA7O0P/yEcb
        bNE1yTQzhd05Mo/KYFTYia1euP/LTgGC1EoYApJvWJH3dfcqJDxL4PIt1163IS/Lp5xP98
        0uIrqqHq47wUL6gBfY6JU5uTr3SPXyk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-qEYoR3SQNWqy_jecAN9K9A-1; Tue, 08 Jun 2021 07:07:27 -0400
X-MC-Unique: qEYoR3SQNWqy_jecAN9K9A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DAD1F101371D;
        Tue,  8 Jun 2021 11:07:25 +0000 (UTC)
Received: from krava (unknown [10.40.195.112])
        by smtp.corp.redhat.com (Postfix) with SMTP id 91817620DE;
        Tue,  8 Jun 2021 11:07:23 +0000 (UTC)
Date:   Tue, 8 Jun 2021 13:07:22 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf session: Correct buffer copying when peek event
Message-ID: <YL9PatslajgTZpZM@krava>
References: <20210605052957.1070720-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210605052957.1070720-1-leo.yan@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 05, 2021 at 01:29:57PM +0800, Leo Yan wrote:
> When peek an event, it has a short path and a long path.  The short path
> uses the session pointer "one_mmap_addr" to directly fetch event; and
> the long path needs to read out the event header and the followed event
> data from file and fill into the buffer pointer passed through the
> argument "buf".
> 
> The issue is in the long path that it copies the event header and event
> data into the same destination address which pointer "buf", this means
> the event header is overwritten.  We are just lucky to run into the
> short path in most cases, so we don't hit the issue in the long path.
> 
> This patch adds the offset "hdr_sz" to the pointer "buf" when copying
> the event data, so that it can reserve the event header which can be
> used properly by its caller.
> 
> Fixes: 5a52f33adf02 ("perf session: Add perf_session__peek_event()")
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/session.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 106b3d60881a..e59242c361ce 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1723,6 +1723,7 @@ int perf_session__peek_event(struct perf_session *session, off_t file_offset,
>  	if (event->header.size < hdr_sz || event->header.size > buf_sz)
>  		return -1;
>  
> +	buf += hdr_sz;

nice ;-)

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

>  	rest = event->header.size - hdr_sz;
>  
>  	if (readn(fd, buf, rest) != (ssize_t)rest)
> -- 
> 2.25.1
> 

