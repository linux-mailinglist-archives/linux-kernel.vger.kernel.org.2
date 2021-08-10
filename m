Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5D13E570D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 11:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239243AbhHJJdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 05:33:24 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:42898
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239153AbhHJJdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 05:33:01 -0400
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id 5D95840656
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 09:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628587958;
        bh=Hsa8IKqVji29FGH+yRDuNJzfbTLnU+d/QReLlRASr30=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=qssNyyJMLQ/nuMzjqRNHiLlERiJ/cOFW7vUZb8GGNkh1/ntGwGvwN5fXjQALKOFvf
         mojDPU4f+rGCQ910mjJu0K5/1PSACPwNQJIhDhhNdPpGa/BBrMg9mLVAfZGVoo6VpY
         pXh3iO69ha841xKJxbH8S+jSOmKUj6c9Tp2K0p3LZ0I3l8vZCTtAMpdyhWV5013W95
         zfsxf2ItTdhp+DnWgkUM/oi7xL/Am6tHMEwcDjyzQEaPFZJir9/6q7s4+fFCevgjAM
         wymXKClGhy0OzdM7LaY0sVw3to3bS1+j+IegcSBNBFe92PnOrY5HOLvXJ+9JjgG906
         uCq8g2O2n3xLA==
Received: by mail-ej1-f71.google.com with SMTP id ju25-20020a17090798b9b029058c24b55273so5421467ejc.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 02:32:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hsa8IKqVji29FGH+yRDuNJzfbTLnU+d/QReLlRASr30=;
        b=E1109DZrxvbLQy/8Cl6hWWqViOrpWcoHV4fP+e+8CmnHKUMHwq3BFtJvEmVfgnmsG0
         Eoks/ppUFRmICBWVHNVwwbUhwYNVO6WaR9shPTNg3ioc3LNSWyTgxVll3lJxT4fHS6/W
         mke3xHP19JaWxVU94LufBKBd5kejcDZFFAlDAFT3d5yBHrvCX+XngTisbCpsUmIU+Vao
         283kL0ysUbbtQfbfRhYg4ZdKkNo0d05TwBBwy3YhQcyGb+RUSr8UixavG1653bbHnKux
         Rd6HFYO/MPQFC7HLkACL1NLp/Bx912264oJvnuN7blZpcIesNMzv8EXWCUy43vfC05KD
         xfWA==
X-Gm-Message-State: AOAM533IJg+8Zz7+qm/1KAeWqWS8xBxS7WgcbIiv2uGg9IeacOXmgojt
        C1FQXD6P1+WRddaATXUAScIcXf+Jp54zqckAci+57DiBNY9TDqNWZIFlI9IBlZjz2JFYqvIK6jC
        M/tm1bf583ZlPwW1tkeoRWDPnf3/e+N63xKQob5S+yw==
X-Received: by 2002:a05:6402:718:: with SMTP id w24mr3802098edx.49.1628587958082;
        Tue, 10 Aug 2021 02:32:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxR7C8E/KWR2jGuw3L7l7j2/qOnH9UiytPUdHGRKEP61jLqGIG5z9kzxTHeSOVYaSZs0tSahg==
X-Received: by 2002:a05:6402:718:: with SMTP id w24mr3802084edx.49.1628587957975;
        Tue, 10 Aug 2021 02:32:37 -0700 (PDT)
Received: from localhost.localdomain ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id q21sm5117606ejs.43.2021.08.10.02.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 02:32:37 -0700 (PDT)
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
Cc:     Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH v2 8/8] MAINTAINERS: clock: include S3C and S5P in Samsung SoC clock entry
Date:   Tue, 10 Aug 2021 11:31:45 +0200
Message-Id: <20210810093145.26153-9-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210810093145.26153-1-krzysztof.kozlowski@canonical.com>
References: <20210810093145.26153-1-krzysztof.kozlowski@canonical.com>
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
index 2dbacacac3f5..4477215ef649 100644
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

