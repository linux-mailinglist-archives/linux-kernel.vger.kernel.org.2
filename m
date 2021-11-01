Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 959A5441FD9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 19:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbhKASQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 14:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbhKASLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 14:11:51 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186D9C061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 11:02:23 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id f10so14814807ilu.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 11:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AI0EGtO0fwy8ABQM2b3fEK3eUYU6jqjRFDdZhYpaGeo=;
        b=JY8uJTVzX0Ut5XrdC7dgInIh7GV7XogEtOsPZDF0iBibhsdEyA2fur4Td5p/bBfbP4
         oMAGLpI6qDbHoQvCijJI9XalSLExjH7lI1CJfN3K/r3kltW5RRKMIGLcxEp/0FDCQvzk
         J88GY6szvCD0jZogUoNp+4HFUlPG2WGbLBzpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AI0EGtO0fwy8ABQM2b3fEK3eUYU6jqjRFDdZhYpaGeo=;
        b=IpTPlEH6+J43jD6OZxSKZv7ZnoQXEMe8ZLkNz3WQ8c4m4N5H5s8tR/JaL8oGAnHlPB
         rZdggy1xol+dYQbFQ09AtRRMXmPVRdLeaJUUcrAJEtBUR8rXMHNzQw4aBWdpmImkJJUo
         kvmmCaW9kMeMEVDNLynl31wq89iPbrUCo2W4fo6BI8tpx743RhvcQIaeHeDGC+waQt0k
         +vf7NttKFb+w2h8MPNzc7DSaVKANXKDNF77sZX6HzmyS2dO6AojddC75yfrJrMUUgQZA
         b1O1cNS3p5VpNp5C44c/MB9I2qSI55JFCsMuXrei+FiBhClNGUXEkHuej8MuDvdrn6NL
         QcnA==
X-Gm-Message-State: AOAM531/ie7hIhFGufxGYj9YCK/tkRxkAxMXVmJXuFkN3tt4KH2zIygS
        3z3i1RLaAwnie/cGuIQwkJTF/fd7cb43dg==
X-Google-Smtp-Source: ABdhPJxs6VJYGmE0KGWZ5zRkoNZkRr90PyQHrzpjOh3rrJf+A/tctAi3YYNn6nlT3xFHoEm7b+HrsQ==
X-Received: by 2002:a05:6e02:13ca:: with SMTP id v10mr8896985ilj.140.1635789742233;
        Mon, 01 Nov 2021 11:02:22 -0700 (PDT)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com. [209.85.166.44])
        by smtp.gmail.com with ESMTPSA id f15sm302843ila.68.2021.11.01.11.02.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 11:02:21 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id p204so10936007iod.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 11:02:21 -0700 (PDT)
X-Received: by 2002:a5d:9753:: with SMTP id c19mr8257662ioo.136.1635789741166;
 Mon, 01 Nov 2021 11:02:21 -0700 (PDT)
MIME-Version: 1.0
References: <20211030100812.1.I6cd9af36b723fed277d34539d3b2ba4ca233ad2d@changeid>
In-Reply-To: <20211030100812.1.I6cd9af36b723fed277d34539d3b2ba4ca233ad2d@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 1 Nov 2021 11:02:09 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xoaypn6wy5mHfTneDrQYexGcdcaMqkSnPJf0YS=jHpPA@mail.gmail.com>
Message-ID: <CAD=FV=Xoaypn6wy5mHfTneDrQYexGcdcaMqkSnPJf0YS=jHpPA@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dsi: set default num_data_lanes
To:     Philip Chen <philipchen@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Bernard Zhao <bernard@vivo.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Oct 30, 2021 at 10:08 AM Philip Chen <philipchen@chromium.org> wrote:
>
> If "data_lanes" property of the dsi output endpoint is missing in
> the DT, num_data_lanes would be 0 by default, which could cause
> dsi_host_attach() to fail if dsi->lanes is set to a non-zero value
> by the bridge driver.
>
> According to the binding document of msm dsi controller, the
> input/output endpoint of the controller is expected to have 4 lanes.
> So let's set num_data_lanes to 4 by default.
>
> Signed-off-by: Philip Chen <philipchen@chromium.org>
> ---
>
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
