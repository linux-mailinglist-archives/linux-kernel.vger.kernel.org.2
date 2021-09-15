Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA6840C0CF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 09:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236719AbhIOHuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 03:50:21 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:39390 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236528AbhIOHuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 03:50:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631692131; x=1663228131;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mznaIENBmnjijvoGVx0g7QmaVy3NcrLnaAc5N0H7ae0=;
  b=VgJGw4duheAApmtT6yilM+Vp3FLmL6Rcg+w7FMiKqQN6IgWLcRfa3uLT
   /98nHxFVv+LQ1CYszOlLFYTcUBlsRz1Vvg9qI0PGKs8saOP56tfcLBm2P
   fIOLQmMOiityUd46NPfwdmcVdM99mQeNmLoKCIjXp/wPJ/zX2loZRpSCc
   ftA9cTP9ic4ud500ZrcfFYg9qZ17i7UwZOdnhFqn4WYacIhC35sjYfmfx
   UgB204j9exs6npPIkaKN5Nd2rpz68qcyoPlhBxnvWAGnC7ph5ml/YF654
   yZqWAjQiiPRjYbd6CgSMmZbD9bTF5gcsNHWk1nLH0jSv+rzn07HQ/9rLs
   Q==;
IronPort-SDR: FnkxGjrDKz6cP+NDrIrfYL9QOMZoKaGLx32R3cAtpMcSkmE0To5crI1T+l+1HpTOfJrnsXBrzr
 gzBgAwVd4FZWTAbB+1fN1XL/47BVcrAwyIlWBmvMoEGOti/50MUaV8klgGCHqMQgticGS0ra4z
 mLoGjoCSudKw8D5LnCk1cYDyGOWL8P9ep+bB1/9KWHNbW/ul8hZQqGxUX4u9w2FfWzLK2813fE
 pdJL2K3DvgN0HVeFPK+1cNlji1Y8gjcUetH7lG5hJAl2lqFGWLihxreYcLNCQUoSi8S/qI7gR9
 r1MHuAvDJNzPUN20CDplv/7H
X-IronPort-AV: E=Sophos;i="5.85,294,1624345200"; 
   d="scan'208";a="136600204"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Sep 2021 00:48:51 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 15 Sep 2021 00:48:49 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 15 Sep 2021 00:48:47 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 0/2] ARM: dts: at91: sama7g5: fixes for sama7g5
Date:   Wed, 15 Sep 2021 10:48:34 +0300
Message-ID: <20210915074836.6574-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patches fixes slew rate settings for SAMA7G5's GMACs and
SDMMCs.

Thank you,
Claudiu Beznea

Claudiu Beznea (2):
  ARM: dts: at91: sama7g5ek: use proper slew-rate settings for GMACs
  ARM: dts: at91: sama7g5ek: to not touch slew-rate for SDMMC pins

 arch/arm/boot/dts/at91-sama7g5ek.dts | 34 +++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 6 deletions(-)

-- 
2.25.1

