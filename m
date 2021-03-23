Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40063346283
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 16:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbhCWPN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 11:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232730AbhCWPMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 11:12:53 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F10C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 08:12:52 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id g8-20020a9d6c480000b02901b65ca2432cso19772594otq.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 08:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SAZiBIhngviqShlUYcMIqLkoRDGcp5pdl7KlOZufEbs=;
        b=ZbDu2rn8fNsxu8F9SovGehcfuhr82N1+Txnspq/N5gPtuNK3xwZC22HeaoZUyZzmPN
         D+3lS3ri3Vi4fGQjAwiBzuG54soNmiWJFhyo0GgBVtuc+kkS063aqcJhos0bER1scwGu
         Sgrf6InpqubuhnCLtEzkJrmtPfBSMYooY3TMeOnCRL2OC2Y9lUavvvAi45D1eHkm44/C
         g/QRGtTHJO1WlNvPiGwzKoWjzfBs4tYNBddReyL9GUIsE/8UJicSS/mB8eSp5Idiy69O
         3OLJCd1czzBB+DHsn7nKVedDc3qtrZ/PqGRB7jLY7BKVdH6Gcf3lWsJuc/tyKbeqerny
         i6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SAZiBIhngviqShlUYcMIqLkoRDGcp5pdl7KlOZufEbs=;
        b=Y6HjKQvdE8U8N0ztbWyPeG+ZU8JK46SksuxSjcKAxBgQk39qYuo2S7bRzSzvGVsOaT
         7GkD9xRSJ3zir0sRNzPZn6vs+6oIzIs8y3qi0kGa9wYJTTOCITErblyVnBGvj/MybL+X
         cWXbn6xc88NFXZ3WJ26ajitZEw5JQXMUPBAiYEZ+RG6I41yjtcOEJEH7HroaPS7DtNBf
         o0J2XYvlwFMtxwhYQPduw6cSqo9DW/2V3e0rbIZnQBYglRuBg7+bav6wYC7A5nmuGWWT
         5B9MCNidh/aUgCZjRPctxHJ1MX5cYGwgUwpWL/7Y+lKtFdNvhbsYttpj59UdR8EDIOgx
         jmfw==
X-Gm-Message-State: AOAM532rz9LtoYBzOLclpaYRVwygDHLms8y5za/QD9CatAKGHYpSCwDb
        RDqqOnZd3E5s1dZst7JtLp3Kkmir1nbPSF5XS6M=
X-Google-Smtp-Source: ABdhPJzZAaNbYPvJqTOFk1n5Xa1ABvpgzcKFUXSzPKV/+WIOQNhS0MW3AGO2JaQaQ9xVy7k5/xNPps9LC+WDytVXetM=
X-Received: by 2002:a9d:d89:: with SMTP id 9mr4838484ots.23.1616512372013;
 Tue, 23 Mar 2021 08:12:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210323010955.132219-1-wanjiabing@vivo.com>
In-Reply-To: <20210323010955.132219-1-wanjiabing@vivo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 23 Mar 2021 11:12:41 -0400
Message-ID: <CADnq5_MNBuBRGYc3r-PzLaiXO82eWwop+F+G+KDtixj-XiFuAA@mail.gmail.com>
Subject: Re: [PATCH] gpu: drm: amd: Remove duplicate include of dce110_resource.h
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Sung Lee <sung.lee@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Tony Cheng <Tony.Cheng@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Isabel Zhang <isabel.zhang@amd.com>,
        Aric Cyr <aric.cyr@amd.com>, Anthony Koo <Anthony.Koo@amd.com>,
        Krunoslav Kovac <Krunoslav.Kovac@amd.com>,
        Wyatt Wood <wyatt.wood@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, kael_w@yeah.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The same patch was already applied recently.  Thanks!

Alex

On Mon, Mar 22, 2021 at 9:10 PM Wan Jiabing <wanjiabing@vivo.com> wrote:
>
> dce110/dce110_resource.h has been included at line 58, so remove
> the duplicate include at line 64.
>
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
> index 4a3df13c9e49..c4fe21b3b23f 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
> @@ -61,7 +61,6 @@
>  #include "dcn21/dcn21_dccg.h"
>  #include "dcn21_hubbub.h"
>  #include "dcn10/dcn10_resource.h"
> -#include "dce110/dce110_resource.h"
>  #include "dce/dce_panel_cntl.h"
>
>  #include "dcn20/dcn20_dwb.h"
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
