Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C835309F46
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 23:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbhAaWty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 17:49:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24524 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229474AbhAaWto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 17:49:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612133298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OrcBJjXN9+U2SoJJ5khn1NO87hjIwQ7UzYNK8cUEEUo=;
        b=LGB1S6VcoFNrbwCn9ls+LpcfTFJ0kJTxbn4CA/gtRX7Xh7cqy6zI1jyB4JTUXYvYQCI4MU
        Hqmpm3WWkHd5Kvbco9s56zdrjpsKIaPpj2aflWPQEP+YI8DrLMibp/uVcqfbJ5s4W4IoaS
        dc+LfOAhTLWXPqJd88dNZVzI394Q454=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-kbQMho7UPAa6jmEtaEG70w-1; Sun, 31 Jan 2021 17:48:15 -0500
X-MC-Unique: kbQMho7UPAa6jmEtaEG70w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2D2C107ACE3;
        Sun, 31 Jan 2021 22:48:13 +0000 (UTC)
Received: from krava (unknown [10.40.192.85])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6D72327C47;
        Sun, 31 Jan 2021 22:48:11 +0000 (UTC)
Date:   Sun, 31 Jan 2021 23:48:10 +0100
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
Subject: Re: [PATCH 2/3] perf tools: Skip MMAP record synthesis for kernel
 threads
Message-ID: <YBczqtjXRvnMRYjD@krava>
References: <20210129054901.1705483-1-namhyung@kernel.org>
 <20210129054901.1705483-3-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129054901.1705483-3-namhyung@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 29, 2021 at 02:49:00PM +0900, Namhyung Kim wrote:
> To synthesize information to resolve sample IPs, it needs to scan task
> and mmap info from the /proc filesystem.  For each process, it
> opens (and reads) status and maps file respectively.  But as kernel
> threads don't have memory maps so we can skip the maps file.
> 
> To find kernel threads, check "VmPeak:" line in /proc/<PID>/status
> file.  It's about the peak virtual memory usage so only user-level
> tasks have that.  Also check "Threads:" line (which follows the VmPeak
> line whether or not it exists) to be sure it's read enough data - just
> in case of deeply nested pid namespaces or large number of
> supplementary groups are involved.

I don't understand this Threads: check, could you please
show example where it's useful for the check?

thanks,
jirka

> 
> This is for user process:
> 
>   $ head -40 /proc/1/status
>   Name:	systemd
>   Umask:	0000
>   State:	S (sleeping)
>   Tgid:	1
>   Ngid:	0
>   Pid:	1
>   PPid:	0
>   TracerPid:	0
>   Uid:	0	0	0	0
>   Gid:	0	0	0	0
>   FDSize:	256
>   Groups:
>   NStgid:	1
>   NSpid:	1
>   NSpgid:	1
>   NSsid:	1
>   VmPeak:	  234192 kB           <-- here
>   VmSize:	  169964 kB
>   VmLck:	       0 kB
>   VmPin:	       0 kB
>   VmHWM:	   29528 kB
>   VmRSS:	    6104 kB
>   RssAnon:	    2756 kB
>   RssFile:	    3348 kB
>   RssShmem:	       0 kB
>   VmData:	   19776 kB
>   VmStk:	    1036 kB
>   VmExe:	     784 kB
>   VmLib:	    9532 kB
>   VmPTE:	     116 kB
>   VmSwap:	    2400 kB
>   HugetlbPages:	       0 kB
>   CoreDumping:	0
>   THP_enabled:	1
>   Threads:	1                     <-- and here
>   SigQ:	1/62808
>   SigPnd:	0000000000000000
>   ShdPnd:	0000000000000000
>   SigBlk:	7be3c0fe28014a03
>   SigIgn:	0000000000001000
> 
> And this is for kernel thread:
> 
>   $ head -20 /proc/2/status
>   Name:	kthreadd
>   Umask:	0000
>   State:	S (sleeping)
>   Tgid:	2
>   Ngid:	0
>   Pid:	2
>   PPid:	0
>   TracerPid:	0
>   Uid:	0	0	0	0
>   Gid:	0	0	0	0
>   FDSize:	64
>   Groups:
>   NStgid:	2
>   NSpid:	2
>   NSpgid:	0
>   NSsid:	0
>   Threads:	1                     <-- here
>   SigQ:	1/62808
>   SigPnd:	0000000000000000
>   ShdPnd:	0000000000000000
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/synthetic-events.c | 32 +++++++++++++++++++++---------
>  1 file changed, 23 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> index 800522591dde..8b38228c83d8 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -70,13 +70,13 @@ int perf_tool__process_synth_event(struct perf_tool *tool,
>   * the comm, tgid and ppid.
>   */
>  static int perf_event__get_comm_ids(pid_t pid, pid_t tid, char *comm, size_t len,
> -				    pid_t *tgid, pid_t *ppid)
> +				    pid_t *tgid, pid_t *ppid, bool *kernel)
>  {
>  	char bf[4096];
>  	int fd;
>  	size_t size = 0;
>  	ssize_t n;
> -	char *name, *tgids, *ppids;
> +	char *name, *tgids, *ppids, *vmpeak, *threads;
>  
>  	*tgid = -1;
>  	*ppid = -1;
> @@ -102,8 +102,14 @@ static int perf_event__get_comm_ids(pid_t pid, pid_t tid, char *comm, size_t len
>  	bf[n] = '\0';
>  
>  	name = strstr(bf, "Name:");
> -	tgids = strstr(bf, "Tgid:");
> -	ppids = strstr(bf, "PPid:");
> +	tgids = strstr(name ?: bf, "Tgid:");
> +	ppids = strstr(tgids ?: bf, "PPid:");
> +	vmpeak = strstr(ppids ?: bf, "VmPeak:");
> +
> +	if (vmpeak)
> +		threads = NULL;
> +	else
> +		threads = strstr(ppids ?: bf, "Threads:");
>  
>  	if (name) {
>  		char *nl;
> @@ -141,12 +147,17 @@ static int perf_event__get_comm_ids(pid_t pid, pid_t tid, char *comm, size_t len
>  		pr_debug("PPid: string not found for pid %d\n", tid);
>  	}
>  
> +	if (!vmpeak && threads)
> +		*kernel = true;
> +	else
> +		*kernel = false;
> +
>  	return 0;
>  }
>  
>  static int perf_event__prepare_comm(union perf_event *event, pid_t pid, pid_t tid,
>  				    struct machine *machine,
> -				    pid_t *tgid, pid_t *ppid)
> +				    pid_t *tgid, pid_t *ppid, bool *kernel)
>  {
>  	size_t size;
>  
> @@ -157,7 +168,7 @@ static int perf_event__prepare_comm(union perf_event *event, pid_t pid, pid_t ti
>  	if (machine__is_host(machine)) {
>  		if (perf_event__get_comm_ids(pid, tid, event->comm.comm,
>  					     sizeof(event->comm.comm),
> -					     tgid, ppid) != 0) {
> +					     tgid, ppid, kernel) != 0) {
>  			return -1;
>  		}
>  	} else {
> @@ -187,8 +198,10 @@ pid_t perf_event__synthesize_comm(struct perf_tool *tool,
>  					 struct machine *machine)
>  {
>  	pid_t tgid, ppid;
> +	bool kernel_thread;
>  
> -	if (perf_event__prepare_comm(event, 0, pid, machine, &tgid, &ppid) != 0)
> +	if (perf_event__prepare_comm(event, 0, pid, machine, &tgid, &ppid,
> +				     &kernel_thread) != 0)
>  		return -1;
>  
>  	if (perf_tool__process_synth_event(tool, event, machine, process) != 0)
> @@ -748,6 +761,7 @@ static int __event__synthesize_thread(union perf_event *comm_event,
>  	while ((dirent = readdir(tasks)) != NULL) {
>  		char *end;
>  		pid_t _pid;
> +		bool kernel_thread;
>  
>  		_pid = strtol(dirent->d_name, &end, 10);
>  		if (*end)
> @@ -755,7 +769,7 @@ static int __event__synthesize_thread(union perf_event *comm_event,
>  
>  		rc = -1;
>  		if (perf_event__prepare_comm(comm_event, pid, _pid, machine,
> -					     &tgid, &ppid) != 0)
> +					     &tgid, &ppid, &kernel_thread) != 0)
>  			break;
>  
>  		if (perf_event__synthesize_fork(tool, fork_event, _pid, tgid,
> @@ -773,7 +787,7 @@ static int __event__synthesize_thread(union perf_event *comm_event,
>  			break;
>  
>  		rc = 0;
> -		if (_pid == pid) {
> +		if (_pid == pid && !kernel_thread) {
>  			/* process the parent's maps too */
>  			rc = perf_event__synthesize_mmap_events(tool, mmap_event, pid, tgid,
>  						process, machine, mmap_data);
> -- 
> 2.30.0.365.g02bc693789-goog
> 

