Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F7F30D44E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 08:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbhBCHvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 02:51:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:53352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231654AbhBCHvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 02:51:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF4CC64F5C;
        Wed,  3 Feb 2021 07:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612338619;
        bh=9ZnPLFWxyuVetTdyZ2rsor+35zbCTQFmm3ShxD+mVqY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Gk5Bf9vdAcFYZzrPCyBBs5JrE83AKH5RSA9ClK3d+bPSj2wT+GMLKpmU35yKDEGzF
         RqLH6eYza5hwa9/ZpkTBpaoAStu1czKkIsQmshE9agjqnQppsagQziPWaQT6zHsB9d
         fNbel7y62aBzWivivTNxebUiHYluvB7u5hfaayoIQc5gD8NmyFzYmMPZSye+5hk6dh
         xerO5y8MVAf+ta7wU9PtjmKby6wKSSeMw2GFFsDLTiNNimo4nJLUUymRZG++1wm6OM
         Vif/QsyHtskqdhjysIml3SY3SNDnmUfc3EeD19oSEZOQmBIFuu+vYvfs0okleOtKyH
         52zvt+EF7Eakw==
Received: by mail-ot1-f48.google.com with SMTP id 36so22506269otp.2;
        Tue, 02 Feb 2021 23:50:19 -0800 (PST)
X-Gm-Message-State: AOAM5321eBWz14p0TYq0hy+PAEwNAA8kx2IlPkH9PDw2rP4BeWAwyNEV
        dgCQZT0byRQ3qYmwxK0FpPzEGGv5TtnlJp6b3O8=
X-Google-Smtp-Source: ABdhPJx2IAIFAijainQxsZvUjR94cQY1A0IfXD4DaJu5Y/wvAhddYXhrBd+YScXteK8LRmPUQLLJcnZSKhSCQmfhgtI=
X-Received: by 2002:a05:6830:1256:: with SMTP id s22mr1221124otp.251.1612338618909;
 Tue, 02 Feb 2021 23:50:18 -0800 (PST)
MIME-Version: 1.0
References: <20210117180301.1956-1-alistair@alistair23.me> <20210117180301.1956-3-alistair@alistair23.me>
 <20210129071341.GH4356@dragon> <CAKmqyKOoTG+BGhRFtppQxnaV61GFxXXhmZJcxqGQVbnuV1PfqA@mail.gmail.com>
In-Reply-To: <CAKmqyKOoTG+BGhRFtppQxnaV61GFxXXhmZJcxqGQVbnuV1PfqA@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 3 Feb 2021 08:50:02 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1ZLuDTKY6YbPrcM338K4vmAgESeBiNwWN7VaWj2PtKFg@mail.gmail.com>
Message-ID: <CAK8P3a1ZLuDTKY6YbPrcM338K4vmAgESeBiNwWN7VaWj2PtKFg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arch/arm/configs: Enable VMSPLIT_2G in imx_v6_v7_defconfig
To:     Alistair Francis <alistair23@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Alistair Francis <alistair@alistair23.me>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 3, 2021 at 3:37 AM Alistair Francis <alistair23@gmail.com> wrote:
>
> On Thu, Jan 28, 2021 at 11:13 PM Shawn Guo <shawnguo@kernel.org> wrote:
> >
> > On Sun, Jan 17, 2021 at 10:03:01AM -0800, Alistair Francis wrote:
> > > The reMarkable2 requires VMSPLIT_2G, so lets set this in the
> > > imx_v6_v7_defconfig.
> >
> > Hmm, why is VMSPLIT_2G required by reMarkable2?
>
> I'm not too sure. It's difficult to debug problems as I only have a
> UART but without this I don't see any kernel prints so it seems like
> the kernel doesn't get very far. I haven't had any luck with earlycon
> on the device so I don't know how I can get more information.

In the dts file, I can see that the machine has 1GB of RAM at
contiguous addresses. My first guess would be a problem with
highmem, as this configuration means that with VMSPLIT_3G
there are 768MB of lowmem and 256MB of highmem.

Can you try these two things to narrow the problem down
further?

a) disable CONFIG_HIGHMEM when using VMSPLIT_3G
b) use VMSPLIT_3G_OPT

If both of them solve the problem, then highmem is likely
the root cause. One possible issue might be that the boot
loader loads the initramfs or the dtb into a location outside
of the first 768 MB of lowmem where it is unreachable
in the VMSPLIT_3G configuration.

        Arnd
