Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6614116F8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 16:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240531AbhITOac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 10:30:32 -0400
Received: from gloria.sntech.de ([185.11.138.130]:55106 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240039AbhITOaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 10:30:21 -0400
Received: from wf0416.dip.tu-dresden.de ([141.76.181.160] helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mSKHr-0005O5-Id; Mon, 20 Sep 2021 16:28:51 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: rockchip: swap timer clock-names
Date:   Mon, 20 Sep 2021 16:28:44 +0200
Message-Id: <163214478704.1547258.15196055453839008962.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210828102659.7348-1-jbx6244@gmail.com>
References: <20210828102659.7348-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Aug 2021 12:26:59 +0200, Johan Jonker wrote:
> With the conversion of rockchip,rk-timer.yaml the clock-names order
> was set to "pclk", "timer", but nothing was fixed in the ARM dts section
> of the mainline kernel, so the swap timer clock-names that don't fit.
> 
> make ARCH=arm dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml

Applied, thanks!

[1/1] ARM: dts: rockchip: swap timer clock-names
      commit: 3e6f8124a78840d074fab36853ee1f5a2e7cffe5

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
