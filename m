Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7863F7126
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 10:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbhHYIfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 04:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbhHYIfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 04:35:30 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229E4C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 01:34:45 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1629880482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nMKSuVzaG2Rrxo6b48p2rwBfxxJ2KT7SrwxgTpDKdz0=;
        b=J22GtAjAyUq+4ucuS9rnaXAJPz3AmlaomyblNnodTKKXjcUDkTQUDguILGqFq6bgkDPIza
        smdbouKnfcQw9F0inhuiY6JsfHFz73WhlkgWu4f4PlnxJxpDGCqDZqHVqEO9OUeD3GeNrj
        J6qiPsxHSJdpaU5r8E9VP8T3+oZikYw=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     bhelgaas@google.com, arnd@arndb.de, robh@kernel.org,
        lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH linux-next] PCI: Fix the order in unregister path
Date:   Wed, 25 Aug 2021 16:34:25 +0800
Message-Id: <20210825083425.32740-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: yajun.deng@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

device_del() should be called first and then called put_device() in
unregister path, becase if that the final reference count, the device
will be cleaned up via device_release() above. So use device_unregister()
instead.

Fixes: 9885440b16b8 (PCI: Fix pci_host_bridge struct device release/free handling)
Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 drivers/pci/probe.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 0ec5c792c27d..abd481a15a17 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -994,9 +994,7 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	return 0;
 
 unregister:
-	put_device(&bridge->dev);
-	device_del(&bridge->dev);
-
+	device_unregister(&bridge->dev);
 free:
 	kfree(bus);
 	return err;
-- 
2.32.0

