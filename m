Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061B53F77EE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 17:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241925AbhHYPBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 11:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241879AbhHYPBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 11:01:49 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C562C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 08:01:03 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id mf2so33689277ejb.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 08:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=799Z2/KI179bQQtbwpweoVZ8bCIlvRuDcOdYa/Ykq6o=;
        b=b9hIktd2WqHzMClvxOOWXl/vQK4fjLGVQEiXo6uMVYGMNJc5vg/R7LOLDkMdsuKvU6
         RpxYhkQL2IVzgZmbzR3na8bbnb+qF3mWrznYPFJWTuGlYQBC6EuGm83s9WnWJQfBI7Wu
         5MyjvuzhorukoRA2WY+2KtPJWuBv8FRXiyJ6M8NYAtyak3VsAbiipu/rp2GqRu38oWL5
         C8eaNa0fCEjzG92VZj7PyfcKiRQn57Y/EePc57ePxHmM5AimBQBjfJEKla2A5Fu+RUhe
         DtG9MCXjSHJIkMpe4hP1wFeF+Ms5BVJzO+1bdcMUQk6+1L05DnbGFR8p3sFm0TMkllss
         4xsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=799Z2/KI179bQQtbwpweoVZ8bCIlvRuDcOdYa/Ykq6o=;
        b=XVv17QmHbwMog6UR0B6TSxU69x6X+eRBkzvhUghhKkIRIatfMu9Hz+0YWCdZDPOso2
         kP6oMQGinO4IsqNgzSI1s+1hUItajGSHxUGyd4VkY5fEz5+g3LZs1MpT9bwvGvC7jwSK
         O/YvbyXXP+nZhK4J1LXm7cZQNXXilLe5wt9SYIkVKEOUpTPDxDwZVXcR+cM9kJJP7S85
         YeAmHRYXpXAnX7bLG1jd/l71zyBcF2Ac9uKBb+qeCP7aDX85ouSP2tqQtzR1Mw3/An5m
         U41SI9W50PRfUQWCFeX96NBjfYsLS/YOcgCcC0JjX7a86PdmVyERP4w+T08wo0Hfrz3G
         WzcQ==
X-Gm-Message-State: AOAM530GPoZaSKOrSXBkxZEb+HcFJzicGwXESumdWP6wZBZl/ecxCOu1
        EuU0r7Vz8VDG2Nu231DqeHAvBHLHp5EwTND8Ioc5xA==
X-Google-Smtp-Source: ABdhPJwENuukB5OO0YiAwI6TPo2OIjuvYqPyTQll7Yyy1upT4Emk7nF7OSjhWu+LGhKBnCVaUp8ZqsTTLHCVvE2o1Ks=
X-Received: by 2002:a17:907:aa4:: with SMTP id bz4mr21342624ejc.97.1629903661576;
 Wed, 25 Aug 2021 08:01:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210823200132.2006257-1-gwendal@chromium.org>
In-Reply-To: <20210823200132.2006257-1-gwendal@chromium.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 25 Aug 2021 08:00:50 -0700
Message-ID: <CABXOdTe3P_z3QjTcQQya90LB2N29b1DW7-bAH_ix2XhjisnJxg@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_trace: Fix format warnings
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 1:01 PM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> Fix printf format issues in new tracing events.
>
> Fixes: 814318242 ("platform/chrome: cros_ec_trace: Add fields to command traces")
>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  drivers/platform/chrome/cros_ec_trace.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_trace.h b/drivers/platform/chrome/cros_ec_trace.h
> index f50b9f9b8610..a2052db55671 100644
> --- a/drivers/platform/chrome/cros_ec_trace.h
> +++ b/drivers/platform/chrome/cros_ec_trace.h
> @@ -92,7 +92,7 @@ TRACE_EVENT(cros_ec_sensorhub_timestamp,
>                 __entry->current_time = current_time;
>                 __entry->delta = current_timestamp - current_time;
>         ),
> -       TP_printk("ec_ts: %12lld, ec_fifo_ts: %12lld, fifo_ts: %12lld, curr_ts: %12lld, curr_time: %12lld, delta %12lld",
> +       TP_printk("ec_ts: %9d, ec_fifo_ts: %9d, fifo_ts: %12lld, curr_ts: %12lld, curr_time: %12lld, delta %12lld",

Should that be %u (the variables are u32) ?

>                   __entry->ec_sample_timestamp,
>                 __entry->ec_fifo_timestamp,
>                 __entry->fifo_timestamp,
> @@ -122,7 +122,7 @@ TRACE_EVENT(cros_ec_sensorhub_data,
>                 __entry->current_time = current_time;
>                 __entry->delta = current_timestamp - current_time;
>         ),
> -       TP_printk("ec_num: %4d, ec_fifo_ts: %12lld, fifo_ts: %12lld, curr_ts: %12lld, curr_time: %12lld, delta %12lld",
> +       TP_printk("ec_num: %4d, ec_fifo_ts: %9d, fifo_ts: %12lld, curr_ts: %12lld, curr_time: %12lld, delta %12lld",

Same here.

Thanks,
Guenter

>                   __entry->ec_sensor_num,
>                 __entry->ec_fifo_timestamp,
>                 __entry->fifo_timestamp,
> @@ -153,7 +153,7 @@ TRACE_EVENT(cros_ec_sensorhub_filter,
>                 __entry->x = state->x_offset;
>                 __entry->y = state->y_offset;
>         ),
> -       TP_printk("dx: %12lld. dy: %12lld median_m: %12lld median_error: %12lld len: %d x: %12lld y: %12lld",
> +       TP_printk("dx: %12lld. dy: %12lld median_m: %12lld median_error: %12lld len: %lld x: %12lld y: %12lld",
>                   __entry->dx,
>                 __entry->dy,
>                 __entry->median_m,
> --
> 2.33.0.rc2.250.ged5fa647cd-goog
>
