Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9445B4167F7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 00:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243473AbhIWW0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 18:26:34 -0400
Received: from gloria.sntech.de ([185.11.138.130]:34008 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243470AbhIWW0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 18:26:33 -0400
Received: from p5b1274d2.dip0.t-ipconnect.de ([91.18.116.210] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mTX9H-0008Vh-2u; Fri, 24 Sep 2021 00:24:59 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] arm64: dts: rockchip: fix LDO_REG4 / LDO_REG7 confusion on rk3368-lion
Date:   Fri, 24 Sep 2021 00:24:57 +0200
Message-Id: <163243587941.2556919.15754379297611690432.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210922230429.2162535-1-heiko@sntech.de>
References: <20210922230429.2162535-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Sep 2021 01:04:27 +0200, Heiko Stuebner wrote:
> LDO_REG7 is used for generating VCC_18.
> LDO_REG4 is not connected to anything - delete it.

Applied, thanks!

[1/3] arm64: dts: rockchip: fix LDO_REG4 / LDO_REG7 confusion on rk3368-lion
      commit: 3bd7f3ef3b0f34aefcd09e2e834bbee868179b09
[2/3] arm64: dts: rockchip: define iodomains for rk3368-lion
      commit: 0ed6b51dfde601c8b815a81aab701cd8965c5b12
[3/3] arm64: dts: rockchip: add phandles to muxed i2c buses on rk3368-lion
      commit: 5a73d7ca7f7a64144e03ef0fc8eb6f8e5ea54df3

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
