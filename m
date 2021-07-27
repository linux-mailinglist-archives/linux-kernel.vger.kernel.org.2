Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8AD3D6CFC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 05:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbhG0DEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 23:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234679AbhG0DE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 23:04:29 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4849C061760
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 20:44:56 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id go31so6100939ejc.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 20:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8e/Iqcz2zaKZWD3e9hpyeY5k7C6LhWtOJoA94RE+ZHU=;
        b=nDOTdXItUVfaYZj8kx1BJKr56B3JpzweeZw72iF7U4OCvNXKHnP0mrYWGXNWdpE9zL
         jvSQEjMWC7z2o5taqg4ZUeBBlhJo+GFgDYxidkj+js5B6blhktBOXCxWG2C7nk59kU4a
         8nHRU7oiisP/9obwQlhTWl4OYVqor0sQg9juEhEP1aF2mXugTf0WBki84L6NwCHvrAZ4
         Bn57GUvif2qFP5+JwqnyOCUkw1ZvC16ksIU0tdItRvh1sjN0yiXSi7d5i0XQJtbgsrha
         tBw8w1sbJvFLOKKESOCdnSPYYBgTQe60tz1XMXJCozqkSP4TTt/Wi+XAjSU7YGo9d6Sj
         /buw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8e/Iqcz2zaKZWD3e9hpyeY5k7C6LhWtOJoA94RE+ZHU=;
        b=YjnDsQbNXUPmyrXWhe1Gt7yKny3fGOis2N1uVt4wGAWOFdVjsJtZSHzc88hZwEVfJU
         ycvHOto9QpJxVq7WrcI+/ouuWa1dba5QHLEyqhlVs8faAICmKNE3cPr+iWG7s7lOFTCu
         NhENS2YUhQoV1hMxpwiLolrbwbIzwEk5LpFLG81Hi7WM/oLc9HwPhd7U7ywJl9kM05ls
         ASVedyuGUG3SB3rhjmGVcCYLxQEX6W1Ud95/omejgtvaGCvhGaXqkCmSmCishXwXtIH8
         34pJBiTtCkX/imBRWu6bWwx7bcUsAxtHEFxmgSIM19572NZibmi1YoFlLbauV+4bd496
         QhGg==
X-Gm-Message-State: AOAM532Nxl92ooNGi1QG6c0PqPEDerYNFfAcxy0Ncksy9hs0mypPvP1O
        wNZ0d9NC+f0P/IMZt52wdPDx/dCj3KuCwqo3D8QELw==
X-Google-Smtp-Source: ABdhPJy8l6B7cdaL7h7rnH2v0zb2POsgVwm9JxA0mmoRvwVvn1ycLLYj5ASkbQ4wI1yqV9Ft55LItLu0MJjV9WbAfUE=
X-Received: by 2002:a17:907:94c6:: with SMTP id dn6mr9412285ejc.287.1627357495195;
 Mon, 26 Jul 2021 20:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210726153832.339431936@linuxfoundation.org> <20210726153834.463666741@linuxfoundation.org>
In-Reply-To: <20210726153834.463666741@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 27 Jul 2021 09:14:44 +0530
Message-ID: <CA+G9fYt-4cb_fcgTMkxg=RnKBDk8ipgvyW9MUgO2Bam+ounVng@mail.gmail.com>
Subject: Re: [PATCH 4.19 065/120] perf test session_topology: Delete session->evlist
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-stable <stable@vger.kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jul 2021 at 21:28, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> From: Riccardo Mancini <rickyman7@gmail.com>
>
> [ Upstream commit 233f2dc1c284337286f9a64c0152236779a42f6c ]
>
> ASan reports a memory leak related to session->evlist while running:
>
>   # perf test "41: Session topology".
>
> When perf_data is in write mode, session->evlist is owned by the caller,
> which should also take care of deleting it.
>
> This patch adds the missing evlist__delete().
>
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> Fixes: c84974ed9fb67293 ("perf test: Add entry to test cpu topology")
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Kan Liang <kan.liang@intel.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Link: http://lore.kernel.org/lkml/822f741f06eb25250fb60686cf30a35f447e9e91.1626343282.git.rickyman7@gmail.com
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>


perf build failed on 4.19, 4.14, 4.9 and 4.4 due to these warnings / errors
for all the architectures.

>  tools/perf/tests/topology.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
> index 9497d02f69e6..bed53ed82af7 100644
> --- a/tools/perf/tests/topology.c
> +++ b/tools/perf/tests/topology.c
> @@ -52,6 +52,7 @@ static int session_write_header(char *path)
>         TEST_ASSERT_VAL("failed to write header",
>                         !perf_session__write_header(session, session->evlist, data.file.fd, true));
>
> +       evlist__delete(session->evlist);

perf-in.o: In function `session_write_header':
tools/perf/tests/topology.c:55: undefined reference to `evlist__delete'
collect2: error: ld returned 1 exit status

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

ref:
https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-stable-rc-4.19/DISTRO=lkft,MACHINE=intel-corei7-64,label=docker-buster-lkft/893/console

--
Linaro LKFT
https://lkft.linaro.org
