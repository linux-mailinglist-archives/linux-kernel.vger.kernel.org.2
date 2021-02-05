Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83BCE310BF3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 14:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbhBENik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 08:38:40 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:45431 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbhBENdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 08:33:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1612531981; x=1644067981;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TJ1Xni7oqhJicMe/bn1BWlaG9kF212vvJiz63NgX33g=;
  b=tV5uSzXJ2drJK+PqdfI0KSlcV4Dnk3mjHtOyAqIuBcVlbdWQKWNC4Eo2
   hD1evorZ+4eheN8vjGC7b3Ec43lmZ43T1+TvltEqAJ8UK2/A7EDcPJy3X
   BRZiQgq1m37IQCC4suBFK2kjYsuBbXr7v6D+MHUqrCeVyjr5ineefKVzx
   /HIcOx94RfaNjEZhUddE0BQ1zv9Pcrmjh5Fz2rqTPakDUhVa09uS+GNq3
   BUR/CHvTkJA+mpIlwrtM4HiCZhPIfPCi3for+2dbgVEbesXa4VOJNJ32z
   AYKJlD/44a0+G8sli321FosKOaNcQwibQMoPPQUncGcMBWsLfctApkvOa
   w==;
IronPort-SDR: 8SPAgU3YWjpaUOym2T/H2rY69Knb4on0rW6QdWhP1OFUe7mz2ZNNoHtqnqDyKsIjjgrX2Nfy6t
 EDWRsWggWMJWPkxIbKPOobSH9O+BmKVZvXx86M4fNAOJtRM5NhjwW6kRYuABndCi+KTUsUE7um
 MW4PevwyCMvoynRyE4Ugf4+/cFHBOXiuuCjBazaKEm0QyVnmw50+fhUgQilC9LZfViCgULVaqx
 dqWsrpR39nzUMHLS8k64FcDfUBmNEdcPkEB2cc2gncy/BibuixtRXK3KMMRqMMhK6a4azYTZFx
 PKU=
X-IronPort-AV: E=Sophos;i="5.81,154,1610434800"; 
   d="scan'208";a="43072524"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Feb 2021 06:31:41 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 5 Feb 2021 06:31:40 -0700
Received: from atudor-ThinkPad-T470p.amer.actel.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 5 Feb 2021 06:31:38 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <vigneshr@ti.com>, Tudor Ambarus <tudor.ambarus@microchip.com>,
        <p.yadav@ti.com>, <michael@walle.cc>
CC:     <richard@nod.at>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Kavyasree.Kotagiri@microchip.com>,
        <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v3 1/2] mtd: spi-nor: Add Global Block Unlock command
Date:   Fri, 5 Feb 2021 15:31:33 +0200
Message-ID: <161253178923.670759.16987268553514371903.b4-ty@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210121110546.382633-1-tudor.ambarus@microchip.com>
References: <20210121110546.382633-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jan 2021 13:05:45 +0200, Tudor Ambarus wrote:
> The Global Block Unlock command has different names depending
> on the manufacturer, but always the same command value: 0x98.
> Macronix's MX25U12835F names it Gang Block Unlock, Winbond's
> W25Q128FV names it Global Block Unlock and Microchip's
> SST26VF064B names it Global Block Protection Unlock.
> 
> Used in the Individual Block Protection mode, which is mutually
> exclusive with the Block Protection mode (BP0-3).

Applied to spi-nor/next, thanks!

[1/2] mtd: spi-nor: Add Global Block Unlock command
      https://git.kernel.org/mtd/c/a7a5acba0e06
[2/2] mtd: spi-nor: sst: Add support for Global Unlock on sst26vf
      https://git.kernel.org/mtd/c/75386810d3a6

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@microchip.com>
