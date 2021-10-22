Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED5F743747B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 11:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbhJVJPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 05:15:31 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:26182 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbhJVJPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 05:15:14 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HbJWF6hp9z8tsX;
        Fri, 22 Oct 2021 17:11:37 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 22 Oct 2021 17:12:50 +0800
Received: from huawei.com (10.69.192.56) by dggpeml100012.china.huawei.com
 (7.185.36.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 22 Oct
 2021 17:12:50 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <yekai13@huawei.com>,
        <liulongfang@huawei.com>
Subject: [PATCH v3 0/6] crypto: hisilicon - supports hash algorithm for SEC engine
Date:   Fri, 22 Oct 2021 17:10:49 +0800
Message-ID: <20211022091055.15369-1-yekai13@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver adds hash algorithms, sm3, md5, sha1,
sha256, sha512. Add fallback tfm supporting. Modify 
the driver as needed. The fuzzing test has been passed.

changes v1->v2:
	1. Modify the process of export and import. Using the ahash_req as
	   hash state. By copying the content of structure sec_ahash_req to
	   avoid dereferencing random pointers from import path. User can
	   export the hash state and then import the hash state, and it 
	   still work.
	2. Add sm3/md5 generic selection
	
changes v2->v3:
	1. Modify the process of export and import. Export the block of hash
	   state from the mac address, then user can import the existing hash
	   state.

Kai Ye (6):
  crypto: hisilicon/sec - add ping-pong buffer for ahash
  crypto: hisilicon/sec - add ahash alg features for Kunpeng920
  crypto: hisilicon/sec - support the larger packets for digest mode
  crypto: hisilicon/sec - ahash adapt to Kunpeng930 SQE
  crypto: hisilicon/sec - add fallback tfm supporting for ahash
  crypto: hisilicon/sec - add sm3/md5 generic selection for ahash

 drivers/crypto/hisilicon/Kconfig           |    2 +
 drivers/crypto/hisilicon/sec2/sec.h        |   56 +-
 drivers/crypto/hisilicon/sec2/sec_crypto.c | 1345 +++++++++++++++++++-
 drivers/crypto/hisilicon/sec2/sec_crypto.h |   10 +
 4 files changed, 1396 insertions(+), 17 deletions(-)

-- 
2.33.0

