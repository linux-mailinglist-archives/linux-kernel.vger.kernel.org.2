Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 766EC3521B9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 23:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235282AbhDAVhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 17:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234796AbhDAVhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 17:37:03 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2B3C0613E6;
        Thu,  1 Apr 2021 14:37:01 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id z1so3522145edb.8;
        Thu, 01 Apr 2021 14:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e74JBjvASSCexB4+iSEuob3u0eDtHVLnT5ys0O6XPH8=;
        b=mpX/u4NEa6VMl+4sxiJrjdQPOoVilbJvMl23ZXbkewEFQ8lfgtH50OETUYW47QOLtg
         locw/fZ6o0orfi0exx+yUZtZB7Jq2QOcNsEg5QBwxkFTKqwWuVJ5mJUDpwJGHAAvg8le
         5tgcYyAf2k3b2j9WFNMi6h1EE0b/kMySmTSOlYuJjX6nq3HrdmbAI5r+XdfFjSnf8WFy
         mgzz+8mxrwB34r0U3o5LQ7lWjE+9vLF1E9e+w9yVnjLTfWPt5aqpw9Lj6jg2P/17j1v2
         MIqEphx3ik+ITXhIJi6r5Mtl2tpQO4ObRkAB6JjH3MnWjriMHIaA/GuSf/QcG48oIerU
         JHdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e74JBjvASSCexB4+iSEuob3u0eDtHVLnT5ys0O6XPH8=;
        b=Mv20p8Mwkd/N0UA2lL/u+Xsqnk9HFyJZwW9QQfGdcREqZ+Z0N4HqCsYvqjhOXEfEos
         Yg/6WHG434o3dVcHXmkZQY+DifVpqqjLP++mDt1QeKYXguv0dFWP/G1xvVNAMTLqhrVM
         q9VJ73hhT28XACcL1fMg9uTne+SUHPo9tZ53LmR4fS7Jrql+wqxNwleE3YUG3ZO6RYjO
         eiSMyUrgc3/GknK6VtvnoBdXDW7hQ99OXkQEyxNp7ynIhHqU9V+1uVOAtEMONQtqECCT
         fNt4HRbxAMOVP16herwg4h0tnYfTMs/Yz8X4/ltRb1WgMEGYcPemwTzTJ6O0MU+W0N6t
         i9MQ==
X-Gm-Message-State: AOAM531CWGiGtSLn1z+d+4dTMh0EJBnemyPKGMBkUQcC4R4sOPcotpyV
        ZMftZp0VHv/d1KG+VSgU+ywR/XVBa9aZyQ==
X-Google-Smtp-Source: ABdhPJwsCEvVUp7ijj2SJndO5yoENJgYJgXc63ygfjWn90TVlEa7ceZNB8VVE398SrF0IfD6AkIKqA==
X-Received: by 2002:a05:6402:19a:: with SMTP id r26mr11991074edv.44.1617313020404;
        Thu, 01 Apr 2021 14:37:00 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id f9sm4237006edq.43.2021.04.01.14.36.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Apr 2021 14:37:00 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org, balbi@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v6 1/4] usb: dwc3: of-simple: bail probe if no dwc3 child node
Date:   Thu,  1 Apr 2021 23:36:49 +0200
Message-Id: <20210401213652.14676-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210401213652.14676-1-jbx6244@gmail.com>
References: <20210401213652.14676-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some of the dwc3-of-simple compatible SoCs we
don't want to bind this driver to a dwc3 node,
but bind that node to the 'snps,dwc3' driver instead.
The kernel has no logic to decide which driver to bind
to if there are 2 matching drivers, so bail probe if no
dwc3 child node.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/usb/dwc3/dwc3-of-simple.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
index 71fd620c5..8d3baa5df 100644
--- a/drivers/usb/dwc3/dwc3-of-simple.c
+++ b/drivers/usb/dwc3/dwc3-of-simple.c
@@ -38,6 +38,10 @@ static int dwc3_of_simple_probe(struct platform_device *pdev)
 
 	int			ret;
 
+	/* Bail probe if no dwc3 child node. */
+	if (!of_get_compatible_child(dev->of_node, "snps,dwc3"))
+		return -ENODEV;
+
 	simple = devm_kzalloc(dev, sizeof(*simple), GFP_KERNEL);
 	if (!simple)
 		return -ENOMEM;
-- 
2.11.0

