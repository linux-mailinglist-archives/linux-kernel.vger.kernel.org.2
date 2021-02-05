Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D950310388
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 04:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbhBEDYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 22:24:23 -0500
Received: from mail-lf1-f41.google.com ([209.85.167.41]:39667 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhBEDYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 22:24:17 -0500
Received: by mail-lf1-f41.google.com with SMTP id h7so7844205lfc.6;
        Thu, 04 Feb 2021 19:24:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lBhQgpWYfLW4RX9Ru6N2PlBwZejRwOZ4EQOVez/Xssg=;
        b=hUgnqTFEgz6c9Md7pD01PBTa2M+pzZb115r6ykNUNdL4Msji6h2CZnr/XKBjODtasB
         MIHOm0qHURkcyyb62J//FJMHCjB1Ib9ZzbVvxoKwKihqO79B6zKc05Gb4KkD/P8UwsfR
         F8M4FsS7VItWotM+c8ascaHO1RJHpU6jzSyLLblyCF4VbVOUCzj0xLJI1/riMtIWKmqY
         g3iNqBn477CNS/GXXYeZe4x62zHmK0y/3Czf9t/jvnpkt7s/qEQD9DV2zZTrl9Ub2Mx2
         AZFecBk+pRSYnNDDmrQFsqtXm96bjbTfIgZSFQC+mIpnlX2De/LaWIFcxMJ32X6AHwfb
         p0og==
X-Gm-Message-State: AOAM531B9Hil2YPOKSJqQze6lQ1BbS4XNzFPw5omwTdBBLPs4N4A3LQG
        HK/9uK5EVUUYdLLBGO9AP89emLOODZT6Tw==
X-Google-Smtp-Source: ABdhPJwf0Fy/99hSyFPNtSBBqFnO+jBpTdKMFXKbG6XwOkNvuRpeQCp3htlpTWBEJrRNTGsHuOy0aw==
X-Received: by 2002:a05:6512:2287:: with SMTP id f7mr1348404lfu.40.1612495414961;
        Thu, 04 Feb 2021 19:23:34 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id s8sm871434ljm.71.2021.02.04.19.23.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Feb 2021 19:23:34 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id t8so6029381ljk.10;
        Thu, 04 Feb 2021 19:23:34 -0800 (PST)
X-Received: by 2002:a2e:9890:: with SMTP id b16mr1389484ljj.488.1612495414322;
 Thu, 04 Feb 2021 19:23:34 -0800 (PST)
MIME-Version: 1.0
References: <20210204184710.1880895-1-jernej.skrabec@siol.net> <20210204184710.1880895-6-jernej.skrabec@siol.net>
In-Reply-To: <20210204184710.1880895-6-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 5 Feb 2021 11:23:24 +0800
X-Gmail-Original-Message-ID: <CAGb2v65VauNZaxWgayp0BdGxm=Kbb3LF-YXarx9gFZmPYP8B-g@mail.gmail.com>
Message-ID: <CAGb2v65VauNZaxWgayp0BdGxm=Kbb3LF-YXarx9gFZmPYP8B-g@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH 5/5] drm/sun4i: dw-hdmi: Fix max. frequency
 for H6
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
> It turns out that reasoning for lowering max. supported frequency is
> wrong. Scrambling works just fine. Several now fixed bugs prevented
> proper functioning, even with rates lower than 340 MHz. Issues were just
> more pronounced with higher frequencies.
>
> Fix that by allowing max. supported frequency in HW and fix the comment.
>
> Fixes: cd9063757a22 ("drm/sun4i: DW HDMI: Lower max. supported rate for H6")
> Tested-by: Andre Heider <a.heider@gmail.com>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
