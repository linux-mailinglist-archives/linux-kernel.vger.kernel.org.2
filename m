Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74DBF309F52
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 00:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbhAaXCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 18:02:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36546 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229502AbhAaXCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 18:02:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612134037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lAPnHmz7R9EgUZBOaZjccJP5jUsRoUuemitr/bzSB3o=;
        b=FxGg7RrbAHZbvlWkOlWE1EUQW7ELb4Ip9LDBbC4VYgpFsZHQhbQPioJRJjD+h5S1XT+cFN
        nG1X0CFq9aDmnYhtALNDFXlXcCuAanuBmiaBaejqkXZXyM667ZJiM1BHqhKoW5Rh7cssh5
        MTejOUG5WHzNDX5Fc17Fudpg+XDMYpc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-_nahZxPyNQeG2xfkEBmOHw-1; Sun, 31 Jan 2021 18:00:34 -0500
X-MC-Unique: _nahZxPyNQeG2xfkEBmOHw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2571D107ACF6;
        Sun, 31 Jan 2021 23:00:33 +0000 (UTC)
Received: from krava (unknown [10.40.192.85])
        by smtp.corp.redhat.com (Postfix) with SMTP id CB71F6268F;
        Sun, 31 Jan 2021 23:00:30 +0000 (UTC)
Date:   Mon, 1 Feb 2021 00:00:29 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 1/3] perf tools: Use /proc/<PID>/task/<TID>/status for
 synthesis
Message-ID: <YBc2jfTDcBjcL5kN@krava>
References: <20210129054901.1705483-1-namhyung@kernel.org>
 <20210129054901.1705483-2-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129054901.1705483-2-namhyung@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 29, 2021 at 02:48:59PM +0900, Namhyung Kim wrote:
> To save memory usage, it needs to reduce number of entries in the proc
> filesystem.  It's using /proc/<PID>/task directory to traverse threads
> in the process and then kernel creates /proc/<PID>/task/<TID> entries.
> 
> After that it checks the thread info using the /proc/<TID>/status file
> rather than /proc/<PID>/task/<TID>/status.  As far as I can see, they
> are the same and contain all the info we need.
> 
> Using the latter eliminates the unnecessary /proc/<TID> entry.  This
> can be useful especially a large number of threads are used in the
> system.  In my experiment around 1KB of memory on average was saved
> for each thread (which is not a thread group leader).
> 
> To do this, pass both pid and tid to perf_event_prepare_comm() if it
> knows them.  In case it doesn't know, passing 0 as pid will do the old
> way.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/synthetic-events.c | 30 +++++++++++++++++++-----------
>  1 file changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> index 3a898520f05c..800522591dde 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -69,7 +69,7 @@ int perf_tool__process_synth_event(struct perf_tool *tool,
>   * Assumes that the first 4095 bytes of /proc/pid/stat contains
>   * the comm, tgid and ppid.
>   */
> -static int perf_event__get_comm_ids(pid_t pid, char *comm, size_t len,
> +static int perf_event__get_comm_ids(pid_t pid, pid_t tid, char *comm, size_t len,
>  				    pid_t *tgid, pid_t *ppid)
>  {
>  	char bf[4096];
> @@ -81,7 +81,10 @@ static int perf_event__get_comm_ids(pid_t pid, char *comm, size_t len,
>  	*tgid = -1;
>  	*ppid = -1;
>  
> -	snprintf(bf, sizeof(bf), "/proc/%d/status", pid);
> +	if (pid)
> +		snprintf(bf, sizeof(bf), "/proc/%d/task/%d/status", pid, tid);
> +	else
> +		snprintf(bf, sizeof(bf), "/proc/%d/status", tid);
>  
>  	fd = open(bf, O_RDONLY);
>  	if (fd < 0) {
> @@ -93,7 +96,7 @@ static int perf_event__get_comm_ids(pid_t pid, char *comm, size_t len,
>  	close(fd);
>  	if (n <= 0) {
>  		pr_warning("Couldn't get COMM, tigd and ppid for pid %d\n",
> -			   pid);
> +			   tid);
>  		return -1;
>  	}
>  	bf[n] = '\0';
> @@ -116,27 +119,32 @@ static int perf_event__get_comm_ids(pid_t pid, char *comm, size_t len,
>  		memcpy(comm, name, size);
>  		comm[size] = '\0';
>  	} else {
> -		pr_debug("Name: string not found for pid %d\n", pid);
> +		pr_debug("Name: string not found for pid %d\n", tid);
>  	}
>  
>  	if (tgids) {
>  		tgids += 5;  /* strlen("Tgid:") */
>  		*tgid = atoi(tgids);
> +
> +		if (pid && pid != *tgid) {
> +			pr_debug("Tgid: not match to given pid: %d vs %d\n",
> +				 pid, *tgid);

hm, could this actually happen in our case?

jirka

