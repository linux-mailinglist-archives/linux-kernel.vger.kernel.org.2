Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50CE845E42B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 02:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357539AbhKZB4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 20:56:10 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:14982 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357472AbhKZByI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 20:54:08 -0500
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4J0d1c2PBmzZd2n;
        Fri, 26 Nov 2021 09:48:20 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 26 Nov
 2021 09:50:54 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <damien.lemoal@opensource.wdc.com>, <axboe@kernel.dk>,
        <tj@kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <sergei.shtylyov@gmail.com>, <yebin10@huawei.com>,
        <libaokun1@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH -next V5 0/2] fix two bugs when trying rmmod sata_fsl
Date:   Fri, 26 Nov 2021 10:03:05 +0800
Message-ID: <20211126020307.2168767-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V1->V2:
	Fixed the check on the return value of platform_get_irq().
	And propagate errors up to sata_fsl_probe()'s callers.
V2->V3:
	Add fixed and CC stable and modified the patch description.
V3->V4:
	Use a single structure.
V4->V5:
	Delete duplicate dev_err() message.

Baokun Li (2):
  sata_fsl: fix UAF in sata_fsl_port_stop when rmmod sata_fsl
  sata_fsl: fix warning in remove_proc_entry when rmmod sata_fsl

 drivers/ata/sata_fsl.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

-- 
2.31.1

