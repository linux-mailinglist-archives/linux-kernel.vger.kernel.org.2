Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8082D3D0D55
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 13:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238536AbhGUKia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 06:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238482AbhGUKbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 06:31:24 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53224C061767
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 04:11:53 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id k20so1531394pgg.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 04:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5dsg4PXVu53JqXnsoFPSZSATP9C6f/dSLikDFjxEPlQ=;
        b=ta4Y+cFyJqN1VZ2oQ7ngIBRPbzisVXByBryhbjA0cBPpOwMy2KHXxrYYGOucwAzmE5
         YcvJ1gztpgRjqVzt4Js2RAgKTFzI74+ICoIHwibju5AN0oJu/ToFBRm3lrywexUKS8k4
         aWH79o5JFXB9bMbu3i//qpwdCuzBpPPiRf1jbFgXQmNoSMTiwVfgSmGqEmbYGBxzQ6Hx
         s6vQTAztbo/hhRAG7ozI90UqnaHmswjvpxtdCmuU0dmEi80WJ3064QC+aneeeWgPOFuo
         z2RsySb5OKSxHlKZ6y+FmvbkNeE1iMljR9rZ3Jg+Ig51+T+fUeOGncQ5LJ7amrby+IOW
         rwEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5dsg4PXVu53JqXnsoFPSZSATP9C6f/dSLikDFjxEPlQ=;
        b=R705Gb59IntQqe6CDgZJh2D6HW0xYy5epivL6OEkee6y43YZcZVAHn847h9Xrjyh1n
         7QjTBrUCwyKlcrWn9YC0rcJuv9bEd7bJnxe5dSBeNMgDLrSk80+6STMLuFm5lOq0B6vK
         7NawzYScKwNhZuqNXnHSNhUy5jsZtna2qelFX7TIzSVEpQmVxTGGI55ETq4LxWsn2Nxv
         ke/KwZFa23BhRJ+HgjG2TNSOokBaJuomHHIXr5InYEeSpdEBp0qr8sOnz1OX1u6Mvl4/
         ZIS+eRAsGNNPUruIgQaiFpGi+D9BQU2dDwJRV7Sj7XqaTGyLCuVJstQortZdggVaut+D
         hw9Q==
X-Gm-Message-State: AOAM5335exlF2qLZIk1PZUZ5Azbdi6BJVv+SRxSsQCAmqZk7bzNaslS2
        GS17ybllm7K6ZUm8RZDUhvA=
X-Google-Smtp-Source: ABdhPJx9+O0Y+FsWGNBJpXpIzWfzT88w2W5ZWCc8F98MX5vfUy5lphh4+fuhueQf/CwD32aYwZTuxQ==
X-Received: by 2002:a63:1f24:: with SMTP id f36mr35604567pgf.151.1626865912860;
        Wed, 21 Jul 2021 04:11:52 -0700 (PDT)
Received: from localhost.localdomain ([154.16.166.166])
        by smtp.gmail.com with ESMTPSA id d3sm2996679pfj.17.2021.07.21.04.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 04:11:52 -0700 (PDT)
From:   Dongliang Mu <mudongliangabcd@gmail.com>
To:     Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        Aditya Srivastava <yashsri421@gmail.com>,
        Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        industrypack-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ipack: tpci200: pci_iounmap -> iounmap
Date:   Wed, 21 Jul 2021 19:11:30 +0800
Message-Id: <20210721111137.1523229-1-mudongliangabcd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The deallocation api for ioremap should be iounmap, other than
pci_iounmap.

Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
 drivers/ipack/carriers/tpci200.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ipack/carriers/tpci200.c b/drivers/ipack/carriers/tpci200.c
index 3461b0a7dc62..ca302a87bc22 100644
--- a/drivers/ipack/carriers/tpci200.c
+++ b/drivers/ipack/carriers/tpci200.c
@@ -88,8 +88,8 @@ static void tpci200_unregister(struct tpci200_board *tpci200)
 {
 	free_irq(tpci200->info->pdev->irq, (void *) tpci200);
 
-	pci_iounmap(tpci200->info->pdev, tpci200->info->interface_regs);
-	pci_iounmap(tpci200->info->pdev, tpci200->info->cfg_regs);
+	iounmap(tpci200->info->interface_regs);
+	iounmap(tpci200->info->cfg_regs);
 
 	pci_release_region(tpci200->info->pdev, TPCI200_IP_INTERFACE_BAR);
 	pci_release_region(tpci200->info->pdev, TPCI200_IO_ID_INT_SPACES_BAR);
-- 
2.25.1

