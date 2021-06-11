Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 582FE3A3A87
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 05:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbhFKDxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 23:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhFKDxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 23:53:34 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6350EC0617AD
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 20:51:24 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id e20so1423514pgg.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 20:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=wkd+psqbxttkDtNMuavQIcbFyZNe+XjsMd8VM7sojkI=;
        b=JE3Ka7tzFc86cVsvB8jDnClacgUNXr8fr7M5bfL86aoyBQTPxUZSC4+jzCWP/GjsYG
         Y/05AKjPYV/OGQxQCbP9TJLaKvQE5g3Di6k9LkUVA3nxmGnyCIOXzCKw7GEI/nqvxs0o
         8VdeX7skBNzJcjawD84AhVUFW3Raoy2hhkXzi8+9mCCXb9VxHueEEyobN4ShgqjOaF7c
         MwbFzvOCsTmjs7dv3ieBDdoBvJDVW/kB8R07aNgCzcOtxaa+9n9iHp8qI0MFIs4gnv5/
         boJQmapv6vXP+XO+Lrc5h8UpfViRqnhexKwWM/0MqR0/OqBFvI0KraVHMcmgtrWeA3a3
         0CDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wkd+psqbxttkDtNMuavQIcbFyZNe+XjsMd8VM7sojkI=;
        b=c48IvtghcaR3fgaSV4NFMOAZZAjf99s4v1coc0QyWwkjaAfeAP4cSieV7WfhpkrhLk
         MNVYGsAVlNCj3KGQwINeGI15/Z9I42TpfTXyluzJLi/ynd6DdbrGB/T90oOus5Wygps4
         7s7HX5oILhyd+NFwGIh8txGUbkFItKx2Laf+1qH8oUXXYyvYnIbQsva1cV9+NBqHJpal
         uXJhr0ya2NWi2S7BogHFvLP5+aMEg3b9Hfw67Blc2EDW47drgQRRNiGgjjsnY4mftMNr
         yg8h5vcLoyR8YWFbTw1yoDpX+6too9k7GIA1vSi3slzqKqGQeRFDs6CvIBXc91jk3qPv
         Y0vg==
X-Gm-Message-State: AOAM531bLvYr/J8GBqI1YqdtWU/JNevbRPlFqReNtVOL0k7XCtlg5Awc
        pDrhNmCWAmHIF4kuH7QhRMIG+A==
X-Google-Smtp-Source: ABdhPJxaRJdzooBXF+rIKkLISjncPrqsB+/j/AV6w+YPi8Nos9bRbP6hkuiTkZI1pGFg/vOxEfQ0uQ==
X-Received: by 2002:a63:1453:: with SMTP id 19mr1589790pgu.270.1623383483960;
        Thu, 10 Jun 2021 20:51:23 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id n37sm3565593pfv.47.2021.06.10.20.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 20:51:23 -0700 (PDT)
From:   Shunsuke Mie <mie@igel.co.jp>
Cc:     mie@igel.co.jp, Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: endpoint: Fix use after free in pci_epf_remove_cfs()
Date:   Fri, 11 Jun 2021 12:50:44 +0900
Message-Id: <20210611035044.87639-1-mie@igel.co.jp>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All of entries are freed in a loop, however, the freed entry is accessed
by list_del() after the loop.

Fixes: ef1433f ("PCI: endpoint: Create configfs entry for each pci_epf_device_id table entry")
Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
 drivers/pci/endpoint/pci-epf-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index e9289d10f822..538e902b0ba6 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -202,8 +202,10 @@ static void pci_epf_remove_cfs(struct pci_epf_driver *driver)
 		return;
 
 	mutex_lock(&pci_epf_mutex);
-	list_for_each_entry_safe(group, tmp, &driver->epf_group, group_entry)
+	list_for_each_entry_safe(group, tmp, &driver->epf_group, group_entry) {
+		list_del(&group->group_entry);
 		pci_ep_cfs_remove_epf_group(group);
+	}
 	list_del(&driver->epf_group);
 	mutex_unlock(&pci_epf_mutex);
 }
-- 
2.17.1

