Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 895343C3FF4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 01:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbhGKX3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 19:29:07 -0400
Received: from gloria.sntech.de ([185.11.138.130]:54638 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229793AbhGKX26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 19:28:58 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1m2ipr-0000zL-1V; Mon, 12 Jul 2021 01:26:07 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: dts: rockchip: remove interrupt-names from iommu nodes
Date:   Mon, 12 Jul 2021 01:26:01 +0200
Message-Id: <162604593565.371932.12289465831891986359.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210711143430.14347-1-jbx6244@gmail.com>
References: <20210711143430.14347-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Jul 2021 16:34:29 +0200, Johan Jonker wrote:
> The iommu driver gets the interrupts by platform_get_irq(),
> so remove interrupt-names property from iommu nodes.

Applied, thanks!

[1/2] ARM: dts: rockchip: remove interrupt-names from iommu nodes
      commit: 6af95e03fb113fecc1c5d9883d8a7910dace010d
[2/2] arm64: dts: rockchip: remove interrupt-names from iommu nodes
      commit: 53a05c8f6e8e8138a30e5859e760cef483a09e14

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
