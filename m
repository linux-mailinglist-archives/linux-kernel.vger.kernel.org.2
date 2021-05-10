Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 509A037797D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 02:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbhEJANe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 20:13:34 -0400
Received: from gloria.sntech.de ([185.11.138.130]:55884 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229853AbhEJANd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 20:13:33 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lftX4-00085c-Uk; Mon, 10 May 2021 02:12:23 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     xxm@rock-chips.com, robh+dt@kernel.org, will@kernel.org,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        joro@8bytes.org
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: (subset) [PATCH v4 0/6] Add IOMMU driver for rk356x
Date:   Mon, 10 May 2021 02:12:20 +0200
Message-Id: <162060552750.1271206.175954480906958099.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210507090232.233049-1-benjamin.gaignard@collabora.com>
References: <20210507090232.233049-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 May 2021 11:02:26 +0200, Benjamin Gaignard wrote:
> This series adds the IOMMU driver for rk356x SoC.
> Since a new compatible is needed to distinguish this second version of
> IOMMU hardware block from the first one, it is an opportunity to convert
> the binding to DT schema.
> 
> version 4:
>  - Add description for reg items
>  - Remove useless interrupt-names properties
>  - Add description for interrupts items
>  - Remove interrupt-names properties from DST files
> 
> [...]

Applied, thanks!

[3/6] ARM: dts: rockchip: rk322x: Fix IOMMU nodes properties
      commit: 6b023929666f0be5df75f5e0278d1b70effadf42
[4/6] ARM: dts: rockchip: rk3036: Remove useless interrupt-names on IOMMU node
      commit: 304b8fbc950bae102f29ee1e8e8557f2fd08d69a
[5/6] ARM64: dts: rockchip: rk3036: Remove useless interrupt-names properties
      commit: 2bf375982f4a58a95e8b5184565b23677900012c

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
