Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68C8B3E463D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 15:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235342AbhHINLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 09:11:47 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:48980
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235119AbhHINLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 09:11:45 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id 69ED240672
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 13:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628514684;
        bh=RBrWNEsM4hpvDhERmxPrcwjfu4LtC8P3Itfo+sJHtYA=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=VZgYkGzM/QW6cTY+ZwKPFvg8odw7iZ3rk/CmV870FHU3h9dkm4zRtu2Xyoo/RVPBC
         qB0ASYvwToA1wfX21esb7evAOYWU6PQlEDq3Ho3F8J2GVL2ysX2BDI5DVnNEAV2JVO
         mTcNllgRoaqwD1KRAXnUo9pN8giP2NkwRw1HzuiPfKI6U3M7SQlpT+iTubraQxEngt
         nHZ3HLxZw0iMNlrMyyEGpETtAjxDt1ubOPthQEkWZlpBY64ToXAM7H//+nen8DQs9g
         F6gaKhdKJJRysy+0HN6Z1JoA8xfg3JVDTfu9gh4fVNVmc0biKeJyPnuocAREIkAjwx
         Mt7PDgBH2oExQ==
Received: by mail-ed1-f71.google.com with SMTP id v11-20020a056402348bb02903be68e116adso973244edc.14
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 06:11:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RBrWNEsM4hpvDhERmxPrcwjfu4LtC8P3Itfo+sJHtYA=;
        b=E0+pfEtJoftw0RhvdsL7M1enOy/0EJSn1MWJwTm1o6tsbABTb5th0kXUJHamS7daAb
         mW2zXbzU0S+Ui2D4tbW2bxKwMMV0iWsY4tgprT+GXb7unZB1rxCqdKbEsAedSxDjySzq
         H0X7QE6uW3iEJKKHD7ytPy1UtecBVGJkGqUf9tlqv1qHfTuZCTtX6GLC0XPwgyDjLn/2
         9uHeQ2f6bUsWUCLK6nv7NhQ8nN0zLdsWBX4jVy+8kwyHtftUvE6zWWQaGKXsol9KbRvT
         4O7szlJU3V87k1vnQA/SdXUj8IOWyWzIoYVHPlAS2o3Zewt7aRel2by7hzgnyTvGoTQl
         DPkQ==
X-Gm-Message-State: AOAM531vkIYopQ2UL3gcp4BDpG1YrPZhiGFiQCVE4/8Wo1/fKACWTgt1
        CnzW19GuZfWwBsumVYeJ7vsRmUVg9Xc7TFS3qBvj9Now9/brHbhWcvMwkf/1qCt35P2qa1xJHHC
        rBNXgpkF8hoFd9rNgqufzQSVYlWofZ5EU5bH0pZ+WCA==
X-Received: by 2002:a17:906:405:: with SMTP id d5mr22339551eja.189.1628514684090;
        Mon, 09 Aug 2021 06:11:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTLC+OlaK/O1lvE3JnmIxxQBbbFpcaB+prP+VoyxmDkoBcq7h0z45WNG/NNtiMCCWgCULeNA==
X-Received: by 2002:a17:906:405:: with SMTP id d5mr22339525eja.189.1628514683894;
        Mon, 09 Aug 2021 06:11:23 -0700 (PDT)
Received: from localhost.localdomain ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id cf16sm8023425edb.92.2021.08.09.06.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 06:11:23 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] dt-bindings: clock: samsung: more conversions
Date:   Mon,  9 Aug 2021 15:09:33 +0200
Message-Id: <20210809130935.80565-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Conversion of Exynos4 and Exynos3250 seems straightforward.

This depends on:
https://lore.kernel.org/linux-samsung-soc/20210809120544.56596-1-krzysztof.kozlowski@canonical.com/

Best regards,
Krzysztof


Krzysztof Kozlowski (2):
  dt-bindings: clock: samsung: convert Exynos3250 to dtschema
  dt-bindings: clock: samsung: convert Exynos4 to dtschema

 .../bindings/clock/exynos3250-clock.txt       | 57 ------------
 .../bindings/clock/exynos4-clock.txt          | 86 -------------------
 .../bindings/clock/samsung,exynos-clock.yaml  | 32 ++++++-
 3 files changed, 31 insertions(+), 144 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/exynos3250-clock.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/exynos4-clock.txt

-- 
2.30.2

