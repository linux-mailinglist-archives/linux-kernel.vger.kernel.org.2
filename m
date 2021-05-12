Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDFEB37B49F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 05:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbhELDiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 23:38:50 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:2302 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhELDir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 23:38:47 -0400
Received: from dggeml757-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Fg0kC1f5fz19Jyl;
        Wed, 12 May 2021 11:33:23 +0800 (CST)
Received: from dggemi760-chm.china.huawei.com (10.1.198.146) by
 dggeml757-chm.china.huawei.com (10.1.199.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 12 May 2021 11:37:38 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggemi760-chm.china.huawei.com (10.1.198.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 12 May 2021 11:37:37 +0800
From:   Hui Tang <tanghui20@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/8] crypto: hisilicon/hpre - fix coding style
Date:   Wed, 12 May 2021 11:34:23 +0800
Message-ID: <1620790471-16621-1-git-send-email-tanghui20@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggemi760-chm.china.huawei.com (10.1.198.146)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fix coding style, as follows:

Hui Tang (8):
  crypto: hisilicon/hpre - the macro 'HPRE_ADDR' expands
  crypto: hisilicon/hpre - init a structure member each line
  crypto: hisilicon/hpre - replace macro with inline function
  crypto: hisilicon/hpre - remove the macro of 'HPRE_DEV'
  crypto: hisilicon/hpre - delete rudundant initialization
  crypto: hisilicon/hpre - use 'GENMASK' to generate mask value
  crypto: hisilicon/hpre - delete rudundant macro definition
  crypto: hisilicon/hpre - add 'default' for switch statement

v1 -> v2: fix build warnings reported by kernel test robot.

 drivers/crypto/hisilicon/hpre/hpre_crypto.c |  67 ++++++------
 drivers/crypto/hisilicon/hpre/hpre_main.c   | 157 +++++++++++++++++-----------
 2 files changed, 128 insertions(+), 96 deletions(-)

--
2.8.1

