Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5EF4116FD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 16:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240662AbhITOah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 10:30:37 -0400
Received: from gloria.sntech.de ([185.11.138.130]:55172 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240420AbhITOa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 10:30:28 -0400
Received: from wf0416.dip.tu-dresden.de ([141.76.181.160] helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mSKHr-0005O5-UB; Mon, 20 Sep 2021 16:28:51 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, Chen-Yu Tsai <wens@csie.org>,
        linux-kernel@vger.kernel.org
Cc:     Heiko Stuebner <heiko@sntech.de>
Subject: Re: (subset) [PATCH 1/2] arm64: dts: allwinner: a64: align operating-points table name with dtschema
Date:   Mon, 20 Sep 2021 16:28:45 +0200
Message-Id: <163214478705.1547258.14943918538537687859.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210819182311.223443-1-krzysztof.kozlowski@canonical.com>
References: <20210819182311.223443-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Aug 2021 20:23:10 +0200, Krzysztof Kozlowski wrote:
> Align the name of operating-points node to dtschema to fix warnings like:
> 
>   arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dt.yaml:
>     opp_table0: $nodename:0: 'opp_table0' does not match '^opp-table(-[a-z0-9]+)?$'

Applied, thanks!

[2/2] arm64: dts: rockchip: align operating-points table name with dtschema
      commit: a30f3d90e2d2f4d0452c0f6f77693d0e9bba3b1e

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
