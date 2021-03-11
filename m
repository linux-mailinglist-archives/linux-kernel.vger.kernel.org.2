Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D32337929
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 17:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234567AbhCKQVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 11:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234545AbhCKQUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 11:20:42 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7078BC061760
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 08:20:42 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id f26so2888923ljp.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 08:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4mfW5335h/WRWI9dVCvKJHe+RapkHx/nphEJf+JLEfY=;
        b=oj/xGKhwPlYIKGs7xGNB09v6HFRF++lyyRmlXCz0eDkY5xcQ3u8RrezpbRkdy11V9C
         +uhCGn6P/rPEbM965aoKuppk2Gvsz3XB7dmtWBEj3Emdg4PGblZQXIghdjISOtxHhdAD
         aY6hAoFGFd5oUpC/2iLC3lzxRzBo3LWLHI52K7qiGdsN4tHYQ8AaUxh9m7mzXK0nXhV7
         0TL4XbcYXCFYcfdH80iGpegLieJLpUbb16RFrglCRznxrD6QDUbtMYsNFXi/jR2aoDek
         tGQmVPJ4JxDfABjrXQPMXsTqvbWSOpjf20XOFkdOJqd+b5SE51BGdaLoFVP2lAZB4aB2
         wBwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4mfW5335h/WRWI9dVCvKJHe+RapkHx/nphEJf+JLEfY=;
        b=Z+h72bb2BjBXw8KjHOPTq1uyGifCtQWv7c1PHO+rb4XnabMrHt/5criVdxPLuWOHGX
         sd6S8jMT9rTyQyRBn4V0H/g+kgsVxuhBPP+JOK6i5dKzYG0e0awDJpbPVR4DNbZZ41IC
         3itfAwCHU7cu+vxv9wIX6jx3+efjwxX3xCrP482S8PHR5cTmdDQ/pEWCYDLvj4eiXdSi
         opkRBcLoTVzEeK20eoD7HYT7D+SuziYivud0RS3+8PS18KfVyr2lAJNEa4TFJc9sMMi1
         cU53Wh4+HU2MHizQRBXmfgPdDPo7xG/c8gubDulVFk09zmtMMIrmX+GHrJXqFpRY6O5N
         WZuQ==
X-Gm-Message-State: AOAM5316U8Y1YoW/SjNwtujxBhAuHbunui9+nq5IE0/Xw5m0ULeW7Vuz
        WC1yyAWAnDKmnfNhOSykyPAjbRRIEU1m2SOEEYGChw==
X-Google-Smtp-Source: ABdhPJxUPh5qHPBDejHPkQZGXI7Wr8UqPIjSZ7fl43pyrVqj46hUhhEA5svMYWySIqUU/pYnrGqKZGpg5zRKasOSBwk=
X-Received: by 2002:a2e:864a:: with SMTP id i10mr5068722ljj.467.1615479640987;
 Thu, 11 Mar 2021 08:20:40 -0800 (PST)
MIME-Version: 1.0
References: <20210115224420.1635017-1-dianders@chromium.org>
 <CACRpkdYUs2W3b_u8YrmYwq_kcUCf0DhZ-o2o6O2EmU5rdtv=BA@mail.gmail.com>
 <CAD=FV=WDVAj+OcVXaTJRUu8tvdDzySW0KOfiGqZHi5YvP42BTA@mail.gmail.com>
 <CACRpkda1Ast1cqNfVJ_u6zs8610DWSQGykPt4yBw+mFZFrUPSg@mail.gmail.com> <CAD=FV=Vj-6Y0X667o5vH0EL7hXi6sU4ZWs_a41B6h0D1s05_Hw@mail.gmail.com>
In-Reply-To: <CAD=FV=Vj-6Y0X667o5vH0EL7hXi6sU4ZWs_a41B6h0D1s05_Hw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 11 Mar 2021 17:20:30 +0100
Message-ID: <CACRpkdZpy9yvp+bzHUGiZVyFBDpJHJcYSZQnBQreCfTQLOj1-Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] drm/panel-simple: Patches for N116BCA-EA1
To:     Doug Anderson <dianders@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Clark <robdclark@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 2:01 AM Doug Anderson <dianders@chromium.org> wrote:

> If you happen to feel in an applying mood one other patch to
> simple-panel I think is OK to land is at:
>
> https://lore.kernel.org/r/20210222081716.1.I1a45aece5d2ac6a2e73bbec50da2086e43e0862b@changeid

I applied and pushed this as well.

Yours,
Linus Walleij
