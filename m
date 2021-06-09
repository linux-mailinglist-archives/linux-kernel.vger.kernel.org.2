Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3ED3A0AB3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 05:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235862AbhFIDjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 23:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbhFIDjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 23:39:09 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59829C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 20:37:04 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id k22-20020a17090aef16b0290163512accedso2888442pjz.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 20:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x3db9pjXA84h01LUCZq4pwVqoTgwPoimoEKIvQtDJvk=;
        b=s3V6CA1Q+zfQZbBHuh+ry0GiiD2rW9uQwZJKsA2r5UK9Zi5cmy/cFoyzFSd1RmHB33
         wbiNzflsUiCzNJxn6GOWqLZI6oR+315jeguEQ3ACLJnG0R2SHPwLW4N8cGVOd6bpvzFG
         ANFe/y6t1ITumv6sFdK13Ic6NqfnreSEaoWkY0ooYFGMAOvoQbiojm0Lo7KK0flOWNxn
         z7F3YhrvPj3l1FRR/HXQphTPFEMj0OQjLOFO8BlAsIKrfVINAkI0uIqOheLLf6fEkwLb
         BNHZwZWKDpQQuSH0i3Q90HL+xNciqAvTe4qnzTdvby9EljaDe8/nw1b3Ell+HBNAipEU
         IL0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x3db9pjXA84h01LUCZq4pwVqoTgwPoimoEKIvQtDJvk=;
        b=tNQaYgAMBATQRpldZAovTDJdVlbyKkD229r7Kf6+T/ykbIoutJXt3WsAteb4CCeBhX
         RMQ+gUaxxxTvQOzLl/8jMpHPF4FQVMmdwxEPCEJwJBlYcLnc3fBpjs05RyZmKzRlIueI
         /xj3SLeXCiNfksfYkGPDE5pqDL9Sc9gWDy5hSxcbNemyKI5Irp0IdJxdnnFYq3XxcxQb
         0lw6IP0tYeYby76WxEN+ITvUEn/IxXT+9QN5GYDW25QWfknfIRLyAlkrzKsoENuT9zar
         jfGKNGmgYAIFpWkOMIInH1TsxiEM6AxDUCor6dyX7v4BU+LzPxJcU9U6L5uzcfbhS0hX
         4+Vg==
X-Gm-Message-State: AOAM5331ULzOUNmJEpCZreU78CrRj+HBfZk3R0y3MvvFIwc0sGCloVtR
        0V2+ujxvnKTSd4iEv0TVn6HaXA==
X-Google-Smtp-Source: ABdhPJx457xWbtIJl1QI/e6/0sC+r5W336CMwB2P1zazGuA+tmNS0WIHnBG+CI10KF4l8b/CDGaJlQ==
X-Received: by 2002:a17:90a:16c2:: with SMTP id y2mr29428390pje.236.1623209823962;
        Tue, 08 Jun 2021 20:37:03 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.135])
        by smtp.gmail.com with ESMTPSA id t24sm3473904pji.56.2021.06.08.20.36.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jun 2021 20:37:03 -0700 (PDT)
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        jean-philippe <jean-philippe@linaro.org>,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v4 1/3] PCI: PASID can be enabled without TLP prefix
Date:   Wed,  9 Jun 2021 11:36:39 +0800
Message-Id: <1623209801-1709-2-git-send-email-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1623209801-1709-1-git-send-email-zhangfei.gao@linaro.org>
References: <1623209801-1709-1-git-send-email-zhangfei.gao@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A PASID-like feature is implemented on AMBA without using TLP prefixes
and these devices have PASID capability though not supporting TLP.
Adding a pasid_no_tlp bit for "PASID works without TLP prefixes" and
pci_enable_pasid() checks pasid_no_tlp as well as eetlp_prefix_path.

Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/pci/ats.c   | 2 +-
 include/linux/pci.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 6d7d649..c967ad6 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -376,7 +376,7 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
 	if (WARN_ON(pdev->pasid_enabled))
 		return -EBUSY;
 
-	if (!pdev->eetlp_prefix_path)
+	if (!pdev->eetlp_prefix_path && !pdev->pasid_no_tlp)
 		return -EINVAL;
 
 	if (!pasid)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c20211e..766dca1 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -388,6 +388,7 @@ struct pci_dev {
 					   supported from root to here */
 	u16		l1ss;		/* L1SS Capability pointer */
 #endif
+	unsigned int	pasid_no_tlp:1;		/* PASID works without TLP Prefix */
 	unsigned int	eetlp_prefix_path:1;	/* End-to-End TLP Prefix */
 
 	pci_channel_state_t error_state;	/* Current connectivity state */
-- 
2.7.4

