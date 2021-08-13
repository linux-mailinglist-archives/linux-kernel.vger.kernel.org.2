Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D00D03EADC9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 02:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbhHMAKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 20:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhHMAJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 20:09:58 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE2AC061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 17:09:32 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id y3so9009866ilm.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 17:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kuq6BdgWAxP1f4LMxWmU1xZAFEtVPA57wWD2OHAVM3E=;
        b=T1ePQR0sqr6jY1bR01WvEo8+FErh9dD8co/P/8tXvu8RM4oMDVrFmY4vkKiM84F+Fc
         Ts4WHqs4kp04jhsPa97ylj8q6Hd+zZlKoNdTl3IwUJu5PCEY+wK6oKLSgdUJ9kL56812
         JzY4U/gUWnTSNOaca8zJVApkGWgwK9FLsXkWg819RdRaEx9mmyb2zDfB8yMm41UM1SdW
         dW7pKRm7UzuyshKAAQhn2LmemrdzgZTg8CjCijZD30QvswmML5n4aT3jupMnY8dBF9aT
         9edYixQ4g2wRn7frBSLv9sc5C6XL20d9igvOE5CjtByl6+6vh7MVN/IT5VAZaUkh+4pn
         fd+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kuq6BdgWAxP1f4LMxWmU1xZAFEtVPA57wWD2OHAVM3E=;
        b=g1iabv66rfuwfepuzKIriHsVmcQoLYwnhXkCh2rD8A9Qq+E1qD2KiMcrjY7Eh5CnKl
         IHY8fchrtcxUFabs2HxjCtZEPFPC5SkHf9uO49g1WV97KR3vm/RSdX9WN1FJrC8FOT7n
         3N2+KqP51Txe95c3csMYbENEDB+r9/EHvE2ph69P94pkndS68XStCaNGywr/atqz6GNL
         gxO9zmrrDidTzolkou1x09tRE60YuE819eLujefzou6Rw+BEROwfMGZaplcxHWGs3vP4
         LlGI+LMqmeY+joQpHKjOMAWZTnXeV3gJnR4U4so0/q9//mIXUUzjzxbuPtgxclye4D95
         7FwA==
X-Gm-Message-State: AOAM533LU54jjdVrGhpSrHtAND77xzNcRyWRmgH2NKXp8xzYtVjGrIoY
        8vxAGe81iLJCG0I7YnZJryF2MQEAT+S9w5mdEFwbTA==
X-Google-Smtp-Source: ABdhPJzPlLHRB+dFvtuGDqlizuDmCKYx+li4yB067XtpCHki1qOlJ4D4vJ2NFyQHCPJe8SWYLvUPaqJg0E27+gRRLaE=
X-Received: by 2002:a92:c68a:: with SMTP id o10mr783270ilg.163.1628813372083;
 Thu, 12 Aug 2021 17:09:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210812235738.1684583-1-namhyung@kernel.org>
In-Reply-To: <20210812235738.1684583-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 12 Aug 2021 17:09:20 -0700
Message-ID: <CAP-5=fVamifp3oua6OTCm3pCxM=RoiMATx90Ynm6JLnUso7zLA@mail.gmail.com>
Subject: Re: [PATCH] perf test: Do not compare overheads in the zstd comp test
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        James Clark <james.clark@arm.com>,
        Thomas Richter <tmricht@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2021 at 4:57 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> The overhead can vary on each run so it'd make the test failed
> sometimes.  Also order of hist entry can change.
>
> Use perf report -F option to omit the overhead field and sort the
> result alphabetically.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/record+zstd_comp_decomp.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/tests/shell/record+zstd_comp_decomp.sh b/tools/perf/tests/shell/record+zstd_comp_decomp.sh
> index 045723b3d992..8a168cf8bacc 100755
> --- a/tools/perf/tests/shell/record+zstd_comp_decomp.sh
> +++ b/tools/perf/tests/shell/record+zstd_comp_decomp.sh
> @@ -25,8 +25,8 @@ check_compressed_stats() {
>
>  check_compressed_output() {
>         $perf_tool inject -i $trace_file -o $trace_file.decomp &&
> -       $perf_tool report -i $trace_file --stdio | head -n -3 > $trace_file.comp.output &&
> -       $perf_tool report -i $trace_file.decomp --stdio | head -n -3 > $trace_file.decomp.output &&
> +       $perf_tool report -i $trace_file --stdio -F comm,dso,sym | head -n -3 > $trace_file.comp.output &&
> +       $perf_tool report -i $trace_file.decomp --stdio -F comm,dso,sym | head -n -3 > $trace_file.decomp.output &&
>         diff $trace_file.comp.output $trace_file.decomp.output
>  }
>
> --
> 2.33.0.rc1.237.g0d66db33f3-goog
>
