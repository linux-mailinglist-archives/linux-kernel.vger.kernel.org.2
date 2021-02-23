Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA97322FEE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 18:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbhBWRqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 12:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbhBWRpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 12:45:43 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7968DC06178A;
        Tue, 23 Feb 2021 09:45:03 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id v21so3237205wml.4;
        Tue, 23 Feb 2021 09:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YCOFQSDEe/3sfY1ZtH3CdhiCYHMFhIU+OK5qjpWOXbw=;
        b=Iay8qIdKim0AaBvFytQmd2LztS7tKQoPDdMD2n9uQvjsYM2Se/agQnN/BA9j+p39AM
         TeI4ZcoRBcRYQsMbXUiywTJwmPKB1jm8v6OktshpBpSHwlFOV+TRU6MekAH2puAHhV3/
         MG8sET4lkGQFXC6O8V49XMgz0NXAkhLIFnHAzNdlp0KNAOEAlrUp+IoLXHQlVnSmK6cJ
         qCqm/7kaoIVVqxp6EzYXVlSN6FDz+4rCT30Q65yD8xhoh1eguIL4cA2UjHMDbtC6K8n/
         K4rn3UL9h/aT6PXTEgjJu1nCGX6nyzl1mGMjxz8nfKjqS0F9NPx2xAKVFA/H/C2urt0a
         CpCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YCOFQSDEe/3sfY1ZtH3CdhiCYHMFhIU+OK5qjpWOXbw=;
        b=EyuvpksujLpIPz4a87U1j/z9SgRWW1sGAlN9VxR+YWqXSaiCgOvt7C/iuLtjokvAo2
         +MbadLPaPNcqm/5HpPyWXPYylMVDtZ7bR/dwos2aaF2ShruCGxPy+psb3Hqwqy2AxLF2
         P3ycagxSeJc9YXTn0FXmTp7KNY1QqDHhBJ3Hpn+6qCob0HtlpA0sosIG/bC5tW+GJWMj
         LLaVi+z5YpTpzeDtG0BQi6l1RpUSwVgNnkls2AhgGkseq0VHvij7PYUFwrkHmAOqz0dg
         fSCSOaU88bUaPYpDrn/wXHdYeJ+16DuV55a9J6YZLG/V6BuXX7KsapwkcM5rZTkcAB6G
         JkAg==
X-Gm-Message-State: AOAM532/3IleEXOPIUEtrBuDSv8IbwpGBjSEZIY3nMn5dzcIllOdDhDl
        xggvBUOJ0IOJNPA29oRQrdM=
X-Google-Smtp-Source: ABdhPJzwLEfBk1TtTHISe2r3iq6YoGW0Nct69tWU2II6kIvPJhlAmm8KgAmFL+Yt+cpws7PCCqYCDw==
X-Received: by 2002:a1c:f312:: with SMTP id q18mr26018356wmq.79.1614102302274;
        Tue, 23 Feb 2021 09:45:02 -0800 (PST)
Received: from skynet.lan (170.red-88-1-105.dynamicip.rima-tde.net. [88.1.105.170])
        by smtp.gmail.com with ESMTPSA id u7sm32408428wrt.67.2021.02.23.09.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 09:45:01 -0800 (PST)
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
Subject: [PATCH v3 3/3] usb: host: ehci-platform: add spurious_oc DT support
Date:   Tue, 23 Feb 2021 18:44:55 +0100
Message-Id: <20210223174455.1378-4-noltari@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210223174455.1378-1-noltari@gmail.com>
References: <20210223155005.21712-1-noltari@gmail.com>
 <20210223174455.1378-1-noltari@gmail.com>
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
 v3: no changes.

 drivers/usb/host/ehci-platform.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
index 4d7b17f4f82b..c70f2d0b4aaf 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -286,6 +286,9 @@ static int ehci_platform_probe(struct platform_device *dev)
 		if (of_property_read_bool(dev->dev.of_node, "big-endian"))
 			ehci->big_endian_mmio = ehci->big_endian_desc = 1;
 
+		if (of_property_read_bool(dev->dev.of_node, "spurious-oc"))
+			ehci->spurious_oc = 1;
+
 		if (of_property_read_bool(dev->dev.of_node,
 					  "needs-reset-on-resume"))
 			priv->reset_on_resume = true;
-- 
2.20.1

