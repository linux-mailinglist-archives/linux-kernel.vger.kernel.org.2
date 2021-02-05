Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1369A310AFA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 13:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhBEMTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 07:19:17 -0500
Received: from mail-lj1-f182.google.com ([209.85.208.182]:42764 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbhBEMPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 07:15:51 -0500
Received: by mail-lj1-f182.google.com with SMTP id c18so7453471ljd.9
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 04:15:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+T/2TzNDJp9mCCmvRN+tN8OL/xtsN61Bf4IuGe4ecvE=;
        b=Srog2K5A6EkRcOEubsOspKttavaJwBHwm6Dvu8J6KORB4oFKAVJ0BElfO2lEZjGige
         87C5/hay9IYNAHHiFLuXnGdgjGXZ2TzI5e3BW04jkSzl+APrzxhPU63bXd99jxIgNoH0
         YDZhVmnUJmpVoCM6AJ4ul2rV7xBbazS3gcvjOmRHE+qax/Vw8bGoU2j7Wyqi7YXfRZqR
         f7PPxZgkepqSwZD7ZpLf8w9TMzEVidngYPAwz1NPxNKkLusVjCR4+mYUjzQNQTy/n8EW
         LYrJPu7xWWetcVmOsYM1Dyh3w2NWn9RAYOPjDokVoCq2jUg/iQeHokQXweDtAI/q9hnm
         tsDg==
X-Gm-Message-State: AOAM531bfmiHmXi/13Idw570CCjJ1jISJIXzUfhLqco8vQPEM/TQI8oU
        +MAwM8dZ9/8KFR+7qQv2iDi1WWDXzagOIX05jHw=
X-Google-Smtp-Source: ABdhPJwBqqy4pyLNxkIxbikskmg5ET/nLFxm7NFW/WCjjjXkJ+yqaJxxcjM+4S8LDuSIUwp0C/LoisKVLSDTEokP4f8=
X-Received: by 2002:a2e:5016:: with SMTP id e22mr2540921ljb.166.1612527305985;
 Fri, 05 Feb 2021 04:15:05 -0800 (PST)
MIME-Version: 1.0
References: <20210129134855.195810-1-jolsa@redhat.com> <20210130234856.271282-1-jolsa@kernel.org>
 <20210130234856.271282-7-jolsa@kernel.org>
In-Reply-To: <20210130234856.271282-7-jolsa@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 5 Feb 2021 21:14:54 +0900
Message-ID: <CAM9d7cg6qEeq--PPxyC9Bq8VNw91O_M+PgnNQ-Sk7n_tKOE1yg@mail.gmail.com>
Subject: Re: [PATCH 06/24] perf daemon: Add config file support
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 31, 2021 at 8:49 AM Jiri Olsa <jolsa@kernel.org> wrote:
[SNIP]
> @@ -263,9 +605,16 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
>         signal(SIGTERM, sig_handler);
>
>         while (!done && !err) {
> -               if (fdarray__poll(&fda, -1)) {
> +               err = daemon__reconfig(daemon);

I think it's confusing since you put the reconfig function here.
What not split normal and reconfig passes?

I mean something like below

 __cmd_start()
{
    setup_server_config();
    daemon__run();

    while (!done && !err) {
        ...
        if (reconfig) {
            daemon__kill();
            setup_server_config();
            daemon__reconfig();
        }
    }

Thanks,
Namhyung


> +
> +               if (!err && fdarray__poll(&fda, -1)) {
> +                       bool reconfig = false;
> +
>                         if (fda.entries[sock_pos].revents & POLLIN)
>                                 err = handle_server_socket(daemon, sock_fd);
> +
> +                       if (reconfig)
> +                               err = setup_server_config(daemon);
>                 }
>         }
>
> --
> 2.29.2
>
