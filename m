Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA819397D99
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 02:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235476AbhFBAMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 20:12:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43561 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235491AbhFBAMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 20:12:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622592633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g6XERwupFZipcAmg6D1I1zxjEbLYz5zppsdgraxGF7Q=;
        b=gHzuf6Hw2lU19oYQ5/H0pQmCLiFaNJ4IdTE86ya3ezqiXE8RewfmzAnbwtIlLzGb3tjtL/
        hx0Wk6x7e/8aoy7irkgxFDmtdO3uxpB1+t66PaHXhMNfGLOxTx5POCN0aXOBhd/JMsWtv+
        PcUp2PriRFBW24O5t+X7zh1PCx+Weg8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-UFLtpwN_MTmP5N7pCWkR3w-1; Tue, 01 Jun 2021 20:10:31 -0400
X-MC-Unique: UFLtpwN_MTmP5N7pCWkR3w-1
Received: by mail-wm1-f70.google.com with SMTP id r15-20020a05600c35cfb029017cc4b1e9faso1506967wmq.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 17:10:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g6XERwupFZipcAmg6D1I1zxjEbLYz5zppsdgraxGF7Q=;
        b=nwlgrrDROLDcX/ktoD6PbHDi01R7FFQDC5AZjoNN+4kkFv9NbC+YIB9SJHrhmCpair
         dn8OibDqGF83rUNy2x0TU4mAF+U8swEVcpGhrGUgTaNSP1rRb1dn9KjAVvBvBXfrHkbi
         BlCBCtFuNQs1xjd6vRBsUdndpwHbs54ZQJWBzZe4Du+5vJZhmwEiuviPKS/0uBDvg7kE
         MTqh5SsmAJY8KnMpZeF0DVy85Pehzxl8JvGIlqsiYL13WHh5nhXWjNlfea7mXPW8L3aw
         Guo709waqW6cLiqQkk8Ikc1lp/zHHAmXuHU/jqtWLx+UZ9qzJ9DHnQqx0y/nd5oGvc/8
         9m2Q==
X-Gm-Message-State: AOAM532do1dXrGncipdKf7pzgT0muBp8rb5af4wUynt/wrN+mVVFsYWU
        FAD82zYpyEj/Dq7sHe+/0le3lzOmKLyOjlsAiKvWyA8gda88w5tYHwdSJvM1I+3VGrf2f8YEDds
        /3XgyM4l1JmE23mlb3bYTqhW/18vsAyA4irPvzshM
X-Received: by 2002:adf:dcc3:: with SMTP id x3mr8763243wrm.177.1622592629521;
        Tue, 01 Jun 2021 17:10:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+7ytifh8Tq7X7nnucf7aYm2Vw3csWvxa0+c2QJbbdpuaVNF93Pvls4Lv1rmxm1PeJU5y+Ay/NirV8hdJrDSY=
X-Received: by 2002:adf:dcc3:: with SMTP id x3mr8763219wrm.177.1622592629297;
 Tue, 01 Jun 2021 17:10:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210305095657.GA142006@embeddedor> <79ff569a-5828-ef21-538b-12d07d34a4ff@embeddedor.com>
 <1ec627af-514e-b24a-da88-13eb561ccb15@embeddedor.com>
In-Reply-To: <1ec627af-514e-b24a-da88-13eb561ccb15@embeddedor.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Wed, 2 Jun 2021 02:10:18 +0200
Message-ID: <CACO55tv3o72GwG8ORcUYQ-nXFDi1Qo0uKG5T_4iVmuhdDxPdqg@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH RESEND][next] drm/nouveau: Fix fall-through
 warnings for Clang
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kees Cook <keescook@chromium.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

all three nouveau patches are

Reviewed-by: Karol Herbst <kherbst@redhat.com>

and I don't think anybody would mind if those get into through other
trees, but maybe drm-mist would be a good place for it if other
patches involve other drm drivers?

On Wed, Jun 2, 2021 at 1:16 AM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> Hi,
>
> Friendly second ping: who can take this?
>
> I can add this to my -next branch for 5.14 if you don't mind.
>
> JFYI: We had thousands of these sorts of warnings and now we are down
> to just 23 in linux-next. This is one of those last remaining warnings.
>
> Thanks
> --
> Gustavo
>
> On 4/20/21 15:13, Gustavo A. R. Silva wrote:
> > Hi all,
> >
> > Friendly ping: who can take this, please?
> >
> > Thanks
> > --
> > Gustavo
> >
> > On 3/5/21 03:56, Gustavo A. R. Silva wrote:
> >> In preparation to enable -Wimplicit-fallthrough for Clang, fix a couple
> >> of warnings by explicitly adding a couple of break statements instead
> >> of letting the code fall through to the next case.
> >>
> >> Link: https://github.com/KSPP/linux/issues/115
> >> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> >> ---
> >>  drivers/gpu/drm/nouveau/nouveau_bo.c        | 1 +
> >>  drivers/gpu/drm/nouveau/nouveau_connector.c | 1 +
> >>  2 files changed, 2 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
> >> index 2375711877cf..62903c3b368d 100644
> >> --- a/drivers/gpu/drm/nouveau/nouveau_bo.c
> >> +++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
> >> @@ -443,6 +443,7 @@ nouveau_bo_pin(struct nouveau_bo *nvbo, uint32_t domain, bool contig)
> >>                      break;
> >>              case TTM_PL_TT:
> >>                      error |= !(domain & NOUVEAU_GEM_DOMAIN_GART);
> >> +                    break;
> >>              default:
> >>                      break;
> >>              }
> >> diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
> >> index 61e6d7412505..eb844cdcaec2 100644
> >> --- a/drivers/gpu/drm/nouveau/nouveau_connector.c
> >> +++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
> >> @@ -157,6 +157,7 @@ nouveau_conn_atomic_set_property(struct drm_connector *connector,
> >>                      default:
> >>                              break;
> >>                      }
> >> +                    break;
> >>              case DRM_MODE_SCALE_FULLSCREEN:
> >>              case DRM_MODE_SCALE_CENTER:
> >>              case DRM_MODE_SCALE_ASPECT:
> >>
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau
>

