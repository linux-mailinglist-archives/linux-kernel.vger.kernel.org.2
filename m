Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9023205D6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 15:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhBTOyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 09:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhBTOyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 09:54:44 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CF5C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 06:54:02 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id t9so772945pjl.5
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 06:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+ONWndi/ymoXM48nCRrDbCP/DsC1CRxO7WJjCq9Zsb8=;
        b=GGGNvrnm7XlXEiPBW7Tj6pBL8B0dQZoO1PY7u1xYv/uO7Dztf+wzuTLoh80oJaPifT
         YHamXnmYgCz9ey0K4p+1LjjpebVkTDX6W/ojNdyf1WM/2w0Wmyg709apYCeP2YTeF4AN
         DienmVYlZOs0SbrPPh8Ne2OX4blBopagJkEX9Bt2RUKP0OMk+sbGpPE04KB36StmRytv
         fKt6jQaxmv18yB447uVvRSYSNlnDufVq0VAIIh5wxEF1ewWF9BbaV+5zj2BPxsRiOoEE
         +fgWMG558vRq0zqZxBEg6Y49IcPc4COcVX7x/iV6MipVrc6d8fhwj216MvxK4hYDDWpB
         cjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+ONWndi/ymoXM48nCRrDbCP/DsC1CRxO7WJjCq9Zsb8=;
        b=HbqxXvrJsjBksw55fQaUpOKMC3iJx3XcxL+5UVPwk4gCf5jcy6tApY2YG1WQxISE/W
         tJ0OzNdkXXz++dsaYlCe9zW4HZkVZInEtPkAnM97ZdfhiTUkbpRimzfjONpr2FJjlX83
         Gm0EF0mkxPYRiBOA6R7aMFowDZHDpDWxhdGEJOBqIiuob4loQNxPRGCrAV13qlhHBuWB
         6+RXIIH/IBxKoOkaDXndfSltG+Kdbve8jpuXIzqHfxmfbXqilu4vzoIv2r/ojC1zpJ/g
         GrOsMzfXrxZFwK5hY8hXS2WC7jTO06aDpYhUbt4Eh1Q/jkXtNFDBQJrOoVdwWh1hdBOZ
         o9Vw==
X-Gm-Message-State: AOAM5315ClZJkzigCLX1oTPsEUbfUWMX1OZgPNsMpXZJT0XsE3O0CT5R
        g5v5Owq9Ozp+quUXsGuCAUs=
X-Google-Smtp-Source: ABdhPJx4OxBRxnDMGJsjtb6SMSvU67RivLwUrSzBqrRNHBjMQHXBgcoOuPF2abG5BgoIix2E9yohig==
X-Received: by 2002:a17:90a:bd90:: with SMTP id z16mr14948548pjr.88.1613832842130;
        Sat, 20 Feb 2021 06:54:02 -0800 (PST)
Received: from localhost.localdomain ([122.10.161.207])
        by smtp.gmail.com with ESMTPSA id v1sm12065313pjh.29.2021.02.20.06.54.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Feb 2021 06:54:01 -0800 (PST)
From:   Yejune Deng <yejune.deng@gmail.com>
To:     shuo.a.liu@intel.com
Cc:     linux-kernel@vger.kernel.org, yejune.deng@gmail.com
Subject: [PATCH] virt: acrn: Use vfs_poll() instead of f_op->poll()
Date:   Sat, 20 Feb 2021 22:53:51 +0800
Message-Id: <20210220145351.14464-1-yejune.deng@gmail.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use vfs_poll() is a more advanced function in acrn_irqfd_assign().
as the same time, modify the definition of events.

Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
---
 drivers/virt/acrn/irqfd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/virt/acrn/irqfd.c b/drivers/virt/acrn/irqfd.c
index a8766d528e29..98d6e9b18f9e 100644
--- a/drivers/virt/acrn/irqfd.c
+++ b/drivers/virt/acrn/irqfd.c
@@ -112,7 +112,7 @@ static int acrn_irqfd_assign(struct acrn_vm *vm, struct acrn_irqfd *args)
 {
 	struct eventfd_ctx *eventfd = NULL;
 	struct hsm_irqfd *irqfd, *tmp;
-	unsigned int events;
+	__poll_t events;
 	struct fd f;
 	int ret = 0;
 
@@ -158,7 +158,7 @@ static int acrn_irqfd_assign(struct acrn_vm *vm, struct acrn_irqfd *args)
 	mutex_unlock(&vm->irqfds_lock);
 
 	/* Check the pending event in this stage */
-	events = f.file->f_op->poll(f.file, &irqfd->pt);
+	events = vfs_poll(f.file, &irqfd->pt);
 
 	if (events & POLLIN)
 		acrn_irqfd_inject(irqfd);
-- 
2.29.0

