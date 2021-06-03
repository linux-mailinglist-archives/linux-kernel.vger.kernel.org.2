Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3DCD39A193
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 14:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhFCMzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 08:55:15 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3413 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbhFCMzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 08:55:14 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Fwm2s1Hmsz6twv;
        Thu,  3 Jun 2021 20:50:29 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 3 Jun 2021 20:53:28 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 3 Jun 2021 20:53:27 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 0/2] mtd: core: add and use MTD_DEVICE_ATTR_RO/RW() helper macros to simplify code
Date:   Thu, 3 Jun 2021 20:53:21 +0800
Message-ID: <20210603125323.12142-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

List of changed function names:
mtd_ecc_stats_corrected_show	--> mtd_corrected_bits_show	//MTD_DEVICE_ATTR_RO(corrected_bits)	/* ecc stats corrected */
mtd_ecc_stats_errors_show	--> mtd_ecc_failures_show	//MTD_DEVICE_ATTR_RO(ecc_failures)	/* ecc stats errors */
mtd_badblocks_show		--> mtd_bad_blocks_show		//MTD_DEVICE_ATTR_RO(bad_blocks)
mtd_bbtblocks_show		--> mtd_bbt_blocks_show		//MTD_DEVICE_ATTR_RO(bbt_blocks)


Zhen Lei (2):
  mtd: core: add MTD_DEVICE_ATTR_RO/RW() helper macros
  mtd: core: use MTD_DEVICE_ATTR_RO/RW() helper macros

 drivers/mtd/mtdcore.c | 52 ++++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 25 deletions(-)

-- 
2.26.0.106.g9fadedd


