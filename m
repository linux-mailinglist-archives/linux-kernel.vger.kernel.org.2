Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0C7402D75
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 19:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345594AbhIGRJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 13:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345260AbhIGRJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 13:09:04 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A977C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 10:07:57 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id bi4so13601809oib.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 10:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j29s6jGrbvtqdrpQkBZYVbTtCf9huBsKw7LAbvekqDc=;
        b=nDMbNZ9NrJI9JSLW4JBrEP3rhrTxiskApiLwhzzTBbw5bocGu3rATpSH8lOsAtCzDt
         W/yn8TNRiS/m2IlUqXDwnBFLGQNjqQsN0ff+91/df3BdpAD3K4X7YOdGM7jflgceOraf
         BFbs2tPYxzpM659Jv0vfxdHIpknDE1S70pQLxltO1wBUipwGBJ8RUjuILAfeZBqOZx7O
         HZHfkrp/QDtLwuztS84UXn+fNKToFEYfHNNUeKQgt9UrdFHqFT8TFBauVzEbe8hzTbCi
         ScEFd0qnqeBrirpapDinhjvUm9oQNA3Jk9U2mlMZyl5jHIdyjrQTwbYD+U+4OungicxA
         UXRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j29s6jGrbvtqdrpQkBZYVbTtCf9huBsKw7LAbvekqDc=;
        b=bpZdem9NZyWRiX8Uv44gbPWgP7xYB8buoXFgbrhmevXXE21uIcepSyD+lq7qiBfuhm
         4x5N/N8zM9H6Th+7rG8aNVbDAIc2oYTvyIOMYf1VHOTPzTQy6wSQrEo4wfUEr7d33ifc
         TXLNB9GvEjps9IaiVSqDsNlLAtkuM9jvkuPsQeaE52LRe9iMMoNMIcjKDTecJe+Cz/FW
         bSzMpx+vOEFqphFI2K7TCmXc2OVKpBG4zzWk1c32ZyMPpQ0cIqRUZa8yR/Fs5EzOMPeb
         LjxUfAan0PH5arrSCa8qx8nsY9efGA+f13Uetcl19amv5FjXPpT2YoF70BXx0aOKFGQD
         Y2sQ==
X-Gm-Message-State: AOAM533xA6M5KDhNOFmFRTEwjiacdAzKW9pjaItcwYJTgbQLOOxxGDEU
        vxsJ7QrZYaIzyaBlqEfDmz0JsGJAlTAN5e3kTDw=
X-Google-Smtp-Source: ABdhPJyQD705JieHy8nmaQuvlsZIWn9W+PazsyLzS41xNVIzxnVtMdvH/weyFa3QYZ0PrVCTGvsf9XM9fY9Sh0UpMUI=
X-Received: by 2002:a05:6808:1310:: with SMTP id y16mr3749150oiv.123.1631034476551;
 Tue, 07 Sep 2021 10:07:56 -0700 (PDT)
MIME-Version: 1.0
References: <1630920208-37789-1-git-send-email-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <1630920208-37789-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 7 Sep 2021 13:07:45 -0400
Message-ID: <CADnq5_NNTmyPs4KL1LgaZntAurjm1vx_m9UH95tMOkojCAtLxw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix warning comparing pointer to 0
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Mon, Sep 6, 2021 at 5:23 AM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> From: chongjiapeng <jiapeng.chong@linux.alibaba.com>
>
> Fix the following coccicheck warning:
>
> ./drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c:643:35-36:
> WARNING comparing pointer to 0.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: chongjiapeng <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
> index 4a4894e..15491e3 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
> @@ -640,7 +640,7 @@ void dcn31_clk_mgr_construct(
>                                 sizeof(struct dcn31_watermarks),
>                                 &clk_mgr->smu_wm_set.mc_address.quad_part);
>
> -       if (clk_mgr->smu_wm_set.wm_set == 0) {
> +       if (!clk_mgr->smu_wm_set.wm_set) {
>                 clk_mgr->smu_wm_set.wm_set = &dummy_wms;
>                 clk_mgr->smu_wm_set.mc_address.quad_part = 0;
>         }
> --
> 1.8.3.1
>
