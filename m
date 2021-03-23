Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C82834628E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 16:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbhCWPOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 11:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbhCWPOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 11:14:17 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9FBC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 08:14:17 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id w31-20020a9d36220000b02901f2cbfc9743so19487820otb.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 08:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X2/dvppl9EFycIbzir/9o2eLnvUFv2pJ4xfdH+MA8QM=;
        b=UYL7rLim99JevyGztNbHniK+OkVfhlRvzTAL3RkiH8/YQTtZTQTM6+dc0rvPvDc2eP
         o/5tgadaF2WWFKuJfSiVvaxfxamcwfN1D80bNBUKwo1u96pAZRa+OCuybj1dmJI4IWAf
         PlIA1zuFfV+0jKBBp7Kc6qhSo3IVU60AV5w1d+QQCxjnQLzt7UaMtQx4qQiJyI1Z6yap
         +9VUSFj19N8glrhb1A4IqQU5icycGjm9mq7t9VX5wvQoSRTYcgMzm1aTrsenoUUYwGle
         XWlJ84ApF9FXH6EN3rh4CJuUB11mVfpKNhcpIGaJ6oeZbOOOkrdAZKTs/uDG8DA7Sruz
         sDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X2/dvppl9EFycIbzir/9o2eLnvUFv2pJ4xfdH+MA8QM=;
        b=at8U4tEf7yFwUETRhX1LdKaPF3UTzYdFjNhZlx00tS5ZLproawGbmW8XxugDIf6cu9
         6EktfoWi6sLFuP5xYnCXVlAr4oM0drc4w+JQtU1dItiXUbO0eC290eRqq8CQ2DHueleW
         m7kZVgeSkCrshjH6eUxTallD6E+6w9KC2vA4oLB8OaCvQXa9v4EscUcbUpvlFA5sRptI
         yW5quPn1bAZWXl9F61Uak8P+BEXvhHz09vEhVRSqXlNVZdht2TnNwyQZ0k/DgjA2wv+m
         FEyaxq0RCOdZikwQaSbYpvnZ+6mrfPcBqVrwS4naoHPwu3iiSEJ3NPxvNjLLC6oV2mSW
         ug+w==
X-Gm-Message-State: AOAM532dqyNpT4pJTkvBTIPw1BrugUWkduAf+ZRSB4eKNgKnVFIQzVgW
        TsY9FVZbiLIiymWf8kIeAjfPy2VUlg2GUa+v31Q=
X-Google-Smtp-Source: ABdhPJxccxo6qay1Ja8B5rRGkZ84PCoqVfKLkENwqOk7ApRciBrgC59v5U9P9CD7fq7Ef1XGJlgxtw+h+XkfyAT3oxU=
X-Received: by 2002:a9d:750e:: with SMTP id r14mr4876999otk.311.1616512457068;
 Tue, 23 Mar 2021 08:14:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210323011923.133284-1-wanjiabing@vivo.com>
In-Reply-To: <20210323011923.133284-1-wanjiabing@vivo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 23 Mar 2021 11:14:05 -0400
Message-ID: <CADnq5_MWQPaSjKY5ky2xSacUr5_fP0uDiw8TU3HVA6QC6NvAtA@mail.gmail.com>
Subject: Re: [PATCH] gpu: drm: amd: Remove duplicate includes
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, kael_w@yeah.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Same patch was already applied recently.

Thanks,

Alex

On Mon, Mar 22, 2021 at 9:19 PM Wan Jiabing <wanjiabing@vivo.com> wrote:
>
> ../hw_ddc.h, ../hw_gpio.h and ../hw_hpd.h have been included
> at line 32, so remove them.
>
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  .../gpu/drm/amd/display/dc/gpio/dce110/hw_factory_dce110.c    | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dce110/hw_factory_dce110.c b/drivers/gpu/drm/amd/display/dc/gpio/dce110/hw_factory_dce110.c
> index 66e4841f41e4..ca335ea60412 100644
> --- a/drivers/gpu/drm/amd/display/dc/gpio/dce110/hw_factory_dce110.c
> +++ b/drivers/gpu/drm/amd/display/dc/gpio/dce110/hw_factory_dce110.c
> @@ -48,10 +48,6 @@
>  #define REGI(reg_name, block, id)\
>         mm ## block ## id ## _ ## reg_name
>
> -#include "../hw_gpio.h"
> -#include "../hw_ddc.h"
> -#include "../hw_hpd.h"
> -
>  #include "reg_helper.h"
>  #include "../hpd_regs.h"
>
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
