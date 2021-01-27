Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FADE305439
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 08:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbhA0HQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 02:16:26 -0500
Received: from mail-lj1-f179.google.com ([209.85.208.179]:34899 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbhA0HKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 02:10:12 -0500
Received: by mail-lj1-f179.google.com with SMTP id r14so880665ljc.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 23:09:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wtz8/vyhQHZRvIkxkl87r/gKCO3Gw1lfl+qkkT0QR78=;
        b=O5fiNABAQ+0i8eorWMnYKF0TyzWDAxrpww3+xF+zVODQchdf0FzQdyxWuNIsqxK/xL
         xhoeo/LGF9DANk7n56Ib8Kdokp8zzLg+kx2MVp94aGBkTRoktQua8Y99Ud6AIGOmGVbt
         4V2EuXUiCGVoEG6pt3vxwSrilqiDzIJHMUV1ZdrncZ79eVFWZiwP9D5Ciw98sUspM+un
         Y28hEQHwVu4t1DWQp8MsyRoTMYa48P7P0Pgk8HrA96egEzfzW1wt08OCj4oqVskEeQHO
         jYpS0fU7nz+kYKTw1nTvwAvtIrs6UEoYfbtdQ1fO2bbaukERKe+RFqAKR/xMpqDAWUyT
         UdzQ==
X-Gm-Message-State: AOAM530INXVqy1cbbpVWXF8Zp9ej53Jgl0nYdpEkOnUApfpboMYVkTbv
        hbNMAR/e6YkRCFxYFvYiOInqm/PNWBZAyoDn9kQ=
X-Google-Smtp-Source: ABdhPJx/Rd75qp3IV3WDDiwh3mHAhUGsxZTtHyGBRTbtiyKGh41lf2fdTIXsBIghIOYP25LmyuBRsF4Tle4vwtEmhcw=
X-Received: by 2002:a2e:390d:: with SMTP id g13mr4757693lja.23.1611731369958;
 Tue, 26 Jan 2021 23:09:29 -0800 (PST)
MIME-Version: 1.0
References: <20210102220441.794923-1-jolsa@kernel.org> <20210102220441.794923-8-jolsa@kernel.org>
In-Reply-To: <20210102220441.794923-8-jolsa@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 27 Jan 2021 16:09:18 +0900
Message-ID: <CAM9d7ci2VUS5oLNDF3J1PgRaGRPSJxAzsn7sd4bC-NX9_2NTfQ@mail.gmail.com>
Subject: Re: [PATCH 07/22] perf daemon: Add daemon command
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

Hi Jiri,

On Sun, Jan 3, 2021 at 7:05 AM Jiri Olsa <jolsa@kernel.org> wrote:
> +int cmd_daemon(int argc, const char **argv)
> +{
> +       struct option daemon_options[] = {
> +               OPT_INCR('v', "verbose", &verbose, "be more verbose"),
> +               OPT_STRING(0, "config", &__daemon.config,
> +                       "config file", "config file path"),
> +               OPT_STRING_OPTARG('x', "field-separator", &__daemon.csv_sep,
> +                       "field separator", "print counts with custom separator", ":"),

Oh, I didn't expect it's optional and default to ":" instead of ",".

Thanks,
Namhyung


> +               OPT_END()
> +       };
