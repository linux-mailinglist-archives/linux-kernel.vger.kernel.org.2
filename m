Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC113CC68B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 23:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235720AbhGQVzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 17:55:16 -0400
Received: from gloria.sntech.de ([185.11.138.130]:35902 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231528AbhGQVzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 17:55:15 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1m4sEI-0006yf-JE; Sat, 17 Jul 2021 23:52:14 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Rob Herring <robh+dt@kernel.org>,
        "matthias.bgg@kernel.org" <matthias.bgg@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        Simon South <simon@simonsouth.net>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Guillaume Gardet <guillaume.gardet@arm.com>,
        linux-rockchip@lists.infradead.org,
        Matthias Brugger <mbrugger@suse.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Disable CDN DP on Pinebook Pro
Date:   Sat, 17 Jul 2021 23:52:11 +0200
Message-Id: <162655869103.853863.17662789602843984386.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210715164101.11486-1-matthias.bgg@kernel.org>
References: <20210715164101.11486-1-matthias.bgg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jul 2021 18:41:01 +0200, matthias.bgg@kernel.org wrote:
> The CDN DP needs a PHY and a extcon to work correctly. But no extcon is
> provided by the device-tree, which leads to an error:
> cdn-dp fec00000.dp: [drm:cdn_dp_probe [rockchipdrm]] *ERROR* missing extcon or phy
> cdn-dp: probe of fec00000.dp failed with error -22
> 
> Disable the CDN DP to make graphic work on the Pinebook Pro.

Applied, thanks!

[1/1] arm64: dts: rockchip: Disable CDN DP on Pinebook Pro
      commit: 714b35da2b6eace13bfe23ae02330e3b6a2ea4e7

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
