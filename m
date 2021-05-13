Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D21FA37F8C2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 15:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbhEMN3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 09:29:47 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3748 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233969AbhEMN3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 09:29:10 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fgsnv4Sy7zqTcx;
        Thu, 13 May 2021 21:24:35 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Thu, 13 May 2021 21:27:53 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <mike.leach@linaro.org>
CC:     <coresight@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>
Subject: [PATCH 0/3] coresight: Few cleanups
Date:   Thu, 13 May 2021 21:27:46 +0800
Message-ID: <1620912469-52222-1-git-send-email-liuqi115@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is just a clean up and should not cause a functional change.

Junhao He (3):
  coresight: core: Fix use of uninitialized pointer
  coresight: core: Remove unnecessary assignment
  coresight: etm4x: core: Remove redundant check of attr

 drivers/hwtracing/coresight/coresight-core.c       | 3 +--
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 5 -----
 2 files changed, 1 insertion(+), 7 deletions(-)

-- 
2.7.4

