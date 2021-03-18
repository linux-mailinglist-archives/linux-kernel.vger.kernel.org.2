Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74A3B34063D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 14:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbhCRNCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 09:02:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41481 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231355AbhCRNCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 09:02:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616072525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qDoOWIN6gx2DNPr/Z3gso012xR/6fSuWK44xws66A/E=;
        b=bqegtN8SRwSrDIUpjgEwRpr/btNEfU8Bkdcj3L+zmXr8V5PkZrBEvIp/hpgw4RqhP06NgL
        eMEAzgP1Lb/6oI2KD/bM2AiejIpNa8WonbOqjQ3dFXGPV4Rmd/NEkrOhACp1y6Hvdxu81u
        JJeUPVmmbaZJq0M36NusBd+APo8WcxU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-wxrUdHwcO3yR37F7hdkflg-1; Thu, 18 Mar 2021 09:02:01 -0400
X-MC-Unique: wxrUdHwcO3yR37F7hdkflg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 385D51009456;
        Thu, 18 Mar 2021 13:01:59 +0000 (UTC)
Received: from krava (unknown [10.40.194.6])
        by smtp.corp.redhat.com (Postfix) with SMTP id 28FC96064B;
        Thu, 18 Mar 2021 13:01:49 +0000 (UTC)
Date:   Thu, 18 Mar 2021 14:01:49 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2 1/3] perf test: Remove unused argument
Message-ID: <YFNPPUK9nE6khx9/@krava>
References: <20210317005505.2794804-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317005505.2794804-1-irogers@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 05:55:03PM -0700, Ian Rogers wrote:
> Remove unused argument from daemon_exit.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

for the patchset

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka


> ---
>  tools/perf/tests/shell/daemon.sh | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/daemon.sh b/tools/perf/tests/shell/daemon.sh
> index 5ad3ca8d681b..66ad56b4e0a5 100755
> --- a/tools/perf/tests/shell/daemon.sh
> +++ b/tools/perf/tests/shell/daemon.sh
> @@ -115,8 +115,7 @@ daemon_start()
>  
>  daemon_exit()
>  {
> -	local base=$1
> -	local config=$2
> +	local config=$1
>  
>  	local line=`perf daemon --config ${config} -x: | head -1`
>  	local pid=`echo "${line}" | awk 'BEGIN { FS = ":" } ; { print $1 }'`
> @@ -171,7 +170,7 @@ EOF
>  			 ${base}/session-time/ack "0"
>  
>  	# stop daemon
> -	daemon_exit ${base} ${config}
> +	daemon_exit ${config}
>  
>  	rm -rf ${base}
>  	rm -f ${config}
> @@ -288,7 +287,7 @@ EOF
>  	done
>  
>  	# stop daemon
> -	daemon_exit ${base} ${config}
> +	daemon_exit ${config}
>  
>  	rm -rf ${base}
>  	rm -f ${config}
> @@ -333,7 +332,7 @@ EOF
>  	fi
>  
>  	# stop daemon
> -	daemon_exit ${base} ${config}
> +	daemon_exit ${config}
>  
>  	# check that sessions are gone
>  	if [ -d "/proc/${pid_size}" ]; then
> @@ -374,7 +373,7 @@ EOF
>  	perf daemon signal --config ${config}
>  
>  	# stop daemon
> -	daemon_exit ${base} ${config}
> +	daemon_exit ${config}
>  
>  	# count is 2 perf.data for signals and 1 for perf record finished
>  	count=`ls ${base}/session-test/ | grep perf.data | wc -l`
> @@ -420,7 +419,7 @@ EOF
>  	fi
>  
>  	# stop daemon
> -	daemon_exit ${base} ${config}
> +	daemon_exit ${config}
>  
>  	rm -rf ${base}
>  	rm -f ${config}
> @@ -457,7 +456,7 @@ EOF
>  	fi
>  
>  	# stop daemon
> -	daemon_exit ${base} ${config}
> +	daemon_exit ${config}
>  
>  	rm -rf ${base}
>  	rm -f ${config}
> -- 
> 2.31.0.rc2.261.g7f71774620-goog
> 

