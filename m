Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B783442B36F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 05:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237372AbhJMD2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 23:28:38 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:23371 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237237AbhJMD2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 23:28:34 -0400
Received: from dggeme754-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HTdB30JgjzQrl5;
        Wed, 13 Oct 2021 11:22:03 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme754-chm.china.huawei.com
 (10.3.19.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Wed, 13
 Oct 2021 11:26:30 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dgilbert@interlog.com>, <bvanassche@acm.org>
CC:     Ye Bin <yebin10@huawei.com>
Subject: [PATCH v2 resend 0/2] Fix out-of-bound read in resp_readcap16 and resp_report_tgtpgs
Date:   Wed, 13 Oct 2021 11:39:11 +0800
Message-ID: <20211013033913.2551004-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme754-chm.china.huawei.com (10.3.19.100)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ye Bin (2):
  scsi:scsi_debug: Fix out-of-bound read in resp_readcap16
  scsi:scsi_debug:Fix out-of-bound read in resp_report_tgtpgs

 drivers/scsi/scsi_debug.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

-- 
2.31.1

