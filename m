Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7269531DFE1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 20:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbhBQTz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 14:55:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54551 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232196AbhBQTzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 14:55:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613591650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X0iUMET3apekVXH6rEyg15tn94AvSxyWLiw3xeT+m28=;
        b=jNe82RoJoU9qasWI+JcQ7UdaAKyfduIOcZtINkVikjVxlF7GlyHORqBsGVgY3+lEl51m7y
        i0jQW/0dgzUCTXiGBZ2zYhpcaU7vpcHQKuQmH5dKYnTX5u01DW3uEvAExHvMBxYJUGP6tt
        Je3Xhb0QMX49REEQNcfZKNAdmQ5RbX8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-553-brBdVrt7NFGsnetgIpHptw-1; Wed, 17 Feb 2021 14:54:06 -0500
X-MC-Unique: brBdVrt7NFGsnetgIpHptw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 337B479ED6;
        Wed, 17 Feb 2021 19:54:04 +0000 (UTC)
Received: from krava (unknown [10.40.195.160])
        by smtp.corp.redhat.com (Postfix) with SMTP id F214018B5E;
        Wed, 17 Feb 2021 19:54:00 +0000 (UTC)
Date:   Wed, 17 Feb 2021 20:54:00 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Nicholas Fraser <nfraser@codeweavers.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Tommi Rantala <tommi.t.rantala@nokia.com>,
        Remi Bernon <rbernon@codeweavers.com>,
        linux-kernel@vger.kernel.org,
        Ulrich Czekalla <uczekalla@codeweavers.com>,
        Huw Davies <huw@codeweavers.com>
Subject: Re: [PATCH 1/4] perf buildid-cache: Don't skip 16-byte build-ids
Message-ID: <YC10WPYjps4Z0H8B@krava>
References: <597788e4-661d-633f-857c-3de700115d02@codeweavers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <597788e4-661d-633f-857c-3de700115d02@codeweavers.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 02:17:25PM -0500, Nicholas Fraser wrote:
> lsdir_bid_tail_filter() ignored any build-id that wasn't exactly 20
> bytes. This worked only for SHA-1 build-ids. The build-id for a PE file
> is always a 16-byte GUID and ELF files can also have MD5 or UUID
> build-ids.
> 
> This fix changes the filter to allow build-ids between 16 and 20 bytes.
> 
> Signed-off-by: Nicholas Fraser <nfraser@codeweavers.com>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/util/build-id.c | 5 +++--
>  tools/perf/util/build-id.h | 4 +++-
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> index 02df36b30ac5..e32e8f2ff3bd 100644
> --- a/tools/perf/util/build-id.c
> +++ b/tools/perf/util/build-id.c
> @@ -448,7 +448,8 @@ static bool lsdir_bid_tail_filter(const char *name __maybe_unused,
>  	int i = 0;
>  	while (isxdigit(d->d_name[i]) && i < SBUILD_ID_SIZE - 3)
>  		i++;
> -	return (i == SBUILD_ID_SIZE - 3) && (d->d_name[i] == '\0');
> +	return (i >= SBUILD_ID_MIN_SIZE - 3) && (i <= SBUILD_ID_SIZE - 3) &&
> +		(d->d_name[i] == '\0');
>  }
>  
>  struct strlist *build_id_cache__list_all(bool validonly)
> @@ -490,7 +491,7 @@ struct strlist *build_id_cache__list_all(bool validonly)
>  		}
>  		strlist__for_each_entry(nd2, linklist) {
>  			if (snprintf(sbuild_id, SBUILD_ID_SIZE, "%s%s",
> -				     nd->s, nd2->s) != SBUILD_ID_SIZE - 1)
> +				     nd->s, nd2->s) > SBUILD_ID_SIZE - 1)
>  				goto err_out;
>  			if (validonly && !build_id_cache__valid_id(sbuild_id))
>  				continue;
> diff --git a/tools/perf/util/build-id.h b/tools/perf/util/build-id.h
> index 02613f4b2c29..c19617151670 100644
> --- a/tools/perf/util/build-id.h
> +++ b/tools/perf/util/build-id.h
> @@ -2,8 +2,10 @@
>  #ifndef PERF_BUILD_ID_H_
>  #define PERF_BUILD_ID_H_ 1
>  
> -#define BUILD_ID_SIZE	20
> +#define BUILD_ID_SIZE	20 /* SHA-1 length in bytes */
> +#define BUILD_ID_MIN_SIZE	16 /* MD5/UUID/GUID length in bytes */
>  #define SBUILD_ID_SIZE	(BUILD_ID_SIZE * 2 + 1)
> +#define SBUILD_ID_MIN_SIZE	(BUILD_ID_MIN_SIZE * 2 + 1)
>  
>  #include "machine.h"
>  #include "tool.h"
> -- 
> 2.30.0
> 

