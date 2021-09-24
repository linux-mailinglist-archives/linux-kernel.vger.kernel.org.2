Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E24041773F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 17:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346981AbhIXPJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 11:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346962AbhIXPJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 11:09:56 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE89C061613
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 08:08:22 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id t28so15056971wra.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 08:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ddIdnJJQzt6KCE2sdls+EVKfN4Fpq3cgwiHva/iq2vo=;
        b=R07NzMnHXoImrOjylse2riaepm/fUDAG6H+3urNsYdy7DtyR6DQLKlKLEryebJ9hTw
         BnGIM1bREVyCNihA2LIgeARwZg0qYezxMAdT5cz6pvSPIP6mDnqhAOTTccrTbvEhx2IP
         ThaFyWXNsXx95VbGwDuF0xHXDAk8KXTCKBJoNs8tMp7BJp4g009Pc6sGt1JTtKM+Q9JQ
         2dMNua+oLsL4AwBizsawN7FfHmhVBlLAyAD9lV1rEbMXnqbOONm3q8EGzo9j8KZHLHxh
         pvzEKziLd/NvU5V2phm4PyE+FozUQH38irfN7asU0uaxV8i5RGA/FxeWS7YQnBuMAwQM
         YXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ddIdnJJQzt6KCE2sdls+EVKfN4Fpq3cgwiHva/iq2vo=;
        b=hS6l/XiYXzyfRkSq4oDUWIb7LeUHnUCkPscktUvvzIxvY2f5ufEhNpTMu98fxv7xa/
         +mOvtY7MjyLelVb/1Ghuti4bxdzhYKTbim5xHKDoTnr3Ay+Cpq1Hu2rh9m+f4NTa8UCy
         LCgw2mP7BzCeTYqUsITVu5v+grbGg0119iVRjwaQtfuyfFBF9CpW+zUNgv/vteahZ+7J
         TrMLGQ2YXQhWHmX+fZ8Lo4vaGcmxgDexBcQjhiUYLycNvvcCYaZrENQtiSTARTA52eKt
         cT6EfSpqsbBZF23LjY4WrBAZtQDhe/6qNMC+oM9i2QS9kiFqzBAijHYtumfyIfpK5tHv
         1wfw==
X-Gm-Message-State: AOAM533xSH0TY0urt8QpNuxy++cABsiXqaOySahOw6wmdWsGvSYXv93s
        /mr09jqr3/UfbQGxuhr/O+5Mb1wNpK0c7npQ327ghA==
X-Google-Smtp-Source: ABdhPJyr4VODmsi8x1Q4P6qhekNJlvK9Ik/fVMP470V1zoNi6TDT90zRMm+XDKBECfyZ8uByjbOF1JkmHjTvUKWhKtQ=
X-Received: by 2002:adf:fe08:: with SMTP id n8mr12114792wrr.246.1632496101043;
 Fri, 24 Sep 2021 08:08:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210924115817.58689-1-likexu@tencent.com>
In-Reply-To: <20210924115817.58689-1-likexu@tencent.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 24 Sep 2021 08:08:07 -0700
Message-ID: <CAP-5=fW+Wn+_OcQWR8-UHQ42CsG6koZVw-UWBptQY8oYLsW=Vg@mail.gmail.com>
Subject: Re: [PATCH] perf config: Refine error message to eliminate confusion
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 4:58 AM Like Xu <like.xu.linux@gmail.com> wrote:
>
> From: Like Xu <likexu@tencent.com>
>
> If there is no configuration file at first, the user can
> write any pair of "key.subkey=value" to the newly created
> configuration file, while value validation against a valid
> configurable key is *deferred* until the next execution or
> the implied execution of "perf config ... ".
>
> For example:
>
>  $ rm ~/.perfconfig
>  $ perf config call-graph.dump-size=65529
>  $ cat ~/.perfconfig
>  # this file is auto-generated.
>  [call-graph]
>         dump-size = 65529
>  $ perf config call-graph.dump-size=2048
>  callchain: Incorrect stack dump size (max 65528): 65529
>  Error: wrong config key-value pair call-graph.dump-size=65529
>
> The user might expect that the second value 2048 is valid
> and can be updated to the configuration file, but the error
> message is very confusing because the first value 65529 is
> not reported as an error during the last configuration.
>
> It is recommended not to change the current behavior of
> delayed validation (as more effort is needed), but to refine
> the original error message to *clearly indicate* that the
> cause of the error is the configuration file.
>
> Signed-off-by: Like Xu <likexu@tencent.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/config.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
> index 4fb5e90d7a57..60ce5908c664 100644
> --- a/tools/perf/util/config.c
> +++ b/tools/perf/util/config.c
> @@ -801,7 +801,7 @@ int perf_config_set(struct perf_config_set *set,
>                                   section->name, item->name);
>                         ret = fn(key, value, data);
>                         if (ret < 0) {
> -                               pr_err("Error: wrong config key-value pair %s=%s\n",
> +                               pr_err("Error in the given config file: wrong config key-value pair %s=%s\n",
>                                        key, value);
>                                 /*
>                                  * Can't be just a 'break', as perf_config_set__for_each_entry()
> --
> 2.32.0
>
