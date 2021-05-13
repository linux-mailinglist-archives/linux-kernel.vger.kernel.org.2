Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01FAE3800D3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 01:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbhEMX2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 19:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbhEMX2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 19:28:20 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF19C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 16:27:10 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id a24-20020a05620a1038b02902fa6ba180ffso8827620qkk.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 16:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+KbOaFytJGmeVohVDEIu5JposTZYrKluPZGiqJdiK3k=;
        b=O6IUFO/UDzEhMp6UQLRu5ZYFrOg61wl/gjt0b8epRd7qPBv6SDrxprjfGPbzVqSYHe
         1bik0kNhpU3/81H03PIctZwVXB9iUchOS82Y3eiHEdAUFp3IAqBeVbblNTsrxIYTJRVM
         mtvn9gStOIQJbfvzykTgxZW6YKFHeDYpn4zhPafvxTYU5kLPuQA0esWDgb1nyEapqdUo
         TQljnQnJt9itX6BUHQ62DY9gWr/F/tdpPDIURxQ3oA2PjVrAa4bLa4eOBHNdt7POQXAx
         5Ay4ME2f4rBNiKULVV7/ea8ZXvolWcv4X0zP9DN8Nef09Yqdz+PzWV8Pco68sZwJ9Avi
         yEZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+KbOaFytJGmeVohVDEIu5JposTZYrKluPZGiqJdiK3k=;
        b=cIbiczxN6p4oMdiRC5PqnUjyo6nrqgjGXvLLDYxD9G1S7E+gXsPYE6AanM/7wxPZR5
         k2Di62dJCPY3KWzGYXWTJKBSjGnf3N45r5q1VW1+dnYP8JE2nsUCoeXizTROrXgpRsbL
         nGQCXdG8eO92gI6IWMd68JCaCxdbcH5tpPr2gIQ32Sq05Vj1uj+fBlq+6pj7Vkv5bruA
         DNenW2zP8nBsuPYfmijusoMNYX/0pQsEC7eQaTOFYRws/1HeMzmYrpxh2hRMKfxKqlq5
         ic7qNOLnXx5WF89Ic10J4wRFhiem/6xuf6VAn7csIog8cvUyruHL1NVRBSv6C4BxWQpN
         9ixA==
X-Gm-Message-State: AOAM5317JS86ZeWYN6+lYHSiQTR4w8ot1FKSyGgNDICShv5gZWzWytXb
        UhXJHc5fMcp1kpNVzXWVVWP3ns6IGpwp
X-Google-Smtp-Source: ABdhPJwLAZGSj+LMGCsjuEKKTdeGSWf/qY+BNlUVa2V285NHbR/Iqw5WsYFG/rWe+mGHhHjoUplKlZGhvyxs
X-Received: from rajat2.mtv.corp.google.com ([2620:15c:202:201:d1cc:8ac5:2f45:7909])
 (user=rajatja job=sendgmr) by 2002:ad4:55ca:: with SMTP id
 bt10mr43230140qvb.6.1620948429274; Thu, 13 May 2021 16:27:09 -0700 (PDT)
Date:   Thu, 13 May 2021 16:27:01 -0700
In-Reply-To: <20210513232701.411773-1-rajatja@google.com>
Message-Id: <20210513232701.411773-2-rajatja@google.com>
Mime-Version: 1.0
References: <20210513232701.411773-1-rajatja@google.com>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
Subject: [PATCH v4 2/2] PCI: Add sysfs "removable" attribute
From:   Rajat Jain <rajatja@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rajat Jain <rajatja@google.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
        helgaas@kernel.org, Oliver Neukum <oneukum@suse.com>,
        David Laight <David.Laight@aculab.com>,
        "=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=" <kw@linux.com>
Cc:     rajatxjain@gmail.com, jsbarnes@google.com, dtor@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A PCI device is "external_facing" if it's a Root Port with the ACPI
"ExternalFacingPort" property or if it has the DT "external-facing"
property.  We consider everything downstream from such a device to
be removable by user.

We're mainly concerned with consumer platforms with user accessible
Thunderbolt ports that are vulnerable to DMA attacks, and we expect those
ports to be identified by firmware as "ExternalFacingPort". Devices in
traditional hotplug slots can technically be removed, but the expectation
is that unless the port is marked with "ExternalFacingPort", such devices
are less accessible to user / may not be removed by end user, and thus not
exposed as "removable" to userspace.

This can be used to implement userspace policies tailored for
user removable devices. Eg usage:
https://chromium-review.googlesource.com/c/chromiumos/platform2/+/2591812
https://chromium-review.googlesource.com/c/chromiumos/platform2/+/2795038
(code uses such an attribute to remove external PCI devices or disable
features on them as needed by the policy desired)

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v4: - code comments, commit log updates
    - Make "removable" attribute show up only under devices that are
      really removable.
v3: - commit log updated
    - Rename set_pci_dev_removable() -> pci_set_removable()
    - Call it after applying early PCI quirks.
v2: Add documentation

 .../ABI/testing/sysfs-devices-removable       |  3 ++-
 drivers/pci/probe.c                           | 22 +++++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-removable b/Documentation/ABI/testing/sysfs-devices-removable
index acf7766e800b..bda6c320c8d3 100644
--- a/Documentation/ABI/testing/sysfs-devices-removable
+++ b/Documentation/ABI/testing/sysfs-devices-removable
@@ -14,4 +14,5 @@ Description:
 
 		Currently this is only supported by USB (which infers the
 		information from a combination of hub descriptor bits and
-		platform-specific data such as ACPI).
+		platform-specific data such as ACPI) and PCI (which gets this
+		from ACPI / device tree).
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 3a62d09b8869..812e0d7fd7a7 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1575,6 +1575,26 @@ static void set_pcie_untrusted(struct pci_dev *dev)
 		dev->untrusted = true;
 }
 
+static void pci_set_removable(struct pci_dev *dev)
+{
+	struct pci_dev *parent = pci_upstream_bridge(dev);
+
+	/*
+	 * We (only) consider everything downstream from an external_facing
+	 * device to be removable by the user. We're mainly concerned with
+	 * consumer platforms with user accessible thunderbolt ports that are
+	 * vulnerable to DMA attacks, and we expect those ports to be marked by
+	 * the firmware as external_facing. Devices in traditional hotplug
+	 * slots can technically be removed, but the expectation is that unless
+	 * the port is marked with external_facing, such devices are less
+	 * accessible to user / may not be removed by end user, and thus not
+	 * exposed as "removable" to userspace.
+	 */
+	if (parent &&
+	    (parent->external_facing || dev_is_removable(&parent->dev)))
+		dev_set_removable(&dev->dev, DEVICE_REMOVABLE);
+}
+
 /**
  * pci_ext_cfg_is_aliased - Is ext config space just an alias of std config?
  * @dev: PCI device
@@ -1822,6 +1842,8 @@ int pci_setup_device(struct pci_dev *dev)
 	/* Early fixups, before probing the BARs */
 	pci_fixup_device(pci_fixup_early, dev);
 
+	pci_set_removable(dev);
+
 	pci_info(dev, "[%04x:%04x] type %02x class %#08x\n",
 		 dev->vendor, dev->device, dev->hdr_type, dev->class);
 
-- 
2.31.1.751.gd2f1c929bd-goog

