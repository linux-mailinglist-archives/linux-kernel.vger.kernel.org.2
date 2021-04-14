Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0D935FB91
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 21:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348263AbhDNTVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 15:21:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26058 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353343AbhDNTU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 15:20:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618428037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UphdTTPmEmUSjyaceF0LEvVjd0amxlrNI6FMP1n6uYE=;
        b=iQMxnwMYtfC8pZyFp7zn1lIK3yDoOpZPuGUF9s08gTLHzBPeN4AH5YBL5LJCQh3JhFfJRo
        GKSLYJqWM7piI28ftAqd6J5GB55ZSSa4BeEKuwZ8jS9Nhu3QtRUQyArwdMTl7SQw/cgyNm
        YesEjUwxNxl/u7v1rj+TNBWpwoK7mlY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-Lk-qWu35NdyslZNuGmUBHQ-1; Wed, 14 Apr 2021 15:20:35 -0400
X-MC-Unique: Lk-qWu35NdyslZNuGmUBHQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87F326414C;
        Wed, 14 Apr 2021 19:20:33 +0000 (UTC)
Received: from krava (unknown [10.40.192.62])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6FA8210016FE;
        Wed, 14 Apr 2021 19:20:31 +0000 (UTC)
Date:   Wed, 14 Apr 2021 21:20:30 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>
Subject: Re: [PATCH v8 0/4] libperf userspace counter access
Message-ID: <YHdAfm/On2rcbM6C@krava>
References: <20210414155412.3697605-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414155412.3697605-1-robh@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 10:54:08AM -0500, Rob Herring wrote:
> I'm resending just the libperf userspace counter access without the Arm 
> bits so hopefully it can be picked up for 5.13. The Arm bits seem to be 
> a never ending review filled with long periods of silence. :(
> 
> Prior versions are here[1][2][3][4][5][6][7][8].
> 
> Rob
> 
> [1] https://lore.kernel.org/r/20190822144220.27860-1-raphael.gault@arm.com/
> [2] https://lore.kernel.org/r/20200707205333.624938-1-robh@kernel.org/
> [3] https://lore.kernel.org/r/20200828205614.3391252-1-robh@kernel.org/
> [4] https://lore.kernel.org/r/20200911215118.2887710-1-robh@kernel.org/
> [5] https://lore.kernel.org/r/20201001140116.651970-1-robh@kernel.org/
> [6] https://lore.kernel.org/r/20210114020605.3943992-1-robh@kernel.org/
> [7] https://lore.kernel.org/r/20210311000837.3630499-1-robh@kernel.org/
> [8] https://lore.kernel.org/r/20210413171606.1825808-1-robh@kernel.org/
> 
> Rob Herring (4):
>   tools/include: Add an initial math64.h
>   libperf: Add evsel mmap support
>   libperf: tests: Add support for verbose printing
>   libperf: Add support for user space counter access

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> 
>  tools/include/linux/math64.h             | 75 ++++++++++++++++++++
>  tools/lib/perf/Documentation/libperf.txt |  3 +
>  tools/lib/perf/evsel.c                   | 80 +++++++++++++++++++++
>  tools/lib/perf/include/internal/evsel.h  |  1 +
>  tools/lib/perf/include/internal/mmap.h   |  3 +
>  tools/lib/perf/include/internal/tests.h  | 32 +++++++++
>  tools/lib/perf/include/perf/evsel.h      |  3 +
>  tools/lib/perf/libperf.map               |  3 +
>  tools/lib/perf/mmap.c                    | 88 ++++++++++++++++++++++++
>  tools/lib/perf/tests/Makefile            |  6 +-
>  tools/lib/perf/tests/test-evsel.c        | 66 ++++++++++++++++++
>  11 files changed, 358 insertions(+), 2 deletions(-)
>  create mode 100644 tools/include/linux/math64.h
> 
> -- 
> 2.27.0
> 

