Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E38939264E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 06:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbhE0E1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 00:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbhE0E1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 00:27:02 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FCBC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 21:25:24 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id v22so3882024oic.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 21:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HlEEB7m4vbuZJ5U/IF3dSwz8wK0GbasA4XFoALDTWL8=;
        b=W5/+NkQahCgvZZ1x00cU/xU8h+8cEB/LHC5TNOw+Qcu43GEXKib+gni+t4UUYVyU4b
         FADaYkMAkf8n+5lPiHn9m+W+H90W/b4+4FFG1IhqblRjXl+llnwhZu+vXnhdi5E2btqk
         j2ebfn+If6EBldLbq5k4BPeGxAAzl84vP4VWe2xjRf1rEt3JbuqWusKzzRv3TsxB3qgz
         mkHT7vJ60Ml3mnW0UYPWWKOmAHFYD6tyohnS/NWdv82NutAwQmL1MIyJZ/y3B1SsSTAR
         KHTxUhr6/fXZaWhQJo0h4Ldg4iX5E6VgzBCWqsqFGk3mgABntDMN0AlzvPNf5MFgudsg
         sEJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HlEEB7m4vbuZJ5U/IF3dSwz8wK0GbasA4XFoALDTWL8=;
        b=dpAnCTnXErb9PWEg2dpC3/p3paDIZtoJYaMCB9hYvNqdXfMbKBeplh0HioQC064rUv
         ZUeYghX6IbFcHMSzRJKdyqrZRsPtNBl1WSAkFP7CgPEDzv8H6kJFvIFp0WjSGERVNPUs
         /L4hd35jT7EO9WAnB26jt4j1FPnBZl28jWukETJkozJVLvUjf1q4i00GSmyOSNKJg2sC
         CncdHzJopp05f10JIoDctmetVa+NoVSxuAfcxq8QRpwSY/KxeCTpHtdhBRf1ZM6YtMLd
         ECouvWtHyRJx4ZDkMurhzPm3FXfYrPSJFINNyrgGqV11rSSkpXCTPO919I3cEzQFXmvB
         51cA==
X-Gm-Message-State: AOAM530uZ/CUWXMN+we1SaOm0yOD1aay9TxveFCUoIpqreobGAglCw4G
        1A6yu5Zlw3iTNje8wJLGMLVCJ3Zkhd6AuWOGyM+Fv6Vx
X-Google-Smtp-Source: ABdhPJzJ+S3b+XHZOW81VUxJ1mHkElsf0B94rZZm/7C5niMZ+YtERtmHEKDtM8Uc8rDW/9L+Ulyr21pntbu0H/HCLJk=
X-Received: by 2002:a05:6808:1592:: with SMTP id t18mr1076858oiw.123.1622089524295;
 Wed, 26 May 2021 21:25:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210526084726.552052-1-lee.jones@linaro.org> <20210526084726.552052-22-lee.jones@linaro.org>
In-Reply-To: <20210526084726.552052-22-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 27 May 2021 00:25:13 -0400
Message-ID: <CADnq5_O0upD-8xOmzd+jGdozS=F9k0+xTTOWYm29Xwop4Th9zg@mail.gmail.com>
Subject: Re: [PATCH 21/34] drm/amd/display/dc/dce110/dce110_hw_sequencer:
 Include header containing our prototypes
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Leo Li <sunpeng.li@amd.com>, LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Wed, May 26, 2021 at 4:48 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_hw_sequencer.c:92=
9:6: warning: no previous prototype for =E2=80=98dce110_edp_wait_for_T12=E2=
=80=99 [-Wmissing-prototypes]
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c =
b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> index 9219db79f32b6..1ef1b1b33fb09 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> @@ -64,6 +64,7 @@
>  #include "atomfirmware.h"
>
>  #include "dce110_hw_sequencer.h"
> +#include "dcn10/dcn10_hw_sequencer.h"
>
>  #define GAMMA_HW_POINTS_NUM 256
>
> --
> 2.31.1
>
