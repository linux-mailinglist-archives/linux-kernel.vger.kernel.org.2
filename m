Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F763D39E7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 14:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbhGWLVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 07:21:42 -0400
Received: from gloria.sntech.de ([185.11.138.130]:45186 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234601AbhGWLVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 07:21:39 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1m6tsU-0004qO-PN; Fri, 23 Jul 2021 14:02:06 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     devicetree@vger.kernel.org,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, kernel@collabora.com,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Xing Zheng <zhengxing@rock-chips.com>,
        linux-clk@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: clk: Convert rockchip,rk3399-cru to DT schema
Date:   Fri, 23 Jul 2021 14:02:04 +0200
Message-Id: <162704168907.1329605.6589153087595599071.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210610175613.167601-1-nfraprado@collabora.com>
References: <20210610175613.167601-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jun 2021 14:56:13 -0300, Nícolas F. R. A. Prado wrote:
> Convert the rockchip,rk3399-cru binding to DT schema format.
> Tested with
> ARCH=arm64 make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.yaml
> ARCH=arm64 make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.yaml

Applied, thanks!

[1/1] dt-bindings: clk: Convert rockchip,rk3399-cru to DT schema
      commit: d475653672b730a30bd1391f68c98f450afaf725

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
