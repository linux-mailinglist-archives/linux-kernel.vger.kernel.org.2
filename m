Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D976B3B66E3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 18:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbhF1Qlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 12:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbhF1Qlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 12:41:31 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CC5C061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 09:39:04 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so19410040otl.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 09:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dzETNv4uyDhuYHJGELa+ExcxyxQjGe2pv/stbKqgYMw=;
        b=rBenLrIuJvtaIysQfKhnjr14lj+L8avGymkeyl2Kyk5vGXN2R2ZoQZPHPQ7ExWAk3Y
         yL+pi2ALV/47YsUPRCkvmBi3C0gFZJdvv2BMtGxj/7UGql6F4EcIv+nKxIseax3bagZf
         T74nScYy0afGUWmzWwZSV7ag4jRiYsg0VdYVMAwEhd3YrS+v/RQsVkFSb7or7n5vd6PW
         bFpt+Nq+mZvF/9cSpnkyXoFsxY3ygqAIRXG7Pxmg86DG1XGwOPZA28HHtlrpKmJKz6o5
         +w7oUK0hqy4Wtx72SJnMmruTs8zEKNl3uM80qaAlO7NE2fciTXdroF+fhEXtU7pNukXJ
         0hng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dzETNv4uyDhuYHJGELa+ExcxyxQjGe2pv/stbKqgYMw=;
        b=XTc+LRujRZwjZlydMEY+LBROF8Ne3rmtMMhOUAfP73NFry70RcmU1hlPnW9i0qqxeV
         zvwgX9YGiim8ZBw4IlrbPspBlf+lgGAjT07pqo+Ykv+QM6zvKItB1DHZ7BJfPF1tvlBZ
         7YkSxliuBdlkk3xk3IeETcteSz3njHAjtWxr+KchzPBrE62X6RpErW9N1DtS10BN5fXq
         SbC/DN2COfWtiZPFUTBrDP01pH4hJV3/2xQhtyQJhe9XbSKubGBoM92QucoGXl0rx+Pj
         VHZQmC/i9PBaptQRfsCCMzzo7YJsqdk9NUGkCEpKM/uoaUmWaCaRqFq+MDcauHQMGjze
         8sXQ==
X-Gm-Message-State: AOAM532WMCr+CXBdg9QCHZMN3v9xykhBYpYiPfxAt9pJn0cINphm41eg
        yVPqlPXbz80DuTj0EY+6XxXG7OaCDAASh31bH2A=
X-Google-Smtp-Source: ABdhPJzYRZG+BMW6R3nKjH+PGAeE2fWVuPRA4R5Z/llGtbaSglDGzXmuYL/A81nL+/pjaKCm3iK3ZnT4JtzU94FalS8=
X-Received: by 2002:a05:6830:4119:: with SMTP id w25mr432485ott.132.1624898343968;
 Mon, 28 Jun 2021 09:39:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210623103039.9881-1-msuchanek@suse.de> <6ae69103-b01f-4f16-7cd2-845ea991ae95@amd.com>
In-Reply-To: <6ae69103-b01f-4f16-7cd2-845ea991ae95@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 28 Jun 2021 12:38:53 -0400
Message-ID: <CADnq5_OcurGjMshexjUO58+7n0vxvvyn7wozPnVM-ArGCEovzQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/dc: Really fix DCN3.1 Makefile for PPC64
To:     Harry Wentland <harry.wentland@amd.com>
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Arnd Bergmann <arnd@arndb.de>, Leo Li <sunpeng.li@amd.com>,
        Will Deacon <will@kernel.org>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>, Huang Rui <ray.huang@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Fri, Jun 25, 2021 at 4:14 PM Harry Wentland <harry.wentland@amd.com> wrote:
>
> On 2021-06-23 6:30 a.m., Michal Suchanek wrote:
> > Also copy over the part that makes old gcc handling cross-platform.
> >
> > Fixes: df7a1658f257 ("drm/amdgpu/dc: fix DCN3.1 Makefile for PPC64")
> > Fixes: 926d6972efb6 ("drm/amd/display: Add DCN3.1 blocks to the DC Makefile")
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> > The fact that the old gcc handling triggers on gcc 10 and 11 is another
> > story I don't want to delve into.
> > ---
> >  drivers/gpu/drm/amd/display/dc/dcn31/Makefile | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/Makefile b/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
> > index 5dcdc5a858fe..4bab97acb155 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
> > @@ -28,6 +28,7 @@ endif
> >  CFLAGS_$(AMDDALPATH)/dc/dcn31/dcn31_resource.o += -mhard-float
> >  endif
> >
> > +ifdef CONFIG_X86
> >  ifdef IS_OLD_GCC
> >  # Stack alignment mismatch, proceed with caution.
> >  # GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
> > @@ -36,6 +37,7 @@ CFLAGS_$(AMDDALPATH)/dc/dcn31/dcn31_resource.o += -mpreferred-stack-boundary=4
> >  else
> >  CFLAGS_$(AMDDALPATH)/dc/dcn31/dcn31_resource.o += -msse2
> >  endif
> > +endif
> >
> >  AMD_DAL_DCN31 = $(addprefix $(AMDDALPATH)/dc/dcn31/,$(DCN31))
> >
> >
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
