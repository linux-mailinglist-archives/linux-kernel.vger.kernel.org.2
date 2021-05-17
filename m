Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D38A8382783
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 10:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235759AbhEQIwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 04:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235621AbhEQIwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 04:52:18 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7EAC061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 01:51:01 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id t30so4172107pgl.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 01:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k+uEjOsRVN+pB4hd2Muc710zjpcCWqHrlB6JKHzbhcY=;
        b=KLty9evHZn7EqkaXSGojnk/JkLocOwV9WBKIv6wjz6wqMacqatsoZsjKr/h18icLRL
         kGOLBubiPNaDvwnJ+hgtDXvazKFQZUXKPKgA8iXbsDr5HX7E+uJohavKcsQK5E9rgu8N
         3MtizK9b6y32icZaGcR2zQQ133uaozrUCxA3ulSuV+R3EFJ+s6IJZctfjTqF++CdJnf6
         oK/7zJUxqS/3WVv5tHjMA7ukIUzaEBvgmax4dCCyOlg6Q0t6X/6Zz9iwUxhJL6rLOsI6
         aLB3mn5cVrgxZ6RkweOsuKDT8RqyF2uPfg6FIAKQU+ZRM1QUSVODE6d1C5IIEnp1VSsM
         +fEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k+uEjOsRVN+pB4hd2Muc710zjpcCWqHrlB6JKHzbhcY=;
        b=kA1le9lhBr8oIiqNKnyxzCHWs6CAdDkzAESOBVqQioOuMrSaiv2NbKXaJLVT1kIFyM
         84jaqy3E4uDhSzKU2m37nmWH29NsdF7JjatanoZr0AsuGURaHIQM3vODLvDYOhyUkUMt
         HGu/wSBC9qS07tcvAYJHrVebz4oVc1dhHmzxLf8AF/8uVK9OVCzxaitBfE0aslSGh8HK
         EavYFAdSsz736W+Gyb98Ncdlw53cnOn6jymb3uF+mIQFzQj/l8Iq7bUmyRUcrgDFvLu5
         ztJe5xWhna4dFkKlPAeNri6jJfNNyunN8wLn1dzfrdo43n24ZTLAYQYC+8W/FKmHXpz+
         Y8zg==
X-Gm-Message-State: AOAM532dVakBnxN9ZNQ11QcPPDqk8VhuRk4rrSHtFYLz38ogPXzVMECu
        rJW4qa7Wh/+jy+ZOgIwlNZ/TuQvxpDWDUdU7P62tHw==
X-Google-Smtp-Source: ABdhPJxhAX1QS/4ah6ZYhzP6xMO7Wq4GVZTq8fM0zlwsOJynQnZxRoAuZGB5c/lI8spDb81X2Q6oAsOgVtUh17oh6T0=
X-Received: by 2002:a63:1054:: with SMTP id 20mr7243032pgq.120.1621241461009;
 Mon, 17 May 2021 01:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <1620801955-19188-1-git-send-email-zou_wei@huawei.com>
In-Reply-To: <1620801955-19188-1-git-send-email-zou_wei@huawei.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 17 May 2021 10:50:50 +0200
Message-ID: <CAG3jFyvfO0L3JczeWZVE7hbcxL9rw3ub7=nQ2H1nkYkmhZz4RA@mail.gmail.com>
Subject: Re: [PATCH -next] drm/bridge: lt9611: Add missing MODULE_DEVICE_TABLE
To:     Zou Wei <zou_wei@huawei.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Zou,

On Wed, 12 May 2021 at 08:29, Zou Wei <zou_wei@huawei.com> wrote:
>
> This patch adds missing MODULE_DEVICE_TABLE definition which generates
> correct modalias for automatic loading of this driver when it is built
> as an external module.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>  drivers/gpu/drm/bridge/lontium-lt9611.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/bridge/lontium-lt9611.c
> index e8eb8de..29b1ce2 100644
> --- a/drivers/gpu/drm/bridge/lontium-lt9611.c
> +++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
> @@ -1215,6 +1215,7 @@ static struct i2c_device_id lt9611_id[] = {
>         { "lontium,lt9611", 0 },
>         {}
>  };
> +MODULE_DEVICE_TABLE(i2c, lt9611_id);
>
>  static const struct of_device_id lt9611_match_table[] = {
>         { .compatible = "lontium,lt9611" },
> --
> 2.6.2
>

This looks good to me, I've picked this change into drm-misc-next.

https://cgit.freedesktop.org/drm/drm-misc/commit/?id=8d0b1fe81e18eb66a2d4406386760795fe0d77d9
