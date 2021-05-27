Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A87503925AB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 05:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234878AbhE0D4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 23:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbhE0D4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 23:56:35 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD92C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 20:55:02 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id f22-20020a4aeb160000b029021135f0f404so815540ooj.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 20:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DYdOvbKIS1vZWONSAPvNPTiDzbelKy3t1aUeLsgWFhI=;
        b=kPGnlulp5k2F+B+K3fyRfScskNP8ZyHJoSJbo95tgoVtlPWnIWQMm4Pa6u9ilh9CHJ
         HVXsPASkp3wrDb1Yn/26wivV7jrv+xZPANfnvwcd+QZeMPonDhYsQR1afdCAzjhAThoj
         z4W0EbKuxEn1bQdk4qKBxvmv1TuZCpdG+jhfb/Pjb24sMBPCCSOPPlE9AsAX8NbEBY+P
         CI8Ix37uFTrUJ8KNa+JHjcHdSg65XZvQqBPmAM1jscOmSFCKBdA7YUiXfOkSA1nl+K0/
         jH54F+4j+8zWxf19n01IdshtAyjwtPuiSWPxAgzsF9OODng9Xnvit5YxgdUBMaSkVWDT
         +4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DYdOvbKIS1vZWONSAPvNPTiDzbelKy3t1aUeLsgWFhI=;
        b=TG5EHxWZ9LyIlM020EeUqv0Jbn8aUOp0KsiuFQQs1QQFnx90+3HCrmGSg7uiWHKMmk
         +GaF8C8T5/VQlYSEVCHmmScflcMa1ncd7x3YXEp8HWAd1DfAbJUBNWvpvn/8CCWmV8AX
         8CZ1TLQYyVdJ6nH9C/bhAyGCuJHHCfw7zpcPNWLh1wEQ62fdqEffwfhkbkY/DAPZSkon
         PaDLcaI3zwI7pnHcpN5yVCU9qT/GG/tcO1BwPb2L2PNV4JxLytuSEP11ZyS+tBproFN3
         lae+qUruY5pITqf2TxOIRKnI3mMsRCl96sCeZkoJr8odFnuk88HGqlMztCZ9Wlb+gkgT
         TcWw==
X-Gm-Message-State: AOAM533GLyRPAlxG8IImVEB7tdhDTtwPooEfilf/IungJ/4NXsqXcQD7
        VhJlvI8VRIY5z9MHMnr5OExCR46EH2vBodwyPlY=
X-Google-Smtp-Source: ABdhPJw6g2LITGmHYZhVJQjNCbEYY+uteLhXWlUvPhqUVuSZe5IwdkcB5EHEfuy02gyjwWePP3qG5xRWbOHESHpsJdg=
X-Received: by 2002:a4a:d085:: with SMTP id i5mr1199155oor.61.1622087702123;
 Wed, 26 May 2021 20:55:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210526084726.552052-1-lee.jones@linaro.org> <20210526084726.552052-8-lee.jones@linaro.org>
In-Reply-To: <20210526084726.552052-8-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 26 May 2021 23:54:51 -0400
Message-ID: <CADnq5_NU4fPUun-W2--KbpKP7yD1oD-tcQ=B82Apg6xiXR6+xQ@mail.gmail.com>
Subject: Re: [PATCH 07/34] drm/amd/pm/powerplay/hwmgr/vega20_hwmgr: Provide
 function name 'vega20_init_smc_table()'
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Wed, May 26, 2021 at 4:47 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega20_hwmgr.c:781: war=
ning: expecting prototype for Initializes the SMC table and uploads it(). P=
rototype was for vega20_init_smc_table() instead
>
> Cc: Evan Quan <evan.quan@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/driv=
ers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
> index d3177a534fdf0..0791309586c58 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
> @@ -772,7 +772,7 @@ static int vega20_setup_default_dpm_tables(struct pp_=
hwmgr *hwmgr)
>  }
>
>  /**
> - * Initializes the SMC table and uploads it
> + * vega20_init_smc_table - Initializes the SMC table and uploads it
>   *
>   * @hwmgr:  the address of the powerplay hardware manager.
>   * return:  always 0
> --
> 2.31.1
>
