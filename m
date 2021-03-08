Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA0E330862
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 07:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234957AbhCHGo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 01:44:56 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:10080 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhCHGot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 01:44:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1615185889; x=1646721889;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1PWokqeLlK1wLdbrnNsyo72LALUZ8gy162Bk7d98kqE=;
  b=oM7tuXWeruyp12yTgmI+cw3zZZptP2EG4/Li3SQSPJmzixrkiEltNPCC
   nNys6VbztbrE97EjMO3kHs1utMwao71hkvg1yP1ac2y67ha0mNzgUgANO
   qoPEFo9W3zhMLCQMbeCtWXTRATxhjrhdsVLhnS5Hp5TXUPDz/KmKiZy95
   YatMIBuZ31d5wTAs424uJFw7bseXRSGPZoROvo0/gl+FWxC7eFC+Oa54l
   cUPyZpKnPJIa09BKLZKT7ygP4RlLvxbDmuYwrt4cpCs6/nbyUGD/9fSVF
   OhjLyyEEG1SqNMUhO9k2bt2xY3Y5oIWgS6wtWXsoEUkcKXUVohkCMT1mz
   g==;
IronPort-SDR: DengQCPIAECU3j2WnDHB3JWU+eHFKML132SiCCEHA59Rtg784uuNi+74a2rZYl4vA49tjFkHEu
 KAOL8G4J7p8w+r/06FGwzsPomZ6cDToIebqJiELkmvEWafwMoanEAWM0FvjBrsr+aEx2HFJLQF
 npZ6JX0PSfu865S8vd2WtY6sw2R+hSC4I/5Si6D3n7Nphh2ZNua0m0oH4rx3OTRXRzgvC6r2Bk
 K8QMlmVQbEzjVtNZ25CJPqLHRklzSq8pHn+bLTxQOe9pBEyYngqYdxMUqGdhELJHswENCjSql7
 gLg=
X-IronPort-AV: E=Sophos;i="5.81,231,1610434800"; 
   d="scan'208";a="112311694"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Mar 2021 23:44:48 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 7 Mar 2021 23:44:48 -0700
Received: from atudor-ThinkPad-T470p.amer.actel.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Sun, 7 Mar 2021 23:44:46 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Richard Weinberger <richard@nod.at>,
        Lee Jones <lee.jones@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v1 1/1] mtd: spi-nor: intel-spi: Move platform data header to x85 subfolder
Date:   Mon, 8 Mar 2021 08:44:45 +0200
Message-ID: <161518567740.71282.5118491437409807533.b4-ty@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210304140820.56692-1-andriy.shevchenko@linux.intel.com>
References: <20210304140820.56692-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Mar 2021 16:08:20 +0200, Andy Shevchenko wrote:
> In order to group x86 related platform data move intel-spi.h to x85 folder.
> 
> While at it, remove duplicate inclusion in C file.


s/x85/x86 in subject and commit description and applied to spi-nor/next. 
Thanks!

[1/1] mtd: spi-nor: intel-spi: Move platform data header to x85 subfolder
      https://git.kernel.org/mtd/c/ae2177cf318d

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@microchip.com>
