Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5F01356602
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 10:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244423AbhDGIDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 04:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242867AbhDGIDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 04:03:34 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652B8C061764
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 01:03:25 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id il9-20020a17090b1649b0290114bcb0d6c2so859735pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 01:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ysz6P9xATvW1FQeoAOxq6tV62TCAmsjSNij/bztrdn4=;
        b=o/5LMQjagAvllv1FW0C6iohuW9mW4dBaVhOXr1Pk7pWDq/KE9mX65b5nA1Bzzanwag
         +RFpkpi0XGmLVFT91DQDCvQKT4tET0B5Z7Hi76NP/5DKkaCqlC4MKNWASCjUUaKetbNd
         BQOHpOmEoY21qIanN+h5LV1NofcYVG7xEZ2yWxxEsAZMtcGcVrZZvxHf1K4Q2IQFd/48
         t7o5UpDN8V1e9BYOJK95cVEfQCVHkyivPxGu7I7FCEDWORgOHDTupcNJdSQx/4JbEXYc
         Fqvbp3dZWYyPqm/TSlCHOMZCXKzbyG0gazYDS9Xie6FUMDuQ8wAmnXab8OUYrXPU8HXd
         xMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ysz6P9xATvW1FQeoAOxq6tV62TCAmsjSNij/bztrdn4=;
        b=rIAc4OULdPmk30r6Vem+vaIwgmGX3hV5UnPF4lGaJVL/S3r0M4+nhdbvnXPg93c7U/
         ctwsr8ZY9eRuU2fzUowpndxgm78CZpQ8KVCj9jRT2wD3326Mq68Bur+YcYVLnwgvplqH
         h0sqkO/ochyXKt8HjBS7AveT2YmeR5Ez91eUCXwQeh3Wi+eQ512Vmb25tjKmEDaWxak6
         X8fo6M0Vyqo61v5a4MIafbSJPwPueqU97Td3FdR8A+NNg51jq+tmTWah9BO1XzfnubjD
         oHc8dNrAw8/mmloI8Crr8L7CBx5L2sFCf3Rn/zgNOtKsnteF7526SPshr+MHg/eKTb7E
         2VNQ==
X-Gm-Message-State: AOAM533IigJdcUj0mjaUabYsOGWN8h9n3N55+H2dVxvP0FlvQTFiwEE9
        bC1b3Qm82yf9q0K+GfG/ODu/H/TnRJSuru90a4KCJw==
X-Google-Smtp-Source: ABdhPJzF+g42/bKDLTlY9qetsSZrUD78KLNgSN+3VIfx1JGyGKvSj7fv3RYuv3ijxVh8hTfZTwZjsRTHMV6cgV2emXY=
X-Received: by 2002:a17:90a:4a8f:: with SMTP id f15mr2168432pjh.19.1617782604872;
 Wed, 07 Apr 2021 01:03:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210406090733.169989-1-zhangjianhua18@huawei.com>
 <CAG3jFyvC6ozPxQ=TPdPgLAugKky5AhOZGJSiw0Dc3Kn5Pba0cA@mail.gmail.com> <d9bd5abf-0293-6155-dee0-20199fed1fc0@huawei.com>
In-Reply-To: <d9bd5abf-0293-6155-dee0-20199fed1fc0@huawei.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Wed, 7 Apr 2021 10:03:13 +0200
Message-ID: <CAG3jFyu6YY5pr5bdvqAbzZu0GG0z=PWP+JHL59G26cg0P=563w@mail.gmail.com>
Subject: Re: [PATCH -next] drm/bridge: lt8912b: DRM_LONTIUM_LT8912B select GPIOLIB
To:     "zhangjianhua (E)" <zhangjianhua18@huawei.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        johnny.chenyi@huawei.com, heying24@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, you are right, there are many files reference
> gpiod_set_value_cansleep() and
>
> devm_gpiod_get_optional(). How about add config dependencies for all
> releated

I think this is the way to go and roughly half of the drm bridge
drivers seem to need this change.

Do you mind submitting a series of patches adding this fix for all of
the relevant bridge drivers?

>
> configs or only add config dependencies for the top level config?
>
