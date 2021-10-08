Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8B64269E0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 13:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242024AbhJHLnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 07:43:16 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:47362
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242442AbhJHLkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 07:40:05 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1CE5D40007
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 11:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633693087;
        bh=3lioRcCn3/5I7Byd/FEr0VTjZpCEaYjPURKLlNwW7t4=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=L4m3LXfzJPrmhKKmCayaDbEUQpBkYUWnc2uSQ8jDt5o0ZrnBXtzIIO51mIFMHYP8Q
         xq/TjhGu+14IAEMTyVaNuivhLnprtbx0LpwyTbc1t/JN0CgGeMZRp9EkJZvI0cbwdn
         jNHx/mekwZUJDvTJSl8SdIA9NQ4AiGcTqV75bys8AA7MtTA7XhC0vQ4Un6B1IJYWne
         +3YfZMFsrjowNMAVl8VWpreO+M3S9KYRjf9QNvq3QLr2NW9DFTFq5irNRPE8jT0Alz
         zKT2OLLKKQ0SJgvT06+g6FUTA1X1gTRuXAY8xzEQ8ZLt9czQ7TCqWRyMHhLNR0iWbg
         MNtbBR4sEmY7g==
Received: by mail-ed1-f71.google.com with SMTP id u24-20020aa7db98000000b003db57b1688aso3542665edt.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 04:38:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3lioRcCn3/5I7Byd/FEr0VTjZpCEaYjPURKLlNwW7t4=;
        b=wTQZ9Lg3/7nWOWMthdv2phNbT6XSosVhiMJpdMHwqya8Q0nh9AExcBkZDzA1I1G9VX
         chp2HF7HwgTEymY5Qntb1FxEmfMeEZF0FPmXKqp4wMbIOoCASOJ7ZlJFhe/Rz82ZUltx
         zkFK2f+d9rPhX4ycXVu/Qmfk2v32GdhVrPuOzqgDB5VGSW7ZCOZAKEAv5yMx7qoPkqG3
         azrPzaYWoRtzRUcoT1g+fRdbxh1EB8VZMS2xQUEXLs0MtcWMtFoIsPXL73GVgT3pDA/u
         T/taLxHHWmGcPcXICVP7Wa58C+S+5vB63rGhJr3qTX6cTAFiCs/zUXzLoChGpc2ykAWl
         C0Ug==
X-Gm-Message-State: AOAM530swsWrkusqUolLm22q/xZBmfdEdgi82qZ2iy+hnlBoBVUEzsFM
        ls7mHGMX5IPC/4SdCK8sK5atQ8grDA0g/4LY3Y0vSColuCE65ANtYlOw5cCk/v6HykfQZGOYtPv
        UrDOug7FrEytErPFuCHlisv0lVU+uPvlMUyaAxqcV/A==
X-Received: by 2002:a50:e1c3:: with SMTP id m3mr14475699edl.28.1633693086684;
        Fri, 08 Oct 2021 04:38:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzSgOOTxmIz6/eUaO3XLb/7FHGRRj5wImxJqfZ/8ppuVdIQh/Aapau2ufIxWL+mBrSjYqbxmA==
X-Received: by 2002:a50:e1c3:: with SMTP id m3mr14475657edl.28.1633693086467;
        Fri, 08 Oct 2021 04:38:06 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-186-13.adslplus.ch. [188.155.186.13])
        by smtp.gmail.com with ESMTPSA id la1sm819948ejc.48.2021.10.08.04.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 04:38:05 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Sam Protsenko <semen.protsenko@linaro.org>, stable@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 02/10] regulator: dt-bindings: samsung,s5m8767: correct s5m8767,pmic-buck-default-dvs-idx property
Date:   Fri,  8 Oct 2021 13:37:14 +0200
Message-Id: <20211008113723.134648-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211008113723.134648-1-krzysztof.kozlowski@canonical.com>
References: <20211008113723.134648-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver was always parsing "s5m8767,pmic-buck-default-dvs-idx", not
"s5m8767,pmic-buck234-default-dvs-idx".

Cc: <stable@vger.kernel.org>
Fixes: 26aec009f6b6 ("regulator: add device tree support for s5m8767")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/regulator/samsung,s5m8767.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/samsung,s5m8767.txt b/Documentation/devicetree/bindings/regulator/samsung,s5m8767.txt
index d9cff1614f7a..6cd83d920155 100644
--- a/Documentation/devicetree/bindings/regulator/samsung,s5m8767.txt
+++ b/Documentation/devicetree/bindings/regulator/samsung,s5m8767.txt
@@ -39,7 +39,7 @@ Optional properties of the main device node (the parent!):
 
 Additional properties required if either of the optional properties are used:
 
- - s5m8767,pmic-buck234-default-dvs-idx: Default voltage setting selected from
+ - s5m8767,pmic-buck-default-dvs-idx: Default voltage setting selected from
    the possible 8 options selectable by the dvs gpios. The value of this
    property should be between 0 and 7. If not specified or if out of range, the
    default value of this property is set to 0.
-- 
2.30.2

