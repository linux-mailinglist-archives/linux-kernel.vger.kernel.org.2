Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C31393071
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 16:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235492AbhE0OJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 10:09:40 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36470 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235386AbhE0OJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 10:09:36 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14RE7ujt026122;
        Thu, 27 May 2021 09:07:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622124476;
        bh=mN4S682wd8UcedJoUsd+cmh9EgUisPUpdvR5ONvh+AY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=C3lian4TP/MYaHLhA31LEUdif9/I45E0UFl/5JjzQ+brSS0Zn/KOcLL+ARNyN1YGW
         r+b6m4i7vLAHf7wRlTusN7CQBJDtOMdGic6PDVD37nwyZQP3QOZSHAGEJ1HfR0D8PI
         DHl4rm5rqFyzPYM/FzsNAwBYlaPBj93sEKiEzMI4=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14RE7umh045458
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 May 2021 09:07:56 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 27
 May 2021 09:07:56 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 27 May 2021 09:07:56 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14RE7qi9099432;
        Thu, 27 May 2021 09:07:53 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        <linux-kernel@vger.kernel.org>, Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH] mtd: spi-nor: Add documentation for spi_nor_soft_reset()
Date:   Thu, 27 May 2021 19:37:44 +0530
Message-ID: <162212417122.9400.10979239903864354902.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511093958.17258-1-p.yadav@ti.com>
References: <20210511093958.17258-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 May 2021 15:09:58 +0530, Pratyush Yadav wrote:
> Document what the function does and that it should only be used when it
> is known that the device supports it. This will avoid unaware
> programmers thinking that they can arbitrarily use it to reset the
> device.

Applied to spi-nor/next, thanks!
[1/1] mtd: spi-nor: Add documentation for spi_nor_soft_reset()
      https://git.kernel.org/mtd/c/ccfb7cf18f

--
Regards
Vignesh

