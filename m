Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B1E4565B7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 23:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbhKRWbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 17:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbhKRWbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 17:31:48 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081C6C061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 14:28:48 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id o15-20020a9d410f000000b0055c942cc7a0so13527196ote.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 14:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iTIRoBMB8dTH55Lw8avCBAoOzO2H2LeNFnFB35W++GY=;
        b=C5gpD143CDgtmN2qVZv2V1OwteZNHALmoAxcCNJZGv3NS1r78PBJtS/pK9WbcA5q9S
         Rjfqu04wyUqbuB6L7yx7PMuWCASDhigrbeu8kGy2Rh1RJklEmVODoc2p3HAXNrvS/GJn
         B/w0COX77qXhtcWSaLbG/eN1+F7Vc6y4su+BdmYKJLSB29IrfCdZSQwgo6e3WAcyAtmk
         AISWmuf3fG8kndvz9eVangzRWtrA9N/acw/wnPOhezSImDc/gQCnM5cEgXTmBthrz5io
         u4FtoUqbH0p/kLBvD/dCVun6VSnmZaNBwCEFt9nTHj6H+fFFb8hveFWzPWo7zswSe7TK
         3Nrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iTIRoBMB8dTH55Lw8avCBAoOzO2H2LeNFnFB35W++GY=;
        b=Mn7oi70SaeyHry1NjU0ctedX+v/Yr7JylERrEheNXd9BFFaAfwMoljl1Da4n4NsasG
         TivQTGs/LK0FrjlvCFhweg6f1zj0fPrlsrqjJPwGPjG/gZShZ/2VtcfV90E7gKbMAG3P
         MHgvgx3585O6qBo+9xgSWC6/v8Wruc9qCsk4hDcz8VFBYLMw6v3DyNnZ/C8TiqB8LtAn
         CZw3pqSPzPdVnRLuSxHwG3T+rrvo4BNM2AqSLRRS10zK9fzYgDY3GMgmdz2tjpvsvkSI
         N7aoP4W8Z7+b5C+Ef76tkhD/CAIqGQanF62wv8bj8LQCVk1KtvIgAj8Oc7pcHmEVF+rB
         J/ag==
X-Gm-Message-State: AOAM531/OcZ+RnLLBsOIgLPAW8a2JW32oVPGt6FWX3iC0+0RCjg606zo
        vuEKuevGR7C4PF5mnp8NxyxKljYKW5i4zOWhcfUhA1Dc
X-Google-Smtp-Source: ABdhPJzyznhO8pdRdplpF77M8F5//6rspO6NfKtmr5De3xuos3zWUtNbCBNN29BnYBWyOf9dB8vdrMP6DZ5X3cS3pGI=
X-Received: by 2002:a9d:67c1:: with SMTP id c1mr567099otn.299.1637274526546;
 Thu, 18 Nov 2021 14:28:46 -0800 (PST)
MIME-Version: 1.0
References: <1637233039-22503-1-git-send-email-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <1637233039-22503-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 18 Nov 2021 17:28:35 -0500
Message-ID: <CADnq5_MK+O-6rMSojCGquCD8HooVfKMwyLez+RKsT38c_X=SMA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/pm: clean up some inconsistent indenting
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        xinhui pan <Xinhui.Pan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Thu, Nov 18, 2021 at 5:57 AM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Eliminate the follow smatch warning:
>
> drivers/gpu/drm/amd/amdgpu/../pm/powerplay/amd_powerplay.c:1554
> pp_asic_reset_mode_2() warn: inconsistent indenting.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> index 8d796ed..20cb234 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> @@ -1551,7 +1551,7 @@ static int pp_set_ppfeature_status(void *handle, uint64_t ppfeature_masks)
>  static int pp_asic_reset_mode_2(void *handle)
>  {
>         struct pp_hwmgr *hwmgr = handle;
> -               int ret = 0;
> +       int ret = 0;
>
>         if (!hwmgr || !hwmgr->pm_en)
>                 return -EINVAL;
> --
> 1.8.3.1
>
