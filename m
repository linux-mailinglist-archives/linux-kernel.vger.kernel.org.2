Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C62A5460EC3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 07:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240966AbhK2GjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 01:39:09 -0500
Received: from mx24.baidu.com ([111.206.215.185]:41724 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233923AbhK2GhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 01:37:09 -0500
Received: from BC-Mail-EX04.internal.baidu.com (unknown [172.31.51.44])
        by Forcepoint Email with ESMTPS id AD0D8A1E29CE0D499B80;
        Mon, 29 Nov 2021 14:33:44 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-EX04.internal.baidu.com (172.31.51.44) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Mon, 29 Nov 2021 14:33:44 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Mon, 29 Nov 2021 14:33:44 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Jyri Sarha <jyri.sarha@iki.fi>, Tomi Valkeinen <tomba@kernel.org>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/tidss: Fix warning: unused variable 'tidss_pm_ops'
Date:   Mon, 29 Nov 2021 14:33:46 +0800
Message-ID: <20211129063347.404-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex11.internal.baidu.com (172.31.51.51) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark 'tidss_pm_ops' as __maybe_unused to avoid
the warning: unused variable 'tidss_pm_ops'

Fixes: 6e120594631f ("drm/tidss: Make use of the helper macro SET_RUNTIME_PM_OPS()")
Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/gpu/drm/tidss/tidss_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tidss/tidss_drv.c b/drivers/gpu/drm/tidss/tidss_drv.c
index 4366b5c798e0..7c784e90e40e 100644
--- a/drivers/gpu/drm/tidss/tidss_drv.c
+++ b/drivers/gpu/drm/tidss/tidss_drv.c
@@ -88,7 +88,7 @@ static int __maybe_unused tidss_resume(struct device *dev)
 	return drm_mode_config_helper_resume(&tidss->ddev);
 }
 
-static const struct dev_pm_ops tidss_pm_ops = {
+static __maybe_unused const struct dev_pm_ops tidss_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(tidss_suspend, tidss_resume)
 	SET_RUNTIME_PM_OPS(tidss_pm_runtime_suspend, tidss_pm_runtime_resume, NULL)
 };
-- 
2.25.1

