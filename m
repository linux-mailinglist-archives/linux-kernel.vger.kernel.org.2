Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B540A3FBB5F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 20:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238265AbhH3SCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 14:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238134AbhH3SC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 14:02:29 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0781CC061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 11:01:34 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id r6so16977692ilt.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 11:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ygxSF0vN5/SU7CsyF4kC8J6axN9ar5vRUhTDMHlx2us=;
        b=akualRgpayXzMZSywS3MKwdOiFuHhXZB7aZLdQb5ZXcfTrfL6xMhyvXPBQP/WtLGAG
         nNvCuKV71CJ091AKsE8xkZSho4ml2kJjMMzZbeGCutokCbWid4ajBDN847XhBKEh/7dU
         /DFy86bSCotq7MgfTUSi98lrQvxDbSZlOC01Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ygxSF0vN5/SU7CsyF4kC8J6axN9ar5vRUhTDMHlx2us=;
        b=psDmXjn+nmXyjd3TIK7tE3u7YScjioqYIxPCkjc8fikmOuAhqQWwxewRSyrwDFOG7L
         OsNbs5nlkv4J3WkixtU/Mbi2jl1lludY97fIoNEdk/Dp1fqeCsEcM0MaCDX4iy6p4BCS
         ukJK6ejpLfsAxdfliY3u4SyksrnA5JrcBMQLb4vt11gNW3gLJ99At2Kedw5sge3xh/mv
         DvdH4JJap1pfwVSyqk/33FaZuE7vmMZXkziX4X71OICuZOrALg6m1C9b/Kinr7h+Nisr
         dKDTT0tE2Q1Dxg02GFyusAFmekl31LD3kzmBGbHSP7lIcfeD0wGH6Lan0lYNbYDvTX3V
         Ujow==
X-Gm-Message-State: AOAM530LvqgLiNtckvox8kvv/2xm/46q0ZFu7kTlv+jaPH68QTReMD8D
        pry86lX+XWoji0IclYExltN9wOj5E1VIkWraKMn2sA==
X-Google-Smtp-Source: ABdhPJwzVuz+HVLtTp+BKEtjNNk6KEolM9zZ4Ng6t7nOcDqHNyzLirnpJ9oTdweBkc9ZO025kdF2hrrfXLnOvmVuA+c=
X-Received: by 2002:a92:4a10:: with SMTP id m16mr17005674ilf.233.1630346493445;
 Mon, 30 Aug 2021 11:01:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210825181802.2838484-1-gwendal@chromium.org> <9d000f0c-ef4a-e92a-44ee-6a887d45f70b@gmail.com>
In-Reply-To: <9d000f0c-ef4a-e92a-44ee-6a887d45f70b@gmail.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Mon, 30 Aug 2021 11:01:22 -0700
Message-ID: <CAPUE2uuKVuYcDuSzedTxG187NvM_=u=EHyVBsWNHeD2ai3rHyg@mail.gmail.com>
Subject: Re: [PATCH v2] platform/chrome: cros_ec_trace: Fix format warnings
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed in V3.
Thanks,
Gwendal.

On Thu, Aug 26, 2021 at 10:21 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 25.08.2021 21:18, Gwendal Grignou =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > Fix printf format issues in new tracing events.
> >
> > Fixes: 814318242 ("platform/chrome: cros_ec_trace: Add fields to comman=
d traces")
> >
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > ---
> > Changes since v1:
> > - Use %u instead of %d for ec timestamp, it is presented as a u32.
> >
> >  drivers/platform/chrome/cros_ec_trace.h | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/platform/chrome/cros_ec_trace.h b/drivers/platform=
/chrome/cros_ec_trace.h
> > index f50b9f9b8610..9d0c848af310 100644
> > --- a/drivers/platform/chrome/cros_ec_trace.h
> > +++ b/drivers/platform/chrome/cros_ec_trace.h
> > @@ -92,7 +92,7 @@ TRACE_EVENT(cros_ec_sensorhub_timestamp,
> >               __entry->current_time =3D current_time;
> >               __entry->delta =3D current_timestamp - current_time;
> >       ),
> > -     TP_printk("ec_ts: %12lld, ec_fifo_ts: %12lld, fifo_ts: %12lld, cu=
rr_ts: %12lld, curr_time: %12lld, delta %12lld",
> > +     TP_printk("ec_ts: %9d, ec_fifo_ts: %9u, fifo_ts: %12lld, curr_ts:=
 %12lld, curr_time: %12lld, delta %12lld",
>
> ec_ts unsigned
>
> >                 __entry->ec_sample_timestamp,
> >               __entry->ec_fifo_timestamp,
> >               __entry->fifo_timestamp,
> > @@ -122,7 +122,7 @@ TRACE_EVENT(cros_ec_sensorhub_data,
> >               __entry->current_time =3D current_time;
> >               __entry->delta =3D current_timestamp - current_time;
> >       ),
> > -     TP_printk("ec_num: %4d, ec_fifo_ts: %12lld, fifo_ts: %12lld, curr=
_ts: %12lld, curr_time: %12lld, delta %12lld",
> > +     TP_printk("ec_num: %4d, ec_fifo_ts: %9u, fifo_ts: %12lld, curr_ts=
: %12lld, curr_time: %12lld, delta %12lld",
>
> ec_num unsigned
>
