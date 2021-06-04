Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D04B439BC19
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 17:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbhFDPjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 11:39:10 -0400
Received: from mail-ej1-f44.google.com ([209.85.218.44]:46054 "EHLO
        mail-ej1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhFDPjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 11:39:09 -0400
Received: by mail-ej1-f44.google.com with SMTP id k7so15099527ejv.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 08:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=18khHUA2AJ3ib5wXxPFFaQIfHWGb1QOUw5+Na90fAf4=;
        b=rdqeHmjXUcQIOHQ/to3kGr2aZHwHzLmp4uZnM7Mq3J89WlI6CCkq0M0UbJrNaS61lD
         p4HwIp1+5cDCIJm6mP0kMoBYg+eQUH+rHUUzJO3RwR5kLtEKiKoBnd3GamDGK1EIe4FT
         TyWJb5f8qBengCA3jkb2xc5HPsA4rm4XgZ3Ytm0Kz6sJOEqAAztIlkmv8/WFlIji7/lt
         qyNp5WGkmM49RpoBMIIZB2Bqf/Rlm/oHL2GX3E5GqnrrBxTmb3JccFneCUs/NKc7O3Hu
         8MraCGqto5hET+0twyYCBnGZ8Z9eZUNyoobQc78pvSF/qkwZigKqJ1dJTC76tYit1Hqe
         aTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=18khHUA2AJ3ib5wXxPFFaQIfHWGb1QOUw5+Na90fAf4=;
        b=PjpJJnWcway2WoM2r8OiSDzsNpg4q/+F5QiAq0ZAYQ3tIsIettrTcMxVG4JCckZbyE
         iVaXTkQH6sEbfMgCUuCG/EmxehDSw+mJFcenNW/YtbOTK7VyajCsLru7FngFkd97pb9t
         n/zMTxklc3z1BrJvL+BZF+8egv6GFrhcemV6bZhnBtNwynbNytToGyWzg2WjapCkMksb
         +JEtslfTn+cb/mdb2unT1nmxj+hV49s+lBd42Ah3SGsg6i3dnf0wlt66M39TQ01rmqE8
         g12Ruge8t7UtT2xUwyLPE+Gr3smdBS1wkd8t3k/SCflF71reSAm7oT4ABCyr4xCXQx/s
         Hsbg==
X-Gm-Message-State: AOAM532tSSTFhu+1KtCpQbrvxYi8ScHo6x+46H77Heag7lwhKYKR+pbb
        kcrH7+0fLvRMCTp1zul7wBzUbA==
X-Google-Smtp-Source: ABdhPJzJk5hJcow9IP1RWbN4rBSMsfSX0vDK2NKcesVXQxSYC3clPLa/eYKG6MLuMUviPoyoU5l5VQ==
X-Received: by 2002:a17:906:7e4d:: with SMTP id z13mr4687520ejr.50.1622820982029;
        Fri, 04 Jun 2021 08:36:22 -0700 (PDT)
Received: from localhost.localdomain (dh207-96-250.xnet.hr. [88.207.96.250])
        by smtp.googlemail.com with ESMTPSA id d25sm2909038ejd.59.2021.06.04.08.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 08:36:21 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     robh+dt@kernel.org, jdelvare@suse.com, linux@roeck-us.net,
        corbet@lwn.net, trivial@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     luka.perkov@sartura.hr, jmp@epiphyte.org, pmenzel@molgen.mpg.de,
        buczek@molgen.mpg.de, Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v3 3/3] MAINTAINERS: Add Delta DPS920AB PSU driver
Date:   Fri,  4 Jun 2021 17:36:12 +0200
Message-Id: <20210604153612.2903839-3-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210604153612.2903839-1-robert.marko@sartura.hr>
References: <20210604153612.2903839-1-robert.marko@sartura.hr>
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

