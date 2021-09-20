Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 554234116F4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 16:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240372AbhITOaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 10:30:25 -0400
Received: from gloria.sntech.de ([185.11.138.130]:55102 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237735AbhITOaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 10:30:21 -0400
Received: from wf0416.dip.tu-dresden.de ([141.76.181.160] helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mSKHq-0005O5-QG; Mon, 20 Sep 2021 16:28:50 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: rockchip: change rv1108 gmac nodename
Date:   Mon, 20 Sep 2021 16:28:41 +0200
Message-Id: <163214478704.1547258.6180917983443491780.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210828114240.12231-1-jbx6244@gmail.com>
References: <20210828114240.12231-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Aug 2021 13:42:40 +0200, Johan Jonker wrote:
> The rv1108 gmac node is checked with rockchip-dwmac.yaml,
> snps,dwmac.yaml and ethernet-controller.yaml.
> The nodename should have a pattern: "^ethernet(@.*)?$",
> so change to nodename.

Applied, thanks!

[1/1] ARM: dts: rockchip: change rv1108 gmac nodename
      commit: f0f56c11447b7c77ba07f05fb07ddb00c3ae42b1

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
