Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1083D4304D1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 21:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241031AbhJPTuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 15:50:08 -0400
Received: from gloria.sntech.de ([185.11.138.130]:47124 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240994AbhJPTuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 15:50:06 -0400
Received: from p508fce7c.dip0.t-ipconnect.de ([80.143.206.124] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mbpes-0008HL-Q4; Sat, 16 Oct 2021 21:47:54 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Heiko Stuebner <heiko@sntech.de>, lee.jones@linaro.org,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        jbx6244@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v2 1/3] dt-bindings: arm: rockchip: add rk3368 compatible string to pmu.yaml
Date:   Sat, 16 Oct 2021 21:47:51 +0200
Message-Id: <163441361289.438137.1214531874214547127.b4-ty@sntech.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210925090405.2601792-1-heiko@sntech.de>
References: <20210925090405.2601792-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Sep 2021 11:04:03 +0200, Heiko Stuebner wrote:
> Add the compatible for the pmu mfd on rk3368.

Applied, thanks!

[1/3] dt-bindings: arm: rockchip: add rk3368 compatible string to pmu.yaml
      commit: fff963f4ec42ae78ae03aae4bab9c709460bdf36
[3/3] arm64: dts: rockchip: add powerdomains to rk3368
      commit: b394e70cdcabec1249db3555779c890456ee7ce5

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
