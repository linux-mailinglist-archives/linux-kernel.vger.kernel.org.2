Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 250B83307B8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 06:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbhCHFua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 00:50:30 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:37641 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbhCHFuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 00:50:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1615182617; x=1646718617;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LqAcY+32EdnZhxrdLJEG7sjrBzhN9AgldB87W29Jsis=;
  b=aEb1yLLnCU7usCtrDUtKroJYNBNk2dTM+7syGUOdA9EbYDGFHP0jUCtL
   6+ERWO7hP8WI3YDCtMi5OKr9o23xU0VdERQSc6bD8c3A/Say2f2Ve0CUg
   xPH369hatuJLI0MLZv4zAGuH+g42KLId8TB3Aa8vWJuY9UOwZT9UK/M71
   1uau79mZ4LeU5Y9PeFUlEqHkzYMA7AMXFNnaybCJhNaIPPSiMHqieTu7M
   IZRSiYxMRVGkh+LmPX6cR/zRrOKrxH3dR8Na/wVEMOGM8iDOOryzeJGoY
   YALSGEFUHhpE7EGXRHDxf95N5hrSGvcaxq/7YL5NkIBFzqmlVdRVgPVWb
   Q==;
IronPort-SDR: qafOGCVQhzScUwI46hyOv/CXGTT2fL02YDZq7sE1BubwFoQvUdwj5/Idn8ZXoEFrvDp9RI4vTF
 xfmvZ3xcFr7hAK2+SC7EyiuzwNtaxIwg+A5AeA7WEhCw5AUCSVAbeQwNDdTIbewKmFtEMIAGWk
 BHikmYHzOzynLOReEFgTI10uNvZqyYa7APkNW4RArITS0wQb+HxXpW57oj56AhoweJFf24qn2j
 XlrgSsyEEq/sRf4MSO5WplMR/SUC1Yl5lzxGIs1mMaPik8j58hTK2Q+rnpmpj4WauJb50CXXnV
 cVA=
X-IronPort-AV: E=Sophos;i="5.81,231,1610434800"; 
   d="scan'208";a="109103564"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Mar 2021 22:50:16 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 7 Mar 2021 22:50:15 -0700
Received: from atudor-ThinkPad-T470p.amer.actel.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Sun, 7 Mar 2021 22:50:14 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        <linux-kernel@vger.kernel.org>,
        "Richard Weinberger" <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "Shuhao Mai" <shuhao.mai.1990@gmail.com>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: Re: [PATCH v2] mtd: spi-nor: winbond: Add support for w25q512jvq
Date:   Mon, 8 Mar 2021 07:50:11 +0200
Message-ID: <161518259586.63466.11466749485988604375.b4-ty@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210208075303.4200-1-shuhao.mai.1990@gmail.com>
References: <20201111014556.6579-1-shuhao.mai.1990@gmail.com> <20210208075303.4200-1-shuhao.mai.1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Feb 2021 15:53:03 +0800, Shuhao Mai wrote:
> Add support for w25q512jvq. This is of the same series chip with
> w25q256jv, which is already supported, but with size doubled and
> different JEDEC ID.
> 
> Tested on Intel whitley platform with dd from/to the flash for
> read/write respectly, and flash_erase for erasing the flash.

Applied to spi-nor/next, thanks!

[1/1] mtd: spi-nor: winbond: Add support for w25q512jvq
      https://git.kernel.org/mtd/c/ff013330fbdb

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@microchip.com>
