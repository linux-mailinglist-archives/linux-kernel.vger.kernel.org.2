Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDCC35808E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 12:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbhDHK06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 06:26:58 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15183 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhDHK0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 06:26:48 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FGHRS6gTkzpW0m;
        Thu,  8 Apr 2021 18:23:48 +0800 (CST)
Received: from huawei.com (10.67.165.24) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.498.0; Thu, 8 Apr 2021
 18:26:25 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yekai13@huawei.com>
Subject: [PATCH 0/2] crypto: correct the use of print format
Date:   Thu, 8 Apr 2021 18:23:49 +0800
Message-ID: <1617877431-38290-1-git-send-email-yekai13@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to Documentation/core-api/printk-formats.rst,
Use the correct print format. Printing an unsigned int value should use %u
instead of %d. Otherwise printk() might end up displaying negative numbers.

Kai Ye (2):
  crypto/atmel - use the correct print format
  crypto: hisilicon/sec_drv - use the correct print format

 drivers/crypto/atmel-i2c.c             | 2 +-
 drivers/crypto/atmel-sha.c             | 4 ++--
 drivers/crypto/hisilicon/sec/sec_drv.c | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.8.1

