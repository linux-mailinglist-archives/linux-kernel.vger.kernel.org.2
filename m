Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B8C3CADCC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 22:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237971AbhGOUYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 16:24:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:56198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235437AbhGOUYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 16:24:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F1E67613D3;
        Thu, 15 Jul 2021 20:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626380503;
        bh=SYaLs1ohm9nYnP1HBgtNYafbqW6mrbrRwfra8T6TbfI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ibnLHtpbPDis+sYzL9JoCTBT3yU1Rdg7/gNT4rGTDwOW0p3vyxjfRMnXtJ+1xU9qp
         MIOYtQnNgYc34pAH6C3n96kc3kKfP5ZBWGbP3JVUzZeJ19LKZsovxRtdRTCUYl4oTp
         2T12IksbcNQ34MMr5yz8UqUxIOpJCeimh0Lmgx+KVoNuf8ROjhOb6SKTROcX3ykl1/
         WwpT0WuIN+iCQ+b71ROfcxiMWklh1HT8Fqq1b/NsEfYSfmLQuyJu6lKibQgnU+UmWL
         3p/Mo6pZpjLiWriba2UEnrltPJuhOcKsda7IIgSGnizWEFFGoKQQUwDrRjO7kOyeY3
         rfX3xa6+boFMg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9D3FB403F2; Thu, 15 Jul 2021 17:21:40 -0300 (-03)
Date:   Thu, 15 Jul 2021 17:21:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 11/20] perf session: cleanup trace_event
Message-ID: <YPCY1F/2vu32kYwE@kernel.org>
References: <cover.1626343282.git.rickyman7@gmail.com>
 <fa2a3f221d90e47ce4e5b7e2d6e64c3509ddc96a.1626343282.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa2a3f221d90e47ce4e5b7e2d6e64c3509ddc96a.1626343282.git.rickyman7@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jul 15, 2021 at 06:07:16PM +0200, Riccardo Mancini escreveu:
> ASan reports several memory leaks when running the perf test
> "82: Use vfs_getname probe to get syscall args filenames", many of which
> are related to session->tevent.
> This patch will solve this problem, then next patch will fix the remaining
> memory leaks in perf-script.
> This bug is due to a missing deallocation of the trace_event data
> strutures.
> 
> This patch adds the missing trace_event__cleanup in
> perf_session__delete.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> ---
>  tools/perf/util/session.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index e9c929a39973ace9..51f72740291267c5 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -306,6 +306,7 @@ void perf_session__delete(struct perf_session *session)
>  			evlist__delete(session->evlist);
>  		perf_data__close(session->data);
>  	}
> +	trace_event__cleanup(&session->tevent);
>  	free(session);
>  }
>  
> -- 
> 2.31.1
> 

-- 

- Arnaldo
