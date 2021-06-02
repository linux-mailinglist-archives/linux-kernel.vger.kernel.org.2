Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8083991D2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 19:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbhFBRkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 13:40:40 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:35836 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhFBRki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 13:40:38 -0400
Received: by mail-wr1-f51.google.com with SMTP id m18so3140637wrv.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 10:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+yaTa+zDqmDiAibU5zoH8Z7YnQKRwY03Jyu/LIqtjEI=;
        b=NweQXUximI5ePuS0XoWrWeT2EWTWo74GFJr3gtWpYr4cBa/glGPCN1MFlztMmepXSt
         Vd+fbZUDe+a5tB+iB/Wbapbm2KVoW96cmcBe8F2P0kkPLtsDvIfcmdGfmbO7fJzG0Zk7
         QOp0ET0vMmsIhYhJXvLtUv1MsbC5taoVQH0DQSDnPGXzEZfKkR6aT94XYk0vILzdgB7Y
         q2SIEJmDPMsjAC2BXzw3yhqibiLA3x+sDITaR01MOpDdMA8usM26KGz0DbZQtDnJDFTV
         4PhF3is4/MZo9nsFotUgEtsFiBRan+5V8KpuZL2r7CB9s38/kYvyhEd2xo5DwkArz5Ua
         cbpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+yaTa+zDqmDiAibU5zoH8Z7YnQKRwY03Jyu/LIqtjEI=;
        b=GF0E8efC7+lx+rzu2h9HN6IXGIjneTVcc+pEyPeldL/ryFfRq/zBk8v4V0wtxBhI1D
         aXrn0zJnY2pfw1NCB3dR7eaqFoAnUMyRVx+RQ7/tsYUHrllZfjcPatVZFexXUjRxCSg2
         CQE9Lc9boUgPoZ4FdHoD9YZ7J2chDohxGX4FVAKyCsTvuXY2VZHTtosR2dymdnGoRcRJ
         8uZLwVuDnDV9zJ4ASoE0XjBzZUzCNE9x41N45LMS0X9WxHZlkFv8sdp7Lgp/IzbjinjZ
         HRda0auJww3TOR4lGI8jdMPbvWd0E4Tdvvjid/S2qyXP0XQa2XmwMxuHkHCKjBwMVNvE
         utCQ==
X-Gm-Message-State: AOAM533+zrRIwt9u8s4W1AqsvV1KUSQlc6sHAK+/oBD2QzR+5o9NujHP
        AJLcVhBZB0/Vr4zmm/gY53OpFg==
X-Google-Smtp-Source: ABdhPJweKZb3mxKzWSBDkCYDSjNL1O4y6OXQiFdyWx0qycUJBjK5T89gdX9sOaxWit8bK7NhrooxDQ==
X-Received: by 2002:a05:6000:186a:: with SMTP id d10mr35384063wri.41.1622655474277;
        Wed, 02 Jun 2021 10:37:54 -0700 (PDT)
Received: from dell ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id i34sm788478wri.3.2021.06.02.10.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 10:37:53 -0700 (PDT)
Date:   Wed, 2 Jun 2021 18:37:52 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Leo Li <sunpeng.li@amd.com>, Mauro Rossi <issor.oruam@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [RESEND 16/26] drm/amd/display/dc/dce/dce_transform: Remove
 superfluous re-initialisation of DCFE_MEM_LIGHT_SLEEP_CNTL,
Message-ID: <20210602173752.GK2173308@dell>
References: <20210602143300.2330146-1-lee.jones@linaro.org>
 <20210602143300.2330146-17-lee.jones@linaro.org>
 <CADnq5_MHcth1p_00d=0ey+kg8o=_ZQk4t-RcU7zx3fb+35uy+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_MHcth1p_00d=0ey+kg8o=_ZQk4t-RcU7zx3fb+35uy+g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Jun 2021, Alex Deucher wrote:

> On Wed, Jun 2, 2021 at 10:33 AM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > Fixes the following W=1 kernel build warning(s):
> >
> >  drivers/gpu/drm/amd/amdgpu/../display/modules/hdcp/hdcp_psp.c:374:22: warning: no previous prototype for ‘mod_hdcp_hdcp1_get_link_encryption_status’
> >  In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:28:
> >  drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_6_0_d.h:568:43: warning: initialized field overwritten [-Woverride-init]
> >  drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:157:14: note: in expansion of macro ‘mmCRTC0_DCFE_MEM_LIGHT_SLEEP_CNTL’
> >  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_transform.h:170:2: note: in expansion of macro ‘SRI’
> >  drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:183:3: note: in expansion of macro ‘XFM_COMMON_REG_LIST_DCE60’
> >  drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:187:3: note: in expansion of macro ‘transform_regs’
> >  drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_6_0_d.h:568:43: note: (near initialization for ‘xfm_regs[0].DCFE_MEM_LIGHT_SLEEP_CNTL’)
> >  drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:157:14: note: in expansion of macro ‘mmCRTC0_DCFE_MEM_LIGHT_SLEEP_CNTL’
> >  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_transform.h:170:2: note: in expansion of macro ‘SRI’
> >  drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:183:3: note: in expansion of macro ‘XFM_COMMON_REG_LIST_DCE60’
> >  drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:187:3: note: in expansion of macro ‘transform_regs’
> >  drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_6_0_d.h:645:43: warning: initialized field overwritten [-Woverride-init]
> >
> > Cc: Harry Wentland <harry.wentland@amd.com>
> > Cc: Leo Li <sunpeng.li@amd.com>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: "Christian König" <christian.koenig@amd.com>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Mauro Rossi <issor.oruam@gmail.com>
> > Cc: amd-gfx@lists.freedesktop.org
> > Cc: dri-devel@lists.freedesktop.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/gpu/drm/amd/display/dc/dce/dce_transform.h | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.h b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.h
> > index cbce194ec7b82..e98b5d4141739 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.h
> > +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.h
> > @@ -166,8 +166,7 @@
> >         SRI(SCL_F_SHARP_CONTROL, SCL, id)
> >
> >  #define XFM_COMMON_REG_LIST_DCE60(id) \
> > -       XFM_COMMON_REG_LIST_DCE60_BASE(id), \
> > -       SRI(DCFE_MEM_LIGHT_SLEEP_CNTL, CRTC, id)
> > +       XFM_COMMON_REG_LIST_DCE60_BASE(id)
> 
> I believe DCFE_MEM_LIGHT_SLEEP_CNTL should be kept here and it should
> be removed from
> XFM_COMMON_REG_LIST_DCE60_BASE() to align with other asics.

Ack.  Sorry for missing this.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
