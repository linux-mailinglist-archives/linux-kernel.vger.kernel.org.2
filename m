Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D493337028
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 11:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbhCKKiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 05:38:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48956 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232001AbhCKKhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 05:37:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615459072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7ob+OP4Gy2kP7fYupwS9HA9zAhy1OO9Oa2UKq2zJ0kg=;
        b=dJgNn/eM0E4rNZh4sG1Z8uLUIp9Fli7zb6Prz0vtsmZYC42VihE1/YOjUVDawWfjSU+MCb
        hyPDyva3a1odff0VpLmMtjdU67IKj6tv3Xo/0PeVSsLyz9P/cnbUpqf0R3UrPY+wskbhk2
        qO+iBrO9tzHVdodUlNrHyOdTX3f9Bag=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-545-VtQT0eX6PMisQEDoDLDx_w-1; Thu, 11 Mar 2021 05:37:48 -0500
X-MC-Unique: VtQT0eX6PMisQEDoDLDx_w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E88BE802B62;
        Thu, 11 Mar 2021 10:37:46 +0000 (UTC)
Received: from krava (unknown [10.40.195.225])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9CA51226E0;
        Thu, 11 Mar 2021 10:37:44 +0000 (UTC)
Date:   Thu, 11 Mar 2021 11:37:43 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 3/3] perf test: Add 30s timeout for wait for daemon start.
Message-ID: <YEny9zLCRxEKzuDm@krava>
References: <20210310204118.711514-1-irogers@google.com>
 <20210310204118.711514-3-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310204118.711514-3-irogers@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 12:41:18PM -0800, Ian Rogers wrote:
> Retry the ping loop upto 600 times, or approximately 30 seconds, to make
> sure the test does hang at start up.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/shell/daemon.sh | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tools/perf/tests/shell/daemon.sh b/tools/perf/tests/shell/daemon.sh
> index a02cedc76de6..cb831ff2c185 100755
> --- a/tools/perf/tests/shell/daemon.sh
> +++ b/tools/perf/tests/shell/daemon.sh
> @@ -127,9 +127,16 @@ daemon_start()
>  
>  	# wait for the session to ping
>  	local state="FAIL"
> +	local retries=0
>  	while [ "${state}" != "OK" ]; do
>  		state=`perf daemon ping --config ${config} --session ${session} | awk '{ print $1 }'`
>  		sleep 0.05
> +		retries=$((${retries} +1))
> +		if [ ${retries} -ge 600 ]; then
> +			echo "Timeout waiting for daemon to ping"
> +			daemon_exit ${config}
> +			exit 62
> +		fi

so it broke in here for you? ;-) makes sense, please keep
the 'FAILED: ...' prefix so it's obvious it's an error

thanks,
jirka

>  	done
>  }
>  
> -- 
> 2.30.1.766.gb4fecdf3b7-goog
> 

