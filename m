Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32781382ADE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 13:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236709AbhEQLYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 07:24:21 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37074 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236528AbhEQLYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 07:24:20 -0400
Received: from mail-qt1-f199.google.com ([209.85.160.199])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1libKw-0000dC-OC
        for linux-kernel@vger.kernel.org; Mon, 17 May 2021 11:23:02 +0000
Received: by mail-qt1-f199.google.com with SMTP id s11-20020ac85ecb0000b02901ded4f15245so4917023qtx.22
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 04:23:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mAhpswL6pA+76vcO9Kp8F8tyniQOjj0n+aDmrDsqL0U=;
        b=eT5G2ftnvQ8HCwAXsz20w+XQmIHo+d+a0R1HkvQPRcVCKwRjzBVlzmrcVER2QJqFQb
         bN0ZzEm1fovq+zu6/4XVRElvogN/36dBjgevSOr9exQLQQ4cNjmBLUQ9m9ECilCW/jsa
         GLxcXcJ03IDHwWMlXFGVaKJH04qbWwRyUKRGpiSlMPq9mq3HUhF7UoUKj35EUDlXj2GX
         AqVnHD7hTNhX1BHu46NJALJjcdgW5v9VJUo61/C2XeEcfkHojb9ABMf67/8Hj0LkGMM3
         821gkHmQl86YTig0kWKqarRrX2UiqeEQsa9py+SfGVKcMOvTfxDAHSE5XktKPDWXmXaW
         1tfQ==
X-Gm-Message-State: AOAM531dcvXQnTne3Ct8FtxEcLdfXtUPBudKkgoQorNwR8bUUO/KiUBv
        0BMweVnmJVAQtB/glB4uYth1ZvzkgMikjCaArefSyGFEictdE+Eovb1zw7fyCDoKH0g+x9lD+hU
        mfPkqx3+3XT5PJ1yr9XkkjuTJqGU1YbyGjP0DIltpjw==
X-Received: by 2002:a37:44cb:: with SMTP id r194mr947792qka.197.1621250581578;
        Mon, 17 May 2021 04:23:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/DTigg9RrTXO/O8wXUDAnbwv8oBKSob9dwO4Gq0wsxVfUKiKadqmLJgKdvTFK65OS8RCOJw==
X-Received: by 2002:a37:44cb:: with SMTP id r194mr947780qka.197.1621250581409;
        Mon, 17 May 2021 04:23:01 -0700 (PDT)
Received: from localhost.localdomain ([45.237.48.6])
        by smtp.gmail.com with ESMTPSA id b3sm8788275qtg.55.2021.05.17.04.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 04:23:00 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH 1/1] memory: pl353: Fix error return code in pl353_smc_probe()
Date:   Mon, 17 May 2021 07:22:57 -0400
Message-Id: <162125055246.5300.15627879267121505532.b4-ty@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210515040004.6983-1-thunder.leizhen@huawei.com>
References: <20210515040004.6983-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 May 2021 12:00:04 +0800, Zhen Lei wrote:
> When no child nodes are matched, an appropriate error code -ENODEV should
> be returned. However, we currently do not explicitly assign this error
> code to 'err'. As a result, 0 was incorrectly returned.

Applied, thanks!

[1/1] memory: pl353: Fix error return code in pl353_smc_probe()
      commit: 76e5624f3f9343a621dd3f4006f4e4d9c3f91e33

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
