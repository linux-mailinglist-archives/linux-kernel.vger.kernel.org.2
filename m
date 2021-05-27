Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE3C393074
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 16:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235925AbhE0OLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 10:11:12 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36702 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234913AbhE0OLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 10:11:01 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14RE9KwM026569;
        Thu, 27 May 2021 09:09:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622124560;
        bh=jo7vp1r1D15eHxjv5T1Z+K8MMAR5BnkxInbZmeLGKDo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=A/sty2KX6ahpEpXRGG4Y2KGTNzuVqmTPIUh8toCrp8lRgyee31egifGNKSuse4AYy
         eGcwnhQo4S6qVuNny9VTEcJqtOlh4JoNo6jI2GBP6lTdtKaTVnb/rvGacpOvT3/rf0
         goPkzLyDlwGFbtRxndGr9hi9oRceRrDO+SaNNQ5s=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14RE9Ksv054737
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 May 2021 09:09:20 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 27
 May 2021 09:09:19 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 27 May 2021 09:09:19 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14RE9FnS102343;
        Thu, 27 May 2021 09:09:16 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH] mtd: spi-nor: otp: fix kerneldoc typos
Date:   Thu, 27 May 2021 19:39:05 +0530
Message-ID: <162212417122.9400.5343449761391565485.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210505200017.17499-1-michael@walle.cc>
References: <20210505200017.17499-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 May 2021 22:00:17 +0200, Michael Walle wrote:
> Use the correct argument names in the kerneldoc.

Applied to spi-nor/next, thanks!
[1/1] mtd: spi-nor: otp: fix kerneldoc typos
      https://git.kernel.org/mtd/c/a6e2cd4dd2

--
Regards
Vignesh

