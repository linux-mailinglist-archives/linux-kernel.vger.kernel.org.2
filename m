Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F06EE39D9C1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 12:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhFGKgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 06:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbhFGKgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 06:36:32 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A689C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 03:34:41 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id cb9so19749931edb.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 03:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=18khHUA2AJ3ib5wXxPFFaQIfHWGb1QOUw5+Na90fAf4=;
        b=n4oXtQgnDbe6I7n8UhQvti9n25PNkA+8CaB7/gRPiiU3ZyE93Zst5Lo98mfSLLITrQ
         m+Sm2IiZ4+HBfyRQSFd1677F5fwG2ouPOfavvFFcQYOR13rX4RsL8Yz3vUBFDQQeXYMd
         MD2zqP/28PRP+IfgT3IOgucxndZGyt6c/LIqEFq1zO1ZL9a6S8VLzo54oQFvctiQzp3s
         sJqxCQppIhK2QaWgg6L06Mtp85vchsoV6xYDCcwx68AjI1iyw5irnFTWFujkoZTqDFcL
         0PUk1z/BnIGy7xjf+qyFpNm9ROOAI2pXvK8nl5IVyA9Sx2ZmDaYoeRb9ZHdAuT/NVCX/
         T72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=18khHUA2AJ3ib5wXxPFFaQIfHWGb1QOUw5+Na90fAf4=;
        b=AY9BZ9qgNJG5v9xKLJpa7gMKJX2m3ZLW3CoB4lv6H6zz5RNE/z4CL0TvKuIjLEnFM5
         V+o1sREYbKdHDT/xk8NJRcjDhH0oLE+GEDensB/57F+aAWk4uFwj/AmJHhSHLx0D3uqh
         OMOGn+kMOLYefnMSm6KW8mMkGz7oCiZmw7jo0jVFXOmrHQENiNKBuye6zsb0EPon23RQ
         VvAC7NlHzD+ddZvrX+KM9NdhNM/EP+ig4+PM6itcGHP4BMbyPkcFi3YIeY/zEqA0gmDU
         NGt3HuPE8nF7kbq71WTMCPTSDwg+Eg9p42AJ3I9JxqMQ00Y7dzZkTuza0NS8kV1rESj6
         6E3A==
X-Gm-Message-State: AOAM531kcxomI/g2gM4ndEeNiwymPGmow9KJlKXzwrzkYcTDCTnwchXu
        Q/R8X+5DgTVVlG9Jdwb6VCGoOg==
X-Google-Smtp-Source: ABdhPJyBBEVMU+l3zZzaxsGHeW4GrlFSXJO8KYLsFCW+34uBpPVt4npJyi0x8cFnKWTER2OPtMwc+Q==
X-Received: by 2002:a05:6402:548:: with SMTP id i8mr19605259edx.344.1623062080229;
        Mon, 07 Jun 2021 03:34:40 -0700 (PDT)
Received: from localhost.localdomain (dh207-96-76.xnet.hr. [88.207.96.76])
        by smtp.googlemail.com with ESMTPSA id b25sm7521037edv.9.2021.06.07.03.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 03:34:39 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     robh+dt@kernel.org, jdelvare@suse.com, linux@roeck-us.net,
        corbet@lwn.net, trivial@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     luka.perkov@sartura.hr, jmp@epiphyte.org, pmenzel@molgen.mpg.de,
        buczek@molgen.mpg.de, Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v4 3/3] MAINTAINERS: Add Delta DPS920AB PSU driver
Date:   Mon,  7 Jun 2021 12:34:31 +0200
Message-Id: <20210607103431.2039073-3-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210607103431.2039073-1-robert.marko@sartura.hr>
References: <20210607103431.2039073-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add maintainers entry for the Delta DPS920AB PSU driver.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v2:
* Drop YAML bindings

 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 82d9c2943c34..0707986e9bb1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5105,6 +5105,13 @@ F:	Documentation/devicetree/bindings/reset/delta,tn48m-reset.yaml
 F:	drivers/gpio/gpio-tn48m.c
 F:	include/dt-bindings/reset/delta,tn48m-reset.h
 
+DELTA DPS920AB PSU DRIVER
+M:	Robert Marko <robert.marko@sartura.hr>
+L:	linux-hwmon@vger.kernel.org
+S:	Maintained
+F:	Documentation/hwmon/dps920ab.rst
+F:	drivers/hwmon/pmbus/dps920ab.c
+
 DENALI NAND DRIVER
 L:	linux-mtd@lists.infradead.org
 S:	Orphan
-- 
2.31.1

