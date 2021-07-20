Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD413CFF66
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 18:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbhGTPrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 11:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236611AbhGTPjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 11:39:46 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18800C061794;
        Tue, 20 Jul 2021 09:19:53 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id y38so33522909ybi.1;
        Tue, 20 Jul 2021 09:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nMW7QBUIc/uDC2jb5O45C3Qll6tdxJ+z7OX5wmkMw7g=;
        b=Q4UxPB6017TkNDUlu96WZV4WEHOBpzJ+89Eh0JNRitvJD5X/GX4ogW1MJeJzjCkhMY
         AxOQU3HVBdXTXwtF61lcXnNkOASFi0o/30oFMWe8rPjhqC6wahIMZfjpaK5IPpjSLDWC
         FtmLW7obp3B4wYCxHVd98Q9xZrjbCxkHkVORCynQ1SKG2vlef3GTIIqGcI+i/5lO5151
         wManlFm/TAlP26oGaJbmNjCY77j3uKob9yi0cRllFsDOAX9/HdDDkwk57ePNBjSjx7Ek
         TPS/Y92Cn3TPvO19KM3RjN9MhOTbdLW+52xR/e/cvPcdybALLF2B9ZQHqIxKwwLnI++e
         umCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nMW7QBUIc/uDC2jb5O45C3Qll6tdxJ+z7OX5wmkMw7g=;
        b=fNh04oaEmycJF6u7/bdigN8NQePBruz+bsZ+Ix4Teoawtj99/c2gHZjIach9RMr+po
         y7J15kDVkc9wL3UIRRy3WeAgCunMpzrR4c+LmlULQH/a3A3F9s+MXYeLd2QaSIYomWv0
         JYPMfXEEKEWXqumNTwoujf4HmmSVjmGtmu7lHlSHRedeaHElsNcv33EyPuSVx3XsBRyf
         nSxmnTGBB8VH9Jfo5EoRYlorL0bpRiTYBuY1Z6B2v38d9AAfi/QQEy0fkDnQrUlPL6+R
         xyvN0eeILVB9IM2dIf71ZPJ2pyFYSdKG+ISUGd57K7sJh0fb5GI16gttOgAiWonqRpyo
         6F2A==
X-Gm-Message-State: AOAM533xUVFIFepwZyhABRaJ+nUwiaiZGqs3SwSiSzcDHEIVtBQ69AcT
        W/IdlwOuQpFa4S18hJT7m+7dCgkqldTrdQC+K5o=
X-Google-Smtp-Source: ABdhPJzR4XdNVwzV7TKxaqvAxwEUOvvE4adIQZkFpm5PJxC9fP7zQf5S1/gxJJQ58sE09rAZMdpjjLkcd6uA7x4DPEk=
X-Received: by 2002:a25:b706:: with SMTP id t6mr40461892ybj.174.1626797992258;
 Tue, 20 Jul 2021 09:19:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210710151034.32857-1-pgwipeout@gmail.com> <20210710151034.32857-5-pgwipeout@gmail.com>
 <20210715162131.GA1184545@robh.at.kernel.org>
In-Reply-To: <20210715162131.GA1184545@robh.at.kernel.org>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Tue, 20 Jul 2021 12:19:39 -0400
Message-ID: <CAMdYzYpXNdmHKBOOgC6DL-_7qrZyifnDPB=WuU0vAY8qPj1_ww@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] arm64: dts: rockchip: add basic dts for Pine64 Quartz64-A
To:     Rob Herring <robh@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Liang Chen <cl@rock-chips.com>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 12:21 PM Rob Herring <robh@kernel.org> wrote:
>
> On Sat, 10 Jul 2021 11:10:34 -0400, Peter Geis wrote:
> > Add a basic dts for the Pine64 Quartz64 Model A Single Board Computer.
> > This board outputs on uart2 for debug.
> >
> > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> > ---
> >  .../devicetree/bindings/arm/rockchip.yaml     |   5 +
> >  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
> >  .../boot/dts/rockchip/rk3566-quartz64-a.dts   | 321 ++++++++++++++++++
> >  3 files changed, 327 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
> >
>
> Acked-by: Rob Herring <robh@kernel.org>

Thank you!
I need to split the dt-bindings out into a separate patch, and the
quartz64-a dts has some mild changes.
Are you okay with me using your ack still?
