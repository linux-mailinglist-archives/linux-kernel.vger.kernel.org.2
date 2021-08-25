Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98C1F3F7AEA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240948AbhHYQt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbhHYQtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:49:55 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D54C061757;
        Wed, 25 Aug 2021 09:49:09 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id m11-20020a056820034b00b0028bb60b551fso9258ooe.5;
        Wed, 25 Aug 2021 09:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0PnOjcm9Fuu9oRLVmMOTan/jdn80kkK21Ga9ki6Awwk=;
        b=oLKBYXOX8Zl+nQIQ14XImUuWQDtAypiP2IN8YZ51Fwze2diqVC9UNIFVWk6OBBzEy4
         yi8ypOx5PPoYDrOalicVkFtXLnmzo7MOKuVAKUDCC509ce6bcN7HA+yTIjxZWRwpQPEj
         KgpFu0POrV2wkwhXSReVmSi/UADcgH8GPIiA+BM60Gmjc3RaMwoKlfUty1Isj/SlfIN+
         9ZNlcqEhis7iVsoL2PHQ7gQTQB/MZ2jco6pv08+KJDaN2HLmF73HnE9o657+z2oIYSS5
         MhI4oEU0I2a8ObpWDWd//HUEpCnag3hF9Bx17N4KR6cV088YU5BcaXhiE1yJHD28G2O1
         mgdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0PnOjcm9Fuu9oRLVmMOTan/jdn80kkK21Ga9ki6Awwk=;
        b=ZjfT3e/g4PI9S/Plqj+QKbk7V3EPmODAej86Z/DQ4S3nHY9AvsKHQwQHu390YmMpI3
         L3wTVbPeSV0KzR+mRKO0/vIJnS/HE32X7YSsc7+vAK0wigeEIS7IY4gj1kYWqmpPL5WJ
         pJLKNod7LQ93+UeWLQHQg3o+ixHpJjeczZo56pnx8NKcDuZzl21nwJMEUe21y/GJGMet
         IAFofUFxx7/ogFEIhJID4Bm8tmb35SrDmLJ73c4ZAr2Hbmo7l5zywK1T+XXFONenFCjr
         A4KK/AaYWbIxoyG7myHKYqx1kXXgSMCvywuXMWTmGOlfSwOC/irkrevZhb43qRpyx1UB
         2XVw==
X-Gm-Message-State: AOAM532izYGiITjkOZlHhSKjEup9gsKwi+RA1NVb+Zcud9UFbU3ekZMd
        TQ8Wx6m9LgE4/k5mbfmsjjdPUQarKbBz1SjWBOM=
X-Google-Smtp-Source: ABdhPJxtlTki/sGBLa9DFM+o5O7lTh25DEiF6j7B6Xps5jPXQTiyNItJ0IZv26fJlktcUUknHJZV96yu5azfwgaPN+4=
X-Received: by 2002:a4a:ba86:: with SMTP id d6mr35250933oop.61.1629910148947;
 Wed, 25 Aug 2021 09:49:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210825113615.14555-1-colin.king@canonical.com> <feed4359-c682-bb13-5584-6f34bb9960eb@amd.com>
In-Reply-To: <feed4359-c682-bb13-5584-6f34bb9960eb@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 25 Aug 2021 12:48:57 -0400
Message-ID: <CADnq5_OTr97_PXPENkT2aZs9xAueFt=2wreDQh9U-MB_zR2c9g@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/display: fix spelling mistake "alidation"
 -> "validation"
To:     Harry Wentland <harry.wentland@amd.com>
Cc:     Colin King <colin.king@canonical.com>, Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Wed, Aug 25, 2021 at 10:09 AM Harry Wentland <harry.wentland@amd.com> wrote:
>
> On 2021-08-25 7:36 a.m., Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > There is a spelling mistake in a DC_LOG_WARNING message. Fix it.
> >
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> >  drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> > index 3223a1ff2292..91cbc0922ad4 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> > @@ -1999,7 +1999,7 @@ bool dcn31_validate_bandwidth(struct dc *dc,
> >       goto validate_out;
> >
> >  validate_fail:
> > -     DC_LOG_WARNING("Mode Validation Warning: %s failed alidation.\n",
> > +     DC_LOG_WARNING("Mode Validation Warning: %s failed validation.\n",
> >               dml_get_status_message(context->bw_ctx.dml.vba.ValidationStatus[context->bw_ctx.dml.vba.soc.num_states]));
> >
> >       BW_VAL_TRACE_SKIP(fail);
> >
>
