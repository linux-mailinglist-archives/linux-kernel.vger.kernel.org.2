Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C597B33702C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 11:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbhCKKi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 05:38:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26533 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232356AbhCKKiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 05:38:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615459088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YYTXQgCPme1/BL+9bC3CrHlm0mxUxBHkGIFhq//cT6E=;
        b=BfY7DNlvddO7nd3O1tRPLHspoi1/Ak86rjtMpmn955iXp16JY7oXKo3fsM5vTVW+AZsbTS
        Yq1lA/fndqWZeOyk9OaGCXNmD5YfumB0Q81Y2mkBzM1zioPocqbFEGvLHUV5/7AOwHE04+
        FAOnFRxeuza7B5g+pyc3InYxoN+aB7M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-ZeubN09AN5mgAOTPeM5siw-1; Thu, 11 Mar 2021 05:38:05 -0500
X-MC-Unique: ZeubN09AN5mgAOTPeM5siw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE3CDCF986;
        Thu, 11 Mar 2021 10:38:03 +0000 (UTC)
Received: from krava (unknown [10.40.195.225])
        by smtp.corp.redhat.com (Postfix) with SMTP id 738B462467;
        Thu, 11 Mar 2021 10:38:01 +0000 (UTC)
Date:   Thu, 11 Mar 2021 11:38:00 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 1/3] perf test: Remove unused argument
Message-ID: <YEnzCEZFi6P30WcZ@krava>
References: <20210310204118.711514-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310204118.711514-1-irogers@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 12:41:16PM -0800, Ian Rogers wrote:
> Remove unused argument from daemon_exit.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

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
> 2.30.1.766.gb4fecdf3b7-goog
> 

