Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1FE83CFBC0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 16:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239226AbhGTNdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 09:33:00 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:11460 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239262AbhGTN1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 09:27:08 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GTg3r6TChzcbXY;
        Tue, 20 Jul 2021 21:46:32 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 20 Jul 2021 21:49:55 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 20 Jul
 2021 21:49:54 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>
CC:     <tiwai@suse.com>, <perex@perex.cz>
Subject: [PATCH -next] ALSA: nm256: Fix error return code in snd_nm256_create()
Date:   Tue, 20 Jul 2021 21:52:37 +0800
Message-ID: <20210720135237.3424521-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If pci_request_regions() fails, it should return error
code in snd_nm256_create().

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 sound/pci/nm256/nm256.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/nm256/nm256.c b/sound/pci/nm256/nm256.c
index a54b9b26a0c2..c9c178504959 100644
--- a/sound/pci/nm256/nm256.c
+++ b/sound/pci/nm256/nm256.c
@@ -1478,7 +1478,8 @@ snd_nm256_create(struct snd_card *card, struct pci_dev *pci)
 	chip->buffer_addr = pci_resource_start(pci, 0);
 	chip->cport_addr = pci_resource_start(pci, 1);
 
-	if (pci_request_regions(pci, card->driver))
+	err = pci_request_regions(pci, card->driver);
+	if (err < 0)
 		return err;
 
 	/* Init the memory port info.  */
-- 
2.25.1

