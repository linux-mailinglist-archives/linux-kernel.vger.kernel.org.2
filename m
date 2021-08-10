Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1559C3D690C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 23:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbhGZVNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 17:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbhGZVND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 17:13:03 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA92BC061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 14:53:30 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id y200so13815100iof.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 14:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=IQII10jPp/lqJWgWHlaLPqEod8OlHucFzIQ+WFXu6Ms=;
        b=NeSguM55iDP/mfQ99k6Mv/5ra8+DifBLFdDspPlKG4Afszstfg1BrL/S2r9pmNG+lU
         t6buy6qJGxq4x99ciqe3YQ+uNHX4KRJdokyNMEtKXdJf5b6TBQzOfWcovekL/+3VxVsl
         JsLKFeQtUMsQJSo2KsaM88mOtnTVOrM7e5flAJ0Ey5A9cBSqKl/QuIyE45NfiPt2ioI4
         xktopLbFfRMKHliCwuwuWvUI1LGe8BZakcw315PoA8YResx9vC0Wfh3KGjHKnxzAtkLe
         +TKuv2w3GCeq+EKRChdqEV+5s7znPUKwY4y4qQS6sIX/Ttmmo9OOkpf6NbnAFT2OjAR0
         cNRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=IQII10jPp/lqJWgWHlaLPqEod8OlHucFzIQ+WFXu6Ms=;
        b=BIiRB6xdrCFs447qxxmQrXnPVZ4qaJV3eZXoGI6rKWs4KfdbzcXG81ndNMjsVybyhL
         0fmTze7da+Px3e8D/bRQbsHCHrt/pl1ByuaLc1/RX7n5QZ2Xmyfp7+OPEZM8JDdwQprJ
         /E1yGRAU5eUHAfQiiYzjOOvXUULL/KbnVDjlg491sfSAHbuonFK+OQnXE/pSTR/kBCXR
         vsKWQ+p1hvs6lVtcf3WzkyTAWsY+YToD8BIEz6l7Gwo4YO73yMs4aoxL66sp6bAa1k/w
         2ZNE9iJhf4xhAwJgohJ2LDBH3WasQbX+iDalnxzYAv2MjDe2p+1J0M67WwswfZsUfcUT
         Gm0A==
X-Gm-Message-State: AOAM530+6ga/YvlG8uwCBiDbdoGbwv1hVwQJ79qqHFz4BdR0wN1BURPY
        SAxc/9Mc9D5R73Fr2YDgUcaJM4w3nxUGEVJ3F9W7wQ==
X-Google-Smtp-Source: ABdhPJzGrHHQjMMYGwMZxDn6SCBCWa22ZhHT1c7gHwmx4zXRB8Few91GTJBsmdvEZLKEvDwX5cAgxRCAFIa0/iWd0fU=
X-Received: by 2002:a02:ad08:: with SMTP id s8mr18597853jan.40.1627336410280;
 Mon, 26 Jul 2021 14:53:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210513060441.408507-1-irogers@google.com> <CAP-5=fV2DOkPDrYexrtMK-krXjSB2STVyDNZpmNnzdPJNom4Wg@mail.gmail.com>
In-Reply-To: <CAP-5=fV2DOkPDrYexrtMK-krXjSB2STVyDNZpmNnzdPJNom4Wg@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 26 Jul 2021 14:53:17 -0700
Message-ID: <CAP-5=fUfhhrkgNU_83KQ4X2G8emsNXNMvi54Fpr9XPTG0TKRmw@mail.gmail.com>
Subject: Re: [PATCH] perf beauty: Reuse the generic switch.
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 8:52 AM Ian Rogers <irogers@google.com> wrote:
>
> On Wed, May 12, 2021 at 11:04 PM Ian Rogers <irogers@google.com> wrote:
> >
> > Previously the code would see if, for example,
> > tools/perf/arch/arm/include/uapi/asm/errno.h exists and if not generate
> > a "generic" switch statement using the asm-generic/errno.h. This creates
> > multiple identical "generic" switch statements before the default
> > generic switch statement for an unknown architecture. By simplifying the
> > archlist to be only for architectures that are not "generic" the amount
> > of generated code can be reduced from 14 down to 6 functions.
> >
> > Remove the special case of x86, instead reverse the architecture names
> > so that it comes first.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Ping.
>
> Thanks!
> Ian

Ping,

Thanks!
Ian

> > ---
> >  tools/perf/trace/beauty/arch_errno_names.sh | 11 +++++------
> >  1 file changed, 5 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/perf/trace/beauty/arch_errno_names.sh b/tools/perf/trace/beauty/arch_errno_names.sh
> > index 9f9ea45cddc4..2c5f72fa8108 100755
> > --- a/tools/perf/trace/beauty/arch_errno_names.sh
> > +++ b/tools/perf/trace/beauty/arch_errno_names.sh
> > @@ -87,14 +87,13 @@ cat <<EoHEADER
> >
> >  EoHEADER
> >
> > -# Create list of architectures and ignore those that do not appear
> > -# in tools/perf/arch
> > +# Create list of architectures that have a specific errno.h.
> >  archlist=""
> > -for arch in $(find $toolsdir/arch -maxdepth 1 -mindepth 1 -type d -printf "%f\n" | grep -v x86 | sort); do
> > -       test -d $toolsdir/perf/arch/$arch && archlist="$archlist $arch"
> > +for arch in $(find $toolsdir/arch -maxdepth 1 -mindepth 1 -type d -printf "%f\n" | sort -r); do
> > +       test -f $toolsdir/arch/$arch/include/uapi/asm/errno.h && archlist="$archlist $arch"
> >  done
> >
> > -for arch in x86 $archlist generic; do
> > +for arch in generic $archlist; do
> >         process_arch "$arch"
> >  done
> > -create_arch_errno_table_func "x86 $archlist" "generic"
> > +create_arch_errno_table_func "$archlist" "generic"
> > --
> > 2.31.1.751.gd2f1c929bd-goog
> >
