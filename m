Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 207F63F6BB8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 00:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbhHXWdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 18:33:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:44990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229482AbhHXWdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 18:33:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9960961220
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 22:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629844351;
        bh=10CR99EYOcsvAxA/Al3XzcQv8Nj0aWopUCUoKMem1aI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eZdREbvxJGaWnWCOe5A1PfaFfh/XlBVfjTXifmqJDLl/5AMmLfk9WBaV87ALhEtgZ
         DiBTDQzH+btFTaKMLsUePpKghcDQ0qoeLOVUf9H03QaPJZXaL2qavo+/IIDBXMmuvw
         DRJljmzht2nl9hkWv54Odc6wuXoHU6ikTBQTUhHMt0DMRt0jCj8C7vNnz7aw8/kOmz
         1plTeStOd3wYk7DMQpu8j/QGrR64YqGzl/XWyztzBJ+UkcPx8u3rWHsIVGvY3MEdDZ
         ci/U0y3h/10ddcNZyLr+OebXDZSx9d6zQiCwAcI0UYf6OgtWbhDINNmg5/xWJp/31+
         gxFunG9720K8Q==
Received: by mail-ej1-f51.google.com with SMTP id u14so22608133ejf.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 15:32:31 -0700 (PDT)
X-Gm-Message-State: AOAM532hsHo0GKxbH9dNaIph0SOytl5vcSlGpdEBHTw8PkoWXXtd6d5q
        VsmZ9RH8WcD6JPkBm9j/4fv+olBuH8ZbN7FfHg==
X-Google-Smtp-Source: ABdhPJwcT3E/+4reEOVVj9eK7xhPUpapFeT3ObUfnT1HAlL5ATW6K5J1ynlDlfctI2sMynrJHYKufcQCmtV5oFGR6PA=
X-Received: by 2002:a17:906:ff41:: with SMTP id zo1mr12446795ejb.525.1629844350263;
 Tue, 24 Aug 2021 15:32:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210824172614.7299-1-alyssa.rosenzweig@collabora.com>
In-Reply-To: <20210824172614.7299-1-alyssa.rosenzweig@collabora.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 24 Aug 2021 17:32:18 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+L7JRhcuy7vgPocGf48KeeW1wBXcw=MZ0r8h5FKHTZ5g@mail.gmail.com>
Message-ID: <CAL_Jsq+L7JRhcuy7vgPocGf48KeeW1wBXcw=MZ0r8h5FKHTZ5g@mail.gmail.com>
Subject: Re: [PATCH] drm/panfrost: Use upper/lower_32_bits helpers
To:     Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 12:27 PM Alyssa Rosenzweig
<alyssa.rosenzweig@collabora.com> wrote:
>
> Use upper_32_bits/lower_32_bits helpers instead of open-coding them.
> This is easier to scan quickly compared to bitwise manipulation, and it
> is pleasingly symmetric. I noticed this when debugging lock_region,
> which had a particularly "creative" way of writing upper_32_bits.
>
> Signed-off-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_job.c |  8 ++++----
>  drivers/gpu/drm/panfrost/panfrost_mmu.c | 12 ++++++------
>  2 files changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
