Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E00E535826F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 13:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhDHLrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 07:47:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30510 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229751AbhDHLru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 07:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617882459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IU7HxOgQxmIHcfsaSQ1rVC0Q+7uDBaSJdYZdiaRrPmU=;
        b=LSIeiwQp441ygAZ7ILbhiyMr7EejcLF1uubQy7I9SL5eTqbFdtpvLNndhYdEtC5pO3PHm6
        SEhsACKEh6qo2gwmZ4PEAMr99nzmC0tyJMrMuUkCLH58Ux/1YW3cG+xoMEP2wXAG3Op5+S
        I8HrXrAqrDz7JENOSG7T85hyZ94VIZI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-DGPnVRFEOCm-1gbxg2nVHg-1; Thu, 08 Apr 2021 07:47:35 -0400
X-MC-Unique: DGPnVRFEOCm-1gbxg2nVHg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D667C1FA3;
        Thu,  8 Apr 2021 11:47:33 +0000 (UTC)
Received: from krava (unknown [10.40.195.201])
        by smtp.corp.redhat.com (Postfix) with SMTP id 30FF360BF1;
        Thu,  8 Apr 2021 11:47:32 +0000 (UTC)
Date:   Thu, 8 Apr 2021 13:47:31 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <song@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, acme@kernel.org,
        acme@redhat.com, namhyung@kernel.org, jolsa@kernel.org,
        songliubraving@fb.com
Subject: Re: [PATCH v2 3/3] perf-stat: introduce config
 stat.bpf-counter-events
Message-ID: <YG7tU/mVxQZLNCYL@krava>
References: <20210407003601.619158-1-song@kernel.org>
 <20210407003601.619158-4-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407003601.619158-4-song@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 05:36:01PM -0700, Song Liu wrote:
> Currently, to use BPF to aggregate perf event counters, the user uses
> --bpf-counters option. Enable "use bpf by default" events with a config
> option, stat.bpf-counter-events. This is limited to hardware events in
> evsel__hw_names.
> 
> This also enables mixed BPF event and regular event in the same sesssion.
> For example:
> 
>    perf config stat.bpf-counter-events=instructions
>    perf stat -e instructions,cs
> 

so if we are mixing events now, how about uing modifier for bpf counters,
instead of configuring .perfconfig list we could use:

  perf stat -e instructions:b,cs

thoughts?

the change below adds 'b' modifier and sets 'evsel::bpf_counter',
feel free to use it

jirka


---
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index ca52581f1b17..c55e4e58d1dc 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -82,6 +82,7 @@ struct evsel {
 		bool			auto_merge_stats;
 		bool			collect_stat;
 		bool			weak_group;
+		bool			bpf_counter;
 		int			bpf_fd;
 		struct bpf_object	*bpf_obj;
 	};
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 9ecb45bea948..b5850f1ea90b 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1801,6 +1801,7 @@ struct event_modifier {
 	int pinned;
 	int weak;
 	int exclusive;
+	int bpf_counter;
 };
 
 static int get_event_modifier(struct event_modifier *mod, char *str,
@@ -1821,6 +1822,7 @@ static int get_event_modifier(struct event_modifier *mod, char *str,
 	int exclude = eu | ek | eh;
 	int exclude_GH = evsel ? evsel->exclude_GH : 0;
 	int weak = 0;
+	int bpf_counter = 0;
 
 	memset(mod, 0, sizeof(*mod));
 
@@ -1864,6 +1866,8 @@ static int get_event_modifier(struct event_modifier *mod, char *str,
 			exclusive = 1;
 		} else if (*str == 'W') {
 			weak = 1;
+		} else if (*str == 'b') {
+			bpf_counter = 1;
 		} else
 			break;
 
@@ -1895,6 +1899,7 @@ static int get_event_modifier(struct event_modifier *mod, char *str,
 	mod->sample_read = sample_read;
 	mod->pinned = pinned;
 	mod->weak = weak;
+	mod->bpf_counter = bpf_counter;
 	mod->exclusive = exclusive;
 
 	return 0;
@@ -1909,7 +1914,7 @@ static int check_modifier(char *str)
 	char *p = str;
 
 	/* The sizeof includes 0 byte as well. */
-	if (strlen(str) > (sizeof("ukhGHpppPSDIWe") - 1))
+	if (strlen(str) > (sizeof("ukhGHpppPSDIWeb") - 1))
 		return -1;
 
 	while (*p) {
@@ -1950,6 +1955,7 @@ int parse_events__modifier_event(struct list_head *list, char *str, bool add)
 		evsel->sample_read         = mod.sample_read;
 		evsel->precise_max         = mod.precise_max;
 		evsel->weak_group	   = mod.weak;
+		evsel->bpf_counter         = mod.bpf_counter;
 
 		if (evsel__is_group_leader(evsel)) {
 			evsel->core.attr.pinned = mod.pinned;
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 0b36285a9435..fb8646cc3e83 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -210,7 +210,7 @@ name_tag	[\'][a-zA-Z_*?\[\]][a-zA-Z0-9_*?\-,\.\[\]:=]*[\']
 name_minus	[a-zA-Z_*?][a-zA-Z0-9\-_*?.:]*
 drv_cfg_term	[a-zA-Z0-9_\.]+(=[a-zA-Z0-9_*?\.:]+)?
 /* If you add a modifier you need to update check_modifier() */
-modifier_event	[ukhpPGHSDIWe]+
+modifier_event	[ukhpPGHSDIWeb]+
 modifier_bp	[rwx]{1,3}
 
 %%

