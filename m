Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 820FA34AE5F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 19:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbhCZSPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 14:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbhCZSOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 14:14:53 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE422C0613B1;
        Fri, 26 Mar 2021 11:14:52 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id o19so7353258edc.3;
        Fri, 26 Mar 2021 11:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=7OwN9sCDoll1kfeOV96JvARjVXcCMVl5pE1420CYpOw=;
        b=grFMxIfnyiOWnB9RplEKcznwJgBk59Dlw9m/Qd10lgjvSNTNyzIknJNEsP1Iwd8yNr
         HRPlwIIiJtJjlO56hyU+aj25+jJzjSuEL6e8XvtMnonsZO+DF3p2//gSHa0AgfmAKhSK
         lUvmNgqIUyOGCWYRIocMdwhD4n8gQlW56XzgqdVjVKtK362IkPsTOi6dKFyDylOD1njO
         FWZFFFKwXsoV+F6LURvZ9bXSfQhbbFRI3ivclSqPkze8Gu3nrm0G29dikRKZoDblCDNH
         mmcPUn1iQxeZmfWhELA4i+As9kT/iYgE+Dlk3135pa+uE/d6S+bfjxf9Ej1F62aWDSBg
         Swlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=7OwN9sCDoll1kfeOV96JvARjVXcCMVl5pE1420CYpOw=;
        b=eAAlZNX4HUkdBSJ/m34k4UTQoWa4UUBgNsCFqZUsMGGQf/v8tcWx+AgCIWCQH7eT2F
         f29lkVptJJd9aslON21aqkcDHedYwcSMtIEwd3eXr8zyKmjrOT4HOMintgV95fZNJwlF
         4ElZLOte88XyTp9lr0G4zxWL0MMmcWLxyJ1UGQpf89n/9oDH2mP3LwxfhS52fBDEk9nf
         Ii5LSQW4yJRcQlea+LooyQoHq403H9deS2/du6tK9MAuUUbafIwUAEYlf+KWBC41P3Z+
         YZ18lTjB8nf3a+T0H3+ZUdrQfaU946By171kr3H9M4+wBDZbsz3xnK6sFVcs0iDqC/fW
         NoFg==
X-Gm-Message-State: AOAM533wWz21cIOhC43+N8isffYFfN6yr1albm249qLqCjT+TEEClqFx
        fC8xQ4rGH/FRTD6N7niVA6o=
X-Google-Smtp-Source: ABdhPJxuA8CArC7vp83Y/bQZyxiB/zWeAqtySapkwLOjb+muwylYkJwlFNtddIpQu548xwd6Df9rEw==
X-Received: by 2002:a05:6402:1545:: with SMTP id p5mr16503433edx.155.1616782491559;
        Fri, 26 Mar 2021 11:14:51 -0700 (PDT)
Received: from LEGION ([111.119.187.49])
        by smtp.gmail.com with ESMTPSA id gj26sm4087570ejb.67.2021.03.26.11.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 11:14:50 -0700 (PDT)
Date:   Fri, 26 Mar 2021 23:14:42 +0500
From:   Muhammad Usama Anjum <musamaanjum@gmail.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "moderated list:XEN HYPERVISOR INTERFACE" 
        <xen-devel@lists.xenproject.org>,
        open list <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, colin.king@canonical.com,
        dan.carpenter@oracle.com
Cc:     musamaanjum@gmail.com
Subject: [PATCH] xen/pciback: Fix incorrect type warnings
Message-ID: <20210326181442.GA1735905@LEGION>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct enum pci_channel_io_normal should be used instead of putting
integer value 1.

Fix following smatch warnings:
drivers/xen/xen-pciback/pci_stub.c:805:40: warning: incorrect type in argument 2 (different base types)
drivers/xen/xen-pciback/pci_stub.c:805:40:    expected restricted pci_channel_state_t [usertype] state
drivers/xen/xen-pciback/pci_stub.c:805:40:    got int
drivers/xen/xen-pciback/pci_stub.c:862:40: warning: incorrect type in argument 2 (different base types)
drivers/xen/xen-pciback/pci_stub.c:862:40:    expected restricted pci_channel_state_t [usertype] state
drivers/xen/xen-pciback/pci_stub.c:862:40:    got int
drivers/xen/xen-pciback/pci_stub.c:973:31: warning: incorrect type in argument 2 (different base types)
drivers/xen/xen-pciback/pci_stub.c:973:31:    expected restricted pci_channel_state_t [usertype] state
drivers/xen/xen-pciback/pci_stub.c:973:31:    got int

Signed-off-by: Muhammad Usama Anjum <musamaanjum@gmail.com>
---
 drivers/xen/xen-pciback/pci_stub.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback/pci_stub.c
index cb904ac83006..f8e4faa96ad6 100644
--- a/drivers/xen/xen-pciback/pci_stub.c
+++ b/drivers/xen/xen-pciback/pci_stub.c
@@ -802,7 +802,7 @@ static pci_ers_result_t xen_pcibk_slot_reset(struct pci_dev *dev)
 			"guest with no AER driver should have been killed\n");
 		goto end;
 	}
-	result = common_process(psdev, 1, XEN_PCI_OP_aer_slotreset, result);
+	result = common_process(psdev, pci_channel_io_normal, XEN_PCI_OP_aer_slotreset, result);
 
 	if (result == PCI_ERS_RESULT_NONE ||
 		result == PCI_ERS_RESULT_DISCONNECT) {
@@ -859,7 +859,7 @@ static pci_ers_result_t xen_pcibk_mmio_enabled(struct pci_dev *dev)
 			"guest with no AER driver should have been killed\n");
 		goto end;
 	}
-	result = common_process(psdev, 1, XEN_PCI_OP_aer_mmio, result);
+	result = common_process(psdev, pci_channel_io_normal, XEN_PCI_OP_aer_mmio, result);
 
 	if (result == PCI_ERS_RESULT_NONE ||
 		result == PCI_ERS_RESULT_DISCONNECT) {
@@ -970,7 +970,7 @@ static void xen_pcibk_error_resume(struct pci_dev *dev)
 		kill_domain_by_device(psdev);
 		goto end;
 	}
-	common_process(psdev, 1, XEN_PCI_OP_aer_resume,
+	common_process(psdev, pci_channel_io_normal, XEN_PCI_OP_aer_resume,
 		       PCI_ERS_RESULT_RECOVERED);
 end:
 	if (psdev)
-- 
2.25.1

