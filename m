Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33EAD35FC96
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 22:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbhDNUZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 16:25:57 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:33280 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbhDNUZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 16:25:55 -0400
Received: by mail-lf1-f54.google.com with SMTP id w8so26858921lfr.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 13:25:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rOfuDmclgy0v4Rb5T8Eq+9z9YpZiwO2+5AJvp+hGYCM=;
        b=NlyihoqBtYR1XImiQZTIlFViNIl9voZh90xxBjXUBy5WrBlB7lHL6i06wopPOCIroo
         1qMpmZ9zTrq9bmO9FS9VU5vnlY4d2PWmiBFT/fZoB2Uznos4uDlB6mjf/uhbe2dp6V9j
         eiP4PeGqdoh2+CFzs2gguoVj1KyS/RnLs4O5V7c+CTnQ4kj+gCzC7sH5FwCYy0WLsFYP
         lRbHP/n2U5FS99/TEYiWh5Cf+ublNqKqBXpNjp0sJprt9LfdNi3RzGbkKhrvWUwirH7h
         K73aYY5zPgjItEihcgvRWNKtgyh5k1qyckR8+qvrKS08Tsi5kfW0Ch+IMGwwukZTdaaV
         G8Zw==
X-Gm-Message-State: AOAM531OOBELeg6GgIPIJK+TCzI0OY6KRNKOxsDHAMn93vhWzMUHB1x7
        i/qErmYzQZ1nP5G042bMD7jIJJs40xcujdt60As=
X-Google-Smtp-Source: ABdhPJyaPadKOveugC/Cr+FGaVQjFkYqVeqLXfpeOLoj5U5SH3GMv6OnCUupWJJpmY1InqOXaJDuQwbrnbTUHm+0llo=
X-Received: by 2002:a05:6512:3d8d:: with SMTP id k13mr14543308lfv.494.1618431932761;
 Wed, 14 Apr 2021 13:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210414195758.4078803-1-robh@kernel.org>
In-Reply-To: <20210414195758.4078803-1-robh@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 15 Apr 2021 05:25:21 +0900
Message-ID: <CAM9d7chWROPAg3T_gd+T6N+94pWawKtggyegCGo0nXzKF+F7+g@mail.gmail.com>
Subject: Re: [PATCH] libperf: xyarray: Add bounds checks to xyarray__entry()
To:     Rob Herring <robh@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 4:58 AM Rob Herring <robh@kernel.org> wrote:
>
> xyarray__entry() is missing any bounds checking yet often the x and y
> parameters come from external callers. Add bounds checks and an
> unchecked __xyarray__entry().
>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  tools/lib/perf/include/internal/xyarray.h | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/perf/include/internal/xyarray.h b/tools/lib/perf/include/internal/xyarray.h
> index 51e35d6c8ec4..f0896c00b494 100644
> --- a/tools/lib/perf/include/internal/xyarray.h
> +++ b/tools/lib/perf/include/internal/xyarray.h
> @@ -18,11 +18,18 @@ struct xyarray *xyarray__new(int xlen, int ylen, size_t entry_size);
>  void xyarray__delete(struct xyarray *xy);
>  void xyarray__reset(struct xyarray *xy);
>
> -static inline void *xyarray__entry(struct xyarray *xy, int x, int y)
> +static inline void *__xyarray__entry(struct xyarray *xy, int x, int y)
>  {
>         return &xy->contents[x * xy->row_size + y * xy->entry_size];
>  }
>
> +static inline void *xyarray__entry(struct xyarray *xy, int x, int y)
> +{
> +       if (x >= xy->max_x || y >= xy->max_y)
> +               return NULL;

Maybe better to check negatives as well.

Thanks,
Namhyung


> +       return __xyarray__entry(xy, x, y);
> +}
> +
>  static inline int xyarray__max_y(struct xyarray *xy)
>  {
>         return xy->max_y;
> --
> 2.27.0
>
