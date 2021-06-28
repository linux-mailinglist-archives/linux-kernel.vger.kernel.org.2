Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B72E43B5E1B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 14:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbhF1MiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 08:38:11 -0400
Received: from mail-m121144.qiye.163.com ([115.236.121.144]:48776 "EHLO
        mail-m121144.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232514AbhF1MiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 08:38:10 -0400
DKIM-Signature: a=rsa-sha256;
        b=ixfloo1MHAWjR+Nz1ljxCUSePHF3wpONviFosozKxXdBrokr1sqoqNmMZtUXIVTY1gmvoQ5brfzvheAOZwDjfDqOJRgRmquAi+MzNDC6vonmRO+fXYwCCVJDa0hMafmTLCONe2uIhzD2uuolKLtSoxYMOICSAkUfcfi09KzXt+g=;
        c=relaxed/relaxed; s=default; d=vivo.com; v=1;
        bh=xpl7brLCo2gGrul+NZ+CKYfqW57kbhKm/BKbSTcLQ54=;
        h=date:mime-version:subject:message-id:from;
Received: from Wanjb.localdomain (unknown [36.152.145.182])
        by mail-m121144.qiye.163.com (Hmail) with ESMTPA id 0D13CAC00A6;
        Mon, 28 Jun 2021 20:35:38 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] lkdtm: remove duplicated include of init.h
Date:   Mon, 28 Jun 2021 20:35:12 +0800
Message-Id: <20210628123512.38090-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQx9CHlYYGk4YSE5CSExITUJVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NhQ6LSo5Hz9KEDQ8NCI0Iw0J
        PU0KFBVVSlVKTUlPQ0NITEhDT09PVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFKT09NNwY+
X-HM-Tid: 0a7a529e3622b039kuuu0d13cac00a6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following checkincludes.pl warning:
./drivers/misc/lkdtm/core.c
26	#include <linux/init.h>
    29	#include <linux/init.h>

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/misc/lkdtm/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index 9dda87c6b54a..c9a0ad6d5d72 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -26,7 +26,6 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/debugfs.h>
-#include <linux/init.h>
 
 #define DEFAULT_COUNT 10
 
-- 
2.20.1

