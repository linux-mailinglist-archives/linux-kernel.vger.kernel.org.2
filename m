Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E74E3FC9B1
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 16:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236214AbhHaO1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 10:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233576AbhHaO1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 10:27:00 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349DCC061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 07:26:05 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id mw10-20020a17090b4d0a00b0017b59213831so2167236pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 07:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ysJARml9hvQhxWkQGnSee4N2rvgFLMKbDovp4lP2LPg=;
        b=CIerM5zaDu3bLrRJpOuATMcjNqRG0wlOpQrPsxVcyxfa2iOx7sdZArfmwf0y2rXRoe
         fEmQXMNWn+9/I4vkHRUcJ7zFupltTpHxoqW/7CZ5QpR47qkREE/5YZozs8DL7oppEGsa
         Ve0fMZdA2MR/pCnNmwUEtaCs2xKjK2jF5cif9F4XtoiB7IUs2GZSYPj97OvYbpBhin5F
         TJY5o4bOI4+Q1t2hy3CuK3rLZhFKL7pQO4kW4DrgaFkimLQyAKpzydtYIkj3xaBtqN9Z
         NrPfWWu8d5wgSVaDAHPa/6T0W21QfjWlSkIF1poYrys4414b9s+/C+PjJ3mibqOQyNti
         O8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ysJARml9hvQhxWkQGnSee4N2rvgFLMKbDovp4lP2LPg=;
        b=KwwTvNnBPsBUIJVDtLUnc2amzH/xyVLo/HyHqQX8tGRS0toS2A7tnMjDw+0F8XCFkE
         TUaAjLtnktSGL+TJ2D27ILaq+W5H8utl5IogC0D9M0Zs9wLHRLRdIXj8mZdZIZ/ZO6di
         wuW4b0ziV7mzDBU7Ydb5hIdvvM2VgBsFLFB1Rq9dmg9jP6qUrfiTuigeWxP9KxKnl4L5
         +jw0cwJkHNMHUhoVrfQYhLa0SGKZrijBTaJpMncuY3T6rmui/dncCJ1hbsy5EoxXDl4o
         tj+Zyv21mh/9X4sG5/R6XfVG/fUw9DlYp/gRvkFBsSMbylwPWAZBmE9j+vYbfjqmp7GN
         YnMQ==
X-Gm-Message-State: AOAM533Kv50/RZXkXWIc88uQcWYVo7HFIHqQKDKd2zXDPDdrkybUIseM
        XmoMyCqbej7xEYNqHsw/u29JIlFrQiJ93q3O8V4G4zC20cU=
X-Google-Smtp-Source: ABdhPJw85e6v2e4XdIa48zuxRlXebSpwS2wWM3qtUei3YMH29CKgSxWgYhYxZKgyJ2OO5TsAIkN+cZA5IWxX63J56aA=
X-Received: by 2002:a17:902:6b8a:b029:12d:3f99:9e5e with SMTP id
 p10-20020a1709026b8ab029012d3f999e5emr4996810plk.66.1630419964677; Tue, 31
 Aug 2021 07:26:04 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20210831135143eucas1p1bc6f6a6ca587818c1bb036a64723577c@eucas1p1.samsung.com>
 <20210831135048.4305-1-caihuoqing@baidu.com> <5ef0c227-555d-a12c-1685-ff43e43bdf97@samsung.com>
In-Reply-To: <5ef0c227-555d-a12c-1685-ff43e43bdf97@samsung.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 31 Aug 2021 16:25:53 +0200
Message-ID: <CAG3jFyvot4auJMVrndw_+DHhBsis05iuhTDzYYtyRHsD-GR12Q@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: cdns: Make use of the helper function devm_platform_ioremap_resource()
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Cai Huoqing <caihuoqing@baidu.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Aug 2021 at 15:58, Andrzej Hajda <a.hajda@samsung.com> wrote:
>
>
> W dniu 31.08.2021 o 15:50, Cai Huoqing pisze:
> > Use the devm_platform_ioremap_resource() helper instead of
> > calling platform_get_resource() and devm_ioremap_resource()
> > separately
> >
> > Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

Applied to drm-misc-next.
