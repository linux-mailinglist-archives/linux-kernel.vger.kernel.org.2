Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF8873DC2EF
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 05:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237060AbhGaD1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 23:27:47 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:12432 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbhGaD1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 23:27:39 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Gc8kT6bQYzch6F;
        Sat, 31 Jul 2021 11:24:01 +0800 (CST)
Received: from dggpeml500012.china.huawei.com (7.185.36.15) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 31 Jul 2021 11:27:29 +0800
Received: from huawei.com (10.69.192.56) by dggpeml500012.china.huawei.com
 (7.185.36.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Sat, 31 Jul
 2021 11:27:29 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <yekai13@huawei.com>
Subject: [PATCH 0/5] crypto: hisilicon - some misc bugfix for SEC engine
Date:   Sat, 31 Jul 2021 11:26:31 +0800
Message-ID: <1627701996-4589-1-git-send-email-yekai13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500012.china.huawei.com (7.185.36.15)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

some misc bugfix for SEC engine.

Kai Ye (5):
  crypto: hisilicon/sec - fixup icv checking enabled on Kunpeng 930
  crypto: hisilicon/sec - delete the print of fallback tfm application
    failure
  crypto: hisilicon/sec - fix the max length of AAD for the CCM mode
  crypto: hisilicon/sec - fix the CTR mode BD configuration
  crypto: hisilicon/sec - use the correct print format

 drivers/crypto/hisilicon/sec2/sec_crypto.c | 30 ++++++++++++++++++++----------
 drivers/crypto/hisilicon/sec2/sec_crypto.h |  6 ++++--
 2 files changed, 24 insertions(+), 12 deletions(-)

-- 
2.7.4

