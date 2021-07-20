Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A313CF494
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 08:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242088AbhGTFyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 01:54:37 -0400
Received: from mx21.baidu.com ([220.181.3.85]:38896 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242043AbhGTFyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 01:54:21 -0400
Received: from BJHW-Mail-Ex01.internal.baidu.com (unknown [10.127.64.11])
        by Forcepoint Email with ESMTPS id 969EAFD35FF82B9BC42D;
        Tue, 20 Jul 2021 14:34:42 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-Mail-Ex01.internal.baidu.com (10.127.64.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Tue, 20 Jul 2021 14:34:42 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Tue, 20 Jul 2021 14:34:41 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <Felix.Kuehling@amd.com>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <Xinhui.Pan@amd.com>,
        <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, Cai Huoqing <caihuoqing@baidu.com>
Subject: [PATCH] drm/amdkfd: move PTR_ERR under IS_ERR() condition
Date:   Tue, 20 Jul 2021 14:34:35 +0800
Message-ID: <20210720063435.373-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex14.internal.baidu.com (172.31.51.54) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

no need to get error code when IS_ERR is false

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index e48acdd03c1a..710659b3c1f0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -72,16 +72,18 @@ int kfd_chardev_init(void)
                goto err_register_chrdev;

        kfd_class = class_create(THIS_MODULE, kfd_dev_name);
-       err = PTR_ERR(kfd_class);
-       if (IS_ERR(kfd_class))
+       if (IS_ERR(kfd_class)) {
+               err = PTR_ERR(kfd_class);
                goto err_class_create;
+       }

        kfd_device = device_create(kfd_class, NULL,
                                        MKDEV(kfd_char_dev_major, 0),
                                        NULL, kfd_dev_name);
-       err = PTR_ERR(kfd_device);
-       if (IS_ERR(kfd_device))
+       if (IS_ERR(kfd_device)) {
+               err = PTR_ERR(kfd_device);
                goto err_device_create;
+       }

        return 0;

--
2.25.1

