Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838BE3A8F0A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 04:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbhFPCxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 22:53:21 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:10079 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbhFPCxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 22:53:20 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G4V424bJDzZfBy;
        Wed, 16 Jun 2021 10:48:18 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 10:51:13 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 16 Jun
 2021 10:51:13 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>
CC:     <perex@perex.cz>, <tiwai@suse.com>, <broonie@kernel.org>
Subject: [PATCH -next] ALSA: fm801: Fix missing pci_release_regions() on error in snd_fm801_create()
Date:   Wed, 16 Jun 2021 10:55:07 +0800
Message-ID: <20210616025507.2120103-1-yangyingliang@huawei.com>
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

Fix the missing pci_release_regions() before return
from snd_fm801_create() in the error handling case.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 sound/pci/fm801.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/fm801.c b/sound/pci/fm801.c
index ed9dae87145b..adac9c6a67f0 100644
--- a/sound/pci/fm801.c
+++ b/sound/pci/fm801.c
@@ -1254,6 +1254,7 @@ static int snd_fm801_create(struct snd_card *card,
 				IRQF_SHARED, KBUILD_MODNAME, chip)) {
 			dev_err(card->dev, "unable to grab IRQ %d\n", pci->irq);
 			snd_fm801_free(chip);
+			pci_release_regions(pci);
 			return -EBUSY;
 		}
 		chip->irq = pci->irq;
@@ -1266,6 +1267,7 @@ static int snd_fm801_create(struct snd_card *card,
 	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
 	if (err < 0) {
 		snd_fm801_free(chip);
+		pci_release_regions(pci);
 		return err;
 	}
 
@@ -1273,6 +1275,7 @@ static int snd_fm801_create(struct snd_card *card,
 	err = v4l2_device_register(&pci->dev, &chip->v4l2_dev);
 	if (err < 0) {
 		snd_fm801_free(chip);
+		pci_release_regions(pci);
 		return err;
 	}
 	chip->tea.v4l2_dev = &chip->v4l2_dev;
@@ -1285,6 +1288,7 @@ static int snd_fm801_create(struct snd_card *card,
 		if (snd_tea575x_init(&chip->tea, THIS_MODULE)) {
 			dev_err(card->dev, "TEA575x radio not found\n");
 			snd_fm801_free(chip);
+			pci_release_regions(pci);
 			return -ENODEV;
 		}
 	} else if ((chip->tea575x_tuner & TUNER_TYPE_MASK) == 0) {
-- 
2.25.1

