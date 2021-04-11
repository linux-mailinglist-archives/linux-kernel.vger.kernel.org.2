Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5762D35B235
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 09:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235020AbhDKHpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 03:45:30 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:16379 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhDKHp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 03:45:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1618127111; x=1649663111;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=deDvm+/gIW+AgC4Z2vogfCHV0tnsxgDJvqBREMBMDPk=;
  b=PCV50UQMdZGGJ6DWYnKK2N9XnCjatbZbe2jlAJ2GelstDsk7TVZerWxX
   JnPeuLtfuUPPvrgQnTfkMNQWWK4m0KPx2JHrHIX9hRh31UwUwZupPulDR
   ZIvvfOx2rXagA8tRRN7LV4ZjfCi6w01UVU9hT4PnXNbmGTJX3JgGSE3qf
   gl3nX6KL4eXrSCK4Kxvcs5A8H1HFDQ0yeeWdgoe2rhSD+/mJiDHZBWw6S
   9+libhSMo4QyKp/14X821cuyeys2Wd/kNf9G5rveB8BZGPrGnLK/fBSsM
   LT42lx7+FtMzNLljerTwcird2COB7f75X6Pm2KmnWpS5agADUyM36OC8/
   A==;
IronPort-SDR: P6B/ic+g+PpJaHWjRXpPNl1PW8oQP9RDnrqNGTGCUV7eEZqdq3nn9qvfIEy6XGrLrIyRf2GyI/
 3V1LuK1C0koZxIh6n+5Yt++XzzWnn5a0PANW4oMu3Qg9J5z6VyqKqOQ6EBL5fLIA/LJvDSEsFF
 WaF0qkfH9gahJXUCxIscheDlXZdtQL1seg8qDDTGAea0GP+41xNoiksiMn1SKR8d45yVirlrru
 RAARRhabcucmB8EYRIO3q1Zt7SXJ/lF8Q2dzrTxIuey6oeZuuadDrECaZcUj+FeUKHXvK3jMWC
 ZMY=
X-IronPort-AV: E=Sophos;i="5.82,213,1613458800"; 
   d="scan'208";a="50712150"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Apr 2021 00:45:10 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 11 Apr 2021 00:45:10 -0700
Received: from atudor-ThinkPad-T470p.amer.actel.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Sun, 11 Apr 2021 00:45:07 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>, <michael@walle.cc>,
        <ycllin@mxic.com.tw>, <p.yadav@ti.com>, <vigneshr@ti.com>,
        <masonccyang@mxic.com.tw>, <zhengxunli@mxic.com.tw>,
        <juliensu@mxic.com.tw>
CC:     <linux-mtd@lists.infradead.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-kernel@vger.kernel.org>
Subject: Re: (subset)[PATCH 0/2] mtd: spi-nor: macronix: mx25l51245g, mx66l51235l and mx66l51235f
Date:   Sun, 11 Apr 2021 10:45:04 +0300
Message-ID: <161812694422.37194.1007833046830132290.b4-ty@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210402082031.19055-1-tudor.ambarus@microchip.com>
References: <20210402082031.19055-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Apr 2021 11:20:29 +0300, Tudor Ambarus wrote:
> mx25l51245g and mx66l51235l have the same flash ID. The flash
> detection returns the first entry in the flash_info array that
> matches the flash ID that was read, thus for the 0xc2201a ID,
> mx25l51245g was always hit, introducing a regression for
> mx66l51235l. Revert mx25l51245g addition. A solution for these
> flashes to coexist was proposed.
> 
> [...]

Applied to spi-nor/next, thanks!

[1/2] Revert "mtd: spi-nor: macronix: Add support for mx25l51245g"
      https://git.kernel.org/mtd/c/46094049a49b

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@microchip.com>
