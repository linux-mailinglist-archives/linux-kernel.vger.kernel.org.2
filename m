Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 985D4411725
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 16:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237219AbhITOe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 10:34:58 -0400
Received: from gloria.sntech.de ([185.11.138.130]:55286 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231952AbhITOes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 10:34:48 -0400
Received: from wf0416.dip.tu-dresden.de ([141.76.181.160] helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mSKHs-0005O5-PI; Mon, 20 Sep 2021 16:28:52 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Johan Jonker <jbx6244@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: fix: PCI reg address is not configuration space
Date:   Mon, 20 Sep 2021 16:28:48 +0200
Message-Id: <163214478702.1547258.5943542169692932677.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210918164153.207146-1-tomm.merciai@gmail.com>
References: <20210918164153.207146-1-tomm.merciai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Sep 2021 18:41:51 +0200, Tommaso Merciai wrote:
> Warning (pci_device_reg): /pcie@f8000000/pcie@0,0:reg: PCI reg address is not configuration space

Applied, thanks!

[1/1] arm64: dts: rockchip: fix: PCI reg address is not configuration space
      commit: d146198a858ac54653be6d90e3282a7f788c1960

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
