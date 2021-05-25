Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E21C38F9A5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 06:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhEYEf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 00:35:58 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:34649 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhEYEf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 00:35:57 -0400
Received: by mail-lf1-f49.google.com with SMTP id f30so6899114lfj.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 21:34:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kxGZAWkMHs4ghI9ARZ/OGMmVzXyb9VYRh9R9hbaoX7M=;
        b=rB93whYWsUUdr2kGnJ+6md7aRqmARXnM1gBGYboAypWaZJyvvTHLq2roh+eHj+2wd5
         s5aSFskYAfsYwhWDMRgUjJ+qCdAP0M94Q/zaEkHEMOAYNLWJx3zatU+JSkII3XOuQz4C
         VsrK1UERUjTlh+CZVHpmfnyOdKFo9lIqq7oAa2NVvW10SHzJRdH1fyuRdpZZOSrPecSl
         LpDmz7aQZUUUnZsJXho8QZU4fz62P8kGWhXfY/uYtoU5uny9GRkXk9QQlpXIsXqGsFHM
         jJb1dGoPFXWYfakzrBZy1nIOPE62e58HmXFj8hsdx5P5BNmGbXvTzBIJEWDlX99cTDmR
         3euA==
X-Gm-Message-State: AOAM530c7YH2UTD49wcnr+3oIOzf4tVZWZi2OopavgFY/UeZIHyBeAcU
        lS7vEvBGWlIFpssCNzSvpIe3/E12OQw2lhXxvQs=
X-Google-Smtp-Source: ABdhPJzQnGgeNB4VW7TodYELyAm+geGWHBDOeTVPg2mbgH5TTFF3HRhehynYDLQfXlzhWQs1h5bDdNJOKKHPnZ/OhWE=
X-Received: by 2002:a19:f114:: with SMTP id p20mr1136960lfh.112.1621917267767;
 Mon, 24 May 2021 21:34:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210524111514.65713-1-dzagorui@cisco.com>
In-Reply-To: <20210524111514.65713-1-dzagorui@cisco.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 24 May 2021 21:34:16 -0700
Message-ID: <CAM9d7chkR-tcr1B1EePjK4otEDU7=60c1KsPZjYy_YH-=f9zUQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] perf report: compile tips.txt in perf binary
To:     Denys Zagorui <dzagorui@cisco.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, May 24, 2021 at 4:15 AM Denys Zagorui <dzagorui@cisco.com> wrote:
>
> It seems there is some need to have an ability to invoke perf from
> build directory without installation
> (84cfac7f05e1: perf tools: Set and pass DOCDIR to builtin-report.c)
> DOCDIR definition contains an absolute path to kernel source directory.
> It is build machine related info and it makes perf binary unreproducible.
>
> This can be avoided by compiling tips.txt in perf directly.
>
> Signed-off-by: Denys Zagorui <dzagorui@cisco.com>

For all three patches,

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
