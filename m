Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942CD369DD5
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 02:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237094AbhDXAag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 20:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232781AbhDXAaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 20:30:05 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24875C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 17:29:27 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id f7-20020a5b0c070000b02904e9a56ee7e7so26206113ybq.9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 17:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=t9E6AgM/NK1c0PjlCo7SjL7vvuTwSd4YtwEbnSzZpWc=;
        b=VtdIH68xM1pygyf08EF1RBtP6FuOKh1JQGkVtn4Oc2LNZkHX5CJaAK5cPokvcDPZTh
         R4LNvRXeyh1pnUzb7H2U44dvCQi2oF00eDmGW3gW6v4m8VrdQuIpzUNgGmJMO3Pzz6zm
         gpsWXHuZ2WSSPgmM/pcQPRP9L3ncwjkBLwZ/DG6X6EAusrwAWwInS7F9//fEgNK0IF0v
         BRcAUR2d/oJtodkeA+sg4222nkdiRyFgBJI6vJGSgRM5/saMkhJgZeNZXTOvTW15Kegd
         7w1v6hkSWmLHsWkJF8Bg6pJAkXw9RheLqpEXnOxGlYwuJYJXBrX6Ll1omJUMLWXmmdZO
         Ngzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=t9E6AgM/NK1c0PjlCo7SjL7vvuTwSd4YtwEbnSzZpWc=;
        b=GC9aoZACxmIw7s9Mqj/nnrhWHWPoBDFeC7GWzbM+3JFThXMYnS/uzS7Pc60JaTwaNG
         RRPqH1Mj7Agn3WuQuV5CqzBNielfxY9xrjivIyFW97o0nv0V2lGz7pgpcyM3JYOtL5u3
         eEJRpfvZp2+XjRMbmaShC/6Y/BYzO0HZlaDkwLzskPt6aPfM2ZDtn5p9rB7mv3Y0QYr0
         gTCrm5Cltn43PO25GPkx7AkxeB3ANBGb2LjUDIBvaEbzcDdeyWJgvs18WfuuQgtenywU
         L30oEtFimt8K56I33uQFOoQ3zuiAoQkUbMV/FArNFEoHsbnV7PfL3iroyyf+egJqYeLI
         xntg==
X-Gm-Message-State: AOAM532GKhOqOWHWV7wh15fOkSdB6jnO8gEdAYeiFpuMt1k5ki5b1QBc
        ucHb45vEgUm4z/zvuy0Sw0S5wNpkGa3G
X-Google-Smtp-Source: ABdhPJxgHuhOM9o/WEZHSxdi1z6h7fPUHRs3VR53ulgXDShVIbg3nh9bpSIHkl+4N1TSDrbAKAy+hNyy+InK
X-Received: from rajat2.mtv.corp.google.com ([2620:15c:202:201:5cef:2faf:44cf:b69b])
 (user=rajatja job=sendgmr) by 2002:a25:310b:: with SMTP id
 x11mr9110518ybx.10.1619224166211; Fri, 23 Apr 2021 17:29:26 -0700 (PDT)
Date:   Fri, 23 Apr 2021 17:29:18 -0700
In-Reply-To: <20210424002918.1962649-1-rajatja@google.com>
Message-Id: <20210424002918.1962649-2-rajatja@google.com>
Mime-Version: 1.0
References: <20210424002918.1962649-1-rajatja@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH 2/2] pci: Support "removable" attribute for PCI devices
From:   Rajat Jain <rajatja@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rajat Jain <rajatja@google.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
        helgaas@kernel.org
Cc:     rajatxjain@gmail.com, jsbarnes@google.com, dtor@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export the already available info, to the userspace via the
device core, so that userspace can implement whatever policies it
wants to, for external removable devices.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
 drivers/pci/pci-sysfs.c |  1 +
 drivers/pci/probe.c     | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index f8afd54ca3e1..9302f0076e73 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1582,4 +1582,5 @@ static const struct attribute_group *pci_dev_attr_groups[] = {
 
 const struct device_type pci_dev_type = {
 	.groups = pci_dev_attr_groups,
+	.supports_removable = true,
 };
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 953f15abc850..d1cceee62e1b 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1575,6 +1575,16 @@ static void set_pcie_untrusted(struct pci_dev *dev)
 		dev->untrusted = true;
 }
 
+static void set_pci_dev_removable(struct pci_dev *dev)
+{
+	struct pci_dev *parent = pci_upstream_bridge(dev);
+	if (parent &&
+	    (parent->external_facing || dev_is_removable(&parent->dev)))
+		dev_set_removable(&dev->dev, DEVICE_REMOVABLE);
+	else
+		dev_set_removable(&dev->dev, DEVICE_FIXED);
+}
+
 /**
  * pci_ext_cfg_is_aliased - Is ext config space just an alias of std config?
  * @dev: PCI device
@@ -1819,6 +1829,8 @@ int pci_setup_device(struct pci_dev *dev)
 	/* "Unknown power state" */
 	dev->current_state = PCI_UNKNOWN;
 
+	set_pci_dev_removable(dev);
+
 	/* Early fixups, before probing the BARs */
 	pci_fixup_device(pci_fixup_early, dev);
 
-- 
2.31.1.498.g6c1eba8ee3d-goog

