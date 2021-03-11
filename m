Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B76A33702A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 11:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbhCKKi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 05:38:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27942 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232329AbhCKKiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 05:38:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615459079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rRVaU2zLgTWOvguBK3VsEJIxTKsmS7ikYt0PG57dPxY=;
        b=NMJMkBBcK/Bhhshuu4rcJyB2lWCnKI/716kFww3osqqiGXgdxBCms4hN3pwwnhivemrjiX
        GxCyYhOp/gUs0XxqiQ68qjSF0oYmxtX5EUSQ1OH9wLtYyqsMk4TGTACEzu0tYO947tnndN
        /VfJjvsG4Zl2X/LgVI3Cn7r+rfUNHa0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-C8HvfI1_P-eRjArXte_Zig-1; Thu, 11 Mar 2021 05:37:57 -0500
X-MC-Unique: C8HvfI1_P-eRjArXte_Zig-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6D0380432E;
        Thu, 11 Mar 2021 10:37:55 +0000 (UTC)
Received: from krava (unknown [10.40.195.225])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8FA5B10023AB;
        Thu, 11 Mar 2021 10:37:53 +0000 (UTC)
Date:   Thu, 11 Mar 2021 11:37:52 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 2/3] perf test: Cleanup daemon if test is interrupted.
Message-ID: <YEnzAK01qD1+3aOg@krava>
References: <20210310204118.711514-1-irogers@google.com>
 <20210310204118.711514-2-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310204118.711514-2-irogers@google.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 12:41:17PM -0800, Ian Rogers wrote:
> Reorder daemon_start and daemon_exit as the trap handler is added in
> daemon_start referencing daemon_exit.

makes sense, minor comments below

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/shell/daemon.sh | 34 +++++++++++++++++++-------------
>  1 file changed, 20 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/daemon.sh b/tools/perf/tests/shell/daemon.sh
> index 66ad56b4e0a5..a02cedc76de6 100755
> --- a/tools/perf/tests/shell/daemon.sh
> +++ b/tools/perf/tests/shell/daemon.sh
> @@ -98,6 +98,23 @@ check_line_other()
>  	fi
>  }
>  
> +daemon_exit()
> +{
> +	local config=$1
> +
> +	local line=`perf daemon --config ${config} -x: | head -1`
> +	local pid=`echo "${line}" | awk 'BEGIN { FS = ":" } ; { print $1 }'`
> +
> +        # Reset trap handler.
> +        trap - SIGINT SIGTERM

please keep the 'tabs' in here

> +
> +	# stop daemon
> +	perf daemon stop --config ${config}
> +
> +	# ... and wait for the pid to go away
> +	tail --pid=${pid} -f /dev/null
> +}
> +
>  daemon_start()
>  {
>  	local config=$1
> @@ -105,6 +122,9 @@ daemon_start()
>  
>  	perf daemon start --config ${config}
>  
> +        # Clean up daemon if interrupted.
> +        trap "daemon_exit ${config}; exit 4" SIGINT SIGTERM

ditto, plus let's document exit values somewhere in comments,
I think the next patch is adding exit 62, so that one as well

thanks,
jirka

> +
>  	# wait for the session to ping
>  	local state="FAIL"
>  	while [ "${state}" != "OK" ]; do
> @@ -113,20 +133,6 @@ daemon_start()
>  	done
>  }
>  
> -daemon_exit()
> -{
> -	local config=$1
> -
> -	local line=`perf daemon --config ${config} -x: | head -1`
> -	local pid=`echo "${line}" | awk 'BEGIN { FS = ":" } ; { print $1 }'`
> -
> -	# stop daemon
> -	perf daemon stop --config ${config}
> -
> -	# ... and wait for the pid to go away
> -	tail --pid=${pid} -f /dev/null
> -}
> -
>  test_list()
>  {
>  	echo "test daemon list"
> -- 
> 2.30.1.766.gb4fecdf3b7-goog
> 

