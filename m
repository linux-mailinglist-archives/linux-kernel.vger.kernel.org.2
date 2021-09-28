Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A790641B7B0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 21:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242505AbhI1Tkz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Sep 2021 15:40:55 -0400
Received: from mail1.shanghaitech.edu.cn ([119.78.254.90]:46269 "EHLO
        mail.shanghaitech.edu.cn" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S241529AbhI1Tkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 15:40:52 -0400
Received: from [10.15.44.215] by mail.shanghaitech.edu.cn with MESSAGESEC ESMTP id 456895720416615;
        Wed, 29 Sep 2021 03:38:59 +0800 (CST)
Received: from DESKTOP-FOJ6ELG.localdomain (10.15.44.220) by
 smtp.shanghaitech.edu.cn (10.15.44.215) with Microsoft SMTP Server (TLS) id
 14.3.399.0; Wed, 29 Sep 2021 03:38:57 +0800
From:   Mianhan Liu <liumh1@shanghaitech.edu.cn>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Mianhan Liu <liumh1@shanghaitech.edu.cn>
Subject: [PATCH -next] drivers/base/component.c: remove superfluous header files from component.c
Date:   Wed, 29 Sep 2021 03:38:49 +0800
Message-ID: <20210928193849.28717-1-liumh1@shanghaitech.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain
X-Originating-IP: [10.15.44.220]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

component.c hasn't use any macro or function declared in linux/kref.h.
Thus, these files can be removed from component.c safely without
affecting the compilation of the drivers/base/ module

Signed-off-by: Mianhan Liu <liumh1@shanghaitech.edu.cn>

---
 drivers/base/component.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/base/component.c b/drivers/base/component.c
index 5e79299f6..6dc309913 100644
--- a/drivers/base/component.c
+++ b/drivers/base/component.c
@@ -9,7 +9,6 @@
  */
 #include <linux/component.h>
 #include <linux/device.h>
-#include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
-- 
2.25.1


