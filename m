Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 014293E5CA7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 16:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242190AbhHJON6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 10:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240474AbhHJON5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 10:13:57 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E351C0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 07:13:35 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id d10-20020a9d4f0a0000b02904f51c5004e3so17739734otl.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 07:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WBj9jDzdrpkQARXB3cjFr72FO41wqr8C2m6gqeyQkOM=;
        b=G5H3i1qJW9zU2sRnzNTDSWEAviRi5xYzX3sXOLng8kmOXC8SlYtH/pO83+FQFamtev
         mQWemttbtv/NZqWhr57X2ZML7YQStNfVc35CW862oeR7Zj6FXZkLLMr3LFMXIQx1uYQB
         ApIWDHC5af8fq77CUZyP2c+10o3dADueNjrProCLo1N1WCW8J+1G3ReM/5PT1frtnOY/
         QQJuE66EI6nDjs9A1rk8H5Y2iJMIKvqip2p1YdBzEZxdvBRU1hSocjOFfs21Hd+9XBiZ
         xF01NEYDgwJipsvicygnP92Cu8zA4UUtPcE0A/HCSUN4lIktwTT+R+8CJl6p0R2EHOEs
         SB3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WBj9jDzdrpkQARXB3cjFr72FO41wqr8C2m6gqeyQkOM=;
        b=d+uKDQ9Vn7ZLTwBwAKAuyaTsh2TeLhThgHaehE7Lrc6xzL/lngFCYIX+jvDZRGDgvO
         XSryKWzHPJSG447UdTxtbVRmyHBvvo02awd6/Sl6yqZCDHuFi92FDD3lohRsuVaS2LQx
         T+mtZwg/7NcAmHqjKmZP6A58DFLw34REKZdGvvYjw7TnQ0CC9xcxS0O280BfRPP09U6W
         1/BGQncNbZE2qSm8/n2ktCV+r+Ik8v07SxaUPZgtJ3fPpEgcKudlHyV22N6SvC6W0byn
         hgbQ6AG/3mnSeKMypCQrxbXEBxxn4rHLbqfpv55bAYgYIIVMNPMjAIiNG1RbsORiJ+gy
         6CLw==
X-Gm-Message-State: AOAM530JFGNcS28V0e868WDV4x/QvMkHfcb8yLeBpoLcIqgdBlCr92Fv
        vb+dBrDOliJWRuDGycYgc62BO95eI+acVIO9QK4=
X-Google-Smtp-Source: ABdhPJw8TFkDGPU6iSWLNfA+6DeUCxWqVIOLSY1qvG9Gk5q54+qoCpUI8ReRElJ32Ux40vKe6zWz3g6RHiRmbJ20X/0=
X-Received: by 2002:a05:6830:1e78:: with SMTP id m24mr15296402otr.23.1628604815033;
 Tue, 10 Aug 2021 07:13:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210810012304.28068-1-zhaoxiao@uniontech.com>
In-Reply-To: <20210810012304.28068-1-zhaoxiao@uniontech.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 10 Aug 2021 10:13:24 -0400
Message-ID: <CADnq5_M1pon2TxnjU8pLfjGdo9w1iuc6KX6ff2a+7B4cTza79w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: remove variable backlight
To:     zhaoxiao <zhaoxiao@uniontech.com>
Cc:     Dave Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        Nirmoy Das <nirmoy.das@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 9, 2021 at 9:24 PM zhaoxiao <zhaoxiao@uniontech.com> wrote:
>
> The variable backlight is being initialized with a value that
> is never read, it is being re-assigned immediately afterwards.

I don't think this comment really matches the code.  I think you can drop it.

Alex

> Clean up the code by removing the need for variable backlight.
>
> Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dce/dce_abm.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
> index 874b132fe1d7..0808433185f8 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
> @@ -177,23 +177,21 @@ static void dce_abm_init(struct abm *abm, uint32_t backlight)
>  static unsigned int dce_abm_get_current_backlight(struct abm *abm)
>  {
>         struct dce_abm *abm_dce = TO_DCE_ABM(abm);
> -       unsigned int backlight = REG_READ(BL1_PWM_CURRENT_ABM_LEVEL);
>
>         /* return backlight in hardware format which is unsigned 17 bits, with
>          * 1 bit integer and 16 bit fractional
>          */
> -       return backlight;
> +       return REG_READ(BL1_PWM_CURRENT_ABM_LEVEL);
>  }
>
>  static unsigned int dce_abm_get_target_backlight(struct abm *abm)
>  {
>         struct dce_abm *abm_dce = TO_DCE_ABM(abm);
> -       unsigned int backlight = REG_READ(BL1_PWM_TARGET_ABM_LEVEL);
>
>         /* return backlight in hardware format which is unsigned 17 bits, with
>          * 1 bit integer and 16 bit fractional
>          */
> -       return backlight;
> +       return REG_READ(BL1_PWM_TARGET_ABM_LEVEL);
>  }
>
>  static bool dce_abm_set_level(struct abm *abm, uint32_t level)
> --
> 2.20.1
>
>
>
