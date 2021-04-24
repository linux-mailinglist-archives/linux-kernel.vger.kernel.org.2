Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D429D369E7F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 04:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236966AbhDXCR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 22:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236878AbhDXCRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 22:17:19 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F47C061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 19:16:39 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id f19-20020a056a0022d3b02902608c8a75e0so10345326pfj.13
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 19:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TKEPf9xP7+FNQEpv6lL50M3TdirSF/eiH1hrWQCRY5o=;
        b=udh0DmIPk5GqWvOfgWdQNGdjkGvWb/x3HJGafhBtFYld8mjwWaVVh+oZsbZU1KnrLd
         auemL2nKOD7NGcxKR+XGuurcSaNcXnwglupQ+4cCCeM5ysa/iQXb8JU7MJwuCne8K8BI
         GbgE1DIHo5Bf00x0XdzPbPEz4k8trEnh7MQSwYI0NWQSahrRqIYIrrNd8hkl048jMv1H
         NM7bQG1aLj/mPPCsyS5nGnDiQ6P251JOt3I9FfLYyWE7OJB8ESygP0A6Kq0SEh/gWGXc
         H70eawyqHHeDkqoMrwvHq3MF3/tdFRubTMyNmHT5mMBnUX/vslK1ZG2/ggNYb54E7MOC
         JwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TKEPf9xP7+FNQEpv6lL50M3TdirSF/eiH1hrWQCRY5o=;
        b=apqn9JiU76ljOVhHTiC1U1r0Ue6wVXupdWBrUIc9Ann8tt7NQ06uI4MyZOw0l85Mcg
         jWzHNG3EUGLM4BMvVt12rwgzzDKlE8oW6LyIKJOg6OfXWAIm0ad6ITGBFp4PybJ3XaDr
         WExs6rizsOwmalgHcxiq+8YOeUx5JdAC9XIzVtEuNywNpg7tu8v08QvCGBRlbO/2dHVL
         TWld9Mvu8r8KfeTX0hIkqtrPGGFdq0yk8Dyk2c0BLBdpTnkMp/sxWYGZnS0VcAN1FRNE
         0Idup4UlD6OgCv6ciUsnrOt564oVRJdAk5XW2xlhVvC5vNGookDqJUWgfrv5QFUdKMrA
         hCMA==
X-Gm-Message-State: AOAM5322aTC7uVOCmOAoxYNJfyIKhLXqoC3Hls/rOHLrHZf+qKqkCErT
        ZTbD5TN8uvBRQsQPq0+ikDxSUry0yieY
X-Google-Smtp-Source: ABdhPJxbxWJhWAYwpRE5nap2mHgvnzk4LWBr9JI/FjTVoxsf79fnUj2hC/STJT9O0kod3MZfUfgVs4ejVzem
X-Received: from rajat2.mtv.corp.google.com ([2620:15c:202:201:5cef:2faf:44cf:b69b])
 (user=rajatja job=sendgmr) by 2002:a17:903:248e:b029:ec:9c4f:765e with SMTP
 id p14-20020a170903248eb02900ec9c4f765emr7098613plw.17.1619230599038; Fri, 23
 Apr 2021 19:16:39 -0700 (PDT)
Date:   Fri, 23 Apr 2021 19:16:31 -0700
In-Reply-To: <20210424021631.1972022-1-rajatja@google.com>
Message-Id: <20210424021631.1972022-2-rajatja@google.com>
Mime-Version: 1.0
References: <20210424021631.1972022-1-rajatja@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH v2 2/2] pci: Support "removable" attribute for PCI devices
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
v2: Add documentation

 Documentation/ABI/testing/sysfs-devices-removable |  3 ++-
 drivers/pci/pci-sysfs.c                           |  1 +
 drivers/pci/probe.c                               | 12 ++++++++++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-removable b/Documentation/ABI/testing/sysfs-devices-removable
index e13dddd547b5..daac4f007619 100644
--- a/Documentation/ABI/testing/sysfs-devices-removable
+++ b/Documentation/ABI/testing/sysfs-devices-removable
@@ -14,4 +14,5 @@ Description:
 
 		Currently this is only supported by USB (which infers the
 		information from a combination of hub descriptor bits and
-		platform-specific data such as ACPI).
+		platform-specific data such as ACPI) and PCI (which gets this
+		from ACPI / device tree).
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

