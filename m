Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 000C23932E9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 17:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237112AbhE0Pyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 11:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236227AbhE0Pyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 11:54:35 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC81C061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 08:53:01 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id n5-20020a1c72050000b0290192e1f9a7e1so776070wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 08:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=HGCHZQdoXkmTHKhy0wMu2OOlN/apW6NDMOSDRGH5PME=;
        b=cMv0IpLa0t97vKFxU7Sd3iZharAaPisrMmRXOTGm6BogcmXRpbnVUhUVBnsS4GV4aV
         6RzO/clzQrmDaxaQZ7UWgnsoc4V97nsu9A4RtxJfhawCKgbQO67XdBrqlYnZWylwZp0H
         wsZYapDOZ3qOtB3x43mby+pp7i9IGnxN684tOLyyWGqcvGh4v7aOET5/9mXd7rmMcygO
         wGLC4RZHc6J8i6y3sNpu9YV63MH5hfK+NZAEJY2O39ID/uZfzEkPa0ae8gV3+iYpOWc9
         QsNCCbwePv3oWPHCQT0jkDb9VwHbFaPn9787c+69uT5ALDTCXvp5+XmB7LNd+5V34BcM
         zotg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=HGCHZQdoXkmTHKhy0wMu2OOlN/apW6NDMOSDRGH5PME=;
        b=ISSUsP4hx9458gIWFUHJ7pyi8LOTRfQBySM+bYPMYtDkMztsWMkdAqaXbLipq0bPrx
         8yVYHNcix5eNJc1zsrpzYlEJ7j6S2oWZG70fiSw4xXL4mdoGxFN4YoKZgx5pkUkP5m+B
         E1qVnUFGpCZZ+SGClWpa0G+g1S/6OyytaXFGUBacNDOLTiAJByJ77BateoULqo8byKR2
         yQbO1tCPd7pvnZMljcJ7issqNuow8ggTCkwkdlQ3hvYzwjr1cFhE1kGwS96gHhXH7+8p
         pB3ZA0izFUGvaH5T9g6+IwfPXJeP7UdPzFPh44g80pnavvc+0MacQJ2wXYsLC3DZ55pD
         /36g==
X-Gm-Message-State: AOAM531xnRbCgF2eJgQ4EEniC+89NgisNz7Dt700HCgPiejJj3s0H+NI
        qhnW/5nahu77JF2N/2xFZxXHChECX6rTqVZB0UE66w==
X-Google-Smtp-Source: ABdhPJzw/xAWo56FgbIemcrI/9DqfesC+ZBZVxDciPtuB7IiSG/z5JkQ8mnKJB06eIN0bXkydkNn4xytlWBkyMhL8MU=
X-Received: by 2002:a1c:2015:: with SMTP id g21mr8786316wmg.87.1622130780271;
 Thu, 27 May 2021 08:53:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210513060441.408507-1-irogers@google.com>
In-Reply-To: <20210513060441.408507-1-irogers@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 27 May 2021 08:52:47 -0700
Message-ID: <CAP-5=fV2DOkPDrYexrtMK-krXjSB2STVyDNZpmNnzdPJNom4Wg@mail.gmail.com>
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

On Wed, May 12, 2021 at 11:04 PM Ian Rogers <irogers@google.com> wrote:
>
> Previously the code would see if, for example,
> tools/perf/arch/arm/include/uapi/asm/errno.h exists and if not generate
> a "generic" switch statement using the asm-generic/errno.h. This creates
> multiple identical "generic" switch statements before the default
> generic switch statement for an unknown architecture. By simplifying the
> archlist to be only for architectures that are not "generic" the amount
> of generated code can be reduced from 14 down to 6 functions.
>
> Remove the special case of x86, instead reverse the architecture names
> so that it comes first.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Ping.

Thanks!
Ian

> ---
>  tools/perf/trace/beauty/arch_errno_names.sh | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/trace/beauty/arch_errno_names.sh b/tools/perf/trace/beauty/arch_errno_names.sh
> index 9f9ea45cddc4..2c5f72fa8108 100755
> --- a/tools/perf/trace/beauty/arch_errno_names.sh
> +++ b/tools/perf/trace/beauty/arch_errno_names.sh
> @@ -87,14 +87,13 @@ cat <<EoHEADER
>
>  EoHEADER
>
> -# Create list of architectures and ignore those that do not appear
> -# in tools/perf/arch
> +# Create list of architectures that have a specific errno.h.
>  archlist=""
> -for arch in $(find $toolsdir/arch -maxdepth 1 -mindepth 1 -type d -printf "%f\n" | grep -v x86 | sort); do
> -       test -d $toolsdir/perf/arch/$arch && archlist="$archlist $arch"
> +for arch in $(find $toolsdir/arch -maxdepth 1 -mindepth 1 -type d -printf "%f\n" | sort -r); do
> +       test -f $toolsdir/arch/$arch/include/uapi/asm/errno.h && archlist="$archlist $arch"
>  done
>
> -for arch in x86 $archlist generic; do
> +for arch in generic $archlist; do
>         process_arch "$arch"
>  done
> -create_arch_errno_table_func "x86 $archlist" "generic"
> +create_arch_errno_table_func "$archlist" "generic"
> --
> 2.31.1.751.gd2f1c929bd-goog
>
