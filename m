Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFB73A95AC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 11:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbhFPJPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 05:15:22 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:7332 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbhFPJPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 05:15:19 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4G4fWT32lNz6yGQ;
        Wed, 16 Jun 2021 17:09:09 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 17:13:00 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 16 Jun
 2021 17:13:00 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>
CC:     <krzysztof.kozlowski@canonical.com>, <s.nawrocki@samsung.com>,
        <broonie@kernel.org>
Subject: [PATCH -next 0/4] ASoC: samsung: Use devm_platform_get_and_ioremap_resource()
Date:   Wed, 16 Jun 2021 17:16:48 +0800
Message-ID: <20210616091652.2552927-1-yangyingliang@huawei.com>
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

Yang Yingliang (4):
  ASoC: samsung: i2s: Use devm_platform_get_and_ioremap_resource()
  ASoC: samsung: pcm: Use devm_platform_get_and_ioremap_resource()
  ASoC: samsung: s3c2412-i2s: Use
    devm_platform_get_and_ioremap_resource()
  ASoC: samsung: s3c24xx-i2s: Use
    devm_platform_get_and_ioremap_resource()

 sound/soc/samsung/i2s.c         | 3 +--
 sound/soc/samsung/pcm.c         | 3 +--
 sound/soc/samsung/s3c2412-i2s.c | 3 +--
 sound/soc/samsung/s3c24xx-i2s.c | 3 +--
 4 files changed, 4 insertions(+), 8 deletions(-)

-- 
2.25.1

