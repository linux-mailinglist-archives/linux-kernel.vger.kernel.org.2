Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 464F5380982
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 14:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbhENMa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 08:30:57 -0400
Received: from gloria.sntech.de ([185.11.138.130]:44344 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232354AbhENMaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 08:30:55 -0400
Received: from p5b127fa9.dip0.t-ipconnect.de ([91.18.127.169] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lhWwp-0002eq-Af; Fri, 14 May 2021 14:29:43 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: rockchip: rename vcc_stdby node name for rk3066a-rayeager.dts
Date:   Fri, 14 May 2021 14:29:41 +0200
Message-Id: <162099533686.1969114.5207322514424394298.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210510192054.8876-1-jbx6244@gmail.com>
References: <20210510192054.8876-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 May 2021 21:20:54 +0200, Johan Jonker wrote:
> A test with the command below gives this error:
> 
> /arch/arm/boot/dts/rk3066a-rayeager.dt.yaml:
> /: '5v-stdby-regulator' does not match any of the regexes:
> '.*-names$',
> '.*-supply$',
> '^#.*-cells$',
> '^#[a-zA-Z0-9,+\\-._]{0,63}$',
> '^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}$',
> '^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}@[0-9a-fA-F]+(,[0-9a-fA-F]+)*$',
> '^__.*__$',
> 'pinctrl-[0-9]+'
> 
> [...]

Applied, thanks!

[1/1] ARM: dts: rockchip: rename vcc_stdby node name for rk3066a-rayeager.dts
      commit: 87cf20ccecb3e3c00605980ef0dba61398499bf6

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
