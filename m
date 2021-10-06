Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3940042402E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 16:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238694AbhJFOgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 10:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbhJFOf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 10:35:59 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495A7C061749
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 07:34:07 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id t2so9475283wrb.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 07:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lh1W7kBvMeHI+4CDe6VW6N/mE80UvIKM27n3C0kEATc=;
        b=WjLBDqVh2Dr19GIq9tI65YcUQy5A0TXOv9O1f12RZ4PyYliV3XpP7lstHmvpjHU5+x
         YxPzRTsxIlSiPClsUjbgtFHFOwp8Q4VvByQZWRtk3EtWTIdNi82FkuE5lSAzJhtnAaUW
         /c+pfPp+VSMG3ZOJjpR8kxEtyMQxNJsySOn0DgdEruXEGoTpO4LzmphcUr6fQjzdYnr/
         5zhXph32YwzU24FlNhPJLKmXwVjTmgCxe4UzWphqk/kV5f5wXdppCgv6czJ0FOzjUCMd
         EIMgfuumEcB13WPhHcDCjnQdo3N7c1m1CyfJbS1o56R9KtYgQk/q3ZL+IMjcEs1oqxyZ
         gX8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lh1W7kBvMeHI+4CDe6VW6N/mE80UvIKM27n3C0kEATc=;
        b=GL+P60XTU+n9XsvmqOy1ZWJemTxAOKgaKL+tX6W4mH1Lxa6YSqMsLAS/JxoVcQNcGC
         Kppn6JZE5E+CWlOejhdcVvbCiOFTZsYE14FEiEFZxEcA8RAEkvalMNnULKyQUzqvtora
         bD3wGAyidsfwIzyUDIxEjjlxl9OfbwhGwh7t2AVhSLkZxds7tOAx7hFXh2ZrlIYbwkQ1
         TBx5zbzxxf9I87sUGNw2F/59liy52muh8bREQmiVkgCXJVDszvw5k4EhHk3u5uYmd7My
         j1h58Tg178aeGkna1IXR6mynYRHKXQGsogVmwNvQcwejVD5qabV8vIn5ypNa/EbUAy51
         JwnA==
X-Gm-Message-State: AOAM530uPmt9/IRsGJOIFPXqgIdkepvZk3sOVuPNgwvFipyDOxkgHcvo
        +yncXJ1aWCBQpEv/luuK9+Q=
X-Google-Smtp-Source: ABdhPJzsZOnBMAgXooNskOg186A/mNEAspcZPBVdGcUL2CXD7OLN3ivNWlz6Rz06BCA3k+6CyRbbQg==
X-Received: by 2002:adf:f30a:: with SMTP id i10mr1633359wro.65.1633530845433;
        Wed, 06 Oct 2021 07:34:05 -0700 (PDT)
Received: from localhost.localdomain ([197.49.35.129])
        by smtp.gmail.com with ESMTPSA id r205sm1820566wma.3.2021.10.06.07.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 07:34:04 -0700 (PDT)
From:   Sohaib Mohamed <sohaib.amhmd@gmail.com>
To:     sohaib.amhmd@gmail.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: Fix typo in sysfs-firmware-acpi
Date:   Wed,  6 Oct 2021 16:34:01 +0200
Message-Id: <20211006143401.129295-1-sohaib.amhmd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove repeated world: "send send a Notify"

Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>
---
 Documentation/ABI/testing/sysfs-firmware-acpi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-firmware-acpi b/Documentation/ABI/testing/sysfs-firmware-acpi
index 819939d858c9..39173375c53a 100644
--- a/Documentation/ABI/testing/sysfs-firmware-acpi
+++ b/Documentation/ABI/testing/sysfs-firmware-acpi
@@ -112,7 +112,7 @@ Description:
 		OS context.  GPE 0x12, for example, would vector
 		to a level or edge handler called _L12 or _E12.
 		The handler may do its business and return.
-		Or the handler may send send a Notify event
+		Or the handler may send a Notify event
 		to a Linux device driver registered on an ACPI device,
 		such as a battery, or a processor.
 
-- 
2.25.1

