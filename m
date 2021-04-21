Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E89D3670ED
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 19:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244638AbhDURIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 13:08:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45071 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244618AbhDURIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 13:08:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619024844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fKYnlKH/ve8gc+F/YlsL5K2ivrBshU263RafrikX1Ew=;
        b=JaOSgHNWEQTcvrqFf+qbZEF2sepv1lIK+DBaBQ3jP+tZvy7tS1s32/fvSZDreW7VD4Mbep
        MkbnTHkcRW8MjKZEti8u96e9+fx7xMsv6tB+AFksNm8Y24OFGDjOwrQI+96e4RTyaKXc3R
        u74E6UMeoANXOQnQM2CpgaHIiTXSIrk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-5krZEk2jOC-yj9xD9bzPaQ-1; Wed, 21 Apr 2021 13:07:07 -0400
X-MC-Unique: 5krZEk2jOC-yj9xD9bzPaQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0605E10054F6;
        Wed, 21 Apr 2021 17:07:04 +0000 (UTC)
Received: from kasong-rh-laptop.redhat.com (ovpn-12-46.pek2.redhat.com [10.72.12.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A118419D80;
        Wed, 21 Apr 2021 17:07:02 +0000 (UTC)
From:   Kairui Song <kasong@redhat.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Kairui Song <kasong@redhat.com>
Subject: [PATCH] ARM: mark free_initrd_mem as __init
Date:   Thu, 22 Apr 2021 00:34:38 +0800
Message-Id: <20210421163438.1719964-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

free_initrd_mem is only called from __init functions, and only used
during boot, so mark it __init.

Signed-off-by: Kairui Song <kasong@redhat.com>
---
 arch/arm/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 828a2561b229..6db5c0d37d95 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -528,7 +528,7 @@ void free_initmem(void)
 }
 
 #ifdef CONFIG_BLK_DEV_INITRD
-void free_initrd_mem(unsigned long start, unsigned long end)
+void __init free_initrd_mem(unsigned long start, unsigned long end)
 {
 	if (start == initrd_start)
 		start = round_down(start, PAGE_SIZE);
-- 
2.30.2

