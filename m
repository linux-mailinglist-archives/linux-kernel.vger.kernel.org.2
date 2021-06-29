Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D97B3B6D6E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 06:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhF2EVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 00:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbhF2EVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 00:21:52 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06B3C061760
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 21:19:24 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id k16so24953700ios.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 21:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T3qE6ClclvZmXMsxggvUPTF0EehyJNL1Noojj5cr7UM=;
        b=O+eMyEdFQjVux0r8wDwpu0udj8DZYWYCef7lAmU3YwXnc0LzhjgXT7eHEEi/YS1Dvp
         StYthzrnf98eK+oTs6iKE0z66wKcgEEHIZDfe0qN9/0aSNFtPa8HgGXrXkivh6TOVcYt
         zj/iOjHElIuXXzh2P1CyYaYleLk1y2cKQXFX5EikvDgVTG29Y8Vxfdq7qeKytI2whPF4
         D49m2aDYYpDVt7VeNwCks+P7IYbqzo9m/EN49ps21v+Me6CTsfY7nDr2OOGneMzWeTQ1
         mb0EICF11wX4gmOfu3SbZsQvIdEtgq/EvLcrKyOSBRyiXCzIZq/1kv9vSHv8YPwbRAUp
         +dMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T3qE6ClclvZmXMsxggvUPTF0EehyJNL1Noojj5cr7UM=;
        b=pXqlWmRADo6B1Drn0BiSRsx2WwiSrK18DeXauj4xt8fs37RVP3dL4LIVrpyPiAZyXt
         IyscLP+w0DYtF/z5yiexZEk+japFNTLdUssArrMjVHvGXxV5XXrFZvng5pTqby8aGwhW
         N1ru8PYfo5KlXft/weKwfO0IHRqP+hqLXobYE3AFYE4K4ce4by6dAX+IznfYuOVW6iR0
         fmTZ+AFK2Znrg5p2ft04OJ5iRgxe+SWuWqjpqQ/t8a1qGSkM8YUexAesNSmHLwnznhSY
         FkWDrh04WcDXe5nYMbalh0DsdwvEDNVlxUj8T8Q4GAsiV/Y+LP8V4gDvmO7Zzlowg1y0
         Mnyw==
X-Gm-Message-State: AOAM5319XkpkNuxyvTdmIhnbE+n511aygkgdcWyF2mkHx/YXpcUAb9qL
        8arxbr7CXFrlHN3QO+v3invcPNmqiHsdlxnSFR/Rpg==
X-Google-Smtp-Source: ABdhPJwQrGwDnkfRKF30NiG2OP/q/WmFBZnXNe9cvWBWTWVauL3qA3P0SA2hl7b3R+aSH3FjlH67uaVD3PF4G+XG/oI=
X-Received: by 2002:a5d:840c:: with SMTP id i12mr2208007ion.185.1624940363410;
 Mon, 28 Jun 2021 21:19:23 -0700 (PDT)
MIME-Version: 1.0
References: <1623122200-1896-1-git-send-email-kewei.xu@mediatek.com>
 <1623122200-1896-3-git-send-email-kewei.xu@mediatek.com> <54301510-e0d5-0762-1979-b194b8fd5eb8@gmail.com>
 <1623206624.14050.10.camel@mhfsdcap03>
In-Reply-To: <1623206624.14050.10.camel@mhfsdcap03>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Tue, 29 Jun 2021 12:19:12 +0800
Message-ID: <CA+Px+wU8qqEDU+bV0QpoJssNOxebutzRGgHo6WpC9VFJwckKKQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] i2c: mediatek: Dump i2c/dma register when a timeout occurs
To:     Kewei Xu <kewei.xu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>, wsa@the-dreams.de,
        robh+dt@kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        srv_heupstream@mediatek.com, leilk.liu@mediatek.com,
        qii.wang@mediatek.com, qiangming.xia@mediatek.com,
        liguo.zhang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 9, 2021 at 10:44 AM Kewei Xu <kewei.xu@mediatek.com> wrote:
>
> On Tue, 2021-06-08 at 16:01 +0200, Matthias Brugger wrote:
> > Is this offset only for mt8192 or also for mt8183?
> > In any case that should go in as another patch. Either a fix or a new
> > mt_i2c_regs_v3[]
>
> This offset value is suitable for the IC of mt_i2c_regs_v2 hardware
> design similar to mt8192/8195, not for 8183.
>
> The reason for the modification here is that the previous
> offset information is incorrect, OFFSET_DEBUGSTAT = 0XE4 is
> the correct value.

Please submit another patch for fixing the incorrect value.
