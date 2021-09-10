Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC3C8406D9A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 16:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbhIJOZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 10:25:42 -0400
Received: from mail-qt1-f177.google.com ([209.85.160.177]:34597 "EHLO
        mail-qt1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbhIJOZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 10:25:39 -0400
Received: by mail-qt1-f177.google.com with SMTP id 2so1558927qtw.1;
        Fri, 10 Sep 2021 07:24:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3/lXCTGRjOib0NEqydvUuR/bGgrus2AGOSJiOOia7MY=;
        b=J8TBX0PCEAlyuBPxrYWFC/j/xYZPY45B1g9zhLMc4yHZheCoRm3cjLaB560jd+Se9r
         q/UVfjZCrgLl+ki5vfWcr9JTYp1C5J3xYFF+NVeuiXHbzRPITnfTnoZx4kup3Cjw2fF1
         UXY9aVRbhSMnCv7VxLDknnWpjD8nz1aNRqrUKSkSz7lqvproWLIvxuW7TyNGUWrXEOHF
         G9dCcegZvtl1gQ5GeaGdyx9RdOPIo56ftER2JbnWJyrb9pm1KnAYO2ePQTVSDaT3GdoX
         pndk1NqBdnFNIlgUtjm2d6oSJRW5QpPCQdwUwyk3tp+GfMZUp9q3LUrShnxKocSMdMPg
         Q5Tw==
X-Gm-Message-State: AOAM533aWz9zOqi31qd3gSKzcil2CSLeP/hD2mkP4v2fQJ5Ejqv2eZEd
        Gbq5Jwfbiv1uzYkx63wNcLpvvuWZhw==
X-Google-Smtp-Source: ABdhPJwLLwqIpWeQzYq1k7yjFpZImc0ZWD8Y+nVKDluIJN6s8hiRc3X2DQqpYQCvwED182BVKwDPyQ==
X-Received: by 2002:ac8:4292:: with SMTP id o18mr8221809qtl.75.1631283865687;
        Fri, 10 Sep 2021 07:24:25 -0700 (PDT)
Received: from bill-the-cat.lan (2603-6081-7b01-cbda-55fd-c014-b2c6-676a.res6.spectrum.com. [2603:6081:7b01:cbda:55fd:c014:b2c6:676a])
        by smtp.gmail.com with ESMTPSA id b21sm3190527qte.38.2021.09.10.07.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 07:24:23 -0700 (PDT)
From:   Tom Rini <trini@konsulko.com>
To:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] docs: dt: submitting-patches: Add note about other project usage
Date:   Fri, 10 Sep 2021 10:24:19 -0400
Message-Id: <20210910142419.5237-1-trini@konsulko.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In an attempt to make it more broadly known that other projects are
equal consumers / users of the device tree bindings, add a note to
submitting patches to say that extra care and consideration may need to
be taken when updating existing bindings.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Tom Rini <trini@konsulko.com>
---
 Documentation/devicetree/bindings/submitting-patches.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/submitting-patches.rst b/Documentation/devicetree/bindings/submitting-patches.rst
index 8087780f1685..36a17b250ccc 100644
--- a/Documentation/devicetree/bindings/submitting-patches.rst
+++ b/Documentation/devicetree/bindings/submitting-patches.rst
@@ -63,6 +63,9 @@ I. For patch submitters
      string that is matched by the driver (as in the "nvidia,tegra20-pcie"
      example above).
 
+  9) Bindings are actively used by multiple projects other than the Linux
+     Kernel, extra care and consideration may need to be taken when making changes
+     to existing bindings.
 
 II. For kernel maintainers
 ==========================
-- 
2.17.1

