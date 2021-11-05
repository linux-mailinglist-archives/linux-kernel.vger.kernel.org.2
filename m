Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7456446AE6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 23:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbhKEWbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 18:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbhKEWbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 18:31:41 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89259C061570
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 15:29:01 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id i11so1692637ilv.13
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 15:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jDjxnqL+Ru3M1ILZhtlrQeztG6RNMjBqozSge68edGI=;
        b=NjB1yiPzJlNDRcVwwmVO7+DWpgLMyRy0lbo9Ln8xQAb3hM/U1cy99m5YLXa644TuRP
         b3OQRLqAkP0y2pgR8TSE6DmrBs/eGlke5b6QgUtsv8GPe4B+VUiK30nqVxy62dVcLO8L
         Lg2irM21YYw2uOGY7hcYDMvnG150LH0wYKJig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jDjxnqL+Ru3M1ILZhtlrQeztG6RNMjBqozSge68edGI=;
        b=p+xIhvst9cSltXPlJ5LcpkP/Vr/H9Z6C9v8l3zu4WhT4j6zIni9YJoB9IJ+yjoRxRc
         3R5uVaHssJKWZNkt61sRLKu+EGIZPVpa0YiD/pr6UMETqaTcYQ6tYRyKa8izLnHLjWjk
         I8bqk6gB62IwQSiO0K5ipDiQIKJb0L5w7QIQ20z8/NmnLJCCxTvy+w8LStFhv53s9git
         9i9/qYcBhGpoKkHHUG0TRq7qLK8B0BNKGuBqZo2CBL+JtGB9Xagu47gOu2JmeQ2pJn75
         HvxRuNNBC5SPReaXFF7xfBvDCqa5lHGu4DBmFkRk8g8PWCvFnBy/7+okxKRHnzBkhwIr
         AnwA==
X-Gm-Message-State: AOAM532d/WK1wK+SZrnakCPOyltGAS/uekgsG2JYhoPGHfzlCiEi6CP2
        +WEQlTF76MWU2bQwkd8ErKzAsA==
X-Google-Smtp-Source: ABdhPJzVYHOsfve6j1cM2O8WGFl8uYBhASZU2Pp3JXgCAJSKwPzx5hbQPPqDcWbHJWFYy34ZhtrbqQ==
X-Received: by 2002:a92:9513:: with SMTP id y19mr41291649ilh.300.1636151341044;
        Fri, 05 Nov 2021 15:29:01 -0700 (PDT)
Received: from melhuishj.c.googlers.com.com (161.74.123.34.bc.googleusercontent.com. [34.123.74.161])
        by smtp.gmail.com with ESMTPSA id y6sm5516318ilu.38.2021.11.05.15.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 15:29:00 -0700 (PDT)
From:   Jesse Melhuish <melhuishj@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Jesse Melhuish <melhuishj@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH] bluetooth: Don't initialize msft/aosp when using user channel
Date:   Fri,  5 Nov 2021 22:28:37 +0000
Message-Id: <20211105222820.1.I2a8b2f2e52d05ae9ead3f3dcc1dd90ef47a7acd7@changeid>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A race condition is triggered when usermode control is given to
userspace before the kernel's MSFT query responds, resulting in an
unexpected response to userspace's reset command.

Issue can be observed in btmon:
< HCI Command: Vendor (0x3f|0x001e) plen 2                    #3 [hci0]
        05 01                                            ..
@ USER Open: bt_stack_manage (privileged) version 2.22  {0x0002} [hci0]
< HCI Command: Reset (0x03|0x0003) plen 0                     #4 [hci0]
> HCI Event: Command Complete (0x0e) plen 5                   #5 [hci0]
      Vendor (0x3f|0x001e) ncmd 1
	Status: Command Disallowed (0x0c)
	05                                               .
> HCI Event: Command Complete (0x0e) plen 4                   #6 [hci0]
      Reset (0x03|0x0003) ncmd 2
	Status: Success (0x00)

Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
Signed-off-by: Jesse Melhuish <melhuishj@chromium.org>
---

 net/bluetooth/hci_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index c07b2d2a44b0..2b5df597e7ed 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1595,8 +1595,10 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 	    hci_dev_test_flag(hdev, HCI_VENDOR_DIAG) && hdev->set_diag)
 		ret = hdev->set_diag(hdev, true);
 
-	msft_do_open(hdev);
-	aosp_do_open(hdev);
+	if (!hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
+		msft_do_open(hdev);
+		aosp_do_open(hdev);
+	}
 
 	clear_bit(HCI_INIT, &hdev->flags);
 
-- 
2.31.0

