Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 875953E4715
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 16:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234867AbhHIOAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 10:00:52 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:52906
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234825AbhHIOAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 10:00:49 -0400
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 288E53F355
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 14:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628517628;
        bh=ogcKwTXTNYwj+j1SOoDVMuNAFMs2asYIwm4+FNw/esM=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=intbm6++GHyRvl/jNImpuCeR5EP4S0dzPseQahUW5DfI+xaQzoxVzvmDMZpRAmRHz
         jspcJ2m/8+7x2PTydpS5QkWV3swog+tk+IhtcXZMUy3jxR0n4XjM+q8uViKZxMWGO7
         XEohb+JExqd40v6IdReMSLPzbSOe92k7cPbaVqmX2YKx62tYXP2zcrDmOORo8k2tFB
         Avwkrv251fB3vOW1QfXXZGqcO43SQxibEXHCxC6QeYt5T9JVglFQahcQJPXl4v0yaQ
         L+GgQunGo0L6BnadxKsRV3N9JY2JDYr6K5AK4EOEn236Dfp1w6vy59seuZpEBZI8Og
         KueGchOTYFSBA==
Received: by mail-ej1-f70.google.com with SMTP id ne21-20020a1709077b95b029057eb61c6fdfso4539970ejc.22
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 07:00:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ogcKwTXTNYwj+j1SOoDVMuNAFMs2asYIwm4+FNw/esM=;
        b=Viw8dlP+pnyw76EIv+Vag8cFjw5bjtb/HiuK/vUeAWJjeiIatHdJqEEhpuUy5Ppz2X
         IHmQ0WwnzHMwG1rC4ZrH7NJOfPHLLmw8O7T5E/TljYOhFyJlOhul6XaPB2XV4eXcboJY
         V+Opk/IhMC5oze20+u9C722fk3QKlFbpi+//lxlMou2Zv7REMIyPA216uWn7WbzgA9R8
         ruTNeZEwLymtEWChXFk9pKRsN36Qv39pDVpI4Zd3S1B7sJsW+NGhl1kxM0PwXw+L4Qpw
         yLMPXBHmfYN2X/mWcpNIj8ETTpnATo5SnZpXfNepIReqV2UK2mSsASJEhv7x/3uaG8gg
         Cu5A==
X-Gm-Message-State: AOAM531v2zvz54BxnamrDgL8RLZSQK+Ruxvnu7jwscpV4keVq0/hMxr3
        kw9G93QDG7j2nk/n4zPkiP8SpTsuXQKQBhLf2bnB1NoTMqhmJKE8XJmylZ9RB0i1IDgJGxjPfmR
        FFyHVXLMaHys8nsh5PRFTA1yDM0nNW80R1sRfufgCKQ==
X-Received: by 2002:a50:eb95:: with SMTP id y21mr3033504edr.5.1628517627880;
        Mon, 09 Aug 2021 07:00:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrg+ozBKK4x83aTava67CJhBK41FPyP3TvrzsZD3SsSwXCBJSszou+evSlMSrS/YsyQeeDcQ==
X-Received: by 2002:a50:eb95:: with SMTP id y21mr3033487edr.5.1628517627750;
        Mon, 09 Aug 2021 07:00:27 -0700 (PDT)
Received: from localhost.localdomain ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id b17sm7909686edd.27.2021.08.09.07.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 07:00:27 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] MAINTAINERS: clock: include S3C and S5P in Samsung SoC clock entry
Date:   Mon,  9 Aug 2021 15:59:42 +0200
Message-Id: <20210809135942.100744-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210809135942.100744-1-krzysztof.kozlowski@canonical.com>
References: <20210809135942.100744-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cover the S3C and S5Pv210 clock controller binding headers by Samsung
SoC clock controller drivers maintainer entry.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2dbacacac3f5..7846ce554b07 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16496,6 +16496,9 @@ F:	Documentation/devicetree/bindings/clock/samsung,s3c*
 F:	Documentation/devicetree/bindings/clock/samsung,s5p*
 F:	drivers/clk/samsung/
 F:	include/dt-bindings/clock/exynos*.h
+F:	include/dt-bindings/clock/s3c*.h
+F:	include/dt-bindings/clock/s5p*.h
+F:	include/dt-bindings/clock/samsung,*.h
 F:	include/linux/clk/samsung.h
 F:	include/linux/platform_data/clk-s3c2410.h
 
-- 
2.30.2

