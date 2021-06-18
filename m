Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B023ACDB9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 16:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234626AbhFROmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 10:42:54 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57634 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234595AbhFROmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 10:42:52 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 15IEeNZY026566;
        Fri, 18 Jun 2021 09:40:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1624027223;
        bh=XCiiUC6/DdJ/G9x9Zx5amlsB3d7bKlx25c8cMWep5YA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Rsubx4mUTip2MOEffz+AVYRfpKvcO/d4/QlIqlxalG6cE7f7jugfRgBuysUI+hxb9
         fmo8dGq+1XkaLVs8l19fIg6xAEo7xH0BesfPuZqOjBDWM8UaO/9FmwA96uuK3vCcWQ
         Mvxen6dR2nHIrEUfbA8iq1s9HPFH4QHXPEAs5tjY=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 15IEeN89028527
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Jun 2021 09:40:23 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 18
 Jun 2021 09:40:23 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 18 Jun 2021 09:40:23 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 15IEeIkS129394;
        Fri, 18 Jun 2021 09:40:19 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Michael Walle <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Heiko Thiery <heiko.thiery@gmail.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Alexander Williams <awill@google.com>
Subject: Re: [PATCH v4 0/2] mtd: spi-nor: support dumping sfdp tables
Date:   Fri, 18 Jun 2021 20:10:15 +0530
Message-ID: <162402719645.24673.15238447229532389824.b4-ty@ti.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210503155651.30889-1-michael@walle.cc>
References: <20210503155651.30889-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 May 2021 17:56:49 +0200, Michael Walle wrote:
> Add the possibility to dump the SFDP data of a flash device.
> 
> More and more flash devices share the same flash ID and we need per device
> fixups. Usually, these fixups differentiate flashes by looking at
> differences in the SFDP data. Determining the difference is only possible
> if we have the SFDP data for all the flashes which share a flash ID. This
> will lay the foundation to dump the whole SFDP data of a flash device.
> 
> [...]

Applied to spi-nor/next, thanks!
[1/2] mtd: spi-nor: sfdp: save a copy of the SFDP data
      https://git.kernel.org/mtd/c/65b6d89d45
[2/2] mtd: spi-nor: add initial sysfs support
      https://git.kernel.org/mtd/c/36ac022862

--
Regards
Vignesh

