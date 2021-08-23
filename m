Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 508E13F5083
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 20:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbhHWSnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 14:43:10 -0400
Received: from gloria.sntech.de ([185.11.138.130]:54050 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230511AbhHWSnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 14:43:09 -0400
Received: from dynamic-046-114-139-102.46.114.pool.telefonica.de ([46.114.139.102] helo=phil.sntech)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mIEtp-0002Jl-QA; Mon, 23 Aug 2021 20:42:21 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Alex Bee <knaerzche@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] arm64: dts: rockchip: Fix GPU register width for RK3328
Date:   Mon, 23 Aug 2021 20:42:13 +0200
Message-Id: <162974163915.2977894.9290643400538669916.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210623115926.164861-1-knaerzche@gmail.com>
References: <20210623115926.164861-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jun 2021 13:59:26 +0200, Alex Bee wrote:
> As can be seen in RK3328's TRM the register range for the GPU is
> 0xff300000 to 0xff330000.
> It would (and does in vendor kernel) overlap with the registers of
> the HEVC encoder (node/driver do not exist yet in upstream kernel).
> See already existing h265e_mmu node.

Applied, thanks!

[1/1] arm64: dts: rockchip: Fix GPU register width for RK3328
      commit: 3f1c9b99f22c4784bd6f439a63bbf8a61c0335b1

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
