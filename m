Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE5D3AFC71
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 07:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbhFVFKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 01:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhFVFKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 01:10:16 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4627C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 22:08:00 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id a11so22031701wrt.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 22:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DQ9VBpj70ltlAn+nC3HXACTVjQFmEPm+7j+HwScggog=;
        b=heXCST2cu5U/h/j0mEKzvK2GEzGl7FRhoj631tId+/nDBhG7xrWizrNh7YgORvLTLV
         MAZC67H/WFG2U2DYCuiYMGUDLGjQxnFf3yN46suzqBdUCNBDAg7qS+rdXrIPfoRKg2Lp
         zPJrII8VB6yrRkKq7Kf7j+Dp+ffuvt7FYFStm3Db8zbY3+iJOLiQgAVsNSMgUIJA0yDW
         9Xz9PIUhswdjb1PHp0P+PQ8fHosh5WPf9wkVImqFmYbd8axkIbQSXBlfZD6hkRvNyw3d
         QZmE7L/BYuGYx1Ol7MJzDapiV9UXc+cKxnPNOvQszalPHfiZyysqHPbb6j2/iszmerb4
         hSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DQ9VBpj70ltlAn+nC3HXACTVjQFmEPm+7j+HwScggog=;
        b=b7neN4ly8zT3vHxpQDD3q4ojMDCBd9yYGrbtkQqqeXCI/1tqmRnsvCySpLDCJu3lFG
         nrXJ2TpjsgsQVSGFIskxlPeClgXzE3HyVmsXMp70m2IOMppLpZvfczt5WvvCWblnjja4
         Bht3O3GOaJH8SAIJ/Sgw3ZIx28guho7NOq0unR2Ptqpm3WJvN2u4HW0qA82Jm+VK6t+M
         Tn36WhdT48z/FV3UCekpdFRVGh3OlF8JawSGf41hIuqRx7Y+X0ZVxAW22bYNo4ivYg47
         VYdMf+yvDOChUc0UGk2qFp9xk7BopaFdIIvo6SnBURpyV1NVWm+43iSETYpymudecFXC
         qPEQ==
X-Gm-Message-State: AOAM5335XuMLH3IWxZhFdiMG9+OawoUTEnwOLBxCrR0SqZq/aSoDieUz
        NlPxY7IDr6oEIZc3OgjoOXkVB1bjAlGd+wy5zL7hYg==
X-Google-Smtp-Source: ABdhPJzEMNJbJVRBqfojp7VpS0VjJwfhXWGqF3RppD/dfzOrz+9VpKsmc02G/fNkBvouO2rmQqnAftcbmEGvXKfBuaY=
X-Received: by 2002:a05:6000:1c1:: with SMTP id t1mr2335169wrx.282.1624338479142;
 Mon, 21 Jun 2021 22:07:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210621230047.211430-1-rickyman7@gmail.com>
In-Reply-To: <20210621230047.211430-1-rickyman7@gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 21 Jun 2021 22:07:47 -0700
Message-ID: <CAP-5=fVNCcLyAZx2nqOn2t=BTW1FB9sU=-gmSNWukKcTb8HE+Q@mail.gmail.com>
Subject: Re: [PATCH] perf annotate: allow 's' on source code lines
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Martin Liska <mliska@suse.cz>,
        Jason Yan <yanaijie@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2021 at 4:02 PM Riccardo Mancini <rickyman7@gmail.com> wrote:
>
> In perf annotate, when 's' is pressed on a line containing
> source code, it shows the message "Only available for assembly
> lines".
> This patch gets rid of the error, moving the cursr to the next
> available asm line (or the closest previous one if no asm line
> is found moving forwards), before hiding source code lines.
>
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> ---
>  tools/perf/ui/browsers/annotate.c | 28 +++++++++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
> index ad0a70f0edaf..eb94d20d0d13 100644
> --- a/tools/perf/ui/browsers/annotate.c
> +++ b/tools/perf/ui/browsers/annotate.c
> @@ -343,6 +343,29 @@ static void annotate_browser__calc_percent(struct annotate_browser *browser,
>         browser->curr_hot = rb_last(&browser->entries);
>  }
>
> +static struct annotation_line *annotate_browser__find_next_asm_line(
> +                                       struct annotate_browser *browser,
> +                                       struct annotation_line *al)
> +{
> +       struct annotation_line *it = al;
> +
> +       /* find next asm line */
> +       list_for_each_entry_continue(it, browser->b.top, node) {
> +               if (it->idx_asm >= 0)
> +                       return it;
> +       }
> +
> +       /* no asm line found forwards, try backwards */
> +       it = al;
> +       list_for_each_entry_continue_reverse(it, browser->b.top, node) {
> +               if (it->idx_asm >= 0)
> +                       return it;
> +       }
> +
> +       /* There are no asm lines */
> +       return al;

Does this error case need handling in the caller?

Thanks,
Ian

> +}
> +
>  static bool annotate_browser__toggle_source(struct annotate_browser *browser)
>  {
>         struct annotation *notes = browser__annotation(&browser->b);
> @@ -363,9 +386,8 @@ static bool annotate_browser__toggle_source(struct annotate_browser *browser)
>                 browser->b.index = al->idx;
>         } else {
>                 if (al->idx_asm < 0) {
> -                       ui_helpline__puts("Only available for assembly lines.");
> -                       browser->b.seek(&browser->b, -offset, SEEK_CUR);
> -                       return false;
> +                       /* move cursor to next asm line */
> +                       al = annotate_browser__find_next_asm_line(browser, al);
>                 }
>
>                 if (al->idx_asm < offset)
> --
> 2.31.1
>
