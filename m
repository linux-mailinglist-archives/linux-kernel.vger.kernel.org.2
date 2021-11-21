Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2536458605
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 19:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238801AbhKUSza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 13:55:30 -0500
Received: from gloria.sntech.de ([185.11.138.130]:38062 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238771AbhKUSzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 13:55:22 -0500
Received: from ip5f5a6e92.dynamic.kabel-deutschland.de ([95.90.110.146] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1morwi-00086u-DW; Sun, 21 Nov 2021 19:52:12 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Dennis Gilmore <dgilmore@redhat.com>,
        linux-rockchip@lists.infradead.org
Cc:     Heiko Stuebner <heiko@sntech.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Florian Klink <flokli@flokli.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] arm64: dts: rockchip: helios64: add variables for pcie completion
Date:   Sun, 21 Nov 2021 19:52:05 +0100
Message-Id: <163752071860.2241976.17406214616552247687.b4-ty@sntech.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211029005323.144652-1-dgilmore@redhat.com>
References: <20211029005323.144652-1-dgilmore@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Oct 2021 19:53:19 -0500, Dennis Gilmore wrote:
> without ep-gpios defined u-boot does not initialise PCIe
> rockchip_pcie pcie@f8000000: failed to find ep-gpios property
> 
> additionally set max-link-speed and pinctrl-names for completeness
> 
> with this patch and the ones from Florian Klink applied to the dts
> file in u-boot sata drives show up in both u-boot and linux

Applied, thanks!

[1/1] arm64: dts: rockchip: helios64: add variables for pcie completion
      commit: 755fff528b1b760c700dbf39928ff3dda825f748

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
