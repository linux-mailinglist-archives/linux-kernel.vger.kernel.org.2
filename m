Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F60235567F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 16:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345057AbhDFOVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 10:21:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53321 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237043AbhDFOVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 10:21:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617718902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KOsrxh/c/aALPdi2ybytT46YAb20H79vEzFzq4fSRMk=;
        b=L/kxy5RptYGlIf8EabtYFt97UBxSLCOvNY25coF+1kG5mqVhtvyd1xFEDEjAj6HravR1xU
        AcosF8pL2WArjJsjKRbahaDNqLYo8Yt5W0bIMPkUk4WE896v2aoX9B4XFcTX6WY65GtgA2
        Kk5qh7zgCDWrbHQejkZHPznZMZYR/So=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-U0i9sBCBP--zvqFRYFXenA-1; Tue, 06 Apr 2021 10:21:40 -0400
X-MC-Unique: U0i9sBCBP--zvqFRYFXenA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 069B2190A7AD;
        Tue,  6 Apr 2021 14:21:39 +0000 (UTC)
Received: from krava (unknown [10.40.195.36])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4C67919C45;
        Tue,  6 Apr 2021 14:21:37 +0000 (UTC)
Date:   Tue, 6 Apr 2021 16:21:36 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <song@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, acme@kernel.org,
        acme@redhat.com, namhyung@kernel.org, jolsa@kernel.org,
        songliubraving@fb.com
Subject: Re: [PATCH 1/2] perf util: move bperf definitions to a libperf header
Message-ID: <YGxucIgiq+ogX687@krava>
References: <20210403002938.390878-1-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210403002938.390878-1-song@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2021 at 05:29:37PM -0700, Song Liu wrote:
> By following the same protocol, other tools can share hardware PMCs with
> perf. Move perf_event_attr_map_entry and BPERF_DEFAULT_ATTR_MAP_PATH to
> bperf.h for other tools to use.

hi,
so is this necessary for some other tool now?

> 
> Also add bperf_attr_map_compatible() to check whether existing attr_map
> is compatible with current perf binary.

please separate this change

> 
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  tools/lib/perf/include/perf/bperf.h | 29 +++++++++++++++++++
>  tools/perf/util/bpf_counter.c       | 44 ++++++++++++++---------------
>  2 files changed, 50 insertions(+), 23 deletions(-)
>  create mode 100644 tools/lib/perf/include/perf/bperf.h
> 
> diff --git a/tools/lib/perf/include/perf/bperf.h b/tools/lib/perf/include/perf/bperf.h
> new file mode 100644
> index 0000000000000..02b2fd5e50c75
> --- /dev/null
> +++ b/tools/lib/perf/include/perf/bperf.h

I wonder we want to call it bpf_perf.h to be more generic?
or best just bpf.h ... but that might give us some conflict
headache in future ;-)

> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
> +#ifndef __LIBPERF_BPERF_H
> +#define __LIBPERF_BPERF_H
> +
> +/*
> + * bperf uses a hashmap, the attr_map, to track all the leader programs.
> + * The hashmap is pinned in bpffs. flock() on this file is used to ensure
> + * no concurrent access to the attr_map.  The key of attr_map is struct
> + * perf_event_attr, and the value is struct perf_event_attr_map_entry.
> + *
> + * struct perf_event_attr_map_entry contains two __u32 IDs, bpf_link of the
> + * leader prog, and the diff_map. Each perf-stat session holds a reference
> + * to the bpf_link to make sure the leader prog is attached to sched_switch
> + * tracepoint.
> + *
> + * Since the hashmap only contains IDs of the bpf_link and diff_map, it
> + * does not hold any references to the leader program. Once all perf-stat
> + * sessions of these events exit, the leader prog, its maps, and the
> + * perf_events will be freed.
> + */
> +struct perf_event_attr_map_entry {
> +	__u32 link_id;
> +	__u32 diff_map_id;
> +};

this header file should be self contained,
so you need __u32 definitions


> +
> +/* pin the map at sysfs__mountpoint()/BPERF_DEFAULT_ATTR_MAP_PATH */
> +#define BPERF_DEFAULT_ATTR_MAP_PATH "fs/bpf/perf_attr_map"

if we are going to expose this, I think we should expose just
"perf_attr_map" ... without the 'fs/bpf' part, because that
could be mounted anywhere

thanks,
jirka

> +
> +#endif /* __LIBPERF_BPERF_H */
> diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
> index 81d1df3c4ec0e..df70c8dcf7850 100644
> --- a/tools/perf/util/bpf_counter.c
> +++ b/tools/perf/util/bpf_counter.c
> @@ -14,6 +14,7 @@
>  #include <bpf/btf.h>
>  #include <bpf/libbpf.h>
>  #include <api/fs/fs.h>
> +#include <perf/bperf.h>
>  
>  #include "bpf_counter.h"
>  #include "counts.h"
> @@ -29,28 +30,6 @@
>  #include "bpf_skel/bperf_leader.skel.h"
>  #include "bpf_skel/bperf_follower.skel.h"
>  
> -/*
> - * bperf uses a hashmap, the attr_map, to track all the leader programs.
> - * The hashmap is pinned in bpffs. flock() on this file is used to ensure
> - * no concurrent access to the attr_map.  The key of attr_map is struct
> - * perf_event_attr, and the value is struct perf_event_attr_map_entry.
> - *
> - * struct perf_event_attr_map_entry contains two __u32 IDs, bpf_link of the
> - * leader prog, and the diff_map. Each perf-stat session holds a reference
> - * to the bpf_link to make sure the leader prog is attached to sched_switch
> - * tracepoint.
> - *
> - * Since the hashmap only contains IDs of the bpf_link and diff_map, it
> - * does not hold any references to the leader program. Once all perf-stat
> - * sessions of these events exit, the leader prog, its maps, and the
> - * perf_events will be freed.
> - */
> -struct perf_event_attr_map_entry {
> -	__u32 link_id;
> -	__u32 diff_map_id;
> -};
> -
> -#define DEFAULT_ATTR_MAP_PATH "fs/bpf/perf_attr_map"
>  #define ATTR_MAP_SIZE 16
>  
>  static inline void *u64_to_ptr(__u64 ptr)
> @@ -333,6 +312,20 @@ static __u32 bpf_map_get_id(int fd)
>  	return map_info.id;
>  }
>  
> +static bool bperf_attr_map_compatible(int attr_map_fd)
> +{
> +	struct bpf_map_info map_info = {0};
> +	__u32 map_info_len = sizeof(map_info);
> +	int err;
> +
> +	err = bpf_obj_get_info_by_fd(attr_map_fd, &map_info, &map_info_len);
> +
> +	if (err)
> +		return false;
> +	return (map_info.key_size == sizeof(struct perf_event_attr)) &&
> +		(map_info.value_size == sizeof(struct perf_event_attr_map_entry));
> +}
> +
>  static int bperf_lock_attr_map(struct target *target)
>  {
>  	char path[PATH_MAX];
> @@ -342,7 +335,7 @@ static int bperf_lock_attr_map(struct target *target)
>  		scnprintf(path, PATH_MAX, "%s", target->attr_map);
>  	} else {
>  		scnprintf(path, PATH_MAX, "%s/%s", sysfs__mountpoint(),
> -			  DEFAULT_ATTR_MAP_PATH);
> +			  BPERF_DEFAULT_ATTR_MAP_PATH);
>  	}
>  
>  	if (access(path, F_OK)) {
> @@ -367,6 +360,11 @@ static int bperf_lock_attr_map(struct target *target)
>  			return -1;
>  	}
>  
> +	if (!bperf_attr_map_compatible(map_fd)) {
> +		close(map_fd);
> +		return -1;
> +
> +	}
>  	err = flock(map_fd, LOCK_EX);
>  	if (err) {
>  		close(map_fd);
> -- 
> 2.30.2
> 

