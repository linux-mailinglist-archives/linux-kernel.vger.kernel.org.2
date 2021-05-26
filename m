Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C83139172A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 14:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234675AbhEZMPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 08:15:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23443 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233710AbhEZMPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 08:15:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622031230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qNoFfELvFXOBowDpVqibU/BlprkUeXr57Mpcat9u3YU=;
        b=F5/XpDsgahmNcD5P77LvPGBrW1zHkWz4mNsxqvW2fxhB4uKLOyhAiGB1QFNyhHfRUeiCb7
        +M+vDFodF0HlxiAt2WrKjlyxeQ2BBjgb26qd6wVXNZ1nP9IfxF20DdDGb2afdVXNgnrPNB
        WmeytgVO6t7nU77vFpROmygQjPZ+A+4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-SdqgycL_Mj2z5qvUf15kRw-1; Wed, 26 May 2021 08:13:48 -0400
X-MC-Unique: SdqgycL_Mj2z5qvUf15kRw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8629A1854E4B;
        Wed, 26 May 2021 12:13:46 +0000 (UTC)
Received: from krava (unknown [10.40.195.164])
        by smtp.corp.redhat.com (Postfix) with SMTP id 93EBB5D9D3;
        Wed, 26 May 2021 12:13:44 +0000 (UTC)
Date:   Wed, 26 May 2021 14:13:43 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 1/2] perf inject: Call dso__put() even if dso->hit is set
Message-ID: <YK47d3S4wGIr3lu6@krava>
References: <20210524225051.1190486-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210524225051.1190486-1-namhyung@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 03:50:50PM -0700, Namhyung Kim wrote:
> Otherwise it'll leak the refcount for the DSO.  As dso__put() can
> handle a NULL dso pointer, we can just call it unconditionally.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

for the patchset

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/builtin-inject.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index 102cafb0c0b3..8bbaa46eb7e6 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -383,8 +383,8 @@ static int perf_event__repipe_buildid_mmap(struct perf_tool *tool,
>  	if (dso && !dso->hit) {
>  		dso->hit = 1;
>  		dso__inject_build_id(dso, tool, machine, sample->cpumode, 0);
> -		dso__put(dso);
>  	}
> +	dso__put(dso);
>  
>  	return perf_event__repipe(tool, event, sample, machine);
>  }
> @@ -447,8 +447,8 @@ static int perf_event__repipe_buildid_mmap2(struct perf_tool *tool,
>  		dso->hit = 1;
>  		dso__inject_build_id(dso, tool, machine, sample->cpumode,
>  				     event->mmap2.flags);
> -		dso__put(dso);
>  	}
> +	dso__put(dso);
>  
>  	perf_event__repipe(tool, event, sample, machine);
>  
> -- 
> 2.31.1.818.g46aad6cb9e-goog
> 

