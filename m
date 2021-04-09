Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA5633597B7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 10:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbhDIIYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 04:24:10 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16111 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbhDIIYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 04:24:03 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FGrh05m9sz17Qtp;
        Fri,  9 Apr 2021 16:21:36 +0800 (CST)
Received: from huawei.com (10.67.174.37) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.498.0; Fri, 9 Apr 2021
 16:23:47 +0800
From:   Chen Hui <clare.chenhui@huawei.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <mani@kernel.org>,
        <georgi.djakov@linaro.org>, <sivaprak@codeaurora.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 -next 0/3] Add missing MODULE_DEVICE_TABLE
Date:   Fri, 9 Apr 2021 16:23:49 +0800
Message-ID: <20210409082352.233810-1-clare.chenhui@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.37]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:
- separate from one patch into three patches
- add fixes tags

Chen Hui (3):
  clk: qcom: a7-pll: Add missing MODULE_DEVICE_TABLE
  clk: qcom: a53-pll: Add missing MODULE_DEVICE_TABLE
  clk: qcom: apss-ipq-pll: Add missing MODULE_DEVICE_TABLE

 drivers/clk/qcom/a53-pll.c      | 1 +
 drivers/clk/qcom/a7-pll.c       | 1 +
 drivers/clk/qcom/apss-ipq-pll.c | 1 +
 3 files changed, 3 insertions(+)

-- 
2.17.1

