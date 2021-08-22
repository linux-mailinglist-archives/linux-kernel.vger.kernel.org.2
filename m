Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 689A73F4179
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 22:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbhHVU0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 16:26:24 -0400
Received: from gloria.sntech.de ([185.11.138.130]:46446 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229654AbhHVU0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 16:26:23 -0400
Received: from p5b036204.dip0.t-ipconnect.de ([91.3.98.4] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mHu2E-0005lA-2D; Sun, 22 Aug 2021 22:25:38 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Alex Bee <knaerzche@gmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     Rob Herring <robh+dt@kernel.org>, Johan Jonker <jbx6244@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: rockchip: Re-add interrupt-names for RK3399's vpu
Date:   Sun, 22 Aug 2021 22:25:36 +0200
Message-ID: <24767661.6Emhk5qWAg@phil>
In-Reply-To: <CAAEAJfDLvctAk3omLgFBBbzvufFKwSW5_cQZ+MjvyN4khGOe_w@mail.gmail.com>
References: <20210822115755.3171937-1-knaerzche@gmail.com> <CAAEAJfDLvctAk3omLgFBBbzvufFKwSW5_cQZ+MjvyN4khGOe_w@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Sonntag, 22. August 2021, 16:37:24 CEST schrieb Ezequiel Garcia:
> Hi Alex, Heiko,
> 
> On Sun, 22 Aug 2021 at 08:58, Alex Bee <knaerzche@gmail.com> wrote:
> >
> > Commit a728c10dd62a ("arm64: dts: rockchip: remove interrupt-names from iommu nodes")
> > intended to remove the interrupt-names property for mmu nodes, but it
> > also removed it for the vpu node in rk3399.dtsi. That makes the driver
> > fail probing currently.
> > Fix this by re-adding the property for this node.
> >
> > Fixes: a728c10dd62a ("arm64: dts: rockchip: remove interrupt-names from iommu nodes")
> 
> AFAICS a728c10dd62a removed lots of interrupt-names properties
> from devices other than IOMMU.
> 
> Maybe it's best to revert it?

where did you see more mistakes in it?

I.e. first of all, at least when grepping through my kernel history, I only see
  commit 53a05c8f6e8e ("arm64: dts: rockchip: remove interrupt-names from iommu nodes")
with a different hash and at least there I see a lot of iommu interrupt removals
and this one line removing the vpu irqs in error.

So from my glance at it, applying Alex' patch should solve the issue?

Heiko


