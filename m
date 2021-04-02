Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69613352699
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 08:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbhDBGie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 02:38:34 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:46487 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhDBGic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 02:38:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617345511; x=1648881511;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6l2ewII7HZLUgDgNCceti4mGNoBgxO2BRjv+HTj5Vo0=;
  b=k9ZUHu/gnd3Xcda9cKVdLCvHtgm9Ml7Fnd9o3Obk2BiZu3HKjolsyeRD
   B/elLtxLOpnus4vmGmfBdNUpaYqrNy7Fb+25nXOkKXKCn+DGv1Y9o+TxO
   evfbeb6B5fZ9s8qHKtr3Uofr9WXD1hREDIMBfKbpXEbtRYJlCnEvOcjK1
   /xRGQETcclsviVSIfno0aAvN7hF475H3/4uNYQYDWlsSJ/nUV8CTohKbO
   TwWw2hIk6zv25ODgqRcKk9uxG1psq1pe3/pt0ulOsc8Katjx0KAl4VFm9
   4YdKyQ1XzPOqhc1m8GV0KhezfocwZ0+Ya+jcSngsktCk06Ya5DIYD5Dse
   A==;
IronPort-SDR: TL8ljy6RNMv79gk6EfenK6EHogV/VWqyTYuWBwjGus4XNPqosKJPBz5/IgG1Alq2Z/gY9c+5pq
 1sE8ZQkBBd3ENVOZxlbeeh8iMutspbv7+jMDJ/0pNEuwulky/FcrAmk57xB1MoNkEV8c3sALq3
 PJjCIdigQXA3Q1tr24xFwfIfLRLEhcNkyxYkOpsJ4idJbSFcV4prfHaSrZtzdjRkpHlfMddxNU
 GVFEo5QZnptklvXu3Lx1Xb+OFKYrkzz9Q/c8xLshwH7jmt9p92Xl2RS9ocIzMyFHZ3jdCHP2ji
 hlQ=
X-IronPort-AV: E=Sophos;i="5.81,299,1610434800"; 
   d="scan'208";a="49777298"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Apr 2021 23:38:30 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 1 Apr 2021 23:38:30 -0700
Received: from atudor-ThinkPad-T470p.amer.actel.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 1 Apr 2021 23:38:28 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <linux-kernel@vger.kernel.org>, Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v5 0/3] mtd: spi-nor: OTP support
Date:   Fri, 2 Apr 2021 09:38:24 +0300
Message-ID: <161734495497.5882.15333204001106333069.b4-ty@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210321235140.8308-1-michael@walle.cc>
References: <20210321235140.8308-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Mar 2021 00:51:37 +0100, Michael Walle wrote:
> This patchset implements the MTD OTP functions to allow access to the SPI
> OTP data. Specific support is added for Winbond flash chips.
> 
> In the past there was already an attempt by Rahul Bedarkar to add this, but
> there was no response. These patches are slightly based on his work.
> 
> https://lore.kernel.org/linux-mtd/1489754636-21461-1-git-send-email-rahul.bedarkar@imgtec.com/
> 
> [...]

Update 1/3: use div64_u64(), IS_ALIGNED, params->otp.org.
unsigned int region, drop comment, add rlen local variable in spi_nor_mtd_otp_lock()

Applied to spi-nor/next, thanks!

[1/3] mtd: spi-nor: add OTP support
      https://git.kernel.org/mtd/c/06d4bdf0a329
[2/3] mtd: spi-nor: implement OTP support for Winbond and similar flashes
      https://git.kernel.org/mtd/c/10488a53bdc4
[3/3] mtd: spi-nor: winbond: add OTP support to w25q32fw/jw
      https://git.kernel.org/mtd/c/5909dde2bc53

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@microchip.com>
