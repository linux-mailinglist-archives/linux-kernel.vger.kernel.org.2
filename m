Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25E0E3AAA2B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 06:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhFQEhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 00:37:08 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:7313 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbhFQEhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 00:37:07 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4G58Gs1WF5z1BMGR;
        Thu, 17 Jun 2021 12:29:57 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 12:34:59 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 17 Jun
 2021 12:34:58 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
CC:     <olivier.moysan@foss.st.com>, <broonie@kernel.org>
Subject: [PATCH -next 0/3] ASoC: stm32: Use devm_platform_get_and_ioremap_resource()
Date:   Thu, 17 Jun 2021 12:38:44 +0800
Message-ID: <20210617043847.1113092-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_get_and_ioremap_resource() to simplify
code.

Yang Yingliang (3):
  ASoC: stm32: i2s: Use devm_platform_get_and_ioremap_resource()
  ASoC: stm32: sai: Use devm_platform_get_and_ioremap_resource()
  ASoC: stm32: spdifrx: Use devm_platform_get_and_ioremap_resource()

 sound/soc/stm/stm32_i2s.c     | 3 +--
 sound/soc/stm/stm32_sai_sub.c | 3 +--
 sound/soc/stm/stm32_spdifrx.c | 3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

-- 
2.25.1

