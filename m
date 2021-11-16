Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4A9F452A58
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 07:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbhKPGJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 01:09:25 -0500
Received: from mx.ucr.edu ([138.23.62.3]:15863 "EHLO mx2.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233013AbhKPGIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 01:08:45 -0500
X-Greylist: delayed 433 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Nov 2021 01:08:45 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1637042749; x=1668578749;
  h=mime-version:references:in-reply-to:from:date:message-id:
   subject:to:cc;
  bh=Z3Zujelhp95n7JiGO15pEnuj1r6cZj7PyaJcCYcZCrc=;
  b=qgtJUu64HHqX+p+wJlTAs52hE3dubPYm2H+k38o4Kwmkf5EXhkWW84u5
   GOMU5vtvCS2an9fX0iCe939sc4RoMjP3K//UmfabObuTevM/rifmLjmXo
   YaS6NxahvY534BorDx+PwEZt/+Vx//XzjagS6qCMfJ2tFCkBWqoAOFI8Q
   +6+Tk9RTV6zDBjlrxHqIgtkVCBYm9UgML6tJNhV5NuIRX5rj3Sn0YDDAD
   ynFlWOqGcCZDQMWpBf75MldH5oGEditQA6SivPvoOdFtfw9/RUIH35i45
   YmMX+K2MAw2Op8y8tQ7uDiDDwjaczlo+uKqIbYJ4lNtVTmRHmuTcxc5QI
   Q==;
IronPort-SDR: HuwAcAP7lXACTPwrr/NYstLazMwBl2QRMFdJYctvxWvMIKByoLbRhoIYflBcKGAUb0i6B44co8
 f1gmtHvf4DyMkGzeWpWgyD7Nq1t2vy7pIcwJ6Fw+Ydi+LaeTVR2LMfzDqmyM5Wn6LghQpSUm4K
 QeyTysyrbR/+fNlUHHoCxIeGJAVjAXQLuCMAnz0AkgtcgyZ9mck1EgeXHCIqzUkU+PhemdbY5k
 kWBakszRUoux0/lOR8jOaC1Nqb/eMTcBbtWE1/BR3JMeWYk/iLxL0wcFr9nA89yR2sfpTet+sf
 IdmMQEOxDb9YcMPnv8jESaJI
X-IronPort-AV: E=Sophos;i="5.87,238,1631602800"; 
   d="scan'208";a="197337857"
Received: from mail-yb1-f197.google.com ([209.85.219.197])
  by smtp2.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Nov 2021 21:58:30 -0800
Received: by mail-yb1-f197.google.com with SMTP id d27-20020a25addb000000b005c2355d9052so30374938ybe.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 21:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8/XhVolQXCHPmPCzdRzFWhpIuM6H2Dzx9QQPO3TDOnQ=;
        b=f867r1i2Ostx6BltPr4Oc+FLyknNCfRZZ8l/kHRJB8wnAdh1Z+85jOUgfhVaqYWG43
         PnHHT6jy+L7VBZdHouMBNsvuWuuto8figPchs2mldQ8qtJC5qaOraraScvZVlbxxkf4L
         SkpkgUNLz56wCGs3dil3hUuNC1TeoZwqBwW/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8/XhVolQXCHPmPCzdRzFWhpIuM6H2Dzx9QQPO3TDOnQ=;
        b=qbYXnO6EB8QHvBAR8Br9/WuEeVSdmj689pxzjNohpnmf1OAZ8Nc5Mwg9rGRDe3FavK
         Rb+3fo/ULt7I78dRMNySgGzcofQerRmu0tBq2ua/YB96u7yLf6dmmDYBNyNj1H1NC17O
         SpBb0LvZu3n5xEIsvLbbK8AE7uJXGc/EC1peNCQuvDfhCuKZPJmpJ2E/GwbBlB0ezl4x
         HIM/jxgCjWSdOfs8XDfBzYlSeRNokzW0uvRGDZIw3m+vH4oJ5LyWHUewwgHVBuqireAH
         /3pJtUuozIXSnHzILyr28S1E0k3L+8OCI3wzIduNLlIQvAI5lCPMnjGijfyLxfiWJFbq
         6u7g==
X-Gm-Message-State: AOAM5302cerDu3KhdFBp7eBgTImjIAPd4XNxBaYOX0fZbTnPYZaSEKfJ
        PCkotOMZN8n0BbEMDusW33mZmwag5q0BGyuzu9m64pc9jPCMhv8RziWbMvo8X/RpZRLosk3Ynzi
        emOUprSPw4jJDA1dmMIB5mk6Wu/EUYlZXkyvt+Nruig==
X-Received: by 2002:a25:d103:: with SMTP id i3mr5547179ybg.260.1637042310110;
        Mon, 15 Nov 2021 21:58:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxwUr/rkQjN0wPIocSPR9Ha22HtX3sCwe21HdQmlEhLyrgEeqa6u/wE7tEwiSL8OX/t6aAWemYEafgo1TEtMxs=
X-Received: by 2002:a25:d103:: with SMTP id i3mr5547162ybg.260.1637042309942;
 Mon, 15 Nov 2021 21:58:29 -0800 (PST)
MIME-Version: 1.0
References: <CABvMjLTVZaU8vMW__2BDo6FnjFa_bsh2S-kEmg=KV4KTsFiUzA@mail.gmail.com>
 <CACO55tuDQ9UC2rr=_Hsowvujk49oNK1zWfHj3jMnhEqsTAnh0Q@mail.gmail.com>
In-Reply-To: <CACO55tuDQ9UC2rr=_Hsowvujk49oNK1zWfHj3jMnhEqsTAnh0Q@mail.gmail.com>
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Mon, 15 Nov 2021 21:58:19 -0800
Message-ID: <CABvMjLSFLpG4=+tE3Sr2wfRsEuKLXMm++Xx+JNmA8YXptgzkmw@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/core: fix the uninitialized use in nvkm_ioctl_map()
To:     Karol Herbst <kherbst@redhat.com>
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Karol:
Thanks for the feedback, the patch might be too old to apply to the
latest code tree. Let me check and get back to you soon.

On Sat, Nov 13, 2021 at 12:22 PM Karol Herbst <kherbst@redhat.com> wrote:
>
> something seems to have messed with the patch so it doesn't apply correctly.
>
> On Thu, Jun 17, 2021 at 9:39 AM Yizhuo Zhai <yzhai003@ucr.edu> wrote:
> >
> > In function nvkm_ioctl_map(), the variable "type" could be
> > uninitialized if "nvkm_object_map()" returns error code,
> > however, it does not check the return value and directly
> > use the "type" in the if statement, which is potentially
> > unsafe.
> >
> > Signed-off-by: Yizhuo <yzhai003@ucr.edu>
> > ---
> >  drivers/gpu/drm/nouveau/nvkm/core/ioctl.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/core/ioctl.c
> > b/drivers/gpu/drm/nouveau/nvkm/core/ioctl.c
> > index d777df5a64e6..7f2e8482f167 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/core/ioctl.c
> > +++ b/drivers/gpu/drm/nouveau/nvkm/core/ioctl.c
> > @@ -266,6 +266,8 @@ nvkm_ioctl_map(struct nvkm_client *client,
> >                 ret = nvkm_object_map(object, data, size, &type,
> >                                       &args->v0.handle,
> >                                       &args->v0.length);
> > +               if (ret)
> > +                       return ret;
> >                 if (type == NVKM_OBJECT_MAP_IO)
> >                         args->v0.type = NVIF_IOCTL_MAP_V0_IO;
> >                 else
> > --
> > 2.17.1
> >
>


-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
