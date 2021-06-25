Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E0D3B3C47
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 07:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbhFYFjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 01:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhFYFjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 01:39:39 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A709C061756
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 22:37:18 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id u20so258647wmq.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 22:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gaKEOLKP9BIjbEgBwhONJmuxzHCabnKfYmr62NuhX/A=;
        b=pGgT0FyQzjpw3KLSuy26od9PVVACl7X+mw/wpk5dua6WV4O4fyMBgoKliC/GD2tHSV
         sF/vzEBRNoIA/YzBmmL9pem9FQ/ojkUxCeEtWj+DLK6kvmNsh9HmuvbrqKMk3LJ+wMnq
         4nvknpT/oAxU+gxxFQFKg4j6eRbLrZxYQIJiKWcmu/GzOwSgjTKIYQiOLGRmUHLKsIEh
         sBIGI35RJ2sT8aUCailJwG0SuSu/dkfNmNHqD9xXumNl2+khW6txjXVzjzdLIMvBb7iz
         x9hsOyXlPgPhWykNR7Kh6ZT5yTUV70/8b6qNHJkxUK9N61uOUBDhU5oaqzsP30XbEsnj
         PXeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gaKEOLKP9BIjbEgBwhONJmuxzHCabnKfYmr62NuhX/A=;
        b=iVbodyZ2YbFYxzu62zOIuooITTmB5MFaMwk00uv/PqEqBbzpsxu8MqjDrrSOaQQLLk
         jl4bLLvMwPLLKiuuzafjf2qwItvvYVEFo0whX76m/gPKblNlKOFBeHDqcnpUQlm0VyFE
         eDetiVXkldxlEH5pYFS9/fjRHocqCY7CuBayZFAagLL8rJDOMUZjTwrspWAVbtFMe8h2
         J88Ic4lYd2Rgu7FOrherZRZkpPTP6DpGjo9Uv6SA18Yehcxby9ROCRUxsmUvM2HP2rbT
         1ODuqa4bVfemUSMQ8jl2WI10LAjclyVnxldopU8CgYdacIoQAfWDcZwqjmMprFqLCpuW
         1C6w==
X-Gm-Message-State: AOAM5327uAoyjuxFG7Yy6TRv7Z7HJ9i9g4O+VH1NTZE9bnvdbzAqJMMv
        b35oVv/M7rB5dPOcf5HHyMgw1u4MMJrfUBzGEQGniA==
X-Google-Smtp-Source: ABdhPJywhwOUfZ6IrK731NmCUA8weP65uaJQNUOxN0vMtchNBm7MIFnqzF2m7xHkWzPKIm9+Jc977tqhbobm0OxF5bs=
X-Received: by 2002:a05:600c:a01:: with SMTP id z1mr8541210wmp.77.1624599436434;
 Thu, 24 Jun 2021 22:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210624223423.189550-1-rickyman7@gmail.com>
In-Reply-To: <20210624223423.189550-1-rickyman7@gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 24 Jun 2021 22:37:04 -0700
Message-ID: <CAP-5=fXWFvcvNOA+wJMSCp2Qz7EVruufvFBLWEXfdezeEJGUTA@mail.gmail.com>
Subject: Re: [PATCH v2] perf annotate: allow 's' on source code lines
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Martin Liska <mliska@suse.cz>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 3:37 PM Riccardo Mancini <rickyman7@gmail.com> wrote:
>
> In perf annotate, when 's' is pressed on a line containing
> source code, it shows the message "Only available for assembly
> lines".
> This patch gets rid of the error, moving the cursr to the next
> available asm line (or the closest previous one if no asm line
> is found moving forwards), before hiding source code lines.
>
> Changes in v2:
>  - handle case of no asm line found in
>    annotate_browser__find_next_asm_line by returning NULL and
>    handling error in caller.
>
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>

Acked-by: Ian Rogers <irogers@google.com>

> ---
>  tools/perf/ui/browsers/annotate.c | 32 ++++++++++++++++++++++++++++---
>  1 file changed, 29 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
> index ad0a70f0edaf..f5509a958e38 100644
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
> +       return NULL;
> +}
> +
>  static bool annotate_browser__toggle_source(struct annotate_browser *browser)
>  {
>         struct annotation *notes = browser__annotation(&browser->b);
> @@ -363,9 +386,12 @@ static bool annotate_browser__toggle_source(struct annotate_browser *browser)
>                 browser->b.index = al->idx;
>         } else {
>                 if (al->idx_asm < 0) {
> -                       ui_helpline__puts("Only available for assembly lines.");
> -                       browser->b.seek(&browser->b, -offset, SEEK_CUR);
> -                       return false;
> +                       /* move cursor to next asm line */

comment nit, perhaps prefer "closest" rather than "next" due to
searching backward.

Thanks,
Ian

> +                       al = annotate_browser__find_next_asm_line(browser, al);
> +                       if (!al) {
> +                               browser->b.seek(&browser->b, -offset, SEEK_CUR);
> +                               return false;
> +                       }
>                 }
>
>                 if (al->idx_asm < offset)
> --
> 2.31.1
>
