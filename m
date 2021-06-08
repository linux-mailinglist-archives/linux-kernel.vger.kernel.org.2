Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7645839F46F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 12:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbhFHK7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 06:59:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45810 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231806AbhFHK66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 06:58:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623149825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mMlrouWbM08TOZFSM8Y5ixcxez5n04x6VcpRxkJgJbQ=;
        b=IZEkEmFF98bs71prt3MUw+ZKfo71L/EFwsF5gBDc6Ev6wLocOzpuzLrl8G7ZlmkJryLgpa
        P5gCQ0oSQIkch8kFB0WBOz/0SicRLwCDpQRAF9cifnUJukr+Dnd+Nm0IGmxw6giKp9Jvql
        bFnyuFLtYSNwOL3CNr1TOc05JDYEdYU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-R47dfTn2MamOYEj_4X7D4Q-1; Tue, 08 Jun 2021 06:57:01 -0400
X-MC-Unique: R47dfTn2MamOYEj_4X7D4Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 851FA8018A7;
        Tue,  8 Jun 2021 10:57:00 +0000 (UTC)
Received: from krava (unknown [10.40.195.112])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5900B19C66;
        Tue,  8 Jun 2021 10:56:57 +0000 (UTC)
Date:   Tue, 8 Jun 2021 12:56:56 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf evsel: Adjust hybrid event and global event mixed
 group
Message-ID: <YL9M+FUE5BHaD9w/@krava>
References: <20210601013827.1102-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601013827.1102-1-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 09:38:27AM +0800, Jin Yao wrote:
> A group mixed with hybrid event and global event is allowed. For example,
> group leader is 'intel_pt//' and the group member is 'cpu_atom/cycles/'.
> 
> e.g.
> perf record --aux-sample -e '{intel_pt//,cpu_atom/cycles/}:u'
> 
> The challenge is their available cpus are not fully matched. For example,
> 'intel_pt//' is available on CPU0-CPU23, but 'cpu_atom/cycles/' is
> available on CPU16-CPU23.
> 
> When getting the group id for group member, we must be very careful.
> Because the cpu for 'intel_pt//' is not equal to the cpu for
> 'cpu_atom/cycles/'. Actually the cpu here is the index of evsel->core.cpus,
> not the real CPU ID.
> 
> e.g. cpu0 for 'intel_pt//' is CPU0, but cpu0 for 'cpu_atom/cycles/' is CPU16.
> 
> Before:
> 
>   # perf record --aux-sample -e '{intel_pt//,cpu_atom/cycles/}:u' -vv uname
>   ...
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             10
>     size                             128
>     config                           0xe601
>     { sample_period, sample_freq }   1
>     sample_type                      IP|TID|TIME|CPU|IDENTIFIER
>     read_format                      ID
>     disabled                         1
>     inherit                          1
>     exclude_kernel                   1
>     exclude_hv                       1
>     enable_on_exec                   1
>     sample_id_all                    1
>     exclude_guest                    1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid 4084  cpu 0  group_fd -1  flags 0x8 = 5
>   sys_perf_event_open: pid 4084  cpu 1  group_fd -1  flags 0x8 = 6
>   sys_perf_event_open: pid 4084  cpu 2  group_fd -1  flags 0x8 = 7
>   sys_perf_event_open: pid 4084  cpu 3  group_fd -1  flags 0x8 = 9
>   sys_perf_event_open: pid 4084  cpu 4  group_fd -1  flags 0x8 = 10
>   sys_perf_event_open: pid 4084  cpu 5  group_fd -1  flags 0x8 = 11
>   sys_perf_event_open: pid 4084  cpu 6  group_fd -1  flags 0x8 = 12
>   sys_perf_event_open: pid 4084  cpu 7  group_fd -1  flags 0x8 = 13
>   sys_perf_event_open: pid 4084  cpu 8  group_fd -1  flags 0x8 = 14
>   sys_perf_event_open: pid 4084  cpu 9  group_fd -1  flags 0x8 = 15
>   sys_perf_event_open: pid 4084  cpu 10  group_fd -1  flags 0x8 = 16
>   sys_perf_event_open: pid 4084  cpu 11  group_fd -1  flags 0x8 = 17
>   sys_perf_event_open: pid 4084  cpu 12  group_fd -1  flags 0x8 = 18
>   sys_perf_event_open: pid 4084  cpu 13  group_fd -1  flags 0x8 = 19
>   sys_perf_event_open: pid 4084  cpu 14  group_fd -1  flags 0x8 = 20
>   sys_perf_event_open: pid 4084  cpu 15  group_fd -1  flags 0x8 = 21
>   sys_perf_event_open: pid 4084  cpu 16  group_fd -1  flags 0x8 = 22
>   sys_perf_event_open: pid 4084  cpu 17  group_fd -1  flags 0x8 = 23
>   sys_perf_event_open: pid 4084  cpu 18  group_fd -1  flags 0x8 = 24
>   sys_perf_event_open: pid 4084  cpu 19  group_fd -1  flags 0x8 = 25
>   sys_perf_event_open: pid 4084  cpu 20  group_fd -1  flags 0x8 = 26
>   sys_perf_event_open: pid 4084  cpu 21  group_fd -1  flags 0x8 = 27
>   sys_perf_event_open: pid 4084  cpu 22  group_fd -1  flags 0x8 = 28
>   sys_perf_event_open: pid 4084  cpu 23  group_fd -1  flags 0x8 = 29
>   ------------------------------------------------------------
>   perf_event_attr:
>     size                             128
>     config                           0x800000000
>     { sample_period, sample_freq }   4000
>     sample_type                      IP|TID|TIME|PERIOD|IDENTIFIER|AUX
>     read_format                      ID
>     inherit                          1
>     exclude_kernel                   1
>     exclude_hv                       1
>     freq                             1
>     sample_id_all                    1
>     exclude_guest                    1
>     aux_sample_size                  4096
>   ------------------------------------------------------------
>   sys_perf_event_open: pid 4084  cpu 16  group_fd 5  flags 0x8
>   sys_perf_event_open failed, error -22
> 
> The group_fd 5 is not correct. It should be 22 (the fd of
> 'intel_pt' on CPU16).
> 
> After:
> 
>   # perf record --aux-sample -e '{intel_pt//,cpu_atom/cycles/}:u' -vv uname
>   ...
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             10
>     size                             128
>     config                           0xe601
>     { sample_period, sample_freq }   1
>     sample_type                      IP|TID|TIME|CPU|IDENTIFIER
>     read_format                      ID
>     disabled                         1
>     inherit                          1
>     exclude_kernel                   1
>     exclude_hv                       1
>     enable_on_exec                   1
>     sample_id_all                    1
>     exclude_guest                    1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid 5162  cpu 0  group_fd -1  flags 0x8 = 5
>   sys_perf_event_open: pid 5162  cpu 1  group_fd -1  flags 0x8 = 6
>   sys_perf_event_open: pid 5162  cpu 2  group_fd -1  flags 0x8 = 7
>   sys_perf_event_open: pid 5162  cpu 3  group_fd -1  flags 0x8 = 9
>   sys_perf_event_open: pid 5162  cpu 4  group_fd -1  flags 0x8 = 10
>   sys_perf_event_open: pid 5162  cpu 5  group_fd -1  flags 0x8 = 11
>   sys_perf_event_open: pid 5162  cpu 6  group_fd -1  flags 0x8 = 12
>   sys_perf_event_open: pid 5162  cpu 7  group_fd -1  flags 0x8 = 13
>   sys_perf_event_open: pid 5162  cpu 8  group_fd -1  flags 0x8 = 14
>   sys_perf_event_open: pid 5162  cpu 9  group_fd -1  flags 0x8 = 15
>   sys_perf_event_open: pid 5162  cpu 10  group_fd -1  flags 0x8 = 16
>   sys_perf_event_open: pid 5162  cpu 11  group_fd -1  flags 0x8 = 17
>   sys_perf_event_open: pid 5162  cpu 12  group_fd -1  flags 0x8 = 18
>   sys_perf_event_open: pid 5162  cpu 13  group_fd -1  flags 0x8 = 19
>   sys_perf_event_open: pid 5162  cpu 14  group_fd -1  flags 0x8 = 20
>   sys_perf_event_open: pid 5162  cpu 15  group_fd -1  flags 0x8 = 21
>   sys_perf_event_open: pid 5162  cpu 16  group_fd -1  flags 0x8 = 22
>   sys_perf_event_open: pid 5162  cpu 17  group_fd -1  flags 0x8 = 23
>   sys_perf_event_open: pid 5162  cpu 18  group_fd -1  flags 0x8 = 24
>   sys_perf_event_open: pid 5162  cpu 19  group_fd -1  flags 0x8 = 25
>   sys_perf_event_open: pid 5162  cpu 20  group_fd -1  flags 0x8 = 26
>   sys_perf_event_open: pid 5162  cpu 21  group_fd -1  flags 0x8 = 27
>   sys_perf_event_open: pid 5162  cpu 22  group_fd -1  flags 0x8 = 28
>   sys_perf_event_open: pid 5162  cpu 23  group_fd -1  flags 0x8 = 29
>   ------------------------------------------------------------
>   perf_event_attr:
>     size                             128
>     config                           0x800000000
>     { sample_period, sample_freq }   4000
>     sample_type                      IP|TID|TIME|PERIOD|IDENTIFIER|AUX
>     read_format                      ID
>     inherit                          1
>     exclude_kernel                   1
>     exclude_hv                       1
>     freq                             1
>     sample_id_all                    1
>     exclude_guest                    1
>     aux_sample_size                  4096
>   ------------------------------------------------------------
>   sys_perf_event_open: pid 5162  cpu 16  group_fd 22  flags 0x8 = 30
>   sys_perf_event_open: pid 5162  cpu 17  group_fd 23  flags 0x8 = 31
>   sys_perf_event_open: pid 5162  cpu 18  group_fd 24  flags 0x8 = 32
>   sys_perf_event_open: pid 5162  cpu 19  group_fd 25  flags 0x8 = 33
>   sys_perf_event_open: pid 5162  cpu 20  group_fd 26  flags 0x8 = 34
>   sys_perf_event_open: pid 5162  cpu 21  group_fd 27  flags 0x8 = 35
>   sys_perf_event_open: pid 5162  cpu 22  group_fd 28  flags 0x8 = 36
>   sys_perf_event_open: pid 5162  cpu 23  group_fd 29  flags 0x8 = 37
>   ------------------------------------------------------------
>   ...
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> ---
>  tools/perf/util/evsel.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 4a3cd1b5bb33..a9cf615fe580 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1581,6 +1581,15 @@ int __evsel__read_on_cpu(struct evsel *evsel, int cpu, int thread, bool scale)
>  	return 0;
>  }
>  
> +static int evsel_cpuid_match(struct evsel *evsel1, struct evsel *evsel2,
> +			     int cpu)
> +{

could this be better name:

   evsel__match_other_cpu(struct evsel *evsel, struct evsel *other, int cpu)


> +	int cpuid;
> +
> +	cpuid = perf_cpu_map__cpu(evsel1->core.cpus, cpu);
> +	return perf_cpu_map__idx(evsel2->core.cpus, cpuid);
> +}
> +
>  static int get_group_fd(struct evsel *evsel, int cpu, int thread)
>  {
>  	struct evsel *leader = evsel->leader;
> @@ -1595,6 +1604,26 @@ static int get_group_fd(struct evsel *evsel, int cpu, int thread)
>  	 */
>  	BUG_ON(!leader->core.fd);
>  
> +	/*
> +	 * If leader is global event (e.g. 'intel_pt//'), but member is
> +	 * hybrid event. Need to get the leader's fd from correct cpu.
> +	 */
> +	if (evsel__is_hybrid(evsel) &&
> +	    !evsel__is_hybrid(leader)) {
> +		cpu = evsel_cpuid_match(evsel, leader, cpu);
> +		BUG_ON(cpu == -1);
> +	}
> +
> +	/*
> +	 * Leader is hybrid event but member is global event.
> +	 */
> +	if (!evsel__is_hybrid(evsel) &&
> +	    evsel__is_hybrid(leader)) {
> +		cpu = evsel_cpuid_match(evsel, leader, cpu);
> +		if (cpu == -1)
> +			return -1;
> +	}

why do we call BUG_ON on the first one and return -1 on the other?
they are equally bad no?

could you put that into separate function, like

  cpu = evsel__hybrid_group_fd(evsel,  cpu);

jirka


> +
>  	fd = FD(leader, cpu, thread);
>  	BUG_ON(fd == -1);
>  
> -- 
> 2.17.1
> 

