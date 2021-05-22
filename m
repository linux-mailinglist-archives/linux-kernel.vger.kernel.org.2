Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAC938D302
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 04:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbhEVCZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 22:25:58 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:3472 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbhEVCZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 22:25:54 -0400
Received: from dggems704-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Fn6fp0XjVzCsQV;
        Sat, 22 May 2021 10:21:38 +0800 (CST)
Received: from dggemi760-chm.china.huawei.com (10.1.198.146) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sat, 22 May 2021 10:24:26 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggemi760-chm.china.huawei.com (10.1.198.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Sat, 22 May 2021 10:24:26 +0800
From:   Hui Tang <tanghui20@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/4] crypto: ecdh - register NIST P384
Date:   Sat, 22 May 2021 10:21:20 +0800
Message-ID: <1621650084-25505-1-git-send-email-tanghui20@huawei.com>
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

Register NIST P384 tfm and extend the testmgr with NIST P384 test vectors.

Summary of changes:

* crypto/ecdh.c
  - fix 'ecdh_init' not unregistering NIST P192
  - add ecdh_nist_p384_init_tfm
  - register and unregister P384 tfm

* crypto/testmgr.c
  - add test vector for P384 on vector of tests

* crypto/testmgr.h
  - add test vector params for P384

---
v1 -> v2:
* Add patch#1:
  - Fix ecdh-nist-p192's entry in testmgr.
  - Add a comment for registering ecdh-nist-p192.
---

Hui Tang (4):
  crypto: ecdh: fix ecdh-nist-p192's entry in testmgr
  crypto: ecdh - fix 'ecdh_init'
  crypto: ecdh - register NIST P384 tfm
  crypto: ecdh - add test suite for NIST P384

 crypto/ecdh.c    | 45 +++++++++++++++++++++++++++++++++++++++-
 crypto/testmgr.c | 10 ++++++---
 crypto/testmgr.h | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 112 insertions(+), 6 deletions(-)

--
2.8.1

