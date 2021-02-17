Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4EE31DFDD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 20:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbhBQTzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 14:55:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57039 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232196AbhBQTz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 14:55:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613591642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gBN8RI26J3keJJZWMi3gXBCrwNdQ5B+Mt1QnPXk96sc=;
        b=DR/sx3PEnH16AaZBOiFDZBZbIac8Ic61FthYdvT0HOuc/mLmHTur6BxyQOcWfxZ4APFk1T
        5/Le4+pH0BOp2w1mGAL0hIHeGQfIOJk+I3SsX+isnSgcEnzBO3232BYqqJle/EmDfvsoj2
        2kwI+4b84eED+nTq7pQZ4yfZ7yLNrQU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-O2tsGgUWOPyhEckZZZnynw-1; Wed, 17 Feb 2021 14:53:58 -0500
X-MC-Unique: O2tsGgUWOPyhEckZZZnynw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 988BF1030980;
        Wed, 17 Feb 2021 19:53:55 +0000 (UTC)
Received: from krava (unknown [10.40.195.160])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4207E6B8D4;
        Wed, 17 Feb 2021 19:53:52 +0000 (UTC)
Date:   Wed, 17 Feb 2021 20:53:51 +0100
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
Subject: Re: [PATCH 2/2] perf buildid-cache: Add test for 16-byte build-id
Message-ID: <YC10TxP0HKLf8trI@krava>
References: <d1c87379-8837-a5e7-eb44-f063ca0f4766@codeweavers.com>
 <94758ca1-0031-d7c6-6c6a-900fd77ef695@codeweavers.com>
 <27b38347-f71b-5d6c-3190-4c900e864d5d@codeweavers.com>
 <881e2645-263a-b4c7-1f2a-a068f25c1ef7@codeweavers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <881e2645-263a-b4c7-1f2a-a068f25c1ef7@codeweavers.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 04:06:44PM -0500, Nicholas Fraser wrote:
> tests/shell/buildid.sh added an ELF executable with an MD5 build-id to
> the perf debug cache but did not check whether the object was printed
> by a subsequent call to "perf buildid-cache -l". It was being omitted
> from the list.
> 
> A previous commit fixed the bug that left it out of the list. This adds
> a test for it.
> 
> Signed-off-by: Nicholas Fraser <nfraser@codeweavers.com>

Acked-by: Jiri Olsa <jolsa@redhat.com>

few nits below

> ---
>  tools/perf/tests/shell/buildid.sh | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/perf/tests/shell/buildid.sh b/tools/perf/tests/shell/buildid.sh
> index 4861a20edee2..de02a23b7c7b 100755
> --- a/tools/perf/tests/shell/buildid.sh
> +++ b/tools/perf/tests/shell/buildid.sh
> @@ -50,6 +50,12 @@ check()
>  		exit 1
>  	fi
>  
> +	${perf} buildid-cache -l|grep $id

please make space before and after '|'
and use ${id} instead of $id, we use that all over the script

thanks,
jirka


> +	if [ $? -ne 0 ]; then
> +		echo "failed: ${id} is not reported by \"perf buildid-cache -l\""
> +		exit 1
> +	fi
> +
>  	echo "OK for ${1}"
>  }
>  
> -- 
> 2.30.1
> 

