Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5103A6BF0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 18:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbhFNQgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 12:36:53 -0400
Received: from mail-yb1-f174.google.com ([209.85.219.174]:36386 "EHLO
        mail-yb1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234687AbhFNQgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 12:36:48 -0400
Received: by mail-yb1-f174.google.com with SMTP id c14so16319972ybk.3;
        Mon, 14 Jun 2021 09:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zHVS3WQaKuRcUSo80HfryOgVHqso0RV0aNtGn7MfbhE=;
        b=rDVduRpXgoSSl3osXLP/sZ3zt0F4WWMSDICVgNB4Yz7xzPcwGufou7Ylpl7580K08F
         75oGhdoX+V5fjSPNCQTmFj/vv0k46JByxPpgBoyZGy7Fzx9Qi6Z6cGXAMibgACtxPHKQ
         XX2maEf5yhqYS+TUuHNfOp44G1SZqtdUWQDXydZeSQnRsc9EFEW5boZ8uqBpSlGycAvm
         3lZ24J4z+tHhsLc/qyBL79yZYURZNGfqMq88EwY43c++2ka1DHrZ1VB2Imd4D+7O2Igu
         TbLkHMCZu+0MA2mCm35sB+sBOvuAFKiNxsjN1VtKHE0ZNDEEGApd9N4CmcPig2frm6AX
         59aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zHVS3WQaKuRcUSo80HfryOgVHqso0RV0aNtGn7MfbhE=;
        b=WffZ1if/avJg1WeYsaVjzOHIQsO5V4telW7gV2f/szINCfxT54cpDsLtQ8c2HmluoE
         OA6J/Xg8ceuJvMyG/DKG+fmx9hj4oOy5UG6lUIS1YQrPIdtYfFklBUAOjuE1ztmBDMT6
         d1LB0woI97hrHJ6CSjVVOjLilUsROHdKqWhx9rrMSdirr6/u3Z7iC+vRCLSBnT7KgGcA
         0+FojC2+MLfEdUbBi2ihYFspUkgQL93OsEqmA/4FM2xL5mM4bffiywOxFXUO7eHxylO2
         LL8zp/4eq+9UDb6qo0UJAf84PESMxiOiqQJi/k+wJ6vfHwRpfdlm2Rq8TLdHB/jSd86w
         Yxew==
X-Gm-Message-State: AOAM531jyR8ZZ3RsV8i2m3a3DVB5nFUuo0K5B3tz5l7NHMWuPM7cWHMH
        XnhZQCfIrp5g2EA0exRTcGiXj1IACLNGRwtwarg=
X-Google-Smtp-Source: ABdhPJzA67sc555Y0IeG6J9Praw2nvtaHL9QvVpvvkuC9U1BVja5RKTrDUy3oepwkIKt/Dh7z1aR3p6V9pb3FvTgfiM=
X-Received: by 2002:a5b:303:: with SMTP id j3mr23934839ybp.433.1623688424841;
 Mon, 14 Jun 2021 09:33:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210614154359.805555-1-benjamin.gaignard@collabora.com>
In-Reply-To: <20210614154359.805555-1-benjamin.gaignard@collabora.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Mon, 14 Jun 2021 12:33:33 -0400
Message-ID: <CAMdYzYq3ZYb-FA-SWmbgeUKk3gikNjz7Efc3rbLBxS9Erhb1yg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add USB2 support for rk3568
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     kishon@ti.com, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good Afternoon,

This was a hack just to get it to bind.
If you'll notice I've posted a second revision that works better, but
still is untested against anything other than the rk356x.
https://gitlab.com/pine64-org/quartz-bsp/linux-next/-/commit/51612157d7ae3f3c4267ed56676f5d1a952d698f

Very Respectfully,
Peter Geis

On Mon, Jun 14, 2021 at 11:44 AM Benjamin Gaignard
<benjamin.gaignard@collabora.com> wrote:
>
> The original pacth from Peter Geis is here:
> https://gitlab.com/pine64-org/quartz-bsp/linux-next/-/commit/cda136f853628259198d6f70c3e14c9e5c8e097f
>
> I have split the driver part of this patch in two:
>  - one to update reg usage
>  - one to add USB2 support for rk3568
> I have added patches for the bindings:
>  - some clean up
>  - add compatible for rk3568
>
> Benjamin
>
> Benjamin Gaignard (4):
>   dt-bindings: phy: rockchip: USB2: remove useless #phy-cells property
>   dt-bindings: phy: rockchip: USB2: Add compatible for rk3568
>   PHY: rockchip: USB2: Allow 64 bits reg property
>   phy: rockchip: USB2: Add support for rk3568
>
>  .../bindings/phy/phy-rockchip-inno-usb2.yaml  |  3 +-
>  drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 85 +++++++++++++++++--
>  2 files changed, 78 insertions(+), 10 deletions(-)
>
> --
> 2.25.1
>
