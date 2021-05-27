Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60716393302
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 17:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235753AbhE0QBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 12:01:11 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41789 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbhE0QBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 12:01:10 -0400
Received: from mail-ua1-f71.google.com ([209.85.222.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lmIQ4-0002me-3a
        for linux-kernel@vger.kernel.org; Thu, 27 May 2021 15:59:36 +0000
Received: by mail-ua1-f71.google.com with SMTP id j23-20020ab01d170000b029023ea6f67624so173414uak.14
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 08:59:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uhQuusZtBteBcFlBh9DB+rkgQkk6uTxPH7D0Fh683LY=;
        b=SGB8N/SbH0al3qTXicYRzDc4s71gsxYhvblQfoRSegtRvE5yN0WKmAUgxGb7egg7n+
         DKBtfmqzJYPSwlyMFoMPDRG1q5q4daWU6DYueIVHD56dddWrCoz9Jf+BlgYxTlWik9Nu
         s1gL9ehdYkk0FECEa1dxvBdJdKN/FbNjrvg8f3387NYB8mmmZBhsonvRQb2RNudQSxMw
         NHxED3ZaIRqC6hGjGsUK1yqof6hPZF65E5o/bBACKd4LVObnSa3ygCF37dHUBg2Sepj2
         12keT4julc8PEki9Zx9CkGVRGQSR8RDE1s1ZQvPa0cR16m6vkbfg+be7uYZ0o/15Y8eF
         /dgg==
X-Gm-Message-State: AOAM533yXfTxQ0yRFCJlBjUa2Iuot5qDXKJQba6f+j38Q9cI587/B5qY
        LOTQHt5kWSG28id1SKqzPLvYuDBHaL30D+cVw2ref8i/H1fkRhjsv1fV3tU+MDxsUO+OI9UJ4/6
        bsRqxP56pDf26SzNJO3MWrzYnfbx7Awvj4t1iRQlzmg==
X-Received: by 2002:a67:fc06:: with SMTP id o6mr3089906vsq.47.1622131174958;
        Thu, 27 May 2021 08:59:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKX+mkz8i8MFuwbAvw2AHS1wNst25pE9fjXglYMYxSas4giQzrnMVT65LODg0+9SH/UXiNFA==
X-Received: by 2002:a67:fc06:: with SMTP id o6mr3089878vsq.47.1622131174798;
        Thu, 27 May 2021 08:59:34 -0700 (PDT)
Received: from localhost.localdomain ([45.237.48.3])
        by smtp.gmail.com with ESMTPSA id d12sm350441vsc.8.2021.05.27.08.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 08:59:34 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Alim Akhtar <alim.akhtar@gmail.com>
Subject: Re: [PATCH v2] soc: samsung: pmu: drop EXYNOS_CENTRAL_SEQ_OPTION defines
Date:   Thu, 27 May 2021 11:58:46 -0400
Message-Id: <162213112181.85040.1561034513535715407.b4-ty@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210525184716.119663-1-krzysztof.kozlowski@canonical.com>
References: <20210525184716.119663-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 May 2021 14:47:16 -0400, Krzysztof Kozlowski wrote:
> The defines for Exynos5 CENTRAL_SEQ_OPTION (e.g.
> EXYNOS5_USE_STANDBYWFI_ARM_CORE1) are not used.

Applied, thanks!

[1/1] soc: samsung: pmu: drop EXYNOS_CENTRAL_SEQ_OPTION defines
      commit: 16b79a1e083371a38f72872345866e81abb7ca18

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
