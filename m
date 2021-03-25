Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3E0348CA6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 10:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhCYJT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 05:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbhCYJTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 05:19:03 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31823C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 02:19:03 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 91-20020a9d08640000b0290237d9c40382so1263129oty.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 02:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s8gaLzfKO51sv2EAdyYwOBAav4JswI+vzWWUFTJdNYY=;
        b=ZkxfOIKsj2q9i0xgCpJIWPTGgfJnpexFD69S2YCMtm7qz9+Vz3iFYeeL/zq8cW43eJ
         ZxJ0JznpvlRjP0MCLr3dVA6OrS5dUJtNyIVuvegpRL22m1fimwU5A2IkRinyZfD/MOg9
         pdBoeBEUs7bsM2BitRB3evCfcTP2TuuWcIMoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s8gaLzfKO51sv2EAdyYwOBAav4JswI+vzWWUFTJdNYY=;
        b=R1bJv4VxedpM9CLDzFocxXNPUAJXZINP4KzD3Ad36Uey+z4eWAs0SQcUOMS/K2vpIh
         U1t232e7IZ6aOm52LJLcMrbO2wZVONBqas5A6HFtcK6OsKYePi2oIhPJNhu11QQEv2Iw
         fSVSdsdJeZ/QvCfszNDVTKevO5PFfLEWrSbHV7KUeML2BsgjbCGV91Je0KRRxA35ZNUH
         7binlYzr6EixpIychdCcNxKBrgpGkKWog2phsueOpkcR4Rn7K/AUE8E0a6bh8caundWJ
         ikLEL/5m83uArCxmPvOEShzIiBV1BVDGhIc0Ipz1mspHBbAHx5FVClxXga9mKs8/NAWA
         pBhA==
X-Gm-Message-State: AOAM530V4hMvin9eqiwYZ7hTR/a34M8L+ZcfGkooril9baeFHYvhKbZp
        B7ilTjFPoCChHy0coIKwBw+1ujTNJ2Ed+cAarg5SMQ==
X-Google-Smtp-Source: ABdhPJwuRBoHhQ1X/QBIV1XedaouhUZsXyPMY5vgD/AZosvW57FTBULFoCWN1cliFURZtu4WwmxByGgjBHWXJVPUY/M=
X-Received: by 2002:a9d:845:: with SMTP id 63mr4608787oty.303.1616663942428;
 Thu, 25 Mar 2021 02:19:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210325061901.851273-1-wanjiabing@vivo.com> <e45d6b24-5e74-17f6-eb18-c6e51fed923a@epam.com>
 <CAKMK7uEpNexmDYar36ZEX0hbHoxH3Y+_D42NqjRwAqxpiCXHRA@mail.gmail.com>
In-Reply-To: <CAKMK7uEpNexmDYar36ZEX0hbHoxH3Y+_D42NqjRwAqxpiCXHRA@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 25 Mar 2021 10:18:51 +0100
Message-ID: <CAKMK7uGsjv5S8eKGwmM1ErQPnx+UdxgF5c8YXewEDEyMakpEig@mail.gmail.com>
Subject: Re: [PATCH] drivers: gpu: drm: xen_drm_front_drm_info is declared twice
To:     Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Wan Jiabing <wanjiabing@vivo.com>, David Airlie <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kael_w@yeah.net" <kael_w@yeah.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 10:16 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Thu, Mar 25, 2021 at 7:53 AM Oleksandr Andrushchenko
> <Oleksandr_Andrushchenko@epam.com> wrote:
> >
> > Hi,
> >
> > On 3/25/21 8:19 AM, Wan Jiabing wrote:
> > > struct xen_drm_front_drm_info has been declared.
> > > Remove the duplicate.
> > >
> > > Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> >
> > Thank you for the patch,
> >
> > Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> >
> > Will apply to drm-misc-next-fixes
>
> drm-misc-next-fixes is the wrong tree, bugfixes outside of the merge
> window belong into drm-misc-fixes. Please consult
>
> https://drm.pages.freedesktop.org/maintainer-tools/committer-drm-misc.html#where-do-i-apply-my-patch
>
> We need to hard-reset drm-misc-next-fixes back, please re-apply the
> patches (both of them) to drm-misc-fixes. Also adding drm-misc
> maintainers.

Also simple cleanup like this should be pushed to drm-misc-next, not
any of the -fixes branches.
-Daniel

> -Daniel
>
> >
> > Thank you,
> >
> > Oleksandr
> >
> > > ---
> > >   drivers/gpu/drm/xen/xen_drm_front_conn.h | 1 -
> > >   1 file changed, 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/xen/xen_drm_front_conn.h b/drivers/gpu/drm/xen/xen_drm_front_conn.h
> > > index 3adacba9a23b..e5f4314899ee 100644
> > > --- a/drivers/gpu/drm/xen/xen_drm_front_conn.h
> > > +++ b/drivers/gpu/drm/xen/xen_drm_front_conn.h
> > > @@ -16,7 +16,6 @@
> > >   struct drm_connector;
> > >   struct xen_drm_front_drm_info;
> > >
> > > -struct xen_drm_front_drm_info;
> > >
> > >   int xen_drm_front_conn_init(struct xen_drm_front_drm_info *drm_info,
> > >                           struct drm_connector *connector);
>
>
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
