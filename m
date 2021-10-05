Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614FD422603
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 14:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234303AbhJEMNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 08:13:23 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:54496 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233672AbhJEMNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 08:13:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633435893; x=1664971893;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zhTZMjqn4/TM2ZgS/jPX+R07LXff+qvZQ2Gih+sJXa0=;
  b=IGvakfENM8zXPuWMFrja06s3/vAhT3fIaMkvookjbIBGqluFUMQQ8Pf3
   sjZadSmtaDSow6zJiYW5NLLZVEVkyyztoWEJAfPj+uxQih/01La0+02Gw
   0DkJjN5M4Lumc9P5IkWGpjO35WOKHHKaoTmdieSUxfr03iOZVve2JakH5
   nbm40BkyVWolMTqtkMrxDQ9p3OL8YJgAhcVPhx8b6PQlogkRif5P8PNdU
   XH0S+VB75hkU0PVh+UB0IQIA0JtciXcSn1+ZsuGBzCDG1WMVNcAiXHJK9
   SYk9YVArbHx84vLEr6eISRgzlOrArVdJ1T4cAKAaTbspe3ezjliy6PJlw
   A==;
IronPort-SDR: vt751ye8NfyblE+UFZp7sqf0SKExU4Nd3hPQ6jkw/PLkpWczOeEn1gvDpSz+P8pclI72yuVmHg
 lUEbpvQsuSeqHXGyDV5kehTnjsiMStPRoljZlpPqL4mfs5sYkjBDe8PqhL78cI1venVnOBci6P
 ryYLkSaHD6l4PRVggaAedeXel4KglJygCTCA3EQd49wf6jBB9rFHf8XSTuZeV3bMu6tNwMPqIR
 OJATpbyHQHt+e2buUOLZieah7tJahv+GMhsdbMbesbbjfwkuaXLdwndek85wsnJLSq901UIsKV
 e9wkfmzhPz6zeLG0b+IK0+Ij
X-IronPort-AV: E=Sophos;i="5.85,348,1624345200"; 
   d="scan'208";a="138511597"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Oct 2021 05:11:32 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 5 Oct 2021 05:11:31 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 5 Oct 2021 05:11:29 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     Pratyush Yadav <p.yadav@ti.com>, <linux-kernel@vger.kernel.org>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH] MAINTAINERS: Add spi-nor device tree binding under SPI NOR maintainers
Date:   Tue, 5 Oct 2021 15:11:24 +0300
Message-ID: <163343574378.37829.16814957321321688865.b4-ty@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210923191026.19184-1-p.yadav@ti.com>
References: <20210923191026.19184-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Sep 2021 00:40:26 +0530, Pratyush Yadav wrote:
> The binding is for the SPI NOR subsystem so the patches should be sent
> to its maintainers. Currently the patches get sent to Rob Herring and
> MTD maintainers who might not always have the full picture.

Applied to spi-nor/next, thanks!

[1/1] MAINTAINERS: Add spi-nor device tree binding under SPI NOR maintainers
      https://git.kernel.org/mtd/c/3f491d11d8cb

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@microchip.com>
