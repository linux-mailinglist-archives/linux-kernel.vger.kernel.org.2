Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1703F5084
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 20:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbhHWSnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 14:43:19 -0400
Received: from gloria.sntech.de ([185.11.138.130]:54046 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229962AbhHWSnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 14:43:09 -0400
Received: from dynamic-046-114-139-102.46.114.pool.telefonica.de ([46.114.139.102] helo=phil.sntech)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mIEtq-0002Jl-Fu; Mon, 23 Aug 2021 20:42:22 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Alex Bee <knaerzche@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Johan Jonker <jbx6244@gmail.com>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] arm64: dts: rockchip: Re-add interrupt-names for RK3399's vpu
Date:   Mon, 23 Aug 2021 20:42:14 +0200
Message-Id: <162974163915.2977894.410070798189660023.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210822115755.3171937-1-knaerzche@gmail.com>
References: <20210822115755.3171937-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Aug 2021 13:57:55 +0200, Alex Bee wrote:
> Commit a728c10dd62a ("arm64: dts: rockchip: remove interrupt-names from iommu nodes")
> intended to remove the interrupt-names property for mmu nodes, but it
> also removed it for the vpu node in rk3399.dtsi. That makes the driver
> fail probing currently.
> Fix this by re-adding the property for this node.

Applied, thanks!

[1/1] arm64: dts: rockchip: Re-add interrupt-names for RK3399's vpu
      commit: 6b9b7968ff78d5b9a079da2f8decba873af54192

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
