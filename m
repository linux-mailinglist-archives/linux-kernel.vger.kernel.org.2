Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 375F141F12F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 17:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbhJAP2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 11:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbhJAP2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 11:28:39 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBD3C061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 08:26:54 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id x33-20020a9d37a4000000b0054733a85462so11916600otb.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 08:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ikLIfxYdFe+715vkjTYz2QcZQLPsMyfcRuwJRI4JmM4=;
        b=aZ/I4ufvq/NcoW7ML0ypAcwIA1MGyGR0HEqX5iuKNwExlTwu2IdQCNEkeR+zDkSOQz
         BAc+EEnp7lAlKvHdtFQCj/mLjXeGrYwA4ndXkbPsLUqUY410G/t45C3sR7pIGtIkMsQs
         Ma5bgpnAhxOOeMyYg5vftvNNDucX4xwgZBPa+kXETSTpSIisgzdGN9H2iTNJcIJvJ+Kj
         FicGrs2uIxcQzo2iovBMYf/oj78u/OcstbeaKMrkcAADkMF36PUFiHlI90AxFnS8TKMQ
         HGcrDjJnSGGtKZSWGc6sv654TEvAiyhcv+/8cA/JRCOJ5hce5nryAKhtgtg4ehHya/h4
         4nLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ikLIfxYdFe+715vkjTYz2QcZQLPsMyfcRuwJRI4JmM4=;
        b=Miu+6YsQS8UNGEiBswuakw+xiaWh2LulSA3uahwrvKGDEUAZcIgyKUsKOVgnXQwyIr
         AjfWu9XW5dUmERbL23L43dQzcOilNiszrcjzx5MbnwoPCpPpjnLf0hJQYH1GMHc1xOkq
         SSHEtdT9TOmZewj7WwVC6/uQ6f6jMQHxESoXzwssYrRmn9hENL+hfhq0IGqsCL9E+b48
         mPW1PZ6LIAzA6bUDIWGBmmGxDV0S9W/K4fRQzaxKcrW3BMi+9V7t+Ysm/r0ZSXqtDvAY
         f8TjPiiqboSIWQv6yI8ZI3QlX7oYB3s15pvcBgj90CPHqYt5FUZcYJ66WmEk1p2ttNn7
         8VlQ==
X-Gm-Message-State: AOAM5328lorNyqu9WkKAo4ZC8QeZZH/VIB+jvDw99554HJ3lHo1nh1iv
        2CNxTIg7hodoaiWi6kfZD+9GkHuLiWu85qAjHGM=
X-Google-Smtp-Source: ABdhPJxcNNo5JhH3EXbxL8nFCg9PFIAUpeD8fKVx+GFOx30gzwQaBibHmrxqi/VpT6SjMbNmJIvI3Q6p8469AxlsPnY=
X-Received: by 2002:a05:6830:214c:: with SMTP id r12mr10800848otd.200.1633102013972;
 Fri, 01 Oct 2021 08:26:53 -0700 (PDT)
MIME-Version: 1.0
References: <20211001101348.1279-1-guozhengkui@vivo.com> <50430f11-5e95-18f4-7620-2233ef573853@amd.com>
In-Reply-To: <50430f11-5e95-18f4-7620-2233ef573853@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 1 Oct 2021 11:26:42 -0400
Message-ID: <CADnq5_PT+e8j=YEyAjzMQxF5wVzc+cCDbQ6j6FrdWdDWajco=Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: remove some repeated includings
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Guo Zhengkui <guozhengkui@vivo.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Guchun Chen <guchun.chen@amd.com>,
        Peng Ju Zhou <PengJu.Zhou@amd.com>,
        Bokun Zhang <Bokun.Zhang@amd.com>,
        Likun GAO <Likun.Gao@amd.com>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>, kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Fri, Oct 1, 2021 at 6:16 AM Christian K=C3=B6nig <christian.koenig@amd.c=
om> wrote:
>
> Am 01.10.21 um 12:13 schrieb Guo Zhengkui:
> > Remove two repeated includings in line 46 and 47.
> >
> > Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 --
> >   1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_discovery.c
> > index 291a47f7992a..daa798c5b882 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > @@ -30,34 +30,32 @@
> >
> >   #include "soc15.h"
> >   #include "gfx_v9_0.h"
> >   #include "gmc_v9_0.h"
> >   #include "df_v1_7.h"
> >   #include "df_v3_6.h"
> >   #include "nbio_v6_1.h"
> >   #include "nbio_v7_0.h"
> >   #include "nbio_v7_4.h"
> >   #include "hdp_v4_0.h"
> >   #include "vega10_ih.h"
> >   #include "vega20_ih.h"
> >   #include "sdma_v4_0.h"
> >   #include "uvd_v7_0.h"
> >   #include "vce_v4_0.h"
> >   #include "vcn_v1_0.h"
> > -#include "vcn_v2_0.h"
> > -#include "jpeg_v2_0.h"
> >   #include "vcn_v2_5.h"
> >   #include "jpeg_v2_5.h"
> >   #include "smuio_v9_0.h"
> >   #include "gmc_v10_0.h"
> >   #include "gfxhub_v2_0.h"
> >   #include "mmhub_v2_0.h"
> >   #include "nbio_v2_3.h"
> >   #include "nbio_v7_2.h"
> >   #include "hdp_v5_0.h"
> >   #include "nv.h"
> >   #include "navi10_ih.h"
> >   #include "gfx_v10_0.h"
> >   #include "sdma_v5_0.h"
> >   #include "sdma_v5_2.h"
> >   #include "vcn_v2_0.h"
> >   #include "jpeg_v2_0.h"
>
