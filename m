Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5567B325555
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 19:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbhBYSSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 13:18:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42484 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231895AbhBYSSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 13:18:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614277011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=91KG0dW4h8eaWVtd75/f30WhAILKsN5As4nR1hNXNAQ=;
        b=TrCRaRzlzPNwDdVTsbNrrEXi5KCG5TKtUDxCuVTfObt4ckqHpqaRID6VkbVVoxyh7D4CPP
        L0IPenDKrDUZTxnM1g8//4mQrh8lyZyl7yqdUP5rdM9AQZ5/Rtf6miD8NQwGK8hs1VRBgE
        P+IbpxMdqZhunq740SIH+jlD5AMvk9Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-EH_OXAIdOLS5_Rd1Seojpg-1; Thu, 25 Feb 2021 13:16:46 -0500
X-MC-Unique: EH_OXAIdOLS5_Rd1Seojpg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A3FF106BAEE;
        Thu, 25 Feb 2021 18:16:44 +0000 (UTC)
Received: from krava (unknown [10.40.192.91])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 16A225D9D2;
        Thu, 25 Feb 2021 18:16:40 +0000 (UTC)
Date:   Thu, 25 Feb 2021 19:16:39 +0100
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
Message-ID: <YDfph8b9p8sSk1AF@krava>
References: <20210224074841.GD6114@xsang-OptiPlex-9020>
 <cabd8692-07ca-13c8-efb5-e088b4547f80@linux.intel.com>
 <YDenRVGzh5Dv1pC2@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YDenRVGzh5Dv1pC2@krava>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 02:33:57PM +0100, Jiri Olsa wrote:
> On Thu, Feb 25, 2021 at 04:06:23PM +0800, Jin, Yao wrote:
> > Hi Chris, Arnaldo, Jiri,
> > 
> > We observe the parsing error for "software/xxx/" on some platforms.
> > 
> > For example,
> > 
> > # perf stat -e software/r1a/ -a -- sleep 1
> > event syntax error: 'software/r1a/'
> >                      \___ parser error
> > Run 'perf list' for a list of valid events
> > 
> >  Usage: perf stat [<options>] [<command>]
> > 
> >     -e, --event <event>   event selector. use 'perf list' to list available events
> > 
> > And perf test is failed too.
> > 
> > # perf test 6 -vv
> > ...
> > running test 4 'software/r1a/'failed to parse event 'software/r1a/', err 1, str 'parser error'
> > event syntax error: 'software/r1a/'
> >                      \___ parser error
> > 
> > running test 4 'software/r0x1a/'failed to parse event 'software/r0x1a/', err 1, str 'parser error'
> > event syntax error: 'software/r0x1a/'
> >                      \___ parser error
> > ...
> > 
> > The issue should be the conflict between event "i915/software-gt-awake-time/" and pmu "software".
> > 
> > # perf list | grep i915/software
> >   i915/software-gt-awake-time/                       [Kernel PMU event]
> > 
> > Perf supports the event format as "prefix-xxx-suffix", so the "software"
> > string in "software-gt-awake-time" is added to perf_pmu_events_list as
> > PMU_EVENT_SYMBOL_PREFIX. When parsing the string such as "software/xxx/",
> > it’s parsed as PMU_EVENT_SYMBOL_PREFIX for "software", then it would error
> > out in next processing.
> > 
> > So the easy way is to rename "software-gt-awake-time" to "gt-awake-time",
> > right? Otherwise we have to hardcode something in perf tool.
> > 
> > What do you think of this issue and the solution?
> > 
> > BTW, as the robot reported, it's related to the commit 8c3b1ba0e7ea
> > ("drm/i915/gt: Track the overall awake/busy time").
> 
> yes, I think you're right.. I'll try to reproduce and check on this
> 
> I'm still not clear why is that parsing fail if those 2 events are
> distinguished by - and / ... but yep, we are asking for trouble in
> here ;-)
> 
> I think we could either prioritaze one or add extra check when we
> add prefix-xxx-suffix events and do not add ones that have conflict..
> that seems like best solution to me now

would patch below work for you?

jirka


---
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 42c84adeb2fb..e1d0f1028401 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2041,8 +2041,16 @@ static void perf_pmu__parse_init(void)
 			char *tmp = strchr(alias->name, '-');
 
 			if (tmp != NULL) {
-				SET_SYMBOL(strndup(alias->name, tmp - alias->name),
-						PMU_EVENT_SYMBOL_PREFIX);
+				char *prefix = strndup(alias->name, tmp - alias->name);
+
+				if (perf_pmu__find(prefix)) {
+					pr_debug("perf_pmu__parse_init: skipping conflicting alias '%s'\n",
+						 alias->name);
+					free(prefix);
+					continue;
+				}
+
+				SET_SYMBOL(prefix, PMU_EVENT_SYMBOL_PREFIX);
 				p++;
 				SET_SYMBOL(strdup(++tmp), PMU_EVENT_SYMBOL_SUFFIX);
 				len += 2;

