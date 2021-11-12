Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E755C44EFCC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 23:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbhKLW6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 17:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbhKLW6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 17:58:03 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C3FC061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 14:55:12 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id q25so15061832oiw.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 14:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=14vmfAQ42quabFA6Quk5Bt5QbM2BlKN3RxLO3GHhoBE=;
        b=bLxiRmCthb17BYPT3738L9W5unWLvZF2OnGc1K2TH22vAfvajxwu9tkJrBJJFypWmj
         ZKSGqBXbx6Yc//lBGfFP96tOvexhr8BaVlOVDYXSVFFz5ZsQeLqVHeADP+Dv4eRcl9z8
         O0LrlDHx/MJmyyLb1E4C8f14Z3xLVlNqyj/HS9xGFVkWksi0M9i1gXURZqenZqnMYBOp
         Oo7e+fV6F0Sj5miUcNxHW0DBv+bA20mZl379QxADgoSeAC3Q7jCsr0RihKJuHiUgf4LJ
         Q5eKpBC+VZzHGTLCiIu++PE3+hy/C5i/rErUBDvjXRKjD2inqbXXqffJCHBBw4lTsCSO
         C9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=14vmfAQ42quabFA6Quk5Bt5QbM2BlKN3RxLO3GHhoBE=;
        b=znuS55zcRd/8M5wabLi7jhLh+XArtD6HvCUMKCXw90vg+u5EEVu0tctIPIZHpAZg8r
         KOD/ZiF0zLSTOpntuLKx8LQgx8HdfYM1L3FeaGX3nJVPOnWUsRqYaNHoF5KhETUZMtIG
         YJIYEYyRvKM7RtduGNGxGk90elimwn6JcgNBTwTj87LuQortpz1Oj5CXVYc8TOG/u/HP
         UieQ5c0ZU/SEnyGg9jAJJHBhC+r2ddJYpoJ7nnOd3j0MHil6u2JT+oIdI1cSkuj2vhso
         T/hd9Z3uOr1GuN/CuKbUHNpiRJQxmLOSeO3bJHoMKNamGdozV1v0VJLPalUjntkCSa3g
         Fe5g==
X-Gm-Message-State: AOAM530B+bS6BLyUd0sUzkdH6nrHk1b0sf/OYSle1hsD51HZJ/1Q05Vl
        182pvKhjC5bxWun77h81XkpyWsRkhbXl9CqaD0A=
X-Google-Smtp-Source: ABdhPJypOXtXccm6ljMIb6hs2AuHnjL92YyV2/XLtS509BhRrQXvoDIkWy6iJU+rPj+W1nFzyIJNQ42JQ85KTCM3THw=
X-Received: by 2002:aca:3f87:: with SMTP id m129mr29316889oia.5.1636757711431;
 Fri, 12 Nov 2021 14:55:11 -0800 (PST)
MIME-Version: 1.0
References: <1636625005-87952-1-git-send-email-jiapeng.chong@linux.alibaba.com>
 <abc4159c-e903-9265-826e-b44b387a7fcf@amd.com>
In-Reply-To: <abc4159c-e903-9265-826e-b44b387a7fcf@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 12 Nov 2021 17:55:00 -0500
Message-ID: <CADnq5_PEwNL0o=FJdtm2eDeGC07Yd5HK1A8a0Ty1OW3qfBFPEw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Clean up some inconsistent indenting
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        xinhui pan <Xinhui.Pan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Thu, Nov 11, 2021 at 5:09 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
>
>
> Am 11.11.21 um 11:03 schrieb Jiapeng Chong:
> > Eliminate the follow smatch warning:
> >
> > drivers/gpu/drm/amd/amdgpu/../display/dmub/src/dmub_srv.c:622
> > dmub_srv_cmd_execute() warn: inconsistent indenting.
> >
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >   drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/=
gpu/drm/amd/display/dmub/src/dmub_srv.c
> > index 56a0332..e9fadf1 100644
> > --- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
> > +++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
> > @@ -618,8 +618,8 @@ enum dmub_status dmub_srv_cmd_execute(struct dmub_s=
rv *dmub)
> >        * read back stale, fully invalid or partially invalid data.
> >        */
> >       dmub_rb_flush_pending(&dmub->inbox1_rb);
> > +     dmub->hw_funcs.set_inbox1_wptr(dmub, dmub->inbox1_rb.wrpt);
> >
> > -             dmub->hw_funcs.set_inbox1_wptr(dmub, dmub->inbox1_rb.wrpt=
);
> >       return DMUB_STATUS_OK;
> >   }
> >
>
