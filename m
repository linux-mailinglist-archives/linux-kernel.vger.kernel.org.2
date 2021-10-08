Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 926AF426CC8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 16:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbhJHOcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 10:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242175AbhJHOc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 10:32:29 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11228C061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 07:30:34 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id n64so14053504oih.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 07:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RZe90QXqDSFc/e+9Obt5XingpU4tenpe4hJC8C/MZXE=;
        b=XIEe7TAd8yXZAI+Z+DNdd1G3duNavJKSO56H2nfVZ/hXRzvhY6u0Dm4RdUhV0Y2WOz
         b0Fiq752el8Cu2mbWT57S9+VRwimBSdLfFbzpwyHlxG3hj6NpLnQVj3lZMBJuvhplPIN
         c3FHtGnuJdIYxy2oL+MQcdFD7ljOqXSFUGDs3eYRwIIFI9dzC9hIMU51tDtqzw0mXfP/
         WrNOPd8mAPvfIRd60Moxi57KkbRfFiqpuvjv51dK+TLDeWOA8w+ZecSKWZmNOx4VDD3n
         +o+Bq2HXjEyORIrhxi+zQsqC+Gjtsysrd2Chji3qTAAGm3sFFyCntKWI2onerzNgSnhN
         GLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RZe90QXqDSFc/e+9Obt5XingpU4tenpe4hJC8C/MZXE=;
        b=of+qoXpCF/JPwFFFCzJYNW/9jQQPIiRSI2sVH6759yWlO4H8IyDFrGbta0GN/Ur8b3
         YVcwZegJQMBfPKexdaAZCahbRTdg0vPRC0tH0IJ9anVpsSi2rS9MAQqW66BBi/oT0h9q
         HmbuvA/E3IjbCLKFQfzj9xLIrpQIib4rw5/Zqh7Rb35cyx+U3DuzP+2j4gUBWo+okKrF
         YohU3Jl/R+4ORj6ijsuOdR5u9YMHROSOHK6CDIINmYq5pD53awgpDNTO3Gy1vJFJBW0g
         Syf3j0zN8+wj3o5qPbj30U7GHkrU19O0S7cQeQ7mm+cFFlLBzYNQ1aRviylQexx1xwjI
         2ZmQ==
X-Gm-Message-State: AOAM533ACnxmBty7o1/Wo8AJn3uDAAjYqanDK5iNsLtHFYQgqpw+f554
        ACWFMBjShXz8QGlNQIwxWj84BG7q93IPD6w6X/Y=
X-Google-Smtp-Source: ABdhPJxRVxScYicBlo3GRM/GBeUy2slKeQT2zz4Bf0PO2HPDEFeddeFpIPldubvCAZnlMOKuQsrShsQJxeieGL7FOJg=
X-Received: by 2002:aca:4587:: with SMTP id s129mr16219447oia.5.1633703433313;
 Fri, 08 Oct 2021 07:30:33 -0700 (PDT)
MIME-Version: 1.0
References: <20211008084019.502758-1-lv.ruyi@zte.com.cn>
In-Reply-To: <20211008084019.502758-1-lv.ruyi@zte.com.cn>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 8 Oct 2021 10:30:22 -0400
Message-ID: <CADnq5_M14NOOm3cQt8BV_CvRaortNzDz803kE9RdTK5RE+AK-Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: remove duplicate include in dcn201_clk_mgr.c
To:     CGEL <cgel.zte@gmail.com>
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Charlene Liu <charlene.liu@amd.com>,
        Zhan Liu <zhan.liu@amd.com>, lv.ruyi@zte.com.cn,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Fri, Oct 8, 2021 at 4:40 AM <cgel.zte@gmail.com> wrote:
>
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
>
> Remove all but the first include of reg_helper.h and core_types.h
> from dcn201_clk_mgr.c.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
> ---
>  .../gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c    | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
> index 46e7efe9a78a..db9950244c7b 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
> @@ -26,8 +26,6 @@
>  #include "reg_helper.h"
>  #include "core_types.h"
>  #include "dccg.h"
>  #include "clk_mgr_internal.h"
>  #include "dcn201_clk_mgr.h"
>  #include "dcn20/dcn20_clk_mgr.h"
>  #include "dce100/dce_clk_mgr.h"
> -#include "reg_helper.h"
> -#include "core_types.h"
>  #include "dm_helpers.h"
>  #include "dm_services.h"
>
> --
> 2.25.1
>
