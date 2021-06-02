Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 570F339887D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 13:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbhFBLpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 07:45:41 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2962 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhFBLpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 07:45:40 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Fw6Y513pjz68WK;
        Wed,  2 Jun 2021 19:40:57 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 19:43:55 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 19:43:54 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Lee Jones <lee.jones@linaro.org>,
        patches <patches@opensource.cirrus.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 0/9] mfd: use DEVICE_ATTR_* macro to simplify code
Date:   Wed, 2 Jun 2021 19:43:30 +0800
Message-ID: <20210602114339.11223-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DEVICE_ATTR_RO marks ReadOnly file, DEVICE_ATTR_RW marks ReadWrite file, etc..
it's clearer than DEVICE_ATTR.

Zhen Lei (9):
  mfd: wm831x: use DEVICE_ATTR_RO macro
  mfd: ucb1x00-assabet: use DEVICE_ATTR_RO macro
  mfd: timberdale: use DEVICE_ATTR_RO macro
  mfd: sm501: use DEVICE_ATTR_RO macro
  mfd: pcf50633: use DEVICE_ATTR_ADMIN_RO macro
  mfd: kempld-core: use DEVICE_ATTR_RO macro
  mfd: janz-cmodio: use DEVICE_ATTR_RO macro
  mfd: intel_soc_pmic_bxtwc: use DEVICE_ATTR_ADMIN_RW macro
  mfd: ab8500-core: use DEVICE_ATTR_RO/RW macro

 drivers/mfd/ab8500-core.c          | 33 +++++++++++++++---------------
 drivers/mfd/intel_soc_pmic_bxtwc.c | 20 +++++++++---------
 drivers/mfd/janz-cmodio.c          |  6 +++---
 drivers/mfd/kempld-core.c          | 19 ++++++++---------
 drivers/mfd/pcf50633-core.c        | 12 +++++------
 drivers/mfd/sm501.c                |  8 ++++----
 drivers/mfd/timberdale.c           |  6 +++---
 drivers/mfd/ucb1x00-assabet.c      |  2 +-
 drivers/mfd/wm831x-otp.c           |  6 +++---
 9 files changed, 55 insertions(+), 57 deletions(-)

-- 
2.26.0.106.g9fadedd


