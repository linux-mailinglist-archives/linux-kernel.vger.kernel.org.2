Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD64399E33
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 11:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhFCJ6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 05:58:10 -0400
Received: from gloria.sntech.de ([185.11.138.130]:55276 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhFCJ6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 05:58:09 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lok5L-0004PQ-8Y; Thu, 03 Jun 2021 11:56:19 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, kishon@ti.com,
        t.schramm@manjaro.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
        vkoul@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/5] convert grf.txt to YAML
Date:   Thu,  3 Jun 2021 11:56:16 +0200
Message-Id: <162271417225.3165003.9593649275522382168.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210601164800.7670-1-jbx6244@gmail.com>
References: <20210601164800.7670-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jun 2021 18:47:55 +0200, Johan Jonker wrote:
> Changed V7:
>   rebase
>   add compatible for rk3308 USB grf
>     add "rockchip,rk3308-usb2phy-grf" to "usb2phy@[0-9a-f]+$"
>     patternProperties too
>   add USB support to rk3308.dtsi
>     restyle
>     limit grf reg size
>     change sub nodename
>   remove applied patches
> 
> [...]

Applied, thanks!

[1/5] dt-bindings: phy: rename phy nodename in phy-rockchip-inno-usb2.yaml
      commit: e71ccdff376b0bd1bf4d47642b7ec4d791293b96
[2/5] dt-bindings: soc: rockchip: grf: add compatible for RK3308 USB grf
      commit: da76290fa39dc647bf7a1bac6467e66c8e465e54
[3/5] ARM: dts: rockchip: rename nodename for phy-rockchip-inno-usb2
      commit: 2fd2300a9c17ee1c48b1b7a7fabbb90fd12a64f1
[4/5] arm64: dts: rockchip: rename nodename for phy-rockchip-inno-usb2
      commit: 8c3d64251ac5c5a3d10364f6b07d3603ac1e7b4a
[5/5] arm64: dts: rockchip: add USB support to rk3308.dtsi
      commit: 9fcf74b274a1dc5bcda37c34470061ef1e1130dd

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
