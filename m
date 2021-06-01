Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA74D396BAF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 04:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbhFAC6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 22:58:48 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:6099 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbhFAC6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 22:58:45 -0400
Received: from dggeme759-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FvGvt2ttjzYmbn;
        Tue,  1 Jun 2021 10:54:18 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggeme759-chm.china.huawei.com (10.3.19.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 1 Jun 2021 10:57:01 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <song.bao.hua@hisilicon.com>
CC:     Tian Tao <tiantao6@hisilicon.com>
Subject: [PATCH 0/2] use bin_attribute to avoid buff overflow
Date:   Tue, 1 Jun 2021 10:56:48 +0800
Message-ID: <1622516210-10886-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeme759-chm.china.huawei.com (10.3.19.105)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch adds a new function cpumap_print_to_buf and uses
this function in drivers/base/topology.c, and the second patch uses
this new function in drivers/base/node.c

Tian Tao (2):
  topology: use bin_attribute to avoid buff overflow
  drivers/base/node.c: use bin_attribute to avoid buff overflow

 drivers/base/node.c     |  49 +++++++++++++--------
 drivers/base/topology.c | 115 ++++++++++++++++++++++++++----------------------
 include/linux/bitmap.h  |   3 ++
 include/linux/cpumask.h |  25 +++++++++++
 lib/bitmap.c            |  34 ++++++++++++++
 5 files changed, 156 insertions(+), 70 deletions(-)

-- 
2.7.4

