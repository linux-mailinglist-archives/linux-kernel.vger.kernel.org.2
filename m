Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1583932E3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 17:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbhE0Pxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 11:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbhE0Px3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 11:53:29 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A549C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 08:51:55 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso5343500wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 08:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RGM578SjTx4HPSAuDayxd66VlRx8pMIDrOm8Ebr5U4U=;
        b=cznRe/KbSwD4IKSBRhpDdAA3gr55mz4bVGiRHmEOhd+VXY2noIzcwDIN8KVpRNab0s
         nNmAEgJP5V45qsvqJlkcj0eWxMAAMpkCy+r1l9Y0NP0GvnQY7OV2gMrsBXK7EY37bIXB
         InUfP3Vt6XWH2PxXqeOHgC5Smseg6N4oXnvSRq1miEpcVYL0ka0TRiehugi5UU3YAAKx
         A+ydECqCFTS3JsTmSlDp7KS1lieu/iAdSiWya/k2uyskIxRnB1v1+fMzMCUb/m6HaS7k
         N4pOf6yK/Tf3NmNKEqyXRmOxwG+1PKz8qnEFZ+PSCqdIfgcylU3wBGEt30kLnNki5Frl
         4/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RGM578SjTx4HPSAuDayxd66VlRx8pMIDrOm8Ebr5U4U=;
        b=t0UFmeGBUOfNaLwZt49V94lprro1XZAAOT86pQHqqeXrqNmeI23bOnF/wKdelkMbtS
         MTkQK0co6N64G4VEyrcHesPJe1JrjCVP/xTdvCTYskpEYMeBqqKpzBBMRLz5jMelGgZn
         qLxxkAY39/KUo/J8D1okBktwpbzu4hgEJcJxFTxWMVIQrxDPyYyWMXXzdKsRGVRvDuym
         BvtaUYU3kpxlPqQVysyvX2nVDC6lJN7MonxlSoc8ATtUX8PFKbWFSFb/5VbOVZ/zHbIN
         9XqRuqKxWyqmfqwRVJjsA5k6wU0LHZyDh9u46GxTHetiXXLtToVs5SnPa92Rl6oTIoAn
         qh5w==
X-Gm-Message-State: AOAM531fPQv3q8FLp0NhloPXqAeTUTQwTVd1fyHUxRJTl97NZvqkg3Oe
        aSbzpEjjqLBBuIgVWKesrYs9UUwfrXn9d/AF1unVNA==
X-Google-Smtp-Source: ABdhPJwx7qe8Y0mZV7gVdyHoTXhTi2y03ykKGYwRQyBeGlbNF1psf9XSsN2gpRnhJtd3uI0x5VZ2QVY/Dm3HlggI4mQ=
X-Received: by 2002:a1c:4006:: with SMTP id n6mr6898753wma.58.1622130714011;
 Thu, 27 May 2021 08:51:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210519164447.2672030-1-irogers@google.com>
In-Reply-To: <20210519164447.2672030-1-irogers@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 27 May 2021 08:51:41 -0700
Message-ID: <CAP-5=fWRAbkd8MVAxdGf0YGE1oFPT40rZC3eb3OKjqWmBVq_BA@mail.gmail.com>
Subject: Re: [PATCH] perf: Move debug initialization earlier
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>
Cc:     Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 9:44 AM Ian Rogers <irogers@google.com> wrote:
>
> This avoids segfaults during option handlers that use pr_err. For
> example, "perf --debug nopager list" segfaults before this change.
>
> Fixes: 8abceacff87d (perf debug: Add debug_set_file function)
> Signed-off-by: Ian Rogers <irogers@google.com>

Ping.

Thanks!
Ian

> ---
>  tools/perf/perf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/perf.c b/tools/perf/perf.c
> index 20cb91ef06ff..2f6b67189b42 100644
> --- a/tools/perf/perf.c
> +++ b/tools/perf/perf.c
> @@ -443,6 +443,8 @@ int main(int argc, const char **argv)
>         const char *cmd;
>         char sbuf[STRERR_BUFSIZE];
>
> +       perf_debug_setup();
> +
>         /* libsubcmd init */
>         exec_cmd_init("perf", PREFIX, PERF_EXEC_PATH, EXEC_PATH_ENVIRONMENT);
>         pager_init(PERF_PAGER_ENVIRONMENT);
> @@ -531,8 +533,6 @@ int main(int argc, const char **argv)
>          */
>         pthread__block_sigwinch();
>
> -       perf_debug_setup();
> -
>         while (1) {
>                 static int done_help;
>
> --
> 2.31.1.751.gd2f1c929bd-goog
>
