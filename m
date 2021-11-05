Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3DCE445CF0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 01:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbhKEAN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 20:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbhKEANy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 20:13:54 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208D7C061203
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 17:11:16 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id n128so8912745iod.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 17:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4KsnJxBGTyLgNC9LQFVaGBTTSMsAvFSllk79LexRwJA=;
        b=nFhNJs/6zLfX/HDdX03yOBZsFn//RbfnTbfvj+8xfIcqZA01a8sEJdr7u7Hg2yFwIx
         UQ8Wr+wzrwqo1ljEOyT7Z0fOU4gCqarwPqUzj1f018BbkV8CPIPaNqLH+1IHHrzBv5SB
         u/PfIRUb4ABRnF3OXo6a4xpOLivk43cyxfPcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4KsnJxBGTyLgNC9LQFVaGBTTSMsAvFSllk79LexRwJA=;
        b=7ocdUcom+dlRASFA4S4ydEa3tCl6gBtUcoTG7MMbAtH8MgPsxqkLAVvUJOSXk4E+Nh
         vuR/F80ba5Hq5vYIvzj4olA1HlwPnFccmXXHgUEwLPn2BpJWE6TWHfEf24P/FSxcKvqw
         NBElg084m0f0c1hG/EHEL+Qk6cebS/CLabGBNpr0nhyuu5bGB54CCVwJHjNtk57+numd
         J+G+l8Q/4qWtcpjGd02qGCIh+1ke327QyqjiAcK76VT8ozoQHQa0ebW6CTRi2TbOTkAy
         HdBgZAddI87rBsyiGaO6wjjGVIsEu1nkvplICIpmVD8HTr7vsQPDcM8zy4fkHYbcDnHH
         S2MQ==
X-Gm-Message-State: AOAM533f6iU1zhYuIN25mHxy2zahJUyJEU/hYUH938viLgLEi599D9XR
        XDn148ztoXYF1a3J4Ke5nxlkRDe1VshcsQ==
X-Google-Smtp-Source: ABdhPJzaHGiWm/q/CE8+LTmzvVYKyt5iS987h3XQzvOnEjGenXHtCpBGMOumcvfcuUANwJ9zk7R2uA==
X-Received: by 2002:a5d:8152:: with SMTP id f18mr38453286ioo.135.1636071075457;
        Thu, 04 Nov 2021 17:11:15 -0700 (PDT)
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com. [209.85.166.177])
        by smtp.gmail.com with ESMTPSA id k11sm3935736ilv.66.2021.11.04.17.11.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 17:11:14 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id w10so7886784ilc.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 17:11:13 -0700 (PDT)
X-Received: by 2002:a05:6e02:1a85:: with SMTP id k5mr18841136ilv.27.1636071073597;
 Thu, 04 Nov 2021 17:11:13 -0700 (PDT)
MIME-Version: 1.0
References: <20211104222840.781314-1-robdclark@gmail.com>
In-Reply-To: <20211104222840.781314-1-robdclark@gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 4 Nov 2021 17:11:02 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xfv+X+X+KBM5yiJ0CdqyAPDKfOgsoZETb_7kmaHR1ztg@mail.gmail.com>
Message-ID: <CAD=FV=Xfv+X+X+KBM5yiJ0CdqyAPDKfOgsoZETb_7kmaHR1ztg@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/devfreq: Fix OPP refcnt leak
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 4, 2021 at 3:23 PM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> Reported-by: Douglas Anderson <dianders@chromium.org>
> Fixes: 9bc95570175a ("drm/msm: Devfreq tuning")
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/msm_gpu_devfreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
