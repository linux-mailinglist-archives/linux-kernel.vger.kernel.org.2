Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F94841F2F8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 19:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355095AbhJARXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 13:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354507AbhJARXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 13:23:00 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB6BC061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 10:21:15 -0700 (PDT)
Received: from [IPv6:::1] (unknown [IPv6:2a02:810c:c240:2017:3906:69b3:d142:6568])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 6977522234;
        Fri,  1 Oct 2021 19:21:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1633108870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uT4IrMsFOFQcqRXXi3oqr7oTQ371TNfLR3LPEAjuufA=;
        b=QUvHiYQGy6zKy1u/CsjnMQYpK8SWtxe79VSYO2yQEC/kmULU3OoKlYSTtx1+Fe9MpX2j1h
        UYVd6sPEQ4FNMgv5b4bU+aINqg0OJ97v066RTgJWYKsBB8G68b6SGCqKOQnak7qq1QL4zl
        eHfS62zqqyD7O5pqlB28IWKhvlHy0hE=
Date:   Fri, 01 Oct 2021 19:21:08 +0200
From:   Michael Walle <michael@walle.cc>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v1_1/1=5D_mtd=3A_spi-nor=3A_intel-spi=3A_Ad?= =?US-ASCII?Q?d_support_for_Intel_Ice_Lake-N_SPI_serial_flash?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20211001171530.15283-1-andriy.shevchenko@linux.intel.com>
References: <20211001171530.15283-1-andriy.shevchenko@linux.intel.com>
Message-ID: <0D47CDDE-0F9E-4D5D-8524-1D911BF52CEF@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 1=2E Oktober 2021 19:15:30 MESZ schrieb Andy Shevchenko <andriy=2Eshevch=
enko@linux=2Eintel=2Ecom>:
>Intel Ice Lake-N has the same SPI serial flash controller as Ice Lake-LP=
=2E
>Add Ice Lake-N PCI ID to the driver list of supported devices=2E
>
>The device can be found on MacBookPro16,2 [1]=2E
>
>[1]: https://linux-hardware=2Eorg/?probe=3Df1c5cf0c43
>
>Signed-off-by: Andy Shevchenko <andriy=2Eshevchenko@linux=2Eintel=2Ecom>

Hi Andy,=20

there is currently a rewrite of this driver (to use spi-mem)
in progress:

https://lore=2Ekernel=2Eorg/linux-mtd/20210930100719=2E2176-1-mika=2Eweste=
rberg@linux=2Eintel=2Ecom/

Could you try that series with your hardware?=20

-michael=20
