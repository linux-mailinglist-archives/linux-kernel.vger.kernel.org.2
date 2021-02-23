Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 227BB322E99
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 17:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbhBWQRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 11:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233563AbhBWQRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 11:17:33 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8016CC061786;
        Tue, 23 Feb 2021 08:16:50 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id l13so2977331wmg.5;
        Tue, 23 Feb 2021 08:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=62C/tDmk+MSjo8rXAJ962MGxlZhUv4yIxXR51bs0jJs=;
        b=RsZOaSv4al1Nyn95Atv8D97OyyLYxEy4QgIh8648RDP91GQ+bwMGDm/dlDNa6crppD
         ZY38PA12nx04la3S7YlSwKkL27y1GzdwoROt5LEShAS/chRKdfx/81CIDEE81+mMysnO
         UF9ilumUITPX0WpHWzlepdihd+UrrwxXBASi1M0zzcnOqwTjLqv3s4O2H1dR3KtJ6kAQ
         2jE8LBK/eFFK3Vh9f5Mva6fbSkfhQwSAwVjoT6dId8/gKZ/25raaX5EsWr7VNFCZMvER
         iO4caOdUaxRdA7CuRq5Vex7icrCdjs7sIMKa3esjarN/Wzl50dMoy+khM4ADFp0ZTArs
         MpPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=62C/tDmk+MSjo8rXAJ962MGxlZhUv4yIxXR51bs0jJs=;
        b=BlLVBe/0fiOHOICTO3d59UQolbznHlOP10qy+P2fzSMs52VVm98ThAy+uins4BAV5D
         jYJsiDSGb7j1gGdGKIEYem+pG+Pn/317fSwbGHq1DdqmxSA/9H+eGI4m3QWK9UVHnWVW
         L+a/onvrXSzhzVqs0QPqQUXyAKwd9Hnqzo4f4LxdDt+GCDjGMZORwXjMDoS5tkS7hjFX
         TY/tAwGixf/7imftyIjmB0/fFu/uHa5Q6QYfLkYg6klsrPZlnf73VIqFAe2Bn4bO/nYd
         R03clxIgAIUzhgcILqT+tIVfcoBGonUmmEnrn2uqMbVvmMT9Y2F0zCj7UtpZouKCDy66
         W6eQ==
X-Gm-Message-State: AOAM533XI0XrQ3orC+3xQAgbXsOdUqnOUkjf5eQg2wLXTeyH1aW1sRRi
        y7ad5m6FCka70qgRWnxVLbs=
X-Google-Smtp-Source: ABdhPJxgtfnhf8+Y4yT+VytFiVfZMB8uYBTy/eUGUpY5eiUchX0aEQdZpwfvrrnW/u8mmLzvHD12hg==
X-Received: by 2002:a05:600c:35c2:: with SMTP id r2mr24209785wmq.54.1614097009231;
        Tue, 23 Feb 2021 08:16:49 -0800 (PST)
Received: from skynet.lan (170.red-88-1-105.dynamicip.rima-tde.net. [88.1.105.170])
        by smtp.gmail.com with ESMTPSA id h13sm32699925wrv.20.2021.02.23.08.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 08:16:48 -0800 (PST)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     f.fainelli@gmail.com, jonas.gorski@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Tony Prisk <linux@prisktech.co.nz>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v2 2/2] usb: host: ehci-platform: add ignore_oc DT support
Date:   Tue, 23 Feb 2021 17:16:44 +0100
Message-Id: <20210223161644.6095-3-noltari@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210223161644.6095-1-noltari@gmail.com>
References: <20210223155005.21712-1-noltari@gmail.com>
 <20210223161644.6095-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Over-current reporting isn't supported on some platforms such as bcm63xx.
These devices will incorrectly report over-current if this flag isn't properly
activated.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 v2: change flag name and improve documentation as suggested by Alan Stern.

 drivers/usb/host/ehci-platform.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
index a48dd3fac153..2c587e31d010 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -286,6 +286,9 @@ static int ehci_platform_probe(struct platform_device *dev)
 		if (of_property_read_bool(dev->dev.of_node, "big-endian"))
 			ehci->big_endian_mmio = ehci->big_endian_desc = 1;
 
+		if (of_property_read_bool(dev->dev.of_node, "spurious-oc"))
+			ehci->ignore_oc = 1;
+
 		if (of_property_read_bool(dev->dev.of_node,
 					  "needs-reset-on-resume"))
 			priv->reset_on_resume = true;
-- 
2.20.1

