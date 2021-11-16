Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50AFD45335F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 14:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236902AbhKPOAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 09:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236953AbhKPOAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 09:00:38 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54634C061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 05:57:41 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 133so17089876wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 05:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=czQYblp0zgAV+YCvrQJmphHgmDDB70J1rcuR+hc1jL0=;
        b=Hv5EIh28LAn/jDH20bl/EzdKWL9UBJqQGqFzVfD7o6qctL1feG1XytrbQ+eBji/FQo
         +jqKQRi0sBHRJryE8ib3lI5zg0Prdf1YruFAG4C8EC3AIZsTPqMk4QD9OfMyteqgva0G
         r6lzKrlhq6VvcaG23Z7qvuA4GqE/u96wFURt5f7PnWDAX4t1OpfGatNgOEMThDP4qS4t
         l4cuzHy3baMjogAT+RwEu1iqTA4RljJ1QeHGiUouaSw8YkHhjvzTwYcgBXoIkxeHv+7k
         QNe8RTgVaj6ZmL8i1iemR7rp+EgYrcgGALuZGsVENu653f+ACkQDXD44OwqiFCn7JW/i
         f4EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=czQYblp0zgAV+YCvrQJmphHgmDDB70J1rcuR+hc1jL0=;
        b=ofEeH01h+FqSlpaxtbE+bK2m+MOu+YoZ7Br+eNwYSHKOjHoIImEt4ky5q0uWIAq8oe
         6TFmrmz+nm1w5EE8r2GdWhq4etZqCwl+mOvYYvZsd5x4+ponG4tfP7qpvxuM/Y4G0tq6
         bMHkRbT5I/7nKKoVK9HaqnJiHdNo+ff+XoKowg60wIPRva8j6gGQFa1suIT1zfFkKy+H
         UXpF1GYmxPQZrwn9Mvk4TbBtDNWw4WYrWGX2Lb0UZuPtwpONv3/5fHrKdeP8inDH/I1u
         Ibmpjpm7P6n6HS0gplMnIemLPbjxKBw8wKuuYjMGapp89TKNcTE8RI8N3HAI6Ly5ecnA
         WmVg==
X-Gm-Message-State: AOAM531jRzq/2Xx4HSbTComhmATITTOY7NVSAPnORF1CJ9aKIf4K7GJe
        iJ//TTBBjzmWbhPR2PGMvM08zw==
X-Google-Smtp-Source: ABdhPJxoFqhe/4nZuGv1S0NlwQyvuS5IQH2O148D+gI46TPfM8tCKxOx87N4Ji0HxBXiv2YefBoudQ==
X-Received: by 2002:a05:600c:4154:: with SMTP id h20mr67679498wmm.189.1637071059802;
        Tue, 16 Nov 2021 05:57:39 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:ee27:74df:199e:beab])
        by smtp.gmail.com with ESMTPSA id t8sm17491703wrv.30.2021.11.16.05.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 05:57:38 -0800 (PST)
Date:   Tue, 16 Nov 2021 14:57:33 +0100
From:   Marco Elver <elver@google.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Fabian Hemmer <copy@copy.sh>, Ian Rogers <irogers@google.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: Re: [PATCH] perf test: Add basic stress test for sigtrap handling
Message-ID: <YZO4zVusjQ+zu9PJ@elver.google.com>
References: <20211115112822.4077224-1-elver@google.com>
 <YZOpSVOCXe0zWeRs@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZOpSVOCXe0zWeRs@kernel.org>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 09:51AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Nov 15, 2021 at 12:28:23PM +0100, Marco Elver escreveu:
> > Add basic stress test for sigtrap handling as a perf tool built-in test.
> > This allows sanity checking the basic sigtrap functionality from within
> > the perf tool.
> 
> Works as root:
> 
> [root@five ~]# perf test sigtrap
> 73: Sigtrap                                                         : Ok
> [root@five ~]
> 
> Not for !root:
[...]
> FAILED sys_perf_event_open(): Permission denied
> test child finished with -1
> ---- end ----
> Sigtrap: FAILED!

Ah, that shouldn't be the case. It's missing exclude_kernel/hv, and this
test should work just fine as non-root. Please squash the below as well.
Let me know if you'd like a v2.

Ack for your change printing errors as well.

Thanks,
-- Marco

------ >8 ------

From: Marco Elver <elver@google.com>
Date: Tue, 16 Nov 2021 14:52:18 +0100
Subject: [PATCH] fixup! perf test: Add basic stress test for sigtrap handling

Exclude kernel/hypervisor so the test can run as non-root.

Signed-off-by: Marco Elver <elver@google.com>
---
 tools/perf/tests/sigtrap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/tests/sigtrap.c b/tools/perf/tests/sigtrap.c
index febfa1609356..e566f855bf74 100644
--- a/tools/perf/tests/sigtrap.c
+++ b/tools/perf/tests/sigtrap.c
@@ -46,6 +46,8 @@ static struct perf_event_attr make_event_attr(void)
 		.remove_on_exec = 1, /* Required by sigtrap. */
 		.sigtrap	= 1, /* Request synchronous SIGTRAP on event. */
 		.sig_data	= TEST_SIG_DATA,
+		.exclude_kernel = 1,
+		.exclude_hv	= 1,
 	};
 	return attr;
 }
-- 
2.34.0.rc1.387.gb447b232ab-goog

