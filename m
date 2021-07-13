Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F0B3C715A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 15:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236484AbhGMNoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 09:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236222AbhGMNoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 09:44:06 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E54C0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 06:41:16 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id ay16so1559021qvb.12
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 06:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vLkS8he1bc7Cmh6yyqncyHjSKkBroAx2qiGQQkmeSgE=;
        b=G6nXn9w5QrREJfLwC4YiSeL105e5K/Qj9voXl1D7Hn7yXZYmyV7BuUuk8b/RxMb8gZ
         mN8sBsBj637g6rXMobZkIO3u87nyfOu1XImkt1jtpAPQL0DrxC3Bmim46FvTj1xaNVGf
         ErbXnNU1epcRtd2zGSxW7gIY9nDszcpXAMk0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vLkS8he1bc7Cmh6yyqncyHjSKkBroAx2qiGQQkmeSgE=;
        b=llApDxMya3paLmxrptco7YaHH/fZnaprMFlIImXVaqdNZCZPa38J1VKOSsHMXWub/C
         EjRQn9rd3yNWkSDmqkICSxlPXh+3ctwMw4PDNxv62hdxFn2zJQkxUaNlhUgdd3qeBjPD
         MjlCs475u5QNxdXJm5IpewtjirsBVMs5drb7koZ+BOoh0cDrISaq9GVqHR7dQHKRJKzo
         fedJHi3Oje+ALmkTum4G70oOBBwP4hv0447VfR/2Vx2YS59GFzdApVN9kxW6RbMgg8Fj
         k7Ehycwn3IdUJOZ9ZqFtqMAuLdUzhxKM8PMWCowM1HVfflYPjJ73xuWFrgIxDf0ZinlC
         c0SQ==
X-Gm-Message-State: AOAM533+TYnzYFAYMQ1m3S+cBpXvCvhPvZR5k/1IPbcWfoNesOGXsjnS
        xcsPIomU02/3mzJnNzG6y0fyeiaU3fArSw==
X-Google-Smtp-Source: ABdhPJzGNP/uWCvVCf7rrSDaCzbnfo9jyOdi41yTkBmrZxf40DGZkTmVfEdIpVoesLUVuvCaoPMJhA==
X-Received: by 2002:a05:6214:cac:: with SMTP id s12mr4865640qvs.29.1626183675254;
        Tue, 13 Jul 2021 06:41:15 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id f1sm7897559qkh.75.2021.07.13.06.41.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jul 2021 06:41:14 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id r135so34896497ybc.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 06:41:13 -0700 (PDT)
X-Received: by 2002:a25:ae14:: with SMTP id a20mr5690442ybj.41.1626183673327;
 Tue, 13 Jul 2021 06:41:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210712075933.v2.1.I23eb4cc5a680341e7b3e791632a635566fa5806a@changeid>
In-Reply-To: <20210712075933.v2.1.I23eb4cc5a680341e7b3e791632a635566fa5806a@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 13 Jul 2021 06:41:01 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wn1GU51vqBUZAt4b-_CE4qJpj+Himm8B9CBSn0L6P2XA@mail.gmail.com>
Message-ID: <CAD=FV=Wn1GU51vqBUZAt4b-_CE4qJpj+Himm8B9CBSn0L6P2XA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/dp: Move panel DP AUX backlight support to drm_dp_helper
To:     Lyude Paul <lyude@redhat.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Robert Foss <robert.foss@linaro.org>
Cc:     Rajeev Nandan <rajeevny@codeaurora.org>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 12, 2021 at 8:02 AM Douglas Anderson <dianders@chromium.org> wr=
ote:
>
> We were getting a depmod error:
>   depmod: ERROR: Cycle detected: drm_kms_helper -> drm -> drm_kms_helper
>
> It looks like the rule is that drm_kms_helper can call into drm, but
> drm can't call into drm_kms_helper. That means we've got to move the
> DP AUX backlight support into drm_dp_helper.
>
> NOTE: as part of this, I didn't try to do any renames of the main
> registration function. Even though it's in the drm_dp_helper, it still
> feels very parallel to drm_panel_of_backlight().
>
> Fixes: 10f7b40e4f30 ("drm/panel: add basic DP AUX backlight support")
> Reported-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
> Reported-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> Note that I've compile tested this, but I don't have a device setup
> yet that uses this code. Since the code is basically the same as it
> was this should be OK, but if Rajeev could confirm that nothing is
> broken that'd be nice.
>
> Changes in v2:
> - Guard new functions by the proper configs.
>
>  drivers/gpu/drm/drm_dp_helper.c | 113 ++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/drm_panel.c     | 108 ------------------------------
>  include/drm/drm_dp_helper.h     |  16 +++++
>  include/drm/drm_panel.h         |   8 ---
>  4 files changed, 129 insertions(+), 116 deletions(-)

Pushed to drm-misc-next with Rajeev's review:

072ed3431f5b drm/dp: Move panel DP AUX backlight support to drm_dp_helper

-Doug
