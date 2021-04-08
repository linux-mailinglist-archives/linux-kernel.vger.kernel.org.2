Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54567358E35
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 22:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbhDHUSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 16:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbhDHUSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 16:18:00 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B16C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 13:17:48 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id w70so3546488oie.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 13:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GbKRYywPq5lTqQsCGdmRs4HbLi4uvVdVMAoIQiw0/YE=;
        b=XbD/RW/FnbtoAPkniakebko66U6G+Qwa0MElUx/bYeB/yI1VMFNzHysYudOelNxJOa
         duODrLQIYnhnQEUHs962NWQSq9pwDCdB8GPzzEXkmPe/IYwQv86bEnHmAlw9OFRVXk5C
         ajb5DnQBC60HsOVrLNORwe07w5oLUB51hPqz4YfZawEJ3wVXFGTE2M91JAVPORAJshuv
         41X24jeo6ZbFRZwjQsZlOIMqhpyAOWZOkk0geVtTOTj5hnOQ1CR155m2ZbwdphPD97nT
         0lZyU1VthhjJ/vShnJBvXrzQUMKUpw28ZgKvhUdo4wuDGQYHEvlHgVzFkFXfBtRoi2eg
         C+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GbKRYywPq5lTqQsCGdmRs4HbLi4uvVdVMAoIQiw0/YE=;
        b=Zf9iHy2+cuuDsXPyRn510idR1SJzXDtz2ahE0UAksKi6zIj8MOxftynQaT7tsay4WP
         VKJG7tWNdMEjEOn0zKHX2Gfke4DtVpFunWIxZ1fBEhsP45hDORCyd2KgDmp9ISnonMZ3
         MEydaF2irqjCy2P7ix6qxOOqdkVdqS+BKej9071fgKbn3l6nVDLNGJBchjJ9Dj2UK238
         FLhTZ7wAk3lJ7NBr0f3fXF1AjkpLvDL+AhALjpE+U31dPR24yRUjugw6RYge75wYozM1
         dJkiGd5Z42cXfar+LJ0nPLdISpj0f7cr5GHwLm2UZ9a20V3DhDb10Nu9Dx2hkTIajyOk
         EuAw==
X-Gm-Message-State: AOAM533U0psViql1GZzVAJpPg3XefVwNBmNu3X785WFUrlWroD6tssGj
        A7WXAAxo9jOdfGm2MspHV1eLs8Ln7wc8NE9nIlc=
X-Google-Smtp-Source: ABdhPJy3iepTkT0luaZ4mGM1ulSQ3NvsRslRZ7CdM0rJ4+5rDwyS0XO+ds+ufIJhqGDT9E04kcyympW6MJzHfe0MiAE=
X-Received: by 2002:aca:4284:: with SMTP id p126mr7497114oia.123.1617913067479;
 Thu, 08 Apr 2021 13:17:47 -0700 (PDT)
MIME-Version: 1.0
References: <1617765004-5308-1-git-send-email-wangyingjie55@126.com>
In-Reply-To: <1617765004-5308-1-git-send-email-wangyingjie55@126.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 8 Apr 2021 16:17:36 -0400
Message-ID: <CADnq5_OujJOLukc74YQwwW4pdCA-M_4Gz_pZg8Je1ep3HZBBMw@mail.gmail.com>
Subject: Re: [PATCH v1] drm/radeon: Fix a missing check bug in radeon_dp_mst_detect()
To:     wangyingjie55@126.com
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Wed, Apr 7, 2021 at 2:23 AM <wangyingjie55@126.com> wrote:
>
> From: Yingjie Wang <wangyingjie55@126.com>
>
> In radeon_dp_mst_detect(), We should check whether or not @connector
> has been unregistered from userspace. If the connector is unregistered,
> we should return disconnected status.
>
> Fixes: 9843ead08f18 ("drm/radeon: add DisplayPort MST support (v2)")
> Signed-off-by: Yingjie Wang <wangyingjie55@126.com>
> ---
>  drivers/gpu/drm/radeon/radeon_dp_mst.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_dp_mst.c b/drivers/gpu/drm/radeon/radeon_dp_mst.c
> index 2c32186c4acd..4e4c937c36c6 100644
> --- a/drivers/gpu/drm/radeon/radeon_dp_mst.c
> +++ b/drivers/gpu/drm/radeon/radeon_dp_mst.c
> @@ -242,6 +242,9 @@ radeon_dp_mst_detect(struct drm_connector *connector,
>                 to_radeon_connector(connector);
>         struct radeon_connector *master = radeon_connector->mst_port;
>
> +       if (drm_connector_is_unregistered(connector))
> +               return connector_status_disconnected;
> +
>         return drm_dp_mst_detect_port(connector, ctx, &master->mst_mgr,
>                                       radeon_connector->port);
>  }
> --
> 2.7.4
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
