Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF0C349130
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 12:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhCYLsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 07:48:16 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14475 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbhCYLro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 07:47:44 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F5jwP513wzrZfJ;
        Thu, 25 Mar 2021 19:45:41 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Thu, 25 Mar 2021 19:47:34 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <airlied@linux.ie>
CC:     <linux-kernel@vger.kernel.org>, Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] agp: uninorth: Make some symbols static
Date:   Thu, 25 Mar 2021 20:04:33 +0800
Message-ID: <1616673873-111859-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sparse tool complains as follows:

drivers/char/agp/uninorth-agp.c:510:32: warning:
 symbol 'uninorth_agp_driver' was not declared. Should it be static?
drivers/char/agp/uninorth-agp.c:538:32: warning:
 symbol 'u3_agp_driver' was not declared. Should it be static?

This symbol is not used outside of uninorth-agp.c, so this
commit marks it static.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/char/agp/uninorth-agp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/agp/uninorth-agp.c b/drivers/char/agp/uninorth-agp.c
index 62de7f4..06db04c 100644
--- a/drivers/char/agp/uninorth-agp.c
+++ b/drivers/char/agp/uninorth-agp.c
@@ -507,7 +507,7 @@ static const struct aper_size_info_32 u3_sizes[] =
 	{4, 1024, 0, 1}
 };
 
-const struct agp_bridge_driver uninorth_agp_driver = {
+static const struct agp_bridge_driver uninorth_agp_driver = {
 	.owner			= THIS_MODULE,
 	.aperture_sizes		= (void *)uninorth_sizes,
 	.size_type		= U32_APER_SIZE,
@@ -535,7 +535,7 @@ const struct agp_bridge_driver uninorth_agp_driver = {
 	.needs_scratch_page	= true,
 };
 
-const struct agp_bridge_driver u3_agp_driver = {
+static const struct agp_bridge_driver u3_agp_driver = {
 	.owner			= THIS_MODULE,
 	.aperture_sizes		= (void *)u3_sizes,
 	.size_type		= U32_APER_SIZE,
-- 
2.6.2

