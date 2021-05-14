Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4983805C5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 11:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233814AbhENJE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 05:04:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25461 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229981AbhENJEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 05:04:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620982992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hm6jRqClmC4rVRaiD7d7zTb0E35AjExK+thFxiDo1y4=;
        b=c0ii9evUYliBVsnXIHgSlPWfKyM5yzVGt6xZDPVpkhDcaWvSU/41m+m/7O2Rpgvzk58pJl
        XoubOt51dHS/PjYSWDPucxSZ/OJVqVkBVpXucMghjISpMEkXszBrmlVD894eMrnT5qokqF
        /UXqmpnrjp9//dJmF2IGJgt799rr4+0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-fhytkV-xOk6Z0ar6IoKp6g-1; Fri, 14 May 2021 05:03:08 -0400
X-MC-Unique: fhytkV-xOk6Z0ar6IoKp6g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37BEE801B13;
        Fri, 14 May 2021 09:03:06 +0000 (UTC)
Received: from krava (unknown [10.40.193.71])
        by smtp.corp.redhat.com (Postfix) with SMTP id A7DBA5C8AA;
        Fri, 14 May 2021 09:03:02 +0000 (UTC)
Date:   Fri, 14 May 2021 11:03:01 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org,
        Matt Fleming <matt.fleming@intel.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/2] perf tests: Drop __maybe_unused on x86 test
 declarations
Message-ID: <YJ48xSO7fnj4wmtj@krava>
References: <20210513174614.2242210-1-robh@kernel.org>
 <20210513174614.2242210-2-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513174614.2242210-2-robh@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 12:46:14PM -0500, Rob Herring wrote:
> Function declarations don't need __maybe_unused annotations, only the
> implementations do. Drop them on the perf x86 tests.

for both patches:

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: linux-perf-users@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  tools/perf/arch/x86/include/arch-tests.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/include/arch-tests.h b/tools/perf/arch/x86/include/arch-tests.h
> index 462546bfc5f7..9599e7a3f1af 100644
> --- a/tools/perf/arch/x86/include/arch-tests.h
> +++ b/tools/perf/arch/x86/include/arch-tests.h
> @@ -2,12 +2,11 @@
>  #ifndef ARCH_TESTS_H
>  #define ARCH_TESTS_H
>  
> -#include <linux/compiler.h>
>  struct test;
>  
>  /* Tests */
> -int test__rdpmc(struct test *test __maybe_unused, int subtest);
> -int test__insn_x86(struct test *test __maybe_unused, int subtest);
> +int test__rdpmc(struct test *test, int subtest);
> +int test__insn_x86(struct test *test, int subtest);
>  int test__intel_pt_pkt_decoder(struct test *test, int subtest);
>  int test__bp_modify(struct test *test, int subtest);
>  int test__x86_sample_parsing(struct test *test, int subtest);
> -- 
> 2.27.0
> 

