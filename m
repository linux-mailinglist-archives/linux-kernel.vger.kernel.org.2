Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE7E428DB8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 15:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236859AbhJKNX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 09:23:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54937 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236879AbhJKNXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 09:23:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633958484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=arcJc4yWJIHllpbTDWXrg//xpW/vnpRNlerpm22V+dY=;
        b=a7bbLMUKi93xwOmiyWWd2bxeRvyboBPGPsvYZatWp78NRzgV+4JNDK7qGl3y6qcNd/gTe1
        jRNcgFwFgsc63wpRHrnhFnUDPdxU++8NVfb+SI+BHERoH1AoRDx20cd4q02wygHdKRmGRH
        oIP3/57MK4B9bWmOfbAZeJgSQ7hBCH8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-zSuN-sxZMzeN4arW5Wcq3Q-1; Mon, 11 Oct 2021 09:21:23 -0400
X-MC-Unique: zSuN-sxZMzeN4arW5Wcq3Q-1
Received: by mail-ed1-f70.google.com with SMTP id cy14-20020a0564021c8e00b003db8c9a6e30so3472218edb.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 06:21:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=arcJc4yWJIHllpbTDWXrg//xpW/vnpRNlerpm22V+dY=;
        b=UYoAR5oBcJ9eZKVXdGx71D7ppZ0UIhSM+f1PaFNaYbigbha6DtfFi4PqXQdLwvgpey
         Eu473dNgquL/lUXWfOxOcKvkltqcX90WsSODXvLs4u07pmIODwQuxNqGiG2CzIRxIbt0
         mCt5M1SSdTlufEqgSq4TzgY6xSvm6rK/eNxWDeTS1JI/Mp20yXlYjt2UmY5iAlrg4M/r
         FxfL4Z5zMsoLl/YU0PQ4Fh6s6bJe0lfKZgqOWnwbpQMbrkXU4unM3tTkUC5DbE+/QMnB
         7TGxLZtlrix/63aDoCyNWsE8y7XN26ctW9x5VDwQjkJko5EqFDUahGyf8fxwXIDZvLPQ
         0zCw==
X-Gm-Message-State: AOAM530V17pRpIc8ZSsTy6cW7CeboeXXYHUAdioi1ncV+0SCCL0X0AKW
        CONV9ch0PhTnZMkkKrVy8lZFcw9DsGE9A+70qX7UIqKA8G41ySrAUEc4jl0zhhmRPbtnRX0VlBM
        G7QEyF33mO7i+gLQ9iQfaJ8Oa
X-Received: by 2002:a17:906:7c4f:: with SMTP id g15mr18132553ejp.373.1633958482108;
        Mon, 11 Oct 2021 06:21:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxHaoApH5JivFkDAJcelIc6b8KOkfgcUs8ulWHYQQ4KwwoB9SzGLZrv+5Ml+4geETOV95XDlA==
X-Received: by 2002:a17:906:7c4f:: with SMTP id g15mr18132536ejp.373.1633958481950;
        Mon, 11 Oct 2021 06:21:21 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id dx2sm3492583ejb.125.2021.10.11.06.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 06:21:21 -0700 (PDT)
Date:   Mon, 11 Oct 2021 15:21:19 +0200
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
Message-ID: <YWQ6TyyYRfx9AXLH@krava>
References: <cover.1633596227.git.alexey.v.bayduraev@linux.intel.com>
 <6ab47325fa261deca4ca55ecacf1ca2437abcd78.1633596227.git.alexey.v.bayduraev@linux.intel.com>
 <YV/0ZZBu01V87A8e@krava>
 <aa62d0ed-abca-2123-c8bf-cd6bced2fe9c@linux.intel.com>
 <YWBX+p1vtLXXbpkF@krava>
 <5e5ecfcd-57f1-1a06-4ed6-6a1e6983d1f8@linux.intel.com>
 <f8d0accb-b569-3fcd-ffe5-99e2fab4c8b7@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8d0accb-b569-3fcd-ffe5-99e2fab4c8b7@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 12:53:30PM +0300, Bayduraev, Alexey V wrote:
> 
> 
> On 11.10.2021 12:08, Bayduraev, Alexey V wrote:
> > 
> > On 08.10.2021 17:38, Jiri Olsa wrote:
> >> On Fri, Oct 08, 2021 at 11:42:18AM +0300, Bayduraev, Alexey V wrote:
> >>>
> >>>
> >>> On 08.10.2021 10:33, Jiri Olsa wrote:
> >>>> On Thu, Oct 07, 2021 at 01:25:41PM +0300, Alexey Bayduraev wrote:
> >>>>
> >>>> SNIP
> >>>>
> >>>>>  static int
> >>>>> -reader__process_events(struct reader *rd, struct perf_session *session,
> >>>>> -		       struct ui_progress *prog)
> >>>>> +reader__read_event(struct reader *rd, struct perf_session *session,
> >>>>> +		   struct ui_progress *prog)
> > 
> > SNIP
> > 
> >>>>
> >>>> active_decomp should be set/unset within reader__process_events,
> >>>> not just for single event read, right?
> >>>
> >>> No, it should be set before perf_session__process_event/process_decomp_events
> >>> and unset after these calls. So active_decomp setting/unsetting is moved in
> >>> this patch to the reader__read_event function. This is necessary for multiple
> >>> trace reader because it could call reader__read_event in round-robin manner.
> >>
> >> hum, is that code already in? I can't see this happening in current code
> > 
> > Probably I don't understand the question. In [PATCH v3 2/8] I introduced 
> > active_decomp pointer in perf_session. It is initialized by a pointer to the 
> > decompressor object in perf_session. In reader__process_events it is set to 
> > the reader decompressor object. And it is reset to the session decompressor 
> > object at exit. In this case we do not need to reset it after each 
> > perf_session__process_event because this code reads events in loop with 
> > constant reader object. Maybe setting of active_decomp should be at the 
> > entrance to the reader__process_events, not before reader__process_events, 
> > in [PATCH v3 2/8]. All this code is new.
> 
> We set active_decomp for perf_session__process_event (rd->process() in our
> case) and for __perf_session__process_decomp_events, active_decomp is not 
> necessary for other parts of reader__process_events.

so what I see in the code is:

__perf_session__process_events
{
	struct reader rd;

	reader__process_events(rd)
	{
		reader__read_event(rd)
		{
->			session->active_decomp = &rd->decomp_data;
			rd->process(...
->			session->active_decomp = &session->decomp_data;
		}

	}
}


we set session->active_decomp for each event that we process
and I don't understand why we can't do that just once in
__perf_session__process_events, so it'd be like:

__perf_session__process_events
{
	struct reader rd;

->	session->active_decomp = &rd->decomp_data;

	reader__process_events(rd)
	{
		reader__read_event(rd)
		{
			rd->process(...
		}

	}

->	session->active_decomp = &session->decomp_data;
}


or within reader__process_events if it's more convenient

jirka

> 
> Regards,
> Alexey
> 
> > 
> > In this patch I separates single event reading and moves setting/resetting
> > of active_decomp before/after perf_session__process_event because this is 
> > necessary for multiple trace reader. 
> > 
> > Regards,
> > Alexey
> > 
> >>
> >> jirka
> >>
> >>>
> >>> Regards,
> >>> Alexey
> >>>
> >>>>
> >>>> jirka
> >>>>
> >>>>>  	return err;
> >>>>>  }
> >>>>>  
> >>>>> -- 
> >>>>> 2.19.0
> >>>>>
> >>>>
> >>>
> >>
> 

