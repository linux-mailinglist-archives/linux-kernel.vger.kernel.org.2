Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24AFF377EDF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 11:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbhEJJD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 05:03:59 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2738 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbhEJJD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 05:03:57 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fdw3R1kwczqV1M;
        Mon, 10 May 2021 16:59:31 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Mon, 10 May 2021 17:02:44 +0800
From:   Hui Tang <tanghui20@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] crypto: extend 'cra_driver_name' with curve name
Date:   Mon, 10 May 2021 16:59:46 +0800
Message-ID: <1620637188-36988-1-git-send-email-tanghui20@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend initialization of ecdh 'cra_driver_name' with curve name.

Hui Tang (2):
  crypto: ecdh - extend 'cra_driver_name' with curve name
  crypto: hisilicon/hpre - extend 'cra_driver_name' with curve name

 crypto/ecdh.c                               | 4 ++--
 drivers/crypto/hisilicon/hpre/hpre_crypto.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

--
2.8.1

