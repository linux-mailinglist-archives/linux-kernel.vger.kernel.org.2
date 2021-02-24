Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 592BF3240BC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 16:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236552AbhBXPXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 10:23:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33517 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235046AbhBXOn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 09:43:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614177744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8ZK2e6d8sxshnwS/3YhNwbMwKAMlcMdaChQDmmL4XLo=;
        b=J93GYW2ApCg2rf5TdCp+Kkwxmwfu72Mla557JnWWSQfxlwv3EFWae+t2WRkI8MxQ5YSQlL
        0UMb78n1IVv7FimroK3ouisH8ot6nHZazL02pBlTRfaqfLYxjVoxKFJEQVUe4yXRvOiitC
        ictCtqEdtqF5b9j8u5Dcwbc3kOYClWI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-gKR4G8NlM2OragQ9JOWcBA-1; Wed, 24 Feb 2021 09:42:17 -0500
X-MC-Unique: gKR4G8NlM2OragQ9JOWcBA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43DA010168DB;
        Wed, 24 Feb 2021 13:50:24 +0000 (UTC)
Received: from krava (unknown [10.40.193.200])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8F7655C1CF;
        Wed, 24 Feb 2021 13:50:21 +0000 (UTC)
Date:   Wed, 24 Feb 2021 14:50:20 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Nicholas Fraser <nfraser@codeweavers.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        Ulrich Czekalla <uczekalla@codeweavers.com>,
        Huw Davies <huw@codeweavers.com>
Subject: Re: [PATCH 1/2] perf archive: Fix filtering of empty build-ids
Message-ID: <YDZZnDBSsRCtekK3@krava>
References: <442bffc7-ac5c-0975-b876-a549efce2413@codeweavers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <442bffc7-ac5c-0975-b876-a549efce2413@codeweavers.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 11:09:32AM -0500, Nicholas Fraser wrote:
> A non-existent build-id used to be treated as all-zero SHA-1 hash.
> Build-ids are now variable width. A non-existent build-id is an empty
> string and "perf buildid-list" pads this with spaces. This is true even
> when using old perf.data files recorded from older versions of perf;
> "perf buildid-list" never reports an all-zero hash anymore.
> 
> This fixes "perf-archive" to skip missing build-ids by skipping lines
> that start with a padding space rather than with zeroes.
> 
> Signed-off-by: Nicholas Fraser <nfraser@codeweavers.com>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/perf-archive.sh | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/perf/perf-archive.sh b/tools/perf/perf-archive.sh
> index 0cfb3e2cefef..133f0eddbcc4 100644
> --- a/tools/perf/perf-archive.sh
> +++ b/tools/perf/perf-archive.sh
> @@ -20,9 +20,8 @@ else
>  fi
>  
>  BUILDIDS=$(mktemp /tmp/perf-archive-buildids.XXXXXX)
> -NOBUILDID=0000000000000000000000000000000000000000
>  
> -perf buildid-list -i $PERF_DATA --with-hits | grep -v "^$NOBUILDID " > $BUILDIDS
> +perf buildid-list -i $PERF_DATA --with-hits | grep -v "^ " > $BUILDIDS
>  if [ ! -s $BUILDIDS ] ; then
>  	echo "perf archive: no build-ids found"
>  	rm $BUILDIDS || true
> -- 
> 2.30.1
> 

