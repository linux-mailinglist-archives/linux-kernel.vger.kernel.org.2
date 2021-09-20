Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31564116F6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 16:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240444AbhITOa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 10:30:27 -0400
Received: from gloria.sntech.de ([185.11.138.130]:55100 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236619AbhITOaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 10:30:21 -0400
Received: from wf0416.dip.tu-dresden.de ([141.76.181.160] helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mSKHr-0005O5-AW; Mon, 20 Sep 2021 16:28:51 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, robh+dt@kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: rockchip: rk3066a: add more angle brackets to operating-points property
Date:   Mon, 20 Sep 2021 16:28:43 +0200
Message-Id: <163214478705.1547258.12250298518380952554.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210828091233.19992-1-jbx6244@gmail.com>
References: <20210828091233.19992-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Aug 2021 11:12:33 +0200, Johan Jonker wrote:
> After the conversion to YAML of the Operating Performance Points(OPP)
> binding the operating-points property expects values in
> a uint32-matrix with 2 items, so fix the notifications by adding
> angle brackets.
> 
> make ARCH=arm dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/opp/opp-v1.yaml

Applied, thanks!

[1/1] ARM: dts: rockchip: rk3066a: add more angle brackets to operating-points property
      commit: e220e0b00febcad6352dbe22da49ab08a4da4a82

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
