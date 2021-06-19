Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 545B73ADBD9
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 23:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbhFSWAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 18:00:54 -0400
Received: from gloria.sntech.de ([185.11.138.130]:51422 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229585AbhFSWAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 18:00:53 -0400
Received: from p508fcd5b.dip0.t-ipconnect.de ([80.143.205.91] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1luiz7-0000U7-L0; Sat, 19 Jun 2021 23:58:37 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Alex Bee <knaerzche@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: add ir-receiver for rk3399-roc-pc
Date:   Sat, 19 Jun 2021 23:58:33 +0200
Message-Id: <162413990967.13616.4393486224885629799.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210619121642.7892-1-knaerzche@gmail.com>
References: <20210619121642.7892-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Jun 2021 14:16:42 +0200, Alex Bee wrote:
> Like some other RK3399 boards RK3399-ROC-PC has an ir receiver
> connected to pwm3 which can be used as gpio-ir-receiver.

Applied, thanks!

[1/1] arm64: dts: rockchip: add ir-receiver for rk3399-roc-pc
      commit: e1d635bc94bce69e45a2d4e93c94178613e01229

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
