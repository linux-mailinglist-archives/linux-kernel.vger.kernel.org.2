Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F47B37F419
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 10:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbhEMIdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 04:33:53 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:2660 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbhEMIdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 04:33:52 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FglGX0m76zlcB5;
        Thu, 13 May 2021 16:30:28 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Thu, 13 May 2021 16:32:31 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <vaibhav.sr@gmail.com>, <mgreer@animalcreek.com>,
        <johan@kernel.org>, <elder@kernel.org>,
        <gregkh@linuxfoundation.org>
CC:     <greybus-dev@lists.linaro.org>, <linux-staging@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] staging: greybus: audio: Add missing MODULE_DEVICE_TABLE
Date:   Thu, 13 May 2021 16:49:32 +0800
Message-ID: <1620895772-52538-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds missing MODULE_DEVICE_TABLE definition which generates
correct modalias for automatic loading of this driver when it is built
as an external module.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/staging/greybus/audio_codec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/greybus/audio_codec.c b/drivers/staging/greybus/audio_codec.c
index b589cf6..6fa9781 100644
--- a/drivers/staging/greybus/audio_codec.c
+++ b/drivers/staging/greybus/audio_codec.c
@@ -1086,6 +1086,7 @@ static const struct of_device_id greybus_asoc_machine_of_match[]  = {
 	{ .compatible = "toshiba,apb-dummy-codec", },
 	{},
 };
+MODULE_DEVICE_TABLE(of, greybus_asoc_machine_of_match);
 
 static struct platform_driver gbaudio_codec_driver = {
 	.driver = {
-- 
2.6.2

