Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFB55411282
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 12:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234395AbhITKEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 06:04:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:44590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235044AbhITKEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 06:04:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ADE9F60F5D;
        Mon, 20 Sep 2021 10:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632132197;
        bh=qQ9AyDsrctcDXELzmj5Hituf3OumUk7WbMIpeW9r0f0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DyBNcChRM2ShZDW/jEzXgMQR6gbIa8IH4nMyP5KLyeo691ydp88+Wj9htoQJ5l5b9
         lrP2J5Tj3x+wYimzQqL3Yf23Ij5u9lT0p3pqDWmCv0mQdLWMILRUC0jb7Rx40fpYMD
         dStyutE2QiORicJImP/7BbaGi1HCTK/zChMiYmmvkyjHZGaQ23OGMeFHJUyzepWxJX
         /H6zqRxA21nnJdUkjhwT1evocysNfariaPm5zZnUSzvo4KS2HDwjFpN2rDM+/JRMeR
         AyV5+XdbYGn8YHcS6r5ZCinW5Llfr12lARxZKRVmZPPJRhQgCQ9fe8qDTU7MSe0ZO1
         RW9nIU6FdAq+g==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Igor Skalkin <igor.skalkin@opensynergy.com>,
        Peter Hilber <peter.hilber@opensynergy.com>,
        Cristian Marussi <cristian.marussi@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] firmware: arm_scmi: remove __exit annotation
Date:   Mon, 20 Sep 2021 12:02:52 +0200
Message-Id: <20210920100301.1466486-2-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210920100301.1466486-1-arnd@kernel.org>
References: <20210920100301.1466486-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

virtio_scmi_exit() is only called from __exit function, so the annotation
is correct, but when the driver is built-in, the section gets discarded
and the reference from a callback pointer causes a link-time error:

`virtio_scmi_exit' referenced in section `.rodata' of drivers/firmware/arm_scmi/virtio.o: defined in discarded section `.exit.text' of drivers/firmware/arm_scmi/virtio.o

I could not figure out a better workaround, so let's just remove that
annotation even if it wastes a couple of bytes in .text.

Fixes: 46abe13b5e3d ("firmware: arm_scmi: Add virtio transport")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/firmware/arm_scmi/virtio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/virtio.c b/drivers/firmware/arm_scmi/virtio.c
index 224577f86928..8941bb40f2df 100644
--- a/drivers/firmware/arm_scmi/virtio.c
+++ b/drivers/firmware/arm_scmi/virtio.c
@@ -476,7 +476,7 @@ static int __init virtio_scmi_init(void)
 	return register_virtio_driver(&virtio_scmi_driver);
 }
 
-static void __exit virtio_scmi_exit(void)
+static void virtio_scmi_exit(void)
 {
 	unregister_virtio_driver(&virtio_scmi_driver);
 }
-- 
2.29.2

