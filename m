Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC7A141C631
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 16:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244724AbhI2OCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 10:02:18 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:51290
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229832AbhI2OCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 10:02:17 -0400
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7EAE84019B
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 14:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632924035;
        bh=VYDRfTaFk7GuB/XEXk79fvgW/NK1ipUqdTK9Jv6cJQ4=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=R56Fe77nvURkSWkS1my9igDlaESB1xGNOSXzv+p/b2IiLTaw+UERtkR9ZWfFirAdn
         gr26n0l+qYuYFLKhWP6YzAMgfQabIpHAJoiIhdpnF4N38FHmnbpQzUPRn4jjQbbDj+
         7vjwWBpi3tQhdQErMIIqSrjhSn0aErBx0ORkr0g29+1zPt26WwMgPDruo0ZTGVbG3O
         xTJJr1YJ2khd1gYkVd67yDy+iLEQgLLE1OJoIiE4HQipp0vtTHV8Dh/JE0IJUTB4Yn
         UiDTKTPJXhotJMZNX0LC4EEAbieQ3DFzcFVr81XJ9QF978/aHDvJ9Lo72575GROeSu
         pd7DlUTqtgk+Q==
Received: by mail-lf1-f72.google.com with SMTP id c18-20020a056512075200b003fd0e54a0deso1604852lfs.17
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 07:00:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VYDRfTaFk7GuB/XEXk79fvgW/NK1ipUqdTK9Jv6cJQ4=;
        b=Zbn+GXtSLTc6sUnTo/yTFDPaW8prqJ46F4B9hr6paYjw/ebwPjoMg5cjD+3f9c1ju/
         O8yva/WnthLTT6cwGJK6rWQKxunlD+JtY46lqjrdOfXLVuZ1TbrUyZ3iWDeKKVIVLqgn
         2XIGH80jQQE0dQlJJ0k5SUFY3uM79UUq+MVZ+o16P98VogJfkPDV2j7n4EtVpsQ4XTcG
         +DgJg7B/HjyUetZNFCnyIL17ROGjIMaDXBLlX261EA3YAz/ieBOGWIQ6T7IbI5dmBDvx
         PQ6R316tpl5Um21Ld0+bd6AqlBcGrtrx9VUF5R9DXgGKdtyLHJ6tqQz+hF1dBmEYNlqR
         PvFQ==
X-Gm-Message-State: AOAM532aadCqOVelSPtSwuho3mSy9gEI5hknbq9H/PpRTC3cUHC1ZM3K
        KGz3zKtxa94EiYKG1Sbs2TwgNEpaqvNm1Pg5JfYaDznjqB6jxFm2vD0R4h7OlWTeAlkwJi74HJY
        dp27RDd8Ced8FBYwxCt6Pq1x1HCVoiTWf8mK0r/haUw==
X-Received: by 2002:ac2:4c97:: with SMTP id d23mr11378739lfl.15.1632924034292;
        Wed, 29 Sep 2021 07:00:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNUHU/xV49lXy44YvbZX50xwjbr784SqnLBjAKHzw3yVD4i/ibnijkkyR+s5EPlsdBiEkoWw==
X-Received: by 2002:ac2:4c97:: with SMTP id d23mr11378717lfl.15.1632924034138;
        Wed, 29 Sep 2021 07:00:34 -0700 (PDT)
Received: from localhost.localdomain ([193.178.187.25])
        by smtp.gmail.com with ESMTPSA id t135sm252900lff.203.2021.09.29.07.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 07:00:33 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-samsung-soc@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>,
        Olof Johansson <olof@lixom.net>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: Re: [PATCH v2 0/3] soc: samsung: exynos-chipid: be a module!
Date:   Wed, 29 Sep 2021 15:58:48 +0200
Message-Id: <163292392314.29281.2165495192350458305.b4-ty@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210919093114.35987-1-krzysztof.kozlowski@canonical.com>
References: <20210919093114.35987-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Sep 2021 11:31:11 +0200, Krzysztof Kozlowski wrote:
> Changes since v1
> ================
> 1. Drop patch 1/2 - exporting soc_device_to_device
> 2. Add new patches: 1/3 and 3/3.
> 
> Question
> ========
> 
> [...]

Applied, thanks!

[1/3] soc: samsung: exynos-chipid: avoid soc_device_to_device()
      commit: d1141886c8d72ad77920e6e4b617d366e6e3ee8a
[2/3] soc: samsung: exynos-chipid: convert to a module
      commit: 1e3e559f8d4e5b4c873414078facb35273ecbf4b
[3/3] soc: samsung: exynos-chipid: do not enforce built-in
      commit: 140bbfe7cd4be0aa6543f94d3994e4774b325abc

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
