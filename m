Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACBC35E220
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 16:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345311AbhDMO66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 10:58:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58491 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbhDMO6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 10:58:50 -0400
Received: from mail-ej1-f70.google.com ([209.85.218.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lWKUn-0005E3-OI
        for linux-kernel@vger.kernel.org; Tue, 13 Apr 2021 14:58:29 +0000
Received: by mail-ej1-f70.google.com with SMTP id v24so1360371ejb.23
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 07:58:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KXFmnreZUFvpdeZOE3YRnkGXbB2aVTyeo59QFjsyW9I=;
        b=hyISsZVDvoR4yeQvZ5LluKQG9WB9nY7jRCkgMfTSZfULJVXNnJGx9yKujRLAtnmQhu
         4dzwiyLPLMBVcZREC8r9rAwh9WOrgZuUBeIyM8mjCkq0c0P22PAM7N2LytT8TUakxPM8
         262VRAAcXbyW60LIPDU+vpqzHD77ob5ffFQKsK3gsLLNkNQIMhqfXZOeJAfftPeq6cUR
         QEua6j15xGHZT+XmaV3JWzilrttppzg8khkLSv0t0j0Xv7yuchM9iKHoo80bLUdorEbz
         lCmR4d75XrIMuw1mbl3OjVoa+5/KAthMVZY4uiqqVTOEwcvesnwMGLZc72Hbk6477Dyo
         jxmQ==
X-Gm-Message-State: AOAM530tDaAqnmVIantAJAAaFLzZ3hFtKSKbTdRj9F/+JQkUuS6pwRo1
        pMWSVbAEGt5Yxwv+553y2iZD+Qp9BWV4mVHxTqUigoMrKg7FubbWaTv5f6FgKV3KB4kWN9hgzcG
        NDDOGfgdY26E7masJw94Ar/iYvKWmEBC2TD0e6BjO1g==
X-Received: by 2002:a17:906:4d17:: with SMTP id r23mr12011598eju.134.1618325909552;
        Tue, 13 Apr 2021 07:58:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxu/pDogwwsc/dyeGnbfzo8QIv9u+6fKHlBwiNUQ2rfPdi8E5CISH90Pct1hqzIndiuUYdomw==
X-Received: by 2002:a17:906:4d17:: with SMTP id r23mr12011590eju.134.1618325909449;
        Tue, 13 Apr 2021 07:58:29 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id p3sm4395217ejd.65.2021.04.13.07.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 07:58:28 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] memory: samsung: exynos5422-dmc: handle clk_set_parent() failure
Date:   Tue, 13 Apr 2021 16:58:23 +0200
Message-Id: <161832589345.71964.47710078429514068.b4-ty@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210407154535.70756-1-krzysztof.kozlowski@canonical.com>
References: <20210407154535.70756-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Apr 2021 17:45:35 +0200, Krzysztof Kozlowski wrote:
> clk_set_parent() can fail and ignoring such case could lead to invalid
> clock setup for given frequency.

Applied, thanks!

[1/1] memory: samsung: exynos5422-dmc: handle clk_set_parent() failure
      commit: 132c17c3ff878c7beaba51bdd275d5cc654c0e33

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
