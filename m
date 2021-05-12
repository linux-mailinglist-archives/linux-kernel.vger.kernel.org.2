Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6FB637B649
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 08:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhELGoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 02:44:20 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3727 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhELGoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 02:44:16 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fg4sF11gNzmgKq;
        Wed, 12 May 2021 14:39:45 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Wed, 12 May 2021 14:42:59 +0800
From:   Hui Tang <tanghui20@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] crypto: ecdh - register NIST P384
Date:   Wed, 12 May 2021 14:39:59 +0800
Message-ID: <1620801602-49287-1-git-send-email-tanghui20@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
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

Hui Tang (3):
  crypto: ecdh - fix 'ecdh_init'
  crypto: ecdh - register NIST P384 tfm
  crypto: ecdh - add test suite for NIST P384

 crypto/ecdh.c    | 44 +++++++++++++++++++++++++++++++++++++++-
 crypto/testmgr.c |  7 +++++++
 crypto/testmgr.h | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 111 insertions(+), 1 deletion(-)

--
2.8.1

