Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 735993A7472
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 04:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhFOC4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 22:56:13 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:7262 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhFOC4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 22:56:12 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4G3rNg31Shz1BMYl;
        Tue, 15 Jun 2021 09:30:27 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 09:35:25 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 15 Jun
 2021 09:35:24 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <alsa-devel@alsa-project.org>
CC:     <timur@kernel.org>, <broonie@kernel.org>
Subject: [PATCH -next v2 0/9] ASoC: fsl: Use devm_platform_get_and_ioremap_resource()
Date:   Tue, 15 Jun 2021 09:39:13 +0800
Message-ID: <20210615013922.784296-1-yangyingliang@huawei.com>
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

patch #1 ~ #8:
  Use devm_platform_get_and_ioremap_resource()

patch #9
  check return value of platform_get_resource_byname()

v2:
  change error message in patch #9

Yang Yingliang (9):
  ASoC: fsl_asrc: Use devm_platform_get_and_ioremap_resource()
  ASoC: fsl_aud2htx: Use devm_platform_get_and_ioremap_resource()
  ASoC: fsl_easrc: Use devm_platform_get_and_ioremap_resource()
  ASoC: fsl_esai: Use devm_platform_get_and_ioremap_resource()
  ASoC: fsl_micfil: Use devm_platform_get_and_ioremap_resource()
  ASoC: fsl_sai: Use devm_platform_get_and_ioremap_resource()
  ASoC: fsl_spdif: Use devm_platform_get_and_ioremap_resource()
  ASoC: fsl_ssi: Use devm_platform_get_and_ioremap_resource()
  ASoC: fsl_xcvr: check return value after calling
    platform_get_resource_byname()

 sound/soc/fsl/fsl_asrc.c    | 3 +--
 sound/soc/fsl/fsl_aud2htx.c | 3 +--
 sound/soc/fsl/fsl_easrc.c   | 3 +--
 sound/soc/fsl/fsl_esai.c    | 3 +--
 sound/soc/fsl/fsl_micfil.c  | 3 +--
 sound/soc/fsl/fsl_sai.c     | 3 +--
 sound/soc/fsl/fsl_spdif.c   | 3 +--
 sound/soc/fsl/fsl_ssi.c     | 3 +--
 sound/soc/fsl/fsl_xcvr.c    | 4 ++++
 9 files changed, 12 insertions(+), 16 deletions(-)

-- 
2.25.1

