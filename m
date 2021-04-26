Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDD4636BB32
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 23:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237001AbhDZV21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 17:28:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60683 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234146AbhDZV2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 17:28:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619472461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o3JpOlUQxKikE6j4QEgKul9bAOYHZGdHCW6yEmwN6gQ=;
        b=U+euS1wjh3EGrhi514bTUC7ElRNFDwdjiv/LEh3EfmaIaNjcmtrCUk2mCNuqTxyQ15wH+B
        oxHeBIDvp8AAcUSQOuVJH2WlvxEYsF7TmMX1Zj2Zn8ID50DMWUIKIA+ZPHXtfscvNFfOHx
        rt+U4eVdJpJMfgUAoFDzLXVYxQ05yIc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-Kug2PHRzNzCy8RzPRlPTAA-1; Mon, 26 Apr 2021 17:27:38 -0400
X-MC-Unique: Kug2PHRzNzCy8RzPRlPTAA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A563D1922964;
        Mon, 26 Apr 2021 21:27:37 +0000 (UTC)
Received: from krava (unknown [10.40.193.34])
        by smtp.corp.redhat.com (Postfix) with SMTP id BFE2218A73;
        Mon, 26 Apr 2021 21:27:35 +0000 (UTC)
Date:   Mon, 26 Apr 2021 23:27:34 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <song@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, acme@kernel.org,
        acme@redhat.com, namhyung@kernel.org, jolsa@kernel.org,
        songliubraving@fb.com
Subject: Re: [PATCH v5 5/5] perf-stat: introduce bpf_counter_ops->disable()
Message-ID: <YIcwRj4WtsZln4SR@krava>
References: <20210425214333.1090950-1-song@kernel.org>
 <20210425214333.1090950-6-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210425214333.1090950-6-song@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 25, 2021 at 02:43:33PM -0700, Song Liu wrote:

SNIP

> +static inline int bpf_counter__disable(struct evsel *evsel __maybe_unused)
> +{
> +	return 0;
> +}
> +
>  static inline int bpf_counter__read(struct evsel *evsel __maybe_unused)
>  {
>  	return -EAGAIN;
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index d29a8a118973c..e71041c890102 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -17,6 +17,7 @@
>  #include "evsel.h"
>  #include "debug.h"
>  #include "units.h"
> +#include "bpf_counter.h"
>  #include <internal/lib.h> // page_size
>  #include "affinity.h"
>  #include "../perf.h"
> @@ -421,6 +422,9 @@ static void __evlist__disable(struct evlist *evlist, char *evsel_name)
>  	if (affinity__setup(&affinity) < 0)
>  		return;
>  
> +	evlist__for_each_entry(evlist, pos)
> +		bpf_counter__disable(pos);

I was wondering why you don't check evsel__is_bpf like
for the enable case.. and realized that we don't skip
bpf evsels in __evlist__enable and __evlist__disable
like we do in read_affinity_counters

so I guess there's extra affinity setup and bunch of
wrong ioctls being called?

jirka


> +
>  	/* Disable 'immediate' events last */
>  	for (imm = 0; imm <= 1; imm++) {
>  		evlist__for_each_cpu(evlist, i, cpu) {
> -- 
> 2.30.2
> 

