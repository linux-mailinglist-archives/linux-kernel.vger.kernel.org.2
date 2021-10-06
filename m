Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F22E4235D6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 04:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237173AbhJFCdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 22:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhJFCdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 22:33:00 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA73C061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 19:31:09 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id m20so445915iol.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 19:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bq9ss4KGNTszJ/kr+WZe6xTy7aLeLEFMgM617QHj7Q4=;
        b=TFOgfLbssDLWXqgCEl2UkHChoVh4e/FDI3d5hi7PU/H3mkdfRDa/XyUa+7NLlGcJ0G
         lyR8MCEij49zKnhkJUKibBFMzapmSWysRvZkbBxy6teoJsMZHMFwD4G+uEHmHDAiQjlb
         UcjqBpNKg/YWTO316tR0011lAmkVVcHcaU/mQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bq9ss4KGNTszJ/kr+WZe6xTy7aLeLEFMgM617QHj7Q4=;
        b=qwjm5bduFoyUDengwXHOB1DKVx8CgK73Wr/ry/MnbngPaX4LHVHxNMnOHcQQPkSVqq
         9N3YlHkKkEnhrCSlafJQVGbYZMzKMOLF0UfuWxSXUujwNneqCycExU3vKrpzwoik/75e
         Yif1ub/2DPdDFGN/hK3gZ0dx7i4JScQ1FEEikZlK6EBhymL0zqxVV8SNkhC74o6OT5qm
         Gkip95WJcK67SEJJrnLr81cgZtjWretD7FQoO8jfJ1Ay5wshL778aSOYD5fZZDI9blD6
         hnOTpNyVTqg6Ub4XfcEZq/jZOYcmIs21M1dDdjjlHXgdKGo59lnlVChbZYjyAuZixeyP
         sYyA==
X-Gm-Message-State: AOAM532dT7vX/JVCUJPBNV5ZMqtOVj4NPVSJ4Vs61G6RMtOFtQWPG7ZB
        UhSZrr05F1PZd11Y5pEt+l9XjrA1kUv5aA==
X-Google-Smtp-Source: ABdhPJyxxrSy3yzvNfd5aOuhPVtgObLSbbGF5eAPadhWHICTQGp8Q762HxZy9gyhAV4YY2vZIiN3xQ==
X-Received: by 2002:a05:6638:3048:: with SMTP id u8mr5332178jak.103.1633487468287;
        Tue, 05 Oct 2021 19:31:08 -0700 (PDT)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com. [209.85.166.48])
        by smtp.gmail.com with ESMTPSA id b83sm11525280iof.5.2021.10.05.19.31.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 19:31:07 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id n71so1214924iod.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 19:31:07 -0700 (PDT)
X-Received: by 2002:a05:6638:248a:: with SMTP id x10mr5311411jat.3.1633487466752;
 Tue, 05 Oct 2021 19:31:06 -0700 (PDT)
MIME-Version: 1.0
References: <20211005081022.1.Ib059f9c23c2611cb5a9d760e7d0a700c1295928d@changeid>
 <YVxzX9h+jBqOj1/V@intel.com>
In-Reply-To: <YVxzX9h+jBqOj1/V@intel.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 5 Oct 2021 19:30:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XEVJ8trPx39-oepbW6gZJYCcE_W5F0rrC0gUsLTFUy9w@mail.gmail.com>
Message-ID: <CAD=FV=XEVJ8trPx39-oepbW6gZJYCcE_W5F0rrC0gUsLTFUy9w@mail.gmail.com>
Subject: Re: [PATCH] drm/edid: In connector_bad_edid() cap num_of_ext by
 num_blocks read
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        Kuogee Hsieh <khsieh@codeaurora.org>,
        "Zuo, Jerry" <Jerry.Zuo@amd.com>, alexander.deucher@amd.com,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 5, 2021 at 8:46 AM Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:
>
> On Tue, Oct 05, 2021 at 08:10:28AM -0700, Douglas Anderson wrote:
> > In commit e11f5bd8228f ("drm: Add support for DP 1.4 Compliance edid
> > corruption test") the function connector_bad_edid() started assuming
> > that the memory for the EDID passed to it was big enough to hold
> > `edid[0x7e] + 1` blocks of data (1 extra for the base block). It
> > completely ignored the fact that the function was passed `num_blocks`
> > which indicated how much memory had been allocated for the EDID.
> >
> > Let's fix this by adding a bounds check.
> >
> > This is important for handling the case where there's an error in the
> > first block of the EDID. In that case we will call
> > connector_bad_edid() without having re-allocated memory based on
> > `edid[0x7e]`.
> >
> > Fixes: e11f5bd8228f ("drm: Add support for DP 1.4 Compliance edid corru=
ption test")
> > Reported-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > This problem report came up in the context of a patch I sent out [1]
> > and this is my attempt at a fix. The problem predates my patch,
> > though. I don't personally know anything about DP compliance testing
> > and what should be happening here, nor do I apparently have any
> > hardware that actually reports a bad EDID. Thus this is just compile
> > tested. I'm hoping that someone here can test this and make sure it
> > seems OK to them.
> >
> >  drivers/gpu/drm/drm_edid.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> > index 9b19eee0e1b4..ccfa08631c57 100644
> > --- a/drivers/gpu/drm/drm_edid.c
> > +++ b/drivers/gpu/drm/drm_edid.c
> > @@ -1843,8 +1843,9 @@ static void connector_bad_edid(struct drm_connect=
or *connector,
> >       u8 num_of_ext =3D edid[0x7e];
> >
> >       /* Calculate real checksum for the last edid extension block data=
 */
> > -     connector->real_edid_checksum =3D
> > -             drm_edid_block_checksum(edid + num_of_ext * EDID_LENGTH);
> > +     if (num_of_ext <=3D num_blocks - 1)
>
> Something about that doesn't really agree with my brain.
> It's correct but when I read it I can't immediately see it.
>
> I guess what I'd like to see is something like:
> last_block =3D edid[0x7e];
> if (last_block < num_blocks)
>         connector->real_edid_checksum =3D
>                 drm_edid_block_checksum(edid + last_block * EDID_LENGTH);
>
> Techically exactly the same thing, but I don't have to read
> the comparison twice to convince myself that it's correct.
>
> Anyways, this is
> Reviewed-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
> either way.

Yeah, my brain had to work way too hard when I read over my patch too.
I've changed to your math _plus_ a big comment explaining it. I added
your review tag. I'll give this another day or so and then land.

https://lore.kernel.org/r/20211005192905.v2.1.Ib059f9c23c2611cb5a9d760e7d0a=
700c1295928d@changeid

-Doug
