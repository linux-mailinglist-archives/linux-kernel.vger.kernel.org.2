Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0A1D38095C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 14:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbhENMVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 08:21:50 -0400
Received: from gloria.sntech.de ([185.11.138.130]:44034 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232996AbhENMVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 08:21:48 -0400
Received: from p5b127fa9.dip0.t-ipconnect.de ([91.18.127.169] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lhWny-0002bC-00; Fri, 14 May 2021 14:20:34 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: fix regulator-gpio states array
Date:   Fri, 14 May 2021 14:20:30 +0200
Message-Id: <162099477649.1967349.15932194686004438889.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210510215840.16270-1-jbx6244@gmail.com>
References: <20210510215840.16270-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 May 2021 23:58:40 +0200, Johan Jonker wrote:
> A test with the command below gives this error:
> 
> /arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dt.yaml:
> sdmmcio-regulator: states:0:
> [1800000, 1, 3300000, 0] is too long
> 
> dtbs_check expects regulator-gpio states in a format
> of 2 per item, so fix them all.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: fix regulator-gpio states array
      commit: b82f8e2992534aab0fa762a37376be30df263701

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
