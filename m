Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77459380B12
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 16:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbhENOH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 10:07:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:60768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231741AbhENOH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 10:07:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B931B613AA;
        Fri, 14 May 2021 14:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621001206;
        bh=nHTZMSK+yEqpxl4W9Y9GO2JE7UoHrXNsgOeH/QMmN9Q=;
        h=From:To:Cc:Subject:Date:From;
        b=Pf/86j8aE1XOGzSl3qKGLry2tWtd6/r1VF90fB8gacEdIFbrzOhXVr0nmxbuTrM3t
         W2hS3f6VSSvHzc9+AxOisxiCMdsHra6wIJgar1JiDrSxm7W31kNzqq9fb2gD8Znr53
         Pli9pWB/c7VNA79CN0nZJkmRgvdmHOlb99NFfnLX5COIa0gySzQNpHC1nX12X9rHPp
         YSSUZqPsqQ7QQveJnsuGyjyaCqBkQtWAgkMco+s8HNWeHQpKRDhRwpdRJS9qpO9tnl
         ffZjUW7KbqTa7PfQoM4WSDNA3ZKhdwK5jNWDrull8TPkwc5FF8wPJT6qq6n4ggDn6A
         LJW1a1Oc+opBQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH] platform/surface: aggregator: shut up clang -Wconstantn-conversion warning
Date:   Fri, 14 May 2021 16:05:46 +0200
Message-Id: <20210514140556.3492544-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Clang complains about the assignment of SSAM_ANY_IID to
ssam_device_uid->instance:

drivers/platform/surface/surface_aggregator_registry.c:478:25: error: implicit conversion from 'int' to '__u8' (aka 'unsigned char') changes value from 65535 to 255 [-Werror,-Wconstant-conversion]
        { SSAM_VDEV(HUB, 0x02, SSAM_ANY_IID, 0x00) },
        ~                      ^~~~~~~~~~~~
include/linux/surface_aggregator/device.h:71:23: note: expanded from macro 'SSAM_ANY_IID'
 #define SSAM_ANY_IID            0xffff
                                ^~~~~~
include/linux/surface_aggregator/device.h:126:63: note: expanded from macro 'SSAM_VDEV'
        SSAM_DEVICE(SSAM_DOMAIN_VIRTUAL, SSAM_VIRTUAL_TC_##cat, tid, iid, fun)
                                                                     ^~~
include/linux/surface_aggregator/device.h:102:41: note: expanded from macro 'SSAM_DEVICE'
        .instance = ((iid) != SSAM_ANY_IID) ? (iid) : 0,                        \
                                               ^~~

The assignment doesn't actually happen, but clang checks the type limits
before checking whether this assignment is reached. Shut up the warning
using an explicit type cast.

Fixes: eb0e90a82098 ("platform/surface: aggregator: Add dedicated bus and device type")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/surface_aggregator/device.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/surface_aggregator/device.h b/include/linux/surface_aggregator/device.h
index 4441ad667c3f..90df092ed565 100644
--- a/include/linux/surface_aggregator/device.h
+++ b/include/linux/surface_aggregator/device.h
@@ -98,9 +98,9 @@ struct ssam_device_uid {
 		     | (((fun) != SSAM_ANY_FUN) ? SSAM_MATCH_FUNCTION : 0),	\
 	.domain   = d,								\
 	.category = cat,							\
-	.target   = ((tid) != SSAM_ANY_TID) ? (tid) : 0,			\
-	.instance = ((iid) != SSAM_ANY_IID) ? (iid) : 0,			\
-	.function = ((fun) != SSAM_ANY_FUN) ? (fun) : 0				\
+	.target   = ((tid) != SSAM_ANY_TID) ? (u8)(tid) : 0,			\
+	.instance = ((iid) != SSAM_ANY_IID) ? (u8)(iid) : 0,			\
+	.function = ((fun) != SSAM_ANY_FUN) ? (u8)(fun) : 0			\
 
 /**
  * SSAM_VDEV() - Initialize a &struct ssam_device_id as virtual device with
-- 
2.29.2

