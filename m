Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07257325943
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 23:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbhBYWJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 17:09:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:37880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231326AbhBYWJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 17:09:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2AD3164EC3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 22:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614290920;
        bh=lgsSKsv5WWGw6seu4nq2AHtd41HuWunf07o+L8YoEzI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZggjfsYN5FrR9SupneuU2IRJjdzTdVaTsxv1Ie4wAMfYkcPd+2sXuu4YGSeIaV4nv
         8/01nMunkI7RZIO4i803veSZ5IaPoiJndTcXU4x5+ANnUNfxgDqUYUKhbUsdQKhIdk
         GPgHbFuaNAnvOdTwF9w6UIEpudU/zxKsHFuQQ3oyEpDDUOaEjKgL6new7zEyVv/0h4
         nsrowbXbCT3VeigwR5X56xc5bKhu4SjL6UvAN3PLtkvxs1/56GIcXJgXwOwOSvX487
         wY7RcofYniaCfx6I9No7ymbnohUh12JsTNf3q9iayJoDFm8rJnPsUs65OjqYj1GbLj
         96rt4hYCqdguQ==
Received: by mail-ot1-f44.google.com with SMTP id s3so7262041otg.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 14:08:40 -0800 (PST)
X-Gm-Message-State: AOAM5333/aKlygN/jdk95NPHU3fQ4t0qP1dk688JukyUXoY0Ceyw1YZH
        1LPyQtsEAB4ktpezdkxyNGqzkdrm5HDDxG9GcYI=
X-Google-Smtp-Source: ABdhPJy2J3/ZUvDiUbXnSkH6WsBBt1QpKTB1bWQ5CobTQTvdZQ++1o1JSl+X0cNGw2xDt070WbD+2Vi6fwPPHNEcwTI=
X-Received: by 2002:a9d:6b8b:: with SMTP id b11mr4028035otq.210.1614290919292;
 Thu, 25 Feb 2021 14:08:39 -0800 (PST)
MIME-Version: 1.0
References: <20210225150119.405469-1-arnd@kernel.org> <CAKwvOdkWfQi4vPphJ9X+xQ5MdzGhrHr1mj=oFGh3Yv5TB=76_Q@mail.gmail.com>
In-Reply-To: <CAKwvOdkWfQi4vPphJ9X+xQ5MdzGhrHr1mj=oFGh3Yv5TB=76_Q@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 25 Feb 2021 23:08:23 +0100
X-Gmail-Original-Message-ID: <CAK8P3a32ECSnoi=4Ux5RFLdtTxZQe3vuyoLht1SdZ8zujtNrQw@mail.gmail.com>
Message-ID: <CAK8P3a32ECSnoi=4Ux5RFLdtTxZQe3vuyoLht1SdZ8zujtNrQw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix an uninitialized index variable
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Stylon Wang <stylon.wang@amd.com>,
        Eryk Brol <eryk.brol@amd.com>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Simon Ser <contact@emersion.fr>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 10:34 PM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
> return parse_edid_cea(aconnector, edid_ext, EDID_LENGTH, vsdb_info) ? i : -ENODEV;
>
> would suffice, but the patch is still fine as is.

Right, I did not want to change more than necessary here, and the
original code already had the extra assignment instead of returning
the value.

> > @@ -9857,8 +9857,8 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
> >                         }
> >                 }
> >         } else if (edid && amdgpu_dm_connector->dc_sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A) {
> > -               hdmi_valid_vsdb_found = parse_hdmi_amd_vsdb(amdgpu_dm_connector, edid, &vsdb_info);
> > -               if (hdmi_valid_vsdb_found && vsdb_info.freesync_supported) {
> > +               i = parse_hdmi_amd_vsdb(amdgpu_dm_connector, edid, &vsdb_info);
> > +               if (i >= 0 && vsdb_info.freesync_supported) {
>
> reusing `i` here is safe, for now, but reuse of variables like this in
> separate branches like this might not get noticed if the function is
> amended in the future.
>
> >                         timing  = &edid->detailed_timings[i];
> >                         data    = &timing->data.other_data;

The entire point of the patch is that 'i' is in fact used in the following line,
but was lacking an intialization.

       Arnd
