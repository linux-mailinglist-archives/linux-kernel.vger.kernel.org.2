Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13316330B00
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 11:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbhCHKUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 05:20:16 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:31719 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbhCHKT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 05:19:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1615198798; x=1646734798;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oNvNn28rb4tAfciWFYpPvBm0QNlVOJCkd5bG/58CA8k=;
  b=jeXqwtUaGil6M2maqdFc3ien20nFKzejxtU0TT9Qam2caY/9kwbrD+FD
   ZdP0B15JB3witizWdiLPYVMSja+GjtL4Bzz2B4HQ9KvQajhiS7B1llWpN
   V9dX6IY/7lejuJWBTm02mnaQuJa+Vwk+7ESdFlKS/lqxMo0V5exNbjrNT
   ZDTNvmvkazWiEcpmWWoehQqgB1MvVj56L3FgQTJ60qVKq716d8Bh8VMAf
   YqqBrNUDswbY4MpUMk3O1ADQRnVfVhfdkLnaQ45QW3H8vWBZ3ZGMy1kwp
   bQAwRFWYL9aFbI9q3s/z/Xgdlq3C+gfvctnDE2KqboWTXz2kuWVrs2FD/
   w==;
IronPort-SDR: UKIU519NeH63QXkMYghzIo6LLwqy61gNc4pbEp1MgFwbqqiS0H8fWaJiAtYbSqSvUS2k9ggT+y
 9PsgNTsO3RD8yJe/EvsGyQLGvbLEiwFwMZYvzU5Urc0i5TkPiBbLINWn6orBYAWD4tAdGV6yTV
 M9Hp54ZrAZYFaysm/DZM7EFTyl/JW7XEmZ6G6aX5A+z0TjhcnrNaR7QXhl5nFq5L082er9lEIa
 kI/5tyqEL/QRI22XkPUNkFokUiAz+kna4dKBzBPf9xBRELATBpLrgEMVnYFp+0DoMWL64yMaIc
 hto=
X-IronPort-AV: E=Sophos;i="5.81,232,1610434800"; 
   d="scan'208";a="112334912"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Mar 2021 03:19:57 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 8 Mar 2021 03:19:57 -0700
Received: from atudor-ThinkPad-T470p.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 8 Mar 2021 03:19:55 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <p.yadav@ti.com>, <michael@walle.cc>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
CC:     <linux-kernel@vger.kernel.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH] MAINTAINERS: Add Michael and Pratyush as designated reviewers for SPI NOR
Date:   Mon, 8 Mar 2021 12:19:53 +0200
Message-ID: <161519874943.83443.13785039225508399438.b4-ty@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210308092333.80521-2-tudor.ambarus@microchip.com>
References: <20210308092333.80521-1-tudor.ambarus@microchip.com> <20210308092333.80521-2-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Mar 2021 11:23:33 +0200, Tudor Ambarus wrote:
> It's already been the case for some time that Michael and Pratyush
> are reviewing SPI NOR patches. Update MAINTAINERS to reflect reality.

Applied to spi-nor/next, thanks!

[1/1] MAINTAINERS: Add Michael and Pratyush as designated reviewers for SPI NOR
      https://git.kernel.org/mtd/c/47f25032c0e3

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@microchip.com>
