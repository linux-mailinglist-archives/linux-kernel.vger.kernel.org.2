Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A02A3D59A2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 14:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234088AbhGZLyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 07:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233742AbhGZLyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 07:54:22 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED47C061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 05:34:49 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id j2so10846453wrx.9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 05:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jkiNXr4VlGX4jk1tmCfMW3KOCcfI9fRgyo5pODgk9Cg=;
        b=YV+moxv21xffSZngcjywGcDBc0RHjAvLwt4Gg1M2CTkE4RHXMPAkQ9i1bZnm5+kiyq
         8E51pQzWUvqZ4kunC231U1MeUi/uQdLakPGOVGjluquYZoRKQRt334D8wt7okjFUnIRh
         MbOFMCujsbRL5JBaP+ml/YVvxgkI3JCJYVcPrHvxFed7SbpinrN1X0rXgU8ZQXu3Kx93
         6e1sAoY5tU4Z9BaEO7tFIZ6AVNUscd5M1alaeZrrFb7gupsqpFuasduWnhlVkq7rzC3J
         wyn8AN4L1Oqo/alQOzOwyFDQFqHtSFswqwdYoWkBStnfmK+BUUI39fxHDnXgtC+VJFEY
         6zsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jkiNXr4VlGX4jk1tmCfMW3KOCcfI9fRgyo5pODgk9Cg=;
        b=eCYLpbhf0LpWsn/tcwHrfpoVxVCAXeIsGgYIGdcNCdGHfGxWL+7B1Ys+FAV0kqxXFs
         /N9ShTxdOXXVVFJbFyMmJrJaTc4A4rTwDQ0q2NjDKoXrDTT0JrNg6gUuamuPBbuaT3KL
         c4jcXG8NcQnAo6GlLnYEKtVKdrrL0PteQorJiBYLBt9p/uA3w5a0ZkZgXHUWtRfPIeUH
         9PuE57svJ4NPklYrEXe1iIPmNRydKjKaQQq4e+7gzy/4JLQ6lMfcsRsF/FAolPxaRUDZ
         tWp5Odl/C29nXSM3wG4i0OFzYMpL/OoUO0Epl+TLsDNGeo8Hc/lhjWVVc7rWciCFF7FW
         yesw==
X-Gm-Message-State: AOAM5326vlbmMe0EmOWmESGzqpbluFepUOO90n3L7dODPI6gtBzq/U/x
        G09EVQCwHlykEYlbwOd3pOPbE4x088h9L7eC/+uKGg==
X-Google-Smtp-Source: ABdhPJwfx8y+zdl0tsH5FUzDhfgm/mIf+WMkCovlWrXD/lgKM6h61pm3Iy+9uPIJUCnfHF/yPZ8bgWtuaa+nAhm2ook=
X-Received: by 2002:adf:f6cc:: with SMTP id y12mr16153497wrp.178.1627302888459;
 Mon, 26 Jul 2021 05:34:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210723124611.3828908-1-suzuki.poulose@arm.com> <20210723124611.3828908-8-suzuki.poulose@arm.com>
In-Reply-To: <20210723124611.3828908-8-suzuki.poulose@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Mon, 26 Jul 2021 13:34:37 +0100
Message-ID: <CAJ9a7Vi28GuPUx8jvGoYhqBRzWanwhiLJJuLnaZuPj46g3ex2w@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] coresight: trbe: Do not truncate buffer on IRQ
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Coresight ML <coresight@lists.linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tamas.zsoldos@arm.com, Al Grant <al.grant@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        jinlmao@qti.qualcomm.com, James Clark <james.clark@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On Fri, 23 Jul 2021 at 13:46, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> The TRBE driver marks the AUX buffer as TRUNCATED when we get an IRQ
> on FILL event. This has rather unwanted side-effect of the event
> being disabled when there may be more space in the ring buffer.
>
> So, instead of TRUNCATE we need a different flag to indicate
> that the trace may have lost a few bytes (i.e from the point of
> generating the FILL event until the IRQ is consumed). Anyways, the
> userspace must use the size from RECORD_AUX headers to restrict
> the "trace" decoding.
>
> Using PARTIAL flag causes the perf tool to generate the
> following warning:
>
>   Warning:
>   AUX data had gaps in it XX times out of YY!
>
>   Are you running a KVM guest in the background?
>
> which is pointlessly scary for a user. The other remaining options
> are :
>   - COLLISION - Use by SPE to indicate samples collided
>   - Add a new flag - Specifically for CoreSight, doesn't sound
>     so good, if we can re-use something.
>

What is the user visible behaviour when using COLLISION?
The TRUNCATE warning is at least accurate - even if the KVM thing is
something of a red herring.
It is easier to explain a "scary" warning, than try to debug someones
problems if perf is silent or misleading when using the COLLISION
flag.

Regards

Mike


> Given that we don't already use the "COLLISION" flag, the above
> behavior can be notified using this flag for CoreSight.
>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: James Clark <james.clark@arm.com>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-trbe.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index 503bea0137ae..d50f142e86d1 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -615,7 +615,7 @@ static unsigned long arm_trbe_update_buffer(struct coresight_device *csdev,
>                  * for correct size. Also, mark the buffer truncated.
>                  */
>                 write = get_trbe_limit_pointer();
> -               perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
> +               perf_aux_output_flag(handle, PERF_AUX_FLAG_COLLISION);
>         }
>
>         offset = write - base;
> @@ -708,7 +708,7 @@ static void trbe_handle_overflow(struct perf_output_handle *handle)
>          * collection upon the WRAP event, without stopping the source.
>          */
>         perf_aux_output_flag(handle, PERF_AUX_FLAG_CORESIGHT_FORMAT_RAW |
> -                                    PERF_AUX_FLAG_TRUNCATED);
> +                                    PERF_AUX_FLAG_COLLISION);
>         perf_aux_output_end(handle, size);
>         event_data = perf_aux_output_begin(handle, event);
>         if (!event_data) {
> --
> 2.24.1
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
