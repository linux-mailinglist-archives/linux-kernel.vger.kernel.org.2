Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA1B3EB2F5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 10:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239837AbhHMIwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 04:52:17 -0400
Received: from gloria.sntech.de ([185.11.138.130]:43214 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239291AbhHMIwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 04:52:15 -0400
Received: from 82-99-180-238.static.bluetone.cz ([82.99.180.238] helo=phil.sntech)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mESuo-00077D-Kb; Fri, 13 Aug 2021 10:51:46 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wenst@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] arm64: dts: rockchip: Add Scarlet Dumo Variant
Date:   Fri, 13 Aug 2021 10:51:41 +0200
Message-Id: <162884469491.2596417.3007403443594611487.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210812094753.2359087-1-wenst@chromium.org>
References: <20210812094753.2359087-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Aug 2021 17:47:51 +0800, Chen-Yu Tsai wrote:
> A variant of the Chrome OS Gru-Scarlet device is missing in upstream.
> This variant, dumo, is the same as the Innolux display panel variant,
> but requires a specific calibration variant for its WiFi module.
> 
> I'm not sure if it's better to inherit from gru-scarlet-innolux. I kept
> them separate from now, like in downstream ChromeOS kernel v4.4.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: arm: rockchip: Add gru-scarlet-dumo board
      commit: 1aec043e2bcfc28a7b3946c852c89c008cfceb30
[2/2] arm64: dts: rockchip: rk3399: Add gru-scarlet-dumo board
      commit: ae328485ba0d5e2e0ff058438afbd8371badbc19

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
