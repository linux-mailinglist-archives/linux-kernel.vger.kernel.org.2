Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4070E4585FE
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 19:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238767AbhKUSzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 13:55:21 -0500
Received: from gloria.sntech.de ([185.11.138.130]:38046 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233273AbhKUSzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 13:55:20 -0500
Received: from ip5f5a6e92.dynamic.kabel-deutschland.de ([95.90.110.146] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1morwj-00086u-7t; Sun, 21 Nov 2021 19:52:13 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Aditya Prayoga <aditya@kobol.io>, Florian Klink <flokli@flokli.de>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: Enable HDD power on helios64
Date:   Sun, 21 Nov 2021 19:52:07 +0100
Message-Id: <163752071860.2241976.13058196563714996469.b4-ty@sntech.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211020095926.735938-1-flokli@flokli.de>
References: <20211020095926.735938-1-flokli@flokli.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2021 11:59:22 +0200, Florian Klink wrote:
> This adds the hdd_{a,b}_power blocks present in the armbian helios64
> dts. [1]
> 
> Without those powered up, no HDDs will appear (except one connected via
> the m.2 slot).
> 
> >From https://wiki.kobol.io/helios64/sata/#hdd-power:
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: rockchip: Enable HDD power on helios64
      commit: 8169b9894dbd2d4e440cfbc5fe9f733e5876a564
[2/2] arm64: dts: rockchip: fix poweroff
      commit: aef4b9a89a376a9cabe5e744729914e7766c59bb

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
