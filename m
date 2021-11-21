Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71CF4458600
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 19:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238778AbhKUSzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 13:55:22 -0500
Received: from gloria.sntech.de ([185.11.138.130]:38048 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238369AbhKUSzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 13:55:21 -0500
Received: from ip5f5a6e92.dynamic.kabel-deutschland.de ([95.90.110.146] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1morwj-00086u-Qd; Sun, 21 Nov 2021 19:52:13 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     John Keeping <john@metanate.com>,
        linux-rockchip@lists.infradead.org
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Andy Yan <andyshrk@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 0/2] arm64: dts: rockchip: fix a couple of vin-supply typos
Date:   Sun, 21 Nov 2021 19:52:09 +0100
Message-Id: <163752071859.2241976.8663955051690006845.b4-ty@sntech.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211102182908.3409670-1-john@metanate.com>
References: <20211102182908.3409670-1-john@metanate.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Nov 2021 18:29:06 +0000, John Keeping wrote:
> The same "vim-supply" typo appears in a couple of DTs.  Here are fixes
> for both of them.
> 
> John Keeping (2):
>   arm64: dts: rockchip: fix rk3308-roc-cc vcc-sd supply
>   arm64: dts: rockchip: fix rk3399-leez-p710 vcc3v3-lan supply
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: rockchip: fix rk3308-roc-cc vcc-sd supply
      commit: 772fb46109f635dd75db20c86b7eaf48efa46cef
[2/2] arm64: dts: rockchip: fix rk3399-leez-p710 vcc3v3-lan supply
      commit: 2b454a90e2ccdd6e03f88f930036da4df577be76

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
