Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC2F3A1EB9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 23:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhFIVRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 17:17:33 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:40653 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhFIVRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 17:17:33 -0400
Received: by mail-ot1-f41.google.com with SMTP id l15-20020a05683016cfb02903fca0eacd15so1478467otr.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 14:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ufi2FMAuPcpe+FPh/mofpHrmjo2M1TXQM9bY6dxEWt0=;
        b=kxU84jqqRnfGbMPVambFLhN+Wu6tjIjs7VxY9gOo+ZYD77GblJypR21ipnLcWaV5jn
         hQisiL8uu5yGlo6wlvOy0q1ygVEshCpUx710mZsulABXsidQzxP4W2h5yvvxulZKPoAW
         8XXW9j2z3wt3A0S2Z5AB+Gn6tHC9Q/e9qsp7y/zfYwj69dZx/wf2ZsDwpVFUd1uc5kkQ
         qJW8d1fJjr46gDAYAqIjeNK+Y5aXYpthffUJ3Vjoe5wf8jQJXlkElJh8Wlfol6bh4TmZ
         NMwyx+HP/UH+Kc1JETq/f09an6gA9USNzujPs5vQFi9XLQSjbwTeJ0vxQRvRVb4UFmeh
         kgDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ufi2FMAuPcpe+FPh/mofpHrmjo2M1TXQM9bY6dxEWt0=;
        b=f0ofW6j/JHsP7bIV4I8tqgl3sOQ9+6aotqE6xNMSu9A4z9F8VJiSZ47WEw/1G4ucz5
         jz1Z2pm1s3RewpSJrn+HVVUsTGEMslwk1fdJtEISay5V+At+DwKyLbViVZ0LM1Tcu7mD
         DgK4SMu8Ypb+5G1i6TtII7QMhlKFkVD8agvUTAJTxvgJj/wjhptq3AY6/I1sbxn+iHcP
         gW7XliZJ4hi3I3JmL+BICSMDURzhqgo0fwUDEAkVBH2kbDBt/gKJ8ObLmhzJZDgedwFL
         LjYhM//zbAVAPlY3jNuX+YLuB/vI++SQMpsGGb/EYy6xKvjwM6R5eNpoRqmFu3JygfzZ
         cZvw==
X-Gm-Message-State: AOAM530gD/YN4w+EzV9INIhWfyxO1NfMiRefpSmjlW8PU3svT7fvpJ5I
        qtL/njCJlLsScIwGXlk3z5ccy3vkzaLyHA5ZjYM=
X-Google-Smtp-Source: ABdhPJyJHvOi2PyHn0NN80TysiKqaKIq2lyM4e6v/SOEeznvp5dZTp1sgTC5Lb96c1uf5k4v9trihlsAS9LMSW5+lds=
X-Received: by 2002:a9d:6548:: with SMTP id q8mr1155557otl.311.1623273261909;
 Wed, 09 Jun 2021 14:14:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210608030126.23206-1-wanjiabing@vivo.com> <20210609184326.wuyxpphkx3cor2je@outlook.office365.com>
In-Reply-To: <20210609184326.wuyxpphkx3cor2je@outlook.office365.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 9 Jun 2021 17:14:10 -0400
Message-ID: <CADnq5_Mri2JVWNKgKrk+M7n7+WctiE_e4UWOjkgDZLtpC+1LuQ@mail.gmail.com>
Subject: Re: [PATCH] drm: display: Remove duplicate include in dce110
To:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc:     Wan Jiabing <wanjiabing@vivo.com>,
        Ashley Thomas <Ashley.Thomas2@amd.com>,
        Jake Wang <haonan.wang2@amd.com>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Jun Lei <jun.lei@amd.com>,
        Lee Jones <lee.jones@linaro.org>, Hugo Hu <hugo.hu@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Yao Wang1 <Yao.Wang1@amd.com>,
        Michael Strauss <michael.strauss@amd.com>,
        Alvin Lee <alvin.lee2@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>, Tony Cheng <Tony.Cheng@amd.com>,
        Chris Park <Chris.Park@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Wed, Jun 9, 2021 at 2:43 PM Rodrigo Siqueira
<Rodrigo.Siqueira@amd.com> wrote:
>
> On 06/08, Wan Jiabing wrote:
> > Fix the following checkincludes.pl warning:
> > ./drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> > 35      #include "dce110_hw_sequencer.h"
> >     69  #include "dce110_hw_sequencer.h"
> >
> >
> > Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> > ---
> >  drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> > index a08cd52f6ba8..e20d4def3eb9 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> > @@ -66,7 +66,6 @@
> >
> >  #include "atomfirmware.h"
> >
> > -#include "dce110_hw_sequencer.h"
> >  #include "dcn10/dcn10_hw_sequencer.h"
> >
> >  #define GAMMA_HW_POINTS_NUM 256
> > --
> > 2.20.1
> >
>
> lgtm,
>
> Thanks
>
> Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>
> --
> Rodrigo Siqueira
> https://siqueira.tech
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
