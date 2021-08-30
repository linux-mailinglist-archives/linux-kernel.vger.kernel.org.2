Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A313FB9D4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 18:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238078AbhH3QJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 12:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237900AbhH3QJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 12:09:27 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E073BC061575;
        Mon, 30 Aug 2021 09:08:33 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id b5-20020a4ac285000000b0029038344c3dso4719379ooq.8;
        Mon, 30 Aug 2021 09:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LGlCF90Prh9n2u4Ctzp39bN3k2Aae1fS0uTteqOOBpc=;
        b=mrVvliaOqJAmn24rQVts3jWqm9+elkBzrK2b9vJvkzvlwz70Yil6U0wo9wTtfPSmoC
         earDKTMDrNEG8GYBXXs+6p1dbZUnYbABpKt139wDyV+r4m5sqXbT1DNUdcJadF1SVePo
         YpCq5kQtn31N2J+nwYNzrI/J+EuoALojR2mWs1J2qIBCBH6kTV5D4iWcFKntFZutsTmh
         OSJtjxLITUP1ag4fIuH+ZwHbzGrCqvsUMVi6zQ2zuw/ob6nxJap6fT9P/xbRP3D0IZ9H
         0gOS2P534zFZSTK5045enfzLub1nXpORbBckmHcAXBf3/yptCWFVbBE+uvEubPj50z9E
         dkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LGlCF90Prh9n2u4Ctzp39bN3k2Aae1fS0uTteqOOBpc=;
        b=NWDoCi3reKzioU95d8DKMxv5h0SgbGW/G7YdLWSQhTe5Tr8FG0Wc7gryufbXpdBDqs
         8k/hW8ZTkzOMBEyN2jmb+JIlqdjyVmjheXOV4MBxfw+otWwBar7v/S7PscZJh5BYhPGn
         CM6WUDvZhSal7fPXKVuYofNO/Gn9u9FyQCzTSejqowv5MiUc9NAGPbkbRRisWivk39u8
         ylNa5L7D97Ts3cCOryDTC627RlrkGWPIMNsSqhOWRoFqr+RqXoKZFt2HBaoWScyS1jrm
         WNVUn/pKWIDG1BY73aQo6Fv/n1cJWLBEt7d8S8nCjPMMKU/T5RIMCYlPBmHtEUpdF0tp
         dYcA==
X-Gm-Message-State: AOAM530z/ZC4bioLTcSOh3X/f6tv/xtJymau3rcCjM1QBFNIXpo6GfAT
        DAj7SE6+HfcpFaa1ez3DJWxQs7DLyKKq+h9JJc1trGco
X-Google-Smtp-Source: ABdhPJxEwEYq7i5z/6MNA82j5/B7YYx63K32JCp9xiws2ESkd7l/CkxeG4uSyZ7nJAQweRTkvQl4bNyL34+7e8vS7BE=
X-Received: by 2002:a4a:d108:: with SMTP id k8mr10606732oor.90.1630339713364;
 Mon, 30 Aug 2021 09:08:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210829164624.531391-1-colin.king@canonical.com>
In-Reply-To: <20210829164624.531391-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Aug 2021 12:08:22 -0400
Message-ID: <CADnq5_OGXeUJ5ArNyzHQ1mRqfKd57kHbaRY+hCJeLYRBsqxr_g@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/display: Fix unused initialization of
 pointer sink
To:     Colin King <colin.king@canonical.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Sun, Aug 29, 2021 at 12:46 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> Pointer sink is being inintialized with a value that is never read,
> it is later being re-assigned a new value. Remove the redundant
> initialization.
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index e1e57e7465a7..9331c19fe9cb 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -10917,7 +10917,7 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
>         struct amdgpu_dm_connector *amdgpu_dm_connector =
>                         to_amdgpu_dm_connector(connector);
>         struct dm_connector_state *dm_con_state = NULL;
> -       struct dc_sink *sink = amdgpu_dm_connector->dc_sink;
> +       struct dc_sink *sink;
>
>         struct drm_device *dev = connector->dev;
>         struct amdgpu_device *adev = drm_to_adev(dev);
> --
> 2.32.0
>
