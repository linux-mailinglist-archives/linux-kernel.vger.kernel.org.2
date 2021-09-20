Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88F294116F7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 16:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240433AbhITOaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 10:30:30 -0400
Received: from gloria.sntech.de ([185.11.138.130]:55098 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237881AbhITOaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 10:30:21 -0400
Received: from wf0416.dip.tu-dresden.de ([141.76.181.160] helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mSKHq-0005O5-I2; Mon, 20 Sep 2021 16:28:50 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, robh+dt@kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: rockchip: add adc-keys node to rk3066a-mk808.dts
Date:   Mon, 20 Sep 2021 16:28:40 +0200
Message-Id: <163214478705.1547258.17831077090190048027.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210828092755.24560-1-jbx6244@gmail.com>
References: <20210828092755.24560-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Aug 2021 11:27:55 +0200, Johan Jonker wrote:
> The MK808 has a button inside the cover for the boot loader to do
> some action. Add the adc-keys node to the rk3066a-mk808.dts file.
> The rk3066 has a higher maximum DC supply voltage for the analog part of
> SAR-ADC VDDA_SARADC of 2.75V then other Rockchip SoCs.
> For the "rockchip,saradc" node is a vref-supply property required,
> so add a regulator for it as well.

Applied, thanks!

[1/1] ARM: dts: rockchip: add adc-keys node to rk3066a-mk808.dts
      commit: d7197d56c9cf3620ec086550386df3be2c90ae4d

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
