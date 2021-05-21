Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1D1F38C456
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 12:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbhEUKHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 06:07:20 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3616 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhEUKHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 06:07:12 -0400
Received: from dggems704-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fmhwm2QLKzQqYy;
        Fri, 21 May 2021 18:02:16 +0800 (CST)
Received: from dggpeml500012.china.huawei.com (7.185.36.15) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 21 May 2021 18:05:48 +0800
Received: from huawei.com (10.67.165.24) by dggpeml500012.china.huawei.com
 (7.185.36.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 21 May
 2021 18:05:48 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <yekai13@huawei.com>
Subject: [PATCH v2 0/2] crypto: hisilicon/qm - add dfx log and a bugfix
Date:   Fri, 21 May 2021 18:02:42 +0800
Message-ID: <1621591364-46526-1-git-send-email-yekai13@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500012.china.huawei.com (7.185.36.15)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds the dfx log and fixes an algorithm registration bug.

changes v1->v2:
modify the patchset commits

Kai Ye (2):
  crypto: hisilicon/qm - add dfx log if not use hardware crypto algs
  crypto: hisilicon/qm - fix the process of VF's list adding

 drivers/crypto/hisilicon/qm.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

-- 
2.8.1

