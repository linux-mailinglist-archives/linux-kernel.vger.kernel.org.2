Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C77832560B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 20:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbhBYTFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 14:05:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58881 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229769AbhBYTFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 14:05:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614279814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+tBBjR9sNYzM6KSzYefGASfGJGZayMCw0kAzhSTkJbQ=;
        b=JQ04+YiS7+TwEWAGNShZxrHBJ61ZuSt4ejdKpjNW9UOg0UVcuJRcTj/7B8Ib1cZkMsydCF
        8cbJzOAsQn5uydJ2IyUnPIaRUgqad1RSHBAv2yZh0/Zr9X3Xog6qPINFdhdLrIDVTzmOJk
        soRLN8o1NOVVuKCmUVof8oZQD6WfiMQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-CcjKFO4YOG-GHfa8jG3qZw-1; Thu, 25 Feb 2021 14:03:30 -0500
X-MC-Unique: CcjKFO4YOG-GHfa8jG3qZw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84D5DC73A0;
        Thu, 25 Feb 2021 19:03:28 +0000 (UTC)
Received: from krava (unknown [10.40.192.91])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6DC3060854;
        Thu, 25 Feb 2021 19:03:25 +0000 (UTC)
Date:   Thu, 25 Feb 2021 20:03:24 +0100
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
Message-ID: <YDf0fP8XmnTrkIT8@krava>
References: <20210224074841.GD6114@xsang-OptiPlex-9020>
 <cabd8692-07ca-13c8-efb5-e088b4547f80@linux.intel.com>
 <YDenRVGzh5Dv1pC2@krava>
 <YDfph8b9p8sSk1AF@krava>
 <YDfxgfi5DBDMFgwu@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YDfxgfi5DBDMFgwu@krava>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 07:50:46PM +0100, Jiri Olsa wrote:
> On Thu, Feb 25, 2021 at 07:16:44PM +0100, Jiri Olsa wrote:
> > On Thu, Feb 25, 2021 at 02:33:57PM +0100, Jiri Olsa wrote:
> > > On Thu, Feb 25, 2021 at 04:06:23PM +0800, Jin, Yao wrote:
> > > > Hi Chris, Arnaldo, Jiri,
> > > > 
> > > > We observe the parsing error for "software/xxx/" on some platforms.
> > > > 
> > > > For example,
> > > > 
> > > > # perf stat -e software/r1a/ -a -- sleep 1
> > > > event syntax error: 'software/r1a/'
> > > >                      \___ parser error
> > > > Run 'perf list' for a list of valid events
> > > > 
> > > >  Usage: perf stat [<options>] [<command>]
> > > > 
> > > >     -e, --event <event>   event selector. use 'perf list' to list available events
> > > > 
> > > > And perf test is failed too.
> > > > 
> > > > # perf test 6 -vv
> > > > ...
> > > > running test 4 'software/r1a/'failed to parse event 'software/r1a/', err 1, str 'parser error'
> > > > event syntax error: 'software/r1a/'
> > > >                      \___ parser error
> > > > 
> > > > running test 4 'software/r0x1a/'failed to parse event 'software/r0x1a/', err 1, str 'parser error'
> > > > event syntax error: 'software/r0x1a/'
> > > >                      \___ parser error
> > > > ...
> > > > 
> > > > The issue should be the conflict between event "i915/software-gt-awake-time/" and pmu "software".
> > > > 
> > > > # perf list | grep i915/software
> > > >   i915/software-gt-awake-time/                       [Kernel PMU event]
> > > > 
> > > > Perf supports the event format as "prefix-xxx-suffix", so the "software"
> > > > string in "software-gt-awake-time" is added to perf_pmu_events_list as
> > > > PMU_EVENT_SYMBOL_PREFIX. When parsing the string such as "software/xxx/",
> > > > it’s parsed as PMU_EVENT_SYMBOL_PREFIX for "software", then it would error
> > > > out in next processing.
> > > > 
> > > > So the easy way is to rename "software-gt-awake-time" to "gt-awake-time",
> > > > right? Otherwise we have to hardcode something in perf tool.
> > > > 
> > > > What do you think of this issue and the solution?
> > > > 
> > > > BTW, as the robot reported, it's related to the commit 8c3b1ba0e7ea
> > > > ("drm/i915/gt: Track the overall awake/busy time").
> > > 
> > > yes, I think you're right.. I'll try to reproduce and check on this
> > > 
> > > I'm still not clear why is that parsing fail if those 2 events are
> > > distinguished by - and / ... but yep, we are asking for trouble in
> > > here ;-)
> > > 
> > > I think we could either prioritaze one or add extra check when we
> > > add prefix-xxx-suffix events and do not add ones that have conflict..
> > > that seems like best solution to me now
> > 
> > would patch below work for you?
> > 
> > jirka
> 
> and now with more fixes after I ran tests ;-)
> 
> we should perhaps add also same check for non '-' aliases, I'll check

and one more version ;-)

jirka


---
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 42c84adeb2fb..d9e795056d15 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2028,30 +2028,49 @@ static void perf_pmu__parse_init(void)
 		perf_pmu_events_list_num = -1;
 		return;
 	}
-	perf_pmu_events_list = malloc(sizeof(struct perf_pmu_event_symbol) * len);
+	perf_pmu_events_list = zalloc(sizeof(struct perf_pmu_event_symbol) * len);
 	if (!perf_pmu_events_list)
 		return;
-	perf_pmu_events_list_num = len;
 
 	len = 0;
 	pmu = NULL;
 	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
 		list_for_each_entry(alias, &pmu->aliases, list) {
 			struct perf_pmu_event_symbol *p = perf_pmu_events_list + len;
-			char *tmp = strchr(alias->name, '-');
+			char *prefix = strdup(alias->name);
+			char *tmp = strchr(prefix, '-');
+
+			if (tmp != NULL)
+				*tmp = 0;
+
+			/*
+			 * Skip any prefix that conflicts with pmu name,
+			 * otherwise the event parser gets confused.
+			 */
+			if (perf_pmu__find(prefix)) {
+				pr_debug2("perf_pmu__parse_init: skipping conflicting alias '%s'\n",
+					  alias->name);
+				free(prefix);
+				continue;
+			}
 
 			if (tmp != NULL) {
-				SET_SYMBOL(strndup(alias->name, tmp - alias->name),
-						PMU_EVENT_SYMBOL_PREFIX);
+				SET_SYMBOL(prefix, PMU_EVENT_SYMBOL_PREFIX);
 				p++;
 				SET_SYMBOL(strdup(++tmp), PMU_EVENT_SYMBOL_SUFFIX);
 				len += 2;
 			} else {
-				SET_SYMBOL(strdup(alias->name), PMU_EVENT_SYMBOL);
+				SET_SYMBOL(prefix, PMU_EVENT_SYMBOL);
 				len++;
 			}
 		}
 	}
+
+	/* unlikely, but still.. */
+	if (!len)
+		goto err;
+	perf_pmu_events_list_num = len;
+
 	qsort(perf_pmu_events_list, len,
 		sizeof(struct perf_pmu_event_symbol), comp_pmu);
 

