Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3103232ABDC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 21:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447134AbhCBUux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 15:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344629AbhCBRwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 12:52:09 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD54C061221;
        Tue,  2 Mar 2021 09:51:17 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id s3so20830316otg.5;
        Tue, 02 Mar 2021 09:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wbXZh+y7Wwg/hAULiKSl5XcTTJtTCwhI9jiu/kuN7UU=;
        b=TpxZtlx9zhSj5DDnDsYDla0q4cE4cGz3bke3+P6NzMosLpXoRLfFhOR+4q1q4iNdt9
         Us/EyQ3dq9wGSQK3IXeDBbioRv8i366HWBIfEMxDQ4mXNhhzhb0WC27LQ/omHh4k8+jz
         KWjh8/3Wfjr47eA+kvLj//+JNSZux8xNyLLKIcSDdFMMaSfgUnMwXxKMC1IStHsBWno2
         hD6cYKKOyvZItGEhPwErlJGvycxSTS9ycmdRowc9KvOZ5X5IfEjt69DFpySEfUqwmX/L
         moGAb6FhFwY9GcmNI5XSCW9lcI53YETfrgtHcZNye2VyW10iFdtK/EhLL8TuWLDJBFt2
         JFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wbXZh+y7Wwg/hAULiKSl5XcTTJtTCwhI9jiu/kuN7UU=;
        b=jjgpD2BdKiWp7JERDV1inkmUiin4qFIabmUexsx5bzTHb9/5pbKtOf6syrmgXjmpg1
         PTcu9ZSwwf+wmbcUhZCD498eWhFXa2XHmQ2gYE8Bj5iYv97yPG36/u6CeF9QYCDx5vT1
         4gCKj8QUzv8NH6pESM9dh2LuEtjzocF05RPv49Vo99mHqiTShtd6b3kS/1QTV8NLiB6y
         BxZWStzBK8oIwA0YFaBlEObSkmZn7fA80QJHVW8Ys12+0QS3De3GCjwokExlczpGRNDs
         4JQzkSybm48eulr0SGW6luFsXAdJxw3kQbKe8+23w+v4bv7n3OZ3IYBXpFaQd0ubskml
         cvNw==
X-Gm-Message-State: AOAM533D/iO7cp096XRefKX+wILjX0EzI7HBgwsRlcc928iV36o7S+S4
        JtKVDiRmHfZ6ALlwuJMkm3hDCdGU6fEeofAeTvQ=
X-Google-Smtp-Source: ABdhPJyiLqxx0zpTF7yD/rJdXT8zQnIclm83GIlN1LSHj9qFzjDCbyr3HFtAZ/1Q1a4kGUf8K0Cr8EnDa0ewPwwwXnQ=
X-Received: by 2002:a9d:20c3:: with SMTP id x61mr8005751ota.311.1614707476945;
 Tue, 02 Mar 2021 09:51:16 -0800 (PST)
MIME-Version: 1.0
References: <20210302140509.8466-1-colin.king@canonical.com> <b9a11c62-f469-8f5b-9585-74b73cd5a9db@amd.com>
In-Reply-To: <b9a11c62-f469-8f5b-9585-74b73cd5a9db@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 2 Mar 2021 12:51:05 -0500
Message-ID: <CADnq5_Nrg_L+9vFhsxbbeimSvWM2xkD7Og8aARmYGSMUE9rx+Q@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/display: fix the return of the
 uninitialized value in ret
To:     Harry Wentland <harry.wentland@amd.com>
Cc:     Colin King <colin.king@canonical.com>, Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Anson Jacob <Anson.Jacob@amd.com>,
        Mikita Lipski <Mikita.Lipski@amd.com>,
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

On Tue, Mar 2, 2021 at 10:03 AM Harry Wentland <harry.wentland@amd.com> wrote:
>
> On 2021-03-02 9:05 a.m., Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > Currently if stream->signal is neither SIGNAL_TYPE_DISPLAY_PORT_MST or
> > SIGNAL_TYPE_DISPLAY_PORT then variable ret is uninitialized and this is
> > checked for > 0 at the end of the function.  Ret should be initialized,
> > I believe setting it to zero is a correct default.
> >
> > Addresses-Coverity: ("Uninitialized scalar variable")
> > Fixes: bd0c064c161c ("drm/amd/display: Add return code instead of boolean for future use")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> >   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> > index 5159399f8239..5750818db8f6 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> > @@ -530,7 +530,7 @@ bool dm_helpers_dp_write_dsc_enable(
> >   {
> >       uint8_t enable_dsc = enable ? 1 : 0;
> >       struct amdgpu_dm_connector *aconnector;
> > -     uint8_t ret;
> > +     uint8_t ret = 0;
> >
> >       if (!stream)
> >               return false;
> >
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
