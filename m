Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A2C41EB39
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 12:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353309AbhJAKz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 06:55:56 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3907 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352922AbhJAKzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 06:55:31 -0400
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HLRjH1Jc5z67lcR;
        Fri,  1 Oct 2021 18:50:43 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 1 Oct 2021 12:53:39 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 1 Oct 2021 11:53:37 +0100
From:   John Garry <john.garry@huawei.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, John Garry <john.garry@huawei.com>
Subject: [PATCH RESEND 0/2] Improve build test coverage for perf drivers
Date:   Fri, 1 Oct 2021 18:48:44 +0800
Message-ID: <1633085326-156653-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve build test coverage by allowing some more drivers build under
COMPILE_TEST as appropriate.

Baseline is v5.15-rc3

John Garry (2):
  drivers/perf: thunderx2_pmu: Change data in size
    tx2_uncore_event_update()
  drivers/perf: Improve build test coverage

 drivers/perf/Kconfig         | 12 +++++++-----
 drivers/perf/thunderx2_pmu.c |  2 +-
 2 files changed, 8 insertions(+), 6 deletions(-)

-- 
2.26.2

