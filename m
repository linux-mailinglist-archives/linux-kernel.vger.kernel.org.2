Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5F6311A02
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 04:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhBFD1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 22:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbhBFCnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:43:39 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C610C08EB24
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 14:27:05 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id t18so6111867qva.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 14:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=TYrtpVLRn3by/Vo/kcPBrt+TPgx+fv0qz/2DUsVYehs=;
        b=U3Djp3k+GP8+qJmYpXluNSRzD2CCSzeiwHY7gG5D/DqWI0d0WLtnjKmxmVZwbiIl0a
         DFuApaMx2zqSpPNTf2PGF1oJpYthPmhJ2nm7rd2FmpuV1zS4CjVC38Mf9NqZTb6tJ5Rs
         93wkaMcPIgBSX8jCDP5L9RSQLRvhi2UMzrLfRacvFGFL/pq/TEt1Cdp+4z3JxfX6hUPY
         3SaWd0T0LeIsrDoy5GbOj+zSX+2Le6Rc6XHW6dAFGuVc9CI83wb9jLeqsHTQhT8g0xqk
         FYbC9sFBEawc8DYagceFE3B8UJcbArkFf7OvdDS8fCXYYPCcSAz2G0+SwR2UiM/F+Tui
         URvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TYrtpVLRn3by/Vo/kcPBrt+TPgx+fv0qz/2DUsVYehs=;
        b=BL7d1LJMexisp1jHlxp0gRTAkxqzfwS0QqpXj9Sx/NhCnNyFW3pMr2cA+ApMfGxHKd
         tB1iNW9iS4m9XLi0Qw465fy2vQzevZzkliBPZSc8F9f2OzJRjbPtHTjdRegQ7rfhle65
         SjG1BP1wu8yG6HlQ0qqZ3n+L35pwbrrg02bxSfP2kmbGBcBnCn/26No18xAWYCJpc4H8
         nlzj63XCUv5UCjqGfdYPr5fQQ2SmGTSw1k7b03b5eBzhUZh5k/WMaX6fUdpdis11KdJN
         pCpvUcFoXFGN+FwPA+oqiN8FEZTfJu3cTkuVIhwoMB9Tm5YZU3sXSNIOI/P0XPgt2HiQ
         iOSg==
X-Gm-Message-State: AOAM530ESKtPUN2G2KCDTixabJIMvDO47+nuXW174uKnCiZzg+qvmo29
        FtV5peUpBHKpAVt3cAo9LtlNo4aeuIms1J0=
X-Google-Smtp-Source: ABdhPJwdjYLytH5Kf+IR/URLqg4oBMorIriHqSmnCdh9rbCozFjv7tkF2iAFZexBUHOTPiNpU3ZtLytbJBYvjy8=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:6d36:b798:55d7:f5c5])
 (user=saravanak job=sendgmr) by 2002:ad4:4e8a:: with SMTP id
 dy10mr6613039qvb.36.1612564024540; Fri, 05 Feb 2021 14:27:04 -0800 (PST)
Date:   Fri,  5 Feb 2021 14:26:42 -0800
In-Reply-To: <20210205222644.2357303-1-saravanak@google.com>
Message-Id: <20210205222644.2357303-7-saravanak@google.com>
Mime-Version: 1.0
References: <20210205222644.2357303-1-saravanak@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v4 6/8] irqdomain: Mark fwnodes when their irqdomain is added/removed
From:   Saravana Kannan <saravanak@google.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Len Brown <lenb@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Saravana Kannan <saravanak@google.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows fw_devlink to recognize irqdomain drivers that don't use the
device-driver model to initialize the device. fw_devlink will use this
information to make sure consumers of such irqdomain aren't indefinitely
blocked from probing, waiting for the irqdomain device to appear and
bind to a driver.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 kernel/irq/irqdomain.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 6aacd342cd14..288151393a06 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -205,6 +205,7 @@ struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, int size,
 	}
 
 	fwnode_handle_get(fwnode);
+	fwnode_dev_initialized(fwnode, true);
 
 	/* Fill structure */
 	INIT_RADIX_TREE(&domain->revmap_tree, GFP_KERNEL);
@@ -253,6 +254,7 @@ void irq_domain_remove(struct irq_domain *domain)
 
 	pr_debug("Removed domain %s\n", domain->name);
 
+	fwnode_dev_initialized(domain->fwnode, false);
 	fwnode_handle_put(domain->fwnode);
 	if (domain->flags & IRQ_DOMAIN_NAME_ALLOCATED)
 		kfree(domain->name);
-- 
2.30.0.478.g8a0d178c01-goog

