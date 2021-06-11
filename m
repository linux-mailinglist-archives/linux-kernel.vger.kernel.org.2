Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 254803A418A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 13:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhFKMAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 08:00:13 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:55200 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbhFKMAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 08:00:12 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 15BBw25b054437;
        Fri, 11 Jun 2021 06:58:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623412682;
        bh=lz3eUFLWjc5wmVQBahFCbI1CAfEZvq0RXjoWx/xNOTo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=SnTyOxVGtWgam3hw9DxhnyXNuAiMbqT8AKhmfu9poFX/ktkFleo31vrp2wV8yaAjH
         nkX3VDguyCpwIvpP2oMGMfRDYTMeb5CnMbEEqYQG34xIADpcXH4enKuywtqHX1bWRz
         5tdQ8FRSe4IAkySs1S0l04Rh33BYX1aGnDcpLagE=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 15BBw2Tv121572
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Jun 2021 06:58:02 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 11
 Jun 2021 06:58:01 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 11 Jun 2021 06:58:01 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 15BBvvLS039508;
        Fri, 11 Jun 2021 06:57:58 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Michael Walle <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH v6 0/4] mtd: spi-nor: otp: 4 byte mode fix and erase support
Date:   Fri, 11 Jun 2021 17:27:51 +0530
Message-ID: <162341252747.7630.10412857264567592221.b4-ty@ti.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210607112744.21587-1-michael@walle.cc>
References: <20210607112744.21587-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jun 2021 13:27:40 +0200, Michael Walle wrote:
> This series is the follow up on the single patch
> mtd: spi-nor: implement OTP erase for Winbond and similar flashes
> 
> Pratyush Yadav discovered a likely problem with bigger flashes, the address
> to access the security registers is either 3 or 4 byte (at least for
> winbond flashes).
> 
> [...]

Applied to spi-nor/next, thanks!
[1/4] mtd: spi-nor: otp: fix access to security registers in 4 byte mode
      https://git.kernel.org/mtd/c/b97b1a7698
[2/4] mtd: spi-nor: otp: use more consistent wording
      https://git.kernel.org/mtd/c/d5b813e484
[3/4] mtd: spi-nor: otp: return -EROFS if region is read-only
      https://git.kernel.org/mtd/c/388161ca45
[4/4] mtd: spi-nor: otp: implement erase for Winbond and similar flashes
      https://git.kernel.org/mtd/c/c6ec3e1e3a

--
Regards
Vignesh

