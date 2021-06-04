Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5B139AFBD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 03:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhFDBda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 21:33:30 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3051 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhFDBd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 21:33:29 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Fx4qj0JNRzWrTl;
        Fri,  4 Jun 2021 09:26:57 +0800 (CST)
Received: from dggpeml500012.china.huawei.com (7.185.36.15) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 4 Jun 2021 09:31:42 +0800
Received: from huawei.com (10.69.192.56) by dggpeml500012.china.huawei.com
 (7.185.36.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 4 Jun 2021
 09:31:41 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <yekai13@huawei.com>
Subject: [PATCH 0/4] crypto: hisilicon - supports new aeads for new hardware
Date:   Fri, 4 Jun 2021 09:31:25 +0800
Message-ID: <1622770289-21588-1-git-send-email-yekai13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500012.china.huawei.com (7.185.36.15)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver adds new aeads, add fallback tfm supporting.
Modify the driver as needed. The crypto fuzzing test has been passed.

Kai Ye (4):
  crypto: hisilicon/sec - add new algorithm mode for AEAD
  crypto: hisilicon/sec - add fallback tfm supporting for aeads
  crypto: hisilicon/sec - add hardware integrity check value process
  crypto: hisilicon/sec - modify the SEC request structure

 drivers/crypto/hisilicon/sec2/sec.h        |  13 +-
 drivers/crypto/hisilicon/sec2/sec_crypto.c | 575 ++++++++++++++++++++++++-----
 drivers/crypto/hisilicon/sec2/sec_crypto.h |   9 +
 3 files changed, 507 insertions(+), 90 deletions(-)

-- 
2.8.1

