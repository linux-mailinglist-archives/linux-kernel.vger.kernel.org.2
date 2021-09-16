Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B43B040E4F3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 19:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244208AbhIPRGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 13:06:18 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:58902
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348284AbhIPRCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 13:02:25 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2432640261
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 17:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631811663;
        bh=kGvrlwC8dgj36kHCoqcN/7cctXrefdaA9zTh75o6nwc=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=O5lWQNZ0vjXAAINv8zoMm998Bo76oUWH+eJ3tzSTB85IaBL5eWlEBVpB2rmA4Wsnt
         nGZBbS1rFBzaUqRMdAn13m4pzilKsB8PDNhx27B8QqiscQGQpxuCM71Eev9hBQRkev
         BePTEdFsfj4eBh3k3884kBw1Cc3o7JYhbXmTbsRHbAmZL3NXHzDIPu2uauHf4y99F7
         Hoj1jfW2X3voPTImLXCFMWhtheZp4Y6xRfN73KLSasc01st9XwduMW+Di73T2nQk5i
         hdoW8/4BZ1OYz5F6ZHhe987Ds/V79Xo4HEArI6xKBcVvThZMCV2Np5Pyu8ZxnojWd7
         edut1ymigigkg==
Received: by mail-wm1-f69.google.com with SMTP id j16-20020a1c2310000000b0030b3dce20e1so577377wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 10:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kGvrlwC8dgj36kHCoqcN/7cctXrefdaA9zTh75o6nwc=;
        b=jwGb6Gjdi20qC6Iu0l6W6AwC/6nwlAEcxovCgr5qyrr4uembuXEotsy8f4Nt3jY4ue
         N+bKv5SVhbYNeujw1WHGykHSeV5/4OaEBCcj4w/sImI4GJMEWRyl+hI9HKnxNBeq7KW5
         X2y/NNWDl/nrlX2PDJM78g2sOvFwr1sD+0RAtESL7FXLNQyqfidtn5VpGqWf4i1/HVZ1
         Ae8Tlil6Ctsg9I8WmPMFlhK33EhtBuSO7RawiZZIRyTtwy9TNPCIMabItGBy5GQBLlJ0
         5i2H/NALZpRlN5b3UYYFmxTQ1VIwAlEfZD0Jn4y9V2wDa+c5VvWG472JBjAxgE9VRHlP
         edpw==
X-Gm-Message-State: AOAM533om7+0W2Mf6LyzLkfFmuvy/KKdLVl3PKyVxRpb4OznOWXkXYTb
        8Zbv186To6jkTyv1O+IK97ebQTEnwmaLj73N8ozjUiMdrK0jFwh1OpBU6qIyR71HOUHX6tURNiK
        Z6NFvgfLeMxVaIFey4aRVRp3pSc1pmbfOfkdmZF1brQ==
X-Received: by 2002:adf:f084:: with SMTP id n4mr7440204wro.362.1631811662695;
        Thu, 16 Sep 2021 10:01:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZv2NplR10Hi7PCHwaacjnOu8R/e6iK1WzNnokBmPAZv6ETWalQ+ItW3RvnaNG42gpPNXYng==
X-Received: by 2002:adf:f084:: with SMTP id n4mr7440176wro.362.1631811662501;
        Thu, 16 Sep 2021 10:01:02 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id q7sm4062646wrr.10.2021.09.16.10.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 10:01:01 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Matan Ziv-Av <matan@svgalib.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 1/2] platform: lg-laptop: drop unneeded MODULE_ALIAS
Date:   Thu, 16 Sep 2021 19:00:53 +0200
Message-Id: <20210916170054.136790-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MODULE_DEVICE_TABLE already creates proper alias for ACPI driver.
Having another MODULE_ALIAS causes the alias to be duplicated.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/platform/x86/lg-laptop.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg-laptop.c
index 3e520d5bca07..4f3ece819f4c 100644
--- a/drivers/platform/x86/lg-laptop.c
+++ b/drivers/platform/x86/lg-laptop.c
@@ -60,7 +60,6 @@ MODULE_ALIAS("wmi:" WMI_EVENT_GUID2);
 MODULE_ALIAS("wmi:" WMI_EVENT_GUID3);
 MODULE_ALIAS("wmi:" WMI_METHOD_WMAB);
 MODULE_ALIAS("wmi:" WMI_METHOD_WMBB);
-MODULE_ALIAS("acpi*:LGEX0815:*");
 
 static struct platform_device *pf_device;
 static struct input_dev *wmi_input_dev;
-- 
2.30.2

