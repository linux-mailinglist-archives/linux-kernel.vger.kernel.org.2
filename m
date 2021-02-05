Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98303310384
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 04:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhBEDXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 22:23:47 -0500
Received: from mail-lf1-f42.google.com ([209.85.167.42]:41463 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhBEDXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 22:23:41 -0500
Received: by mail-lf1-f42.google.com with SMTP id a8so7820882lfi.8;
        Thu, 04 Feb 2021 19:23:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cYGMAdaRz8G1QUdS9+LomG6wtHz0qQi99/eTTuMLV+0=;
        b=WNGuQmEeSDk6Q8ZsHzFiFkYrL/hrbbtM7HwWDK9ip2uhlK8b4qRdlW5Ea1Lr/4yF71
         5Mtoj1kCeOvUXETveEuLNLdsp289LaSD17tiRpEEFZmIc0JhyAh49ST2trV2vC0Pfpgd
         3oqaMzu+Flo4xBy/iHX6NaaPxVvrliwa4jmDfikh+H4MFjj3IZqigToQmvlj/BMfPNkj
         3subI6/QjV4VlYIv4n3hJ+3Xz96tHg6kq2CIZf5GD3uHhMz+TuYHCBFK9PN13JRtcABW
         eZhdqUBC0db2CETvMY6P4xFL4ou30gJFgqmYkfehjxeE1F6EFvIsSFi5KS5sx3P30REp
         TgZQ==
X-Gm-Message-State: AOAM531wflf2ddEIwzVtaXwDAdbwFYsuawn9SiFFRD9rq+KeKSOs6KwD
        7BmCjVX+KvoXAgYfcuYs/0ofl8G9flh8cg==
X-Google-Smtp-Source: ABdhPJyRSrZot6iuSJMpbwrSrhADCDVPMUq6G80NwbWd/+WdX5mPgEj5k5RuROIZfh81IHbi+9+ZDw==
X-Received: by 2002:ac2:5f6a:: with SMTP id c10mr1311524lfc.216.1612495380162;
        Thu, 04 Feb 2021 19:23:00 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id e10sm830732lfs.304.2021.02.04.19.23.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Feb 2021 19:23:00 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id i187so7841687lfd.4;
        Thu, 04 Feb 2021 19:23:00 -0800 (PST)
X-Received: by 2002:ac2:5f56:: with SMTP id 22mr1458557lfz.296.1612495374946;
 Thu, 04 Feb 2021 19:22:54 -0800 (PST)
MIME-Version: 1.0
References: <20210204184710.1880895-1-jernej.skrabec@siol.net> <20210204184710.1880895-4-jernej.skrabec@siol.net>
In-Reply-To: <20210204184710.1880895-4-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 5 Feb 2021 11:22:44 +0800
X-Gmail-Original-Message-ID: <CAGb2v6524xO6dLnW4mKBjgfFkqbydPDmxJopqkZ53=uXdo3rCw@mail.gmail.com>
Message-ID: <CAGb2v6524xO6dLnW4mKBjgfFkqbydPDmxJopqkZ53=uXdo3rCw@mail.gmail.com>
Subject: Re: [PATCH 3/5] drm/sun4i: dw-hdmi: always set clock rate
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Andre Heider <a.heider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 5, 2021 at 2:48 AM Jernej Skrabec <jernej.skrabec@siol.net> wrote:
>
> As expected, HDMI controller clock should always match pixel clock. In
> the past, changing HDMI controller rate would seemingly worsen
> situation. However, that was the result of other bugs which are now
> fixed.
>
> Fix that by removing set_rate quirk and always set clock rate.
>
> Fixes: 40bb9d3147b2 ("drm/sun4i: Add support for H6 DW HDMI controller")
> Tested-by: Andre Heider <a.heider@gmail.com>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
