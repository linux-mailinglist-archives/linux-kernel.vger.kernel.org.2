Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A03D338C73
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 13:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhCLMNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 07:13:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56464 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229532AbhCLMM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 07:12:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615551176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WwtaaYJsAPHM2MQ6ykC4hJpMyE8cn0R0tH+/nW3nDi0=;
        b=e9v33kfyLkcw93GUARor8mTZPeYVeDVCvzacokZmUdltnPtEEeP9CZCr8VWSiCAyfDooSL
        1Lz6gtWfZrHqUv60fRxW0CY1NunErjGOrCj+8FKeBLMQtz6VGQJL0pyyMggzhDnUgosIRF
        0CFzzqCo+1ioipKx/Bb0pZYWpCzF2MU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4--aUv8mjAMf29uGRGbXbf8g-1; Fri, 12 Mar 2021 07:12:52 -0500
X-MC-Unique: -aUv8mjAMf29uGRGbXbf8g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49F3680006E;
        Fri, 12 Mar 2021 12:12:51 +0000 (UTC)
Received: from krava (unknown [10.40.192.54])
        by smtp.corp.redhat.com (Postfix) with SMTP id 775375DDAD;
        Fri, 12 Mar 2021 12:12:49 +0000 (UTC)
Date:   Fri, 12 Mar 2021 13:12:48 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, acme@kernel.org,
        acme@redhat.com, namhyung@kernel.org, jolsa@kernel.org
Subject: Re: [PATCH] perf-stat: introduce bperf, share hardware PMCs with BPF
Message-ID: <YEtawFnompBDKpK0@krava>
References: <20210312020257.197137-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312020257.197137-1-songliubraving@fb.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 06:02:57PM -0800, Song Liu wrote:
> perf uses performance monitoring counters (PMCs) to monitor system
> performance. The PMCs are limited hardware resources. For example,
> Intel CPUs have 3x fixed PMCs and 4x programmable PMCs per cpu.
> 
> Modern data center systems use these PMCs in many different ways:
> system level monitoring, (maybe nested) container level monitoring, per
> process monitoring, profiling (in sample mode), etc. In some cases,
> there are more active perf_events than available hardware PMCs. To allow
> all perf_events to have a chance to run, it is necessary to do expensive
> time multiplexing of events.
> 
> On the other hand, many monitoring tools count the common metrics (cycles,
> instructions). It is a waste to have multiple tools create multiple
> perf_events of "cycles" and occupy multiple PMCs.
> 
> bperf tries to reduce such wastes by allowing multiple perf_events of
> "cycles" or "instructions" (at different scopes) to share PMUs. Instead
> of having each perf-stat session to read its own perf_events, bperf uses
> BPF programs to read the perf_events and aggregate readings to BPF maps.
> Then, the perf-stat session(s) reads the values from these BPF maps.
> 
> Please refer to the comment before the definition of bperf_ops for the
> description of bperf architecture.
> 
> bperf is off by default. To enable it, pass --use-bpf option to perf-stat.
> bperf uses a BPF hashmap to share information about BPF programs and maps
> used by bperf. This map is pinned to bpffs. The default address is
> /sys/fs/bpf/bperf_attr_map. The user could change the address with option
> --attr-map.

nice, I recall the presentation about that and was wondering
when this will come up ;-)

> 
> ---
> Known limitations:
> 1. Do not support per cgroup events;
> 2. Do not support monitoring of BPF program (perf-stat -b);
> 3. Do not support event groups.
> 
> The following commands have been tested:
> 
>    perf stat --use-bpf -e cycles -a
>    perf stat --use-bpf -e cycles -C 1,3,4
>    perf stat --use-bpf -e cycles -p 123
>    perf stat --use-bpf -e cycles -t 100,101

I assume the output is same as standard perf?

jirka

