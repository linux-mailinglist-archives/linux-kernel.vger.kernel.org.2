Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA953CF63E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 10:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234588AbhGTH5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 03:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhGTH5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 03:57:44 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28EB9C061574
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 01:38:22 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id p36so18929550pfw.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 01:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3UBl5TF7W4cPvNqAim0RfEGw+DwVCp3VD7zo3dPsAO4=;
        b=AxYnmTUa9mJMyKG+S//JMm5wk6u5JQd/KNQQNLWgz2JMwFY3QFutVvP3KUAqPRTtCN
         hlgaV10WPDrfmqcDbff8K2oL1b/9m47aGQqUELkxUMo+j2ygNQev+NPKm2jwrCbGXi2q
         PNAevX7PNUDz6i5PcWzq3pyIEbhjQSXJoE6t+Ve/Qf0NSR8eUz6gaGXhtifwaw+UPj53
         fON+OeteoHYwd1SfVQFm6LMK6RqilZtIvorM6Ir8EQq6cOXpMlKAI/6vPemKcrAycHzz
         aLu55tmLrP+1KCVcQA4g3zVLY5t6EkrM/T8Mmy2HGauIE+2NCgtElZm3Txj7zAmIpyPj
         +T9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3UBl5TF7W4cPvNqAim0RfEGw+DwVCp3VD7zo3dPsAO4=;
        b=FeIw/vhAAZYH3RFuyEorXW3xUHhfOfXCuP2p0Wid0Dqc0k2syKCyS4c0ilcLru+XTj
         3TElXSjGWddnkSIj5oaKV4D7WTx8P4pNZ3zY5r+pznlKfSoO7AGgd0anaW9MsTI0BKg3
         osdNWmKxsZykSS4FHlWx6Gt4blZqBBQCWYUnQ73QI1jwtpEJUpypc2+6XYoKcKoxrXkc
         GmiorZgCz+6tEtZ3XhIjbDUiWPno2E6aovqCWcMCrU24dxtBu0g4Q7B3Nw9cczil4MwW
         tfW8IQYhapYiLcnyrI1Bw15FJMwFI80SdtYfuEUKZh09skCjIpYdwue5Jxv1KgtwtLym
         +rOw==
X-Gm-Message-State: AOAM532/pUb5s2G+7HrJ9IQ8P9kO15ANSoKVyweHPnaJRa+e8v4nP6tz
        z25kPPME0LG2lQ8xXBkkzhs=
X-Google-Smtp-Source: ABdhPJwbmDUIFg7L0Qvve0Kt66BxF7m1V1RDkA9poGcJD6T0SSb3dkt21JsOIQwSQEG1ASgFS0ZWrw==
X-Received: by 2002:a63:db0e:: with SMTP id e14mr4805226pgg.188.1626770301656;
        Tue, 20 Jul 2021 01:38:21 -0700 (PDT)
Received: from localhost.localdomain ([154.16.166.191])
        by smtp.gmail.com with ESMTPSA id x7sm23654193pfc.96.2021.07.20.01.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 01:38:21 -0700 (PDT)
From:   Dongliang Mu <mudongliangabcd@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Dongliang Mu <mudongliangabcd@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tty: nozomi: change tty_unregister_device to tty_port_unregister_device
Date:   Tue, 20 Jul 2021 16:38:05 +0800
Message-Id: <20210720083805.1430892-1-mudongliangabcd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pairwise api invocation of tty_port_register_device should be
tty_port_unregister_device, other than tty_unregister_device.

Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
 drivers/tty/nozomi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c
index 0c80f25c8c3d..08bdd82f60b5 100644
--- a/drivers/tty/nozomi.c
+++ b/drivers/tty/nozomi.c
@@ -1417,7 +1417,8 @@ static int nozomi_card_init(struct pci_dev *pdev,
 
 err_free_tty:
 	for (i--; i >= 0; i--) {
-		tty_unregister_device(ntty_driver, dc->index_start + i);
+		tty_port_unregister_device(&dc->port[i].port, ntty_driver,
+				dc->index_start + i);
 		tty_port_destroy(&dc->port[i].port);
 	}
 	free_irq(pdev->irq, dc);
-- 
2.25.1

