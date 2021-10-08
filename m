Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B10426CD8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 16:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242540AbhJHOk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 10:40:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25242 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242095AbhJHOkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 10:40:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633703934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ex/Nse0k45hr4TX3k1RQfp3p5x7OjHTMNs7Q3CQyzSE=;
        b=NGM7ffuZZnO31EbN5zNev4u4yhCEUWJoA5+qxvP5kA9D01J9p3zoU0Iyd2Bt2vjrY0Zd1j
        D8z799OwQOA5LY/YFQKAOr4Es9qozOnxeOYa5MhNfL4I828aIgnMzy6Pw2xu38dr4DPSx+
        1hZypXxcg9JGz+5HFwpKVSpsDJ7Ay5w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-1doUrOhmPM6Y2u9-lLZ_ZA-1; Fri, 08 Oct 2021 10:38:53 -0400
X-MC-Unique: 1doUrOhmPM6Y2u9-lLZ_ZA-1
Received: by mail-wr1-f70.google.com with SMTP id v15-20020adfa1cf000000b00160940b17a2so7485958wrv.19
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 07:38:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ex/Nse0k45hr4TX3k1RQfp3p5x7OjHTMNs7Q3CQyzSE=;
        b=kj7uTl0PpJQfrSK/Qq9BHhcNdyjaC7+MdG+2ABHoKCBhP4b52selrRke8ZgIQ1V4RJ
         zTB/TcR8AZxO6SCSq/8++yiPgn8CZc1Bum7Gg/scQtLJtspbE66cWgG8B7WvDVIfw53W
         pJnl97MgNkMO/w+wmcnSWw1BdDNihrO0Wpjo965fY3tRZ6OTwPRWLCgD3of5RcQ49o3Y
         qTdPt5iktCv1tajqtevZjc7z6l79tMJHG+UA6aa6ZznxaqkcfSANIWgcDt6s0v/HZaDN
         Hg1S++wfNcxjpSdcBCqG2aUyt7fNUuaiQCg67K4GRgut954Xyqi09XlAED+MSWCUOOaE
         +4NA==
X-Gm-Message-State: AOAM533bH+ZxGNpluFmoHQT8iCHnurOfsvt0H4JOkkzD4EiGSvM+i9P1
        EtE8YCgE0gDHW8Q5x3vjp54ixLld8m349RWJ9KVKmnG5tHpqLe0IaWBrVgUoKBRSZOmMSl85u1E
        s2hRHV7WEyOv97K/a1tDdfw6e
X-Received: by 2002:a1c:a302:: with SMTP id m2mr3848311wme.111.1633703932390;
        Fri, 08 Oct 2021 07:38:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQRdKBPsL2rw9finS9D0bk7UcTpQ6XQDu0xJoVnhGgTR0SI923gNv831dxTA9o8NZqWHeBBQ==
X-Received: by 2002:a1c:a302:: with SMTP id m2mr3848280wme.111.1633703932198;
        Fri, 08 Oct 2021 07:38:52 -0700 (PDT)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id o15sm2630047wmc.21.2021.10.08.07.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 07:38:51 -0700 (PDT)
Date:   Fri, 8 Oct 2021 16:38:50 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Bayduraev, Alexey V" <alexey.v.bayduraev@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: Re: [PATCH v3 6/8] perf session: Move event read code to separate
 function
Message-ID: <YWBX+p1vtLXXbpkF@krava>
References: <cover.1633596227.git.alexey.v.bayduraev@linux.intel.com>
 <6ab47325fa261deca4ca55ecacf1ca2437abcd78.1633596227.git.alexey.v.bayduraev@linux.intel.com>
 <YV/0ZZBu01V87A8e@krava>
 <aa62d0ed-abca-2123-c8bf-cd6bced2fe9c@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa62d0ed-abca-2123-c8bf-cd6bced2fe9c@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2021 at 11:42:18AM +0300, Bayduraev, Alexey V wrote:
> 
> 
> On 08.10.2021 10:33, Jiri Olsa wrote:
> > On Thu, Oct 07, 2021 at 01:25:41PM +0300, Alexey Bayduraev wrote:
> > 
> > SNIP
> > 
> >>  static int
> >> -reader__process_events(struct reader *rd, struct perf_session *session,
> >> -		       struct ui_progress *prog)
> >> +reader__read_event(struct reader *rd, struct perf_session *session,
> >> +		   struct ui_progress *prog)
> >>  {
> >>  	u64 size;
> >>  	int err = 0;
> >>  	union perf_event *event;
> >>  	s64 skip;
> >>  
> >> -	err = reader__init(rd, &session->one_mmap);
> >> -	if (err)
> >> -		goto out;
> >> -
> >> -remap:
> >> -	err = reader__mmap(rd, session);
> >> -	if (err)
> >> -		goto out;
> >> -
> >> -more:
> >>  	event = fetch_mmaped_event(rd->head, rd->mmap_size, rd->mmap_cur,
> >>  				   session->header.needs_swap);
> >>  	if (IS_ERR(event))
> >>  		return PTR_ERR(event);
> >>  
> >>  	if (!event)
> >> -		goto remap;
> >> +		return 1;
> >>  
> >>  	session->active_decomp = &rd->decomp_data;
> >>  	size = event->header.size;
> >> @@ -2311,6 +2301,33 @@ reader__process_events(struct reader *rd, struct perf_session *session,
> >>  
> >>  	ui_progress__update(prog, size);
> >>  
> >> +out:
> >> +	session->active_decomp = &session->decomp_data;
> >> +	return err;
> >> +}
> >> +
> >> +static int
> >> +reader__process_events(struct reader *rd, struct perf_session *session,
> >> +		       struct ui_progress *prog)
> >> +{
> >> +	int err;
> >> +
> >> +	err = reader__init(rd, &session->one_mmap);
> >> +	if (err)
> >> +		goto out;
> >> +
> >> +remap:
> >> +	err = reader__mmap(rd, session);
> >> +	if (err)
> >> +		goto out;
> >> +
> >> +more:
> >> +	err = reader__read_event(rd, session, prog);
> >> +	if (err < 0)
> >> +		goto out;
> >> +	else if (err == 1)
> >> +		goto remap;
> >> +
> >>  	if (session_done())
> >>  		goto out;
> >>  
> >> @@ -2318,7 +2335,6 @@ reader__process_events(struct reader *rd, struct perf_session *session,
> >>  		goto more;
> >>  
> >>  out:
> >> -	session->active_decomp = &session->decomp_data;
> > 
> > active_decomp should be set/unset within reader__process_events,
> > not just for single event read, right?
> 
> No, it should be set before perf_session__process_event/process_decomp_events
> and unset after these calls. So active_decomp setting/unsetting is moved in
> this patch to the reader__read_event function. This is necessary for multiple
> trace reader because it could call reader__read_event in round-robin manner.

hum, is that code already in? I can't see this happening in current code

jirka

> 
> Regards,
> Alexey
> 
> > 
> > jirka
> > 
> >>  	return err;
> >>  }
> >>  
> >> -- 
> >> 2.19.0
> >>
> > 
> 

