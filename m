Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A73333E95A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 06:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhCQF4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 01:56:22 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:58116 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhCQF4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 01:56:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1615960561; x=1647496561;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jtH/Vke6rlwhX4iJALrlQLEMGo2Eixa4niPS9z2+t/E=;
  b=qeCtQA7tCEiAcrqjuyFBlTDdRERW1m/qCiDVmVNxgLoik3NBenjy1eaz
   rQPn8zQFVoSXUKISDdUzzHPk1w3DQPGY0SnFA+zICMTZxnS8H/Nn1onH9
   PWBvpB6fdbyscHYT/Hvt5BTYlwJCw2+Ikr9IfSYawqtsKzuUo1qQH1Auz
   CTGPyEqcj7rN/g0KdQfOGDZLR9VXzMzitpErQRzPU79SxCYJfHrxxnONk
   I2cQcH6fHM2EiXP06RnB+A9c5iCfj9VaORdNzahpdYaDfU7Fth9uJTkw6
   +UKQRJ9C1+HHPgKNo1H+6VhByM7ohRyiPDLLMrF+92uhBDA7eQFHsiVBz
   g==;
IronPort-SDR: zoQySQZEoaRMODehS1QEKQAuR+s+Jv/7L51HS+gpcv0COzXRNhmgjczYjJk5Q6Jgu+jXn5OXk7
 N+CoDZqNc/LzCfhlCHvlovGIEqIUxRIreZwwmReR59KQPl8QNVPn0RPQPtJhOLM2Uf82g1BS+y
 9qUPE7MWCv0slakoaVZve2IJU0W2o8tItg4+u0pdyB5XFbOQNzn5xwdvKeQKXV7k2/T2ViadC+
 t2IQxsaAFojjrF6LUeqHNPU2sx/cFaKJOItnpU0Fypt7S7zTMQPpr819V9v0yNDe7W9edho+gA
 RpY=
X-IronPort-AV: E=Sophos;i="5.81,254,1610434800"; 
   d="scan'208";a="113527771"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Mar 2021 22:56:01 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 16 Mar 2021 22:56:01 -0700
Received: from atudor-ThinkPad-T470p.amer.actel.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 16 Mar 2021 22:55:59 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <michael@walle.cc>, <p.yadav@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>, <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <miquel.raynal@bootlin.com>
Subject: Re: (subset) [PATCH v2 0/5] mtd: spi-nor: Cleanup patches
Date:   Wed, 17 Mar 2021 07:55:57 +0200
Message-ID: <161596027983.9417.8628174282093170718.b4-ty@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210306095002.22983-1-tudor.ambarus@microchip.com>
References: <20210306095002.22983-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Mar 2021 11:49:57 +0200, Tudor Ambarus wrote:
> Various cleanup patches done while reviewing contributions.
> 
> Tudor Ambarus (5):
>   mtd: spi-nor: core: Advance erase after the erase cmd has been
>     completed
>   mtd: spi-nor: core: Add vdbg msg for spi_nor_erase_multi_sectors()
>   mtd: spi-nor: Get rid of duplicated argument in spi_nor_parse_sfdp()
>   mtd: spi-nor: Move Software Write Protection logic out of the core
>   mtd: spi-nor: swp: Drop 'else' after 'return'
> 
> [...]

For 2/5: s/%d/%u and then applied to spi-nor/next 1/5, 2/5 and 3/5.

[1/5] mtd: spi-nor: core: Advance erase after the erase cmd has been completed
      https://git.kernel.org/mtd/c/786a0a75d0f3
[2/5] mtd: spi-nor: core: Add vdbg msg for spi_nor_erase_multi_sectors()
      https://git.kernel.org/mtd/c/8758888c3d78
[3/5] mtd: spi-nor: Get rid of duplicated argument in spi_nor_parse_sfdp()
      https://git.kernel.org/mtd/c/a580293a19fc

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@microchip.com>
