Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC3253271C2
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 10:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbhB1Jfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 04:35:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51253 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230402AbhB1Jfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 04:35:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614504843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MfErU+o2IpTfmX8Bo8uI0qToZvbwIUPvy2u1IZDsMXg=;
        b=dS7Ohw5g4oHjNKmi8YWVjuEhEtBOdBaPQlGzY9WOTj8kXeve1jqCVbBqxvvFw9b8PhcN31
        qkA+A6lPupB1mH5vipYRdRJt+tZ60Gjml3boOlGa/deGh7RerQ1qynglnAN3pynN+fp3Tp
        xPaq/xBcDgfOI2aYkjrBZ7Nagrxwt9s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-C5aHa_i2NamZLFlHWYaEsg-1; Sun, 28 Feb 2021 04:34:01 -0500
X-MC-Unique: C5aHa_i2NamZLFlHWYaEsg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E38938030C2;
        Sun, 28 Feb 2021 09:33:58 +0000 (UTC)
Received: from krava (unknown [10.40.192.3])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1095C5C1BD;
        Sun, 28 Feb 2021 09:33:53 +0000 (UTC)
Date:   Sun, 28 Feb 2021 10:33:52 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Liang, Kan" <kan.liang@intel.com>, "Jin, Yao" <yao.jin@intel.com>,
        "Yi, Ammy" <ammy.yi@intel.com>
Subject: Re: [drm/i915/gt] 8c3b1ba0e7:
 perf-sanity-tests.Parse_event_definition_strings.fail
Message-ID: <YDtjgCcP9mLBcu/y@krava>
References: <20210224074841.GD6114@xsang-OptiPlex-9020>
 <cabd8692-07ca-13c8-efb5-e088b4547f80@linux.intel.com>
 <YDenRVGzh5Dv1pC2@krava>
 <YDfph8b9p8sSk1AF@krava>
 <YDfxgfi5DBDMFgwu@krava>
 <YDf0fP8XmnTrkIT8@krava>
 <d416a908-6a54-5e4c-e377-dc9d2b778941@linux.intel.com>
 <YDodJb4CXDT8VemG@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDodJb4CXDT8VemG@krava>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 27, 2021 at 11:21:25AM +0100, Jiri Olsa wrote:
> On Fri, Feb 26, 2021 at 08:41:26AM +0800, Jin, Yao wrote:
> 
> SNIP
> 
> > > +				SET_SYMBOL(prefix, PMU_EVENT_SYMBOL);
> > >   				len++;
> > >   			}
> > >   		}
> > >   	}
> > > +
> > > +	/* unlikely, but still.. */
> > > +	if (!len)
> > > +		goto err;
> > > +	perf_pmu_events_list_num = len;
> > > +
> > >   	qsort(perf_pmu_events_list, len,
> > >   		sizeof(struct perf_pmu_event_symbol), comp_pmu);
> > > 
> > 
> > Thanks so much for the patch! It works with my tests.
> > 
> > # ./perf test 6
> >  6: Parse event definition strings                                  : Ok
> > 
> > # ./perf stat -e software/r1a/ -a -- sleep 1
> > 
> >  Performance counter stats for 'system wide':
> > 
> >    <not supported>      software/r1a/
> > 
> >        1.000940433 seconds time elapsed
> > 
> > In theory, do we also need to check suffix as well? I think returning
> > PMU_EVENT_SYMBOL_SUFFIX may also confuse the parser. But yes, we don't have
> > this case now.
> 
> yep, let's wait for use case ;-) you can't have suffix
> without prefix, and that's the one failing, so I think
> we are fine

actualy this one seems to work as well, could you plz check

thanks,
jirka


---
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index d5b6aff82f21..d57ac86ce7ca 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -89,6 +89,7 @@ static void inc_group_count(struct list_head *list,
 %type <str> PE_EVENT_NAME
 %type <str> PE_PMU_EVENT_PRE PE_PMU_EVENT_SUF PE_KERNEL_PMU_EVENT PE_PMU_EVENT_FAKE
 %type <str> PE_DRV_CFG_TERM
+%type <str> event_pmu_name
 %destructor { free ($$); } <str>
 %type <term> event_term
 %destructor { parse_events_term__delete ($$); } <term>
@@ -272,8 +273,11 @@ event_def: event_pmu |
 	   event_legacy_raw sep_dc |
 	   event_bpf_file
 
+event_pmu_name:
+PE_NAME | PE_PMU_EVENT_PRE
+
 event_pmu:
-PE_NAME opt_pmu_config
+event_pmu_name opt_pmu_config
 {
 	struct parse_events_state *parse_state = _parse_state;
 	struct parse_events_error *error = parse_state->error;

