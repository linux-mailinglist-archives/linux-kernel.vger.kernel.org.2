Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92EE4310386
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 04:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhBEDYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 22:24:02 -0500
Received: from mail-lf1-f49.google.com ([209.85.167.49]:40890 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhBEDXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 22:23:50 -0500
Received: by mail-lf1-f49.google.com with SMTP id v24so7832277lfr.7;
        Thu, 04 Feb 2021 19:23:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tH2dcjVQVPFUlZ3icB7ec2l1YXyIMMEv/uggANC4SPw=;
        b=Av0fJLWO+C+C9j4A5M/sXlXOQiyWPGCCXOFs7oMOpotVplYk6kPYPLj7z6XaVBWP6V
         fYy5mR73v6Kcvl7NeEI8Z/iqr9Kvsj5KJUrhbFBJJl9wZtLOyQxA5diJ9re0ucVy5eii
         RZd17yLDV9Uy8h/wn6nPYn2IPhUjVRhct3zxlGHeR703fC582r1Lj1O+fF2D7atftDEG
         jXacNTvoawxa8xwwPUmw0/fQ6YUPlVm5aDE0op5DQWHmeUy4Ux1umVLAhxNl9h/QLVJM
         02z0h8zEoG91iM9MOFW7Of3IaHUwcHhmWbSsY733r9QJOQPHEdLQRbt2T1V88yrFQTDK
         O+Kg==
X-Gm-Message-State: AOAM533v8TVi5Qbu2y82qFszsq0+dqxfClhZzRywhPpKVtGiGMrszTiU
        oB1Vxc8QkXguMh0EbBRDqZdfXspqmmq7ag==
X-Google-Smtp-Source: ABdhPJw2NdfZjrn7qChoR8+chKWNlpS/HKXD74iyJ4NfsZUyp20KtzCUFSu1KA+JACz5qenqDjbSSw==
X-Received: by 2002:a19:c217:: with SMTP id l23mr1365244lfc.263.1612495387485;
        Thu, 04 Feb 2021 19:23:07 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id z2sm829635lfd.142.2021.02.04.19.23.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Feb 2021 19:23:07 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id f19so6065896ljn.5;
        Thu, 04 Feb 2021 19:23:06 -0800 (PST)
X-Received: by 2002:a2e:88c1:: with SMTP id a1mr1543946ljk.74.1612495386836;
 Thu, 04 Feb 2021 19:23:06 -0800 (PST)
MIME-Version: 1.0
References: <20210204184710.1880895-1-jernej.skrabec@siol.net> <20210204184710.1880895-5-jernej.skrabec@siol.net>
In-Reply-To: <20210204184710.1880895-5-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 5 Feb 2021 11:22:56 +0800
X-Gmail-Original-Message-ID: <CAGb2v64BpizczmSJdompGosFwWWayNscWvW-7oARLgwNNo=teQ@mail.gmail.com>
Message-ID: <CAGb2v64BpizczmSJdompGosFwWWayNscWvW-7oARLgwNNo=teQ@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH 4/5] drm/sun4i: Fix H6 HDMI PHY configuration
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
> cpce value for 594 MHz is set differently in BSP driver. Fix that.
>
> Fixes: c71c9b2fee17 ("drm/sun4i: Add support for Synopsys HDMI PHY")
> Tested-by: Andre Heider <a.heider@gmail.com>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
