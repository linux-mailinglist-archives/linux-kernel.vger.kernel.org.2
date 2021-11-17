Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7CB454712
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 14:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237475AbhKQNXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 08:23:32 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:46046 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbhKQNXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 08:23:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1637155232; x=1668691232;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r/F5RXTxpA+0lZWVSNUoYs6ScKboHBx/VoX/iobMa7Y=;
  b=LJhPKb/NKOrevp0vJ/hDeiZMhOiESfVxIwd4dlYadm0gNIovcR/8Cgd9
   YJYAjIXY4GiLoUxbTnea0lI/+kTKquCtwvtLCKYx0z1F2a+CWTqh2DBnG
   ShQk2IkArMMJl1VcGfTAiNZTxcCROKokYjrfcBPSyCQL6sxpla9x//qTr
   HkjifijEsov6tnetlt5haJ2BeRGTMYfLpi3ibFAMo+A3rf3egMzP9QHbH
   mCM0L5EmyN3pgFZXPfQiVwf1cX8HbB/GkTSGFQ3Xoo1U3XFoRZrHMahGd
   WygO1ADZw0NGL55Zwx5UIFJq8DZvv0e28d7HXk8JQAolkQ1ktVDmVDHVU
   A==;
IronPort-SDR: W76uNzB3a1rKhexxb2FdjlT45PiVYDMgNXU5+0Qqfh+CM4eeqyMhcaCmTubCWc8QLISc5OhkPY
 3p9Vq5gd/Y+etArLCV6q2HDa8/7JChIInrCqTmAfZvLSdaLAEABqWqpUtrMXDTRUP3iTSVQOUp
 3Hx3jhT9SMl6CkjppLJBsegiJyJFCfAzn/H2gR9DTTlBypTP/zyq6ckB9hPZQ/edWcwQG08vAm
 F2P4glXo1rU4KSz7brpL0DiLkHMNWNwAtBQcBN7kjheplfJodvTBPaJd7tBV+ESZIcSmL0N+ml
 vJDtfl5KrQmmuDKbLrjhsDzY
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="scan'208";a="139427487"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Nov 2021 06:20:31 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 17 Nov 2021 06:20:30 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 17 Nov 2021 06:20:28 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     Pratyush Yadav <p.yadav@ti.com>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        <linux-mtd@lists.infradead.org>,
        Richard Weinberger <richard@nod.at>,
        "Miquel Raynal" <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, Michael Walle <michael@walle.cc>
Subject: Re: [PATCH] MAINTAINERS: Add myself as the SPI NOR co-maintainer
Date:   Wed, 17 Nov 2021 15:20:26 +0200
Message-ID: <163715510294.4949.12245796211168827045.b4-ty@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211029181157.20623-1-p.yadav@ti.com>
References: <20211029181157.20623-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Oct 2021 23:41:57 +0530, Pratyush Yadav wrote:
> I have been reviewing patches and contributing for over a year. I would
> like to help maintain the subsystem as well.

Stripped "the" from the commit subject, added Richard Acked-by
tag as agreed on irc, and applied to spi-nor/next.

Pratyush, welcome and good luck!

[1/1] MAINTAINERS: Add myself as the SPI NOR co-maintainer
      https://git.kernel.org/mtd/c/228e80459960

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@microchip.com>
