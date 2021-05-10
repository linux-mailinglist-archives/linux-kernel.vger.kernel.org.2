Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9B073791C6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 17:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242025AbhEJPBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 11:01:02 -0400
Received: from gloria.sntech.de ([185.11.138.130]:33962 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235859AbhEJO6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 10:58:12 -0400
Received: from [95.90.166.74] (helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lg7L4-0003f3-0e; Mon, 10 May 2021 16:56:54 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, zhangqing@rock-chips.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        enric.balletbo@collabora.com
Subject: Re: [PATCH v9 00/15] soc: rockchip: power-domain: add rk3568 powerdomains
Date:   Mon, 10 May 2021 16:56:51 +0200
Message-Id: <162065860682.1723098.16551538520647881153.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210417112952.8516-1-jbx6244@gmail.com>
References: <20210417112952.8516-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Apr 2021 13:29:37 +0200, Johan Jonker wrote:
> Fix power-controller node names for dtbs_check.
> Convert power domain documentation to json-schema.
> Add a meaningful power domain name.
> Support power domain function for RK3568 Soc.
> 
> Changed in V9:
> [PATCH v9 13/15]:
>   Rename definitions to $defs
>   Restyle patternProperties
> 
> [...]

Applied, thanks!

[01/15] ARM: dts: rockchip: Fix power-controller node names for rk3066a
        commit: f2948781a72f0d8cf2adf31758c357f2f35e6c79
[02/15] ARM: dts: rockchip: Fix power-controller node names for rk3188
        commit: d3bcbcd396175ac26aa54919c0b31c7d2878fc24
[03/15] ARM: dts: rockchip: Fix power-controller node names for rk3288
        commit: 970cdc53cb1afa73602028c103dbfb6a230080be
[04/15] ARM: dts: rockchip: add #power-domain-cells to power domain nodes
        commit: a3ec2d38f6dd922007ee4d414cf76d1f55570844
[05/15] arm64: dts: rockchip: Fix power-controller node names for px30
        commit: d5de0d688ac6e0202674577b05d0726b8a6af401
[06/15] arm64: dts: rockchip: Fix power-controller node names for rk3328
        commit: 6e6a282b49c6db408d27231e3c709fbdf25e3c1b
[07/15] arm64: dts: rockchip: Fix power-controller node names for rk3399
        commit: 148bbe29f9108812c6fedd8a228f9e1ed6b422f7
[08/15] arm64: dts: rockchip: add #power-domain-cells to power domain nodes
        commit: 837188d49823230f47afdbbec7556740e89a8557
[09/15] soc: rockchip: pm-domains: Add a meaningful power domain name
        commit: 0a69452e03564c5eaf99f729de398cd94ee90851
[10/15] dt-bindings: add power-domain header for RK3568 SoCs
        commit: 8cbc5d2f2fe42a1bb1491f25486999d8f4ba9733
[11/15] dt-bindings: arm: rockchip: convert pmu.txt to YAML
        commit: 41413a20b08258cc34af06e01236980ac68ae334
[12/15] dt-bindings: arm: rockchip: add more compatible strings to pmu.yaml
        commit: c29c9dc89381d94a57759b60ef46f3aa2f7d413d
[13/15] dt-bindings: power: rockchip: Convert to json-schema
        commit: dfbe3e44ae8415772d561e71b9b4be035af96396
[14/15] dt-bindings: power: rockchip: Add bindings for RK3568 Soc
        commit: 53f8551a36f97f04bd896a9e8d2daf0c45ffbae8
[15/15] soc: rockchip: power-domain: add rk3568 powerdomains
        commit: b9402acf6350458d934646a4531392bc4f8605d2

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
