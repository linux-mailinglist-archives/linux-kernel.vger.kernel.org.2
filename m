Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E88C3497A1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 18:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhCYRIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 13:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhCYRIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 13:08:25 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869E8C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 10:08:21 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id x2so2861909oiv.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 10:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1PkoObgjDP1C1nJf3TQFBvDH6KCzgdXB9bud0P2XCd0=;
        b=ssVNbWY7QaP0IX3/njd3dS76K+/y6hzcso4UF4Fq0mrzK8WUfF5Ddw2Wfx8q2nIimR
         01Ra6V0tUQhLWZlIYjNCoW7qVtfNQaEFazZY6ghESyOGIgIp2JjWATAgMXKMvRV0FgwB
         2d2td2CN9LIpmdKYRUoRcbeRKFlxwhSJt90QoCUm00jpEoIAvV82Xznqz7rFbGgX/kgJ
         tPkFjVSvKPCGxAIk1Uchsresky+7M/9UYHu/GrSJ/k1OHBWdgprhW93GzLQIOT4zwEBy
         giTdviKYTvl5UX8NxuYws3Hnjktd1PiJpOOb5TiOx2iD3Ky3GV4k7jajhidS6OFCuNsx
         1Nnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1PkoObgjDP1C1nJf3TQFBvDH6KCzgdXB9bud0P2XCd0=;
        b=bxzx7lmQtBqId+EtpLnKr+d1kW0zGLfvvx5upUFt0wJ1m30ffne4BPFhHqgPTONcv1
         cK2oek99zhA8oiIvG4jqRhmoyZ1fW/kBqGbmK3Yj+pEJJrshZpamZYZZ10rYuL0LTrh2
         C4qItz+SiGlZ0EaryUQSYqJuOYmPfQoa3CYPE4X7P4oDc9yKsV6l2TpW5geszEyopXHc
         0dYay/U2xsWieFJuQTkaHaDhtCVjfF0OatD3QbXNgEWB7aKJBEEg1go36ScMon66iBD2
         6BaO/KCHAszcbmnsWgXgsWG9vlXBqWynPHqyPAU9gy2I9+O5SLbEMVSJfcyXCrjcvMZa
         Esfw==
X-Gm-Message-State: AOAM530uHM73GiNPmkDxomw6205VqW7TVU8kqlSvD3LwWtym1KCcp5ib
        OzuHBkZ2ZI1FMN+mS7cEcbOAe79e4FdK0wjwTtg=
X-Google-Smtp-Source: ABdhPJwN6SLyKxUYQXpoYiFP9yp1Ip5mQhoWAwFyE4e7a/0zLr1UczMSFR/yhlDae8rWuqlA2R2yl8Ee+E8EL6ooSt4=
X-Received: by 2002:a05:6808:68a:: with SMTP id k10mr4720367oig.120.1616692100977;
 Thu, 25 Mar 2021 10:08:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210322210612.1786322-1-unixbhaskar@gmail.com> <9696cd2a-bac2-15ba-c8e4-434df7b5cee0@infradead.org>
In-Reply-To: <9696cd2a-bac2-15ba-c8e4-434df7b5cee0@infradead.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 25 Mar 2021 13:08:09 -0400
Message-ID: <CADnq5_OP6rhH48wCWQVFrAC4iH0-v4ihREPMx8qOa=DkHKAehw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Fix a typo in two different sentences
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Quan, Evan" <evan.quan@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Mon, Mar 22, 2021 at 6:45 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 3/22/21 2:06 PM, Bhaskar Chowdhury wrote:
> >
> > s/defintion/definition/ .....two different places.
> >
> > Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
>
> > ---
> >  drivers/gpu/drm/amd/include/atombios.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/include/atombios.h b/drivers/gpu/drm/amd/include/atombios.h
> > index c1d7b1d0b952..47eb84598b96 100644
> > --- a/drivers/gpu/drm/amd/include/atombios.h
> > +++ b/drivers/gpu/drm/amd/include/atombios.h
> > @@ -1987,9 +1987,9 @@ typedef struct _PIXEL_CLOCK_PARAMETERS_V6
> >  #define PIXEL_CLOCK_V6_MISC_HDMI_BPP_MASK           0x0c
> >  #define PIXEL_CLOCK_V6_MISC_HDMI_24BPP              0x00
> >  #define PIXEL_CLOCK_V6_MISC_HDMI_36BPP              0x04
> > -#define PIXEL_CLOCK_V6_MISC_HDMI_36BPP_V6           0x08    //for V6, the correct defintion for 36bpp should be 2 for 36bpp(2:1)
> > +#define PIXEL_CLOCK_V6_MISC_HDMI_36BPP_V6           0x08    //for V6, the correct definition for 36bpp should be 2 for 36bpp(2:1)
> >  #define PIXEL_CLOCK_V6_MISC_HDMI_30BPP              0x08
> > -#define PIXEL_CLOCK_V6_MISC_HDMI_30BPP_V6           0x04    //for V6, the correct defintion for 30bpp should be 1 for 36bpp(5:4)
> > +#define PIXEL_CLOCK_V6_MISC_HDMI_30BPP_V6           0x04    //for V6, the correct definition for 30bpp should be 1 for 36bpp(5:4)
> >  #define PIXEL_CLOCK_V6_MISC_HDMI_48BPP              0x0c
> >  #define PIXEL_CLOCK_V6_MISC_REF_DIV_SRC             0x10
> >  #define PIXEL_CLOCK_V6_MISC_GEN_DPREFCLK            0x40
> > --
>
>
> --
> ~Randy
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
