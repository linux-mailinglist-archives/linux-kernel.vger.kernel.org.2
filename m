Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26E4841171A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 16:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237205AbhITOdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 10:33:35 -0400
Received: from gloria.sntech.de ([185.11.138.130]:55254 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231272AbhITOde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 10:33:34 -0400
Received: from wf0416.dip.tu-dresden.de ([141.76.181.160] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mSKKz-0005Rh-4o; Mon, 20 Sep 2021 16:32:05 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     tomm.merciai@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Johan Jonker <jbx6244@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: fix: PCI reg address is not configuration space
Date:   Mon, 20 Sep 2021 16:32:04 +0200
Message-ID: <4652194.GXAFRqVoOG@phil>
In-Reply-To: <20210918164153.207146-1-tomm.merciai@gmail.com>
References: <20210918164153.207146-1-tomm.merciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 18. September 2021, 18:41:51 CEST schrieb Tommaso Merciai:
> Warning (pci_device_reg): /pcie@f8000000/pcie@0,0:reg: PCI reg address is not configuration space
> 
> Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>

applied for 5.16

thanks
Heiko


