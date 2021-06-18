Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC3953AD3A5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 22:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbhFRUfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 16:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhFRUfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 16:35:47 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3604BC061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 13:33:37 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 7-20020a9d0d070000b0290439abcef697so10950729oti.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 13:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0lqhtlNOacqNuU9HVlYS2QY7iZE+rcKx/NRXadqAqMk=;
        b=AuSfHwDEDhrhZndV8N8LFsf/T1gLt0SL4Kr2SNUF3Pc/mezMmFtpzDBDHqrAsZUjOm
         IRy03UanKoPueyLJxxyoLwi+7yWLwc1lE2fQ43tMiNmxgh+UQyYW3eDQZEGvBUoTnFoj
         +W3JlBI2s3t6P+TdabfSmM9EOHIXcrktMpAx6Z8ZPVkBgpCN4pW/H43hJYBKtTXrXlNc
         cU0YcDuTzY89LB2/chwHDZe20OZ1MOmyeksmzE80G7z+nWE7K/jmpMIHeolUcG+xslRh
         OdMkZqqVcKl668REH5zuplzsz+5hxYSztvpMIQWLSN9pjFs59J2hBmTmeE+tjuO2FgUP
         0GAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0lqhtlNOacqNuU9HVlYS2QY7iZE+rcKx/NRXadqAqMk=;
        b=qoNvwWjtNndDZkvEttuweAXNZu1tWnTB8WSiHkruNmLhdrNvF7cSTVLfAzNJDR2slv
         oJQvJ4UV1mcw6YKzZCkKKYStIfUmYvDwbXyRpGWuxOr7QlMdvmxRBjkX2pJ9ZwCmTF76
         uNRT4ialEAjfLmRnn+5UGWMXEjJMH2n17fHZSLo5T9DCvyKPxjWRvuPwQFAG2bYVaxQa
         Mah8e78xabPDPvkSImmPQC4TSaRYq6omUSCe+SVzGjgIMzBhuqja0nthrZlUPtITZ79m
         JGE+X5i+3swR/q3QD1FDWDeMu6trUOorYscL4BE5lCh4hsKtFXW48JgNeertFgQTdliv
         xtNw==
X-Gm-Message-State: AOAM533WJg/sW7tQC+FwAePrJfDjwVvZ/weOPUe2cj5ATkn7AV/vXPuy
        DdEegwvsZJ0QFSQCUEEdQWpfHSztTeqGpqs9jq4=
X-Google-Smtp-Source: ABdhPJyjQScV8NzchfGaMSY3StM8W4pyefE41t+e7LgjnMwAVnpBNSxJU4R9UsEIdEPTSE9noHheT+zInrDw6nypnQE=
X-Received: by 2002:a05:6830:33ef:: with SMTP id i15mr11028481otu.311.1624048416499;
 Fri, 18 Jun 2021 13:33:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210617023109.204591-1-pulehui@huawei.com> <fa86062f-cb45-245b-1bf0-494ffcd33908@amd.com>
In-Reply-To: <fa86062f-cb45-245b-1bf0-494ffcd33908@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 18 Jun 2021 16:33:25 -0400
Message-ID: <CADnq5_OOQqWf9yTcSwN=U8+1VbyfD-f_RfhQ+Gura_BJkspZmg@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/display: Fix gcc unused variable warning
To:     Harry Wentland <harry.wentland@amd.com>
Cc:     Pu Lehui <pulehui@huawei.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Jun Lei <Jun.Lei@amd.com>,
        Wenjing Liu <wenjing.liu@amd.com>,
        Anson Jacob <Anson.Jacob@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Wesley Chalmers <Wesley.Chalmers@amd.com>,
        Jimmy.Kizito@amd.com, "Cyr, Aric" <aric.cyr@amd.com>,
        Martin Tsai <martin.tsai@amd.com>,
        jinlong zhang <jinlong.zhang@amd.com>, zhangjinhao2@huawei.com,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Thu, Jun 17, 2021 at 2:43 PM Harry Wentland <harry.wentland@amd.com> wro=
te:
>
> On 2021-06-16 10:31 p.m., Pu Lehui wrote:
> > GCC reports the following warning with W=3D1:
> >
> > drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c:3635:17:
> > warning:
> >  variable =E2=80=98status=E2=80=99 set but not used [-Wunused-but-set-v=
ariable]
> >   3635 |  enum dc_status status =3D DC_ERROR_UNEXPECTED;
> >        |                 ^~~~~~
> >
> > The variable should be used for error check, let's fix it.
> >
> > Signed-off-by: Pu Lehui <pulehui@huawei.com>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> >  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers=
/gpu/drm/amd/display/dc/core/dc_link_dp.c
> > index fcb635c85330..cf29265870c8 100644
> > --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> > +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> > @@ -3681,6 +3681,10 @@ bool dp_retrieve_lttpr_cap(struct dc_link *link)
> >                               DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STR=
UCTURE_REV,
> >                               lttpr_dpcd_data,
> >                               sizeof(lttpr_dpcd_data));
> > +             if (status !=3D DC_OK) {
> > +                     dm_error("%s: Read LTTPR caps data failed.\n", __=
func__);
> > +                     return false;
> > +             }
> >
> >               link->dpcd_caps.lttpr_caps.revision.raw =3D
> >                               lttpr_dpcd_data[DP_LT_TUNABLE_PHY_REPEATE=
R_FIELD_DATA_STRUCTURE_REV -
> >
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
