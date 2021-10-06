Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEF6424A04
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 00:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235390AbhJFWrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 18:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbhJFWrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 18:47:15 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B68EC061746
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 15:45:22 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id y197so4577838iof.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 15:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=U8M1dbFOi9vkEKSXXtpgGgRcXsxEcCDZd9Id5Kn3KAI=;
        b=Uhk8XSdYNn5h631zIYLqXzX59plnecs521+YuO/NTKZH6E/AX58IiUEAjOq3QynJxs
         dMvFokV/kZuzna/vkHp59E0MLrFlUruxIdNrCMYk9kEVpFHYcivMVwa9wDxXyO34OquZ
         fOtMiNcvQKkSNxhyUkPoOtLnics+MqHxA7y2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=U8M1dbFOi9vkEKSXXtpgGgRcXsxEcCDZd9Id5Kn3KAI=;
        b=RHxAQT9BAQUqCl2gxos78ijM8qC4D/YiY5ImHRl7FkYCXnDxa7a5Dapgpp1Nag3+9e
         FL84KneW/2UH1zmiRjo5SAKxoQV0hV242e3dkDQTRrTBwLBk8w9pcL1radFvDW8fLiHN
         LefnhQQT7rcpGX/8RZIY/BmhMZPo2WVst9PEOC0tEu7qNoqbPQ62TrKfccm7eviG8fe7
         e2V9O4B7dD5R328w2BlXF+uKAvTVgc0NJMxO+8/aWESEP4vIj3METZEPd7mYwj3Roqyg
         gP1jCGei2ELC11saExZ4y0Rgt+taiddasTesOBeb8Y7dF/QizL3YLeXx9KeNFwBOuJ0T
         jsPQ==
X-Gm-Message-State: AOAM533poTek/BfEforkcYqm9iLk/RxITtEhkpBfKRqWw3c2oR1cIBHe
        JaofTgObafgFg+0Ks3lNAhRk1l2sApNU1g==
X-Google-Smtp-Source: ABdhPJx3FpPoo5usJRYguNaSBlyfK/1nI8IX9oYRJDMRwKMcvmvHz3K63FQ79lX1T2FdpTQ04to81A==
X-Received: by 2002:a5e:d612:: with SMTP id w18mr724537iom.196.1633560321682;
        Wed, 06 Oct 2021 15:45:21 -0700 (PDT)
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com. [209.85.166.172])
        by smtp.gmail.com with ESMTPSA id k4sm12803085ilc.10.2021.10.06.15.45.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 15:45:20 -0700 (PDT)
Received: by mail-il1-f172.google.com with SMTP id r9so4446130ile.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 15:45:19 -0700 (PDT)
X-Received: by 2002:a05:6e02:1847:: with SMTP id b7mr591808ilv.180.1633560319430;
 Wed, 06 Oct 2021 15:45:19 -0700 (PDT)
MIME-Version: 1.0
References: <20211005192905.v2.1.Ib059f9c23c2611cb5a9d760e7d0a700c1295928d@changeid>
In-Reply-To: <20211005192905.v2.1.Ib059f9c23c2611cb5a9d760e7d0a700c1295928d@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 6 Oct 2021 15:45:07 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XP6TFVn=uxRYr0fXzK9s-uh=a06kZBA5Y6Sj99OCeCXQ@mail.gmail.com>
Message-ID: <CAD=FV=XP6TFVn=uxRYr0fXzK9s-uh=a06kZBA5Y6Sj99OCeCXQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/edid: In connector_bad_edid() cap num_of_ext by
 num_blocks read
To:     dri-devel <dri-devel@lists.freedesktop.org>
Cc:     "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        "Zuo, Jerry" <Jerry.Zuo@amd.com>, alexander.deucher@amd.com,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        Kuogee Hsieh <khsieh@codeaurora.org>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
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

On Tue, Oct 5, 2021 at 7:29 PM Douglas Anderson <dianders@chromium.org> wro=
te:
>
> In commit e11f5bd8228f ("drm: Add support for DP 1.4 Compliance edid
> corruption test") the function connector_bad_edid() started assuming
> that the memory for the EDID passed to it was big enough to hold
> `edid[0x7e] + 1` blocks of data (1 extra for the base block). It
> completely ignored the fact that the function was passed `num_blocks`
> which indicated how much memory had been allocated for the EDID.
>
> Let's fix this by adding a bounds check.
>
> This is important for handling the case where there's an error in the
> first block of the EDID. In that case we will call
> connector_bad_edid() without having re-allocated memory based on
> `edid[0x7e]`.
>
> Fixes: e11f5bd8228f ("drm: Add support for DP 1.4 Compliance edid corrupt=
ion test")
> Reported-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
> ---
> This problem report came up in the context of a patch I sent out [1]
> and this is my attempt at a fix. The problem predates my patch,
> though. I don't personally know anything about DP compliance testing
> and what should be happening here, nor do I apparently have any
> hardware that actually reports a bad EDID. Thus this is just compile
> tested. I'm hoping that someone here can test this and make sure it
> seems OK to them.
>
> Changes in v2:
> - Added a comment/changed math to help make it easier to grok.
>
>  drivers/gpu/drm/drm_edid.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)

Pushed this to drm-misc-fixes since the commit it fixes is fairly old.

fdc21c35aaa1 drm/edid: In connector_bad_edid() cap num_of_ext by num_blocks=
 read

-Doug
