Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E92A43E33C3
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 08:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbhHGGdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 02:33:13 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:13398 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbhHGGdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 02:33:12 -0400
Received: from dggeme768-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GhXW14DFSzclMs;
        Sat,  7 Aug 2021 14:29:17 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 dggeme768-chm.china.huawei.com (10.3.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Sat, 7 Aug 2021 14:32:53 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <liulongfang@huawei.com>,
        Weili Qian <qianweili@huawei.com>
Subject: [PATCH 0/3] crypto: hisilicon - enable clock gating for accelerator device
Date:   Sat, 7 Aug 2021 14:29:08 +0800
Message-ID: <1628317751-3396-1-git-send-email-qianweili@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeme768-chm.china.huawei.com (10.3.19.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kunpeng930 accelerator devices support dynamic clock gating. This patchset
enables clock gating for accelerator devices by writing hardware registers.

Weili Qian (3):
  crypto: hisilicon - enable zip device clock gating
  crypto: hisilicon - enable sec device clock gating
  crypto: hisilicon - enable hpre device clock gating

 drivers/crypto/hisilicon/hpre/hpre_main.c | 63 +++++++++++++++++++++++++++++++
 drivers/crypto/hisilicon/sec2/sec_main.c  | 46 +++++++++++++++++++---
 drivers/crypto/hisilicon/zip/zip_main.c   | 26 +++++++++++++
 3 files changed, 130 insertions(+), 5 deletions(-)

-- 
2.8.1

