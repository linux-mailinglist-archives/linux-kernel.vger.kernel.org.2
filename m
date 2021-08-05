Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE5353E1424
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 13:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241149AbhHELwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 07:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241137AbhHELwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 07:52:21 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B362EC061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 04:52:06 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id a13so6307122iol.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 04:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f4GRvnSd2SfTisSbPOnvrb1AGqj2A6VfpqkuBFd8fVE=;
        b=RWa/9OFA5awZx3nilxSRf38QZA0f7ubdiVCjTcKfbkE6DezE9w4XMThdZXYqSnnP5q
         yLejaEgrb0dLym3yOlSQi8X7hH1DKT+OE/XS3F/GtWC18T+WO/5VvBhdl/6uIMAZYsEL
         Ey3GcEd+6nlnFLkN9iEACLdTqz/rTF7G78jbO9FNQrCtjIZtxQP7FZKEy4of+A+3S/xW
         hOk/2dfaPt1XYEcLvHDzfzp1ri5mWwCcp3JPcRN0KemjmPuMNHgec454Ea98OJbxoedd
         HoaSAJgbmS5FX08kMgqhGkl2kK/WXSX+Ay76zBA6ij4ju+SXFZ8u9ojXfeKUJGJPpmSX
         5zxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f4GRvnSd2SfTisSbPOnvrb1AGqj2A6VfpqkuBFd8fVE=;
        b=eBX6y2Uckcbih686FbOKQdkgUOJIKS7vfYTgUtCDYXCe5oOXwusFqHbU6zr9lYtqqG
         hpVckIM6nxg5ReZJCmKUtCpSdm1xeuPqXknAgnlxeK7h+QewzD46Jce4z4G9/f6Hv4mQ
         cviqdLCJ+9Rk+to5rX1rfdhru3xppxt+DX5dUe1mq7jNe44N65twPMCo/xSqrMGT/2I8
         SKnBRHl9liCz7HZW/Nrfux4Vj++0vWRf0JpDxRszzVJ4Ci7nbCTPID1B6qqCiqODeOop
         ejGhTlgBqMC7+pGtP3VGHLJ4w5kBq/cnooHBOGbMSunttPpxSc5flACo6U2i+BmrVvo0
         UxmQ==
X-Gm-Message-State: AOAM531sZIoxU8CxMOCnFqUWMtijnICOChJlXwK4F2tAHfKdpW/AZ4is
        Dp+xMx1uwwIlXNfTLP8+vqKiSQtU6odoYyBXtgicGQ==
X-Google-Smtp-Source: ABdhPJzGQPitS//icrJkZI9zrnhgfKCvXOkyoNpJVFRpO/Os1R43Br1+wcD58Q5kYse0TOwb7aERr1q8UeqA5ufhZCE=
X-Received: by 2002:a6b:ea18:: with SMTP id m24mr972480ioc.76.1628164326010;
 Thu, 05 Aug 2021 04:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210705053258.1614177-1-acourbot@chromium.org>
 <20210705053258.1614177-13-acourbot@chromium.org> <a0a8b9a1-df9e-0e30-9ce6-36759f707e27@collabora.com>
In-Reply-To: <a0a8b9a1-df9e-0e30-9ce6-36759f707e27@collabora.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Thu, 5 Aug 2021 19:51:55 +0800
Message-ID: <CA+Px+wVEpDazZP9gOV=5ANOKhV-k5GzbRWDWFMAJQO7_S=bgEg@mail.gmail.com>
Subject: Re: [PATCH v6 12/14] media: mtk-vcodec: vdec: add media device if
 using stateless api
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     Alexandre Courbot <acourbot@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Yunfei Dong <Yunfei.Dong@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Collabora Kernel ML <kernel@collabora.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2021 at 12:22 AM Dafna Hirschfeld
<dafna.hirschfeld@collabora.com> wrote:
> On 05.07.21 07:32, Alexandre Courbot wrote:
> > +             mtk_v4l2_debug(0, "media registered as /dev/media%d", vfd_dec->num);
> the media's node minor is not vfd_dec->num
IIUC, it should be vfd_dec->minor[1].  Will fix in the next version.

[1]: https://elixir.bootlin.com/linux/v5.14-rc4/source/include/media/v4l2-dev.h#L243

> >   struct mtk_vcodec_dev {
> This structs has a lot of duplicated fields for enc/dec
> Since the device represents either a decoder or an encoder,
> I think all those dupliactes can be removed, so for example
> instead of having both 'dec_irq' and 'enc_irq' we can have just 'irq'
I understand the struct may contain duplicate fields.  However I
prefer to separate the refactor into another series.  Would provide
the fixes later.
