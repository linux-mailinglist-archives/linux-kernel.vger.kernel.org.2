Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9C03AD3BA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 22:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbhFRUlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 16:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbhFRUlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 16:41:11 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1269FC061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 13:39:02 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id v22-20020a0568301416b029044e2d8e855eso1741413otp.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 13:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nD7oBPgnsjHovc35dRV1EnwyKD64NWmMZBEUkjTpRAk=;
        b=bGHfYJiF4w7UHvnhqHzUBV+Ocgv62RTKy3BxvmluYs4zlE/oYdP/GZh0yLoAUPEWh1
         A6ZcK/H8jDWibtdxxdXdCkYiAlEShhADL9i2UuTxii+K77qGd67UpmhzRj3UxcAwwchW
         Q6k+Z/Gfa2zMpoaYir5dJd/i17pGQvvYrIKwpZ37T4jLyREwlDiQUkEY0KkBn1b9CtJj
         yx381egCru++BfsAG6YSUh9sgwhnS08kk0VeSOvSpnCyUhOg2W8qXXuSoe6xgcbpNVwr
         /Na7pmK4QRtt7mggyF9Zj4Mn6czrKIyiirzIIH97wQXuopVuLBBUepMk3e0pt3GlCuLt
         arOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nD7oBPgnsjHovc35dRV1EnwyKD64NWmMZBEUkjTpRAk=;
        b=hBb+pLQiQSZ5KbaX2tyKoqc8USeLOxgvTmcXkZJqsikFUakoEui9XnJcXiAfHpU+ax
         PMYUpMe4ZzekDUVJs1BpMIgUNqs/SXBvUKA7cRGkYK1o8ppeocFA7BYFxziKUzukX/ld
         CEQFGQg72+gV8+kJfZmVbsl3rqz+cKJqThikEyGdW4wsKGbvJ4dqUmEnCW49X9SN4sgg
         9Om7PZU2m1x33qY5VCTt8qwBuxNKNcksfM67rNrwc7WX1QqGLud/Z/9wNAsgaI3C6FaR
         VECiNltKGqM7i3JHDRhDniag8KPZnGy/fwG7M14398lsxMRvc+CqWjXa3JfFey3J970a
         mWsA==
X-Gm-Message-State: AOAM5328+TfxmtJPBsB4nmXsLTRQK8jgdq3rThXJ88RPQUQ+1KwS5Ge4
        ehcEdNz/oayRTo2VpNLgzR06Mp1YE0jUfnqhS64=
X-Google-Smtp-Source: ABdhPJxwuxAhIXgJOKbxs/TF2vViARLkV53PxnduNs8KxpXsryq2O+j1c5KXo1dVlz0GX1vgCOd/a6t/8ZOOgIn2y6k=
X-Received: by 2002:a05:6830:1e64:: with SMTP id m4mr11039021otr.23.1624048741539;
 Fri, 18 Jun 2021 13:39:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210616144027.27225-1-wanjiabing@vivo.com> <0c0c719e-d8fe-b548-80cd-c498642a6c3c@amd.com>
In-Reply-To: <0c0c719e-d8fe-b548-80cd-c498642a6c3c@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 18 Jun 2021 16:38:50 -0400
Message-ID: <CADnq5_M-i-NzvCm5DVaRGsM2G+cR_rRmbisPwbd-4ynM8O3mWQ@mail.gmail.com>
Subject: Re: [PATCH] drm/display: Fix duplicated argument
To:     Harry Wentland <harry.wentland@amd.com>
Cc:     Wan Jiabing <wanjiabing@vivo.com>, Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Solomon Chiu <solomon.chiu@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Anson Jacob <Anson.Jacob@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, kael_w@yeah.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Fri, Jun 18, 2021 at 9:56 AM Harry Wentland <harry.wentland@amd.com> wrote:
>
> On 2021-06-16 10:40 a.m., Wan Jiabing wrote:
> > Fix coccicheck warning:
> >
> > ./drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c:
> > 55:12-42: duplicated argument to && or ||
> >
> > Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> >  .../gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c   | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
> > index cb15525ddb49..dc8b3afef301 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
> > @@ -52,7 +52,7 @@ static bool CalculateBytePerPixelAnd256BBlockSizes(
> >               *BytePerPixelDETC = 0;
> >               *BytePerPixelY = 4;
> >               *BytePerPixelC = 0;
> > -     } else if (SourcePixelFormat == dm_444_16 || SourcePixelFormat == dm_444_16) {
> > +     } else if (SourcePixelFormat == dm_444_16) {
> >               *BytePerPixelDETY = 2;
> >               *BytePerPixelDETC = 0;
> >               *BytePerPixelY = 2;
> >
>
