Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1F56398A58
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 15:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbhFBN0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 09:26:21 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56248 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhFBN0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 09:26:20 -0400
Received: from mail-ed1-f71.google.com ([209.85.208.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1loQrM-0006SC-8K
        for linux-kernel@vger.kernel.org; Wed, 02 Jun 2021 13:24:36 +0000
Received: by mail-ed1-f71.google.com with SMTP id s20-20020a0564025214b029038752a2d8f3so1409034edd.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 06:24:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZbqO9leiYLcpHf1/CeWaekIOBlRRyOOvjknnxl/dSpE=;
        b=dQ7PqsonUA6ePVelSJFiNYEzxEvWJyB7kuXIJ4aOLMx5p39VIljdhOHWWuF3iyxwu4
         8qeG3igPctDLQjYQr9dHbYNB/z/PwbEt7xgTxehJixsPGV0VN+stH6558ZJXDCgKhWGN
         zI3CWRAq2zjMGureozkI3ix6cUYu2tuh46C8BycYya3CDOMq/b3cr/sBcKs+AtCCrRo0
         RJ5y1fFMUwNg3Lr0z/uY+gL2+8bcpgTXJwi59YXsnf3TvSYOifi6wNpHIW+8jW1FRvau
         pZ/bzaxda8LmFWX846RrYGwmY2SykB22BkiUoijhFSjovDAB67WJoV94XTIgW8S4fv4s
         5ueA==
X-Gm-Message-State: AOAM530gPX6SeHMZoYINCz0e9NHObYfMxEcZunA+WqpQo88MceVugwX7
        /tsSbm3Vki4nZLmSOFEyG60eBUXDBg1a4Q5LzNupKUrTQKOgTarmrSHAPZXXCDfSxO2bruF+b6a
        HEKPf4qN5wOV7OTaHUonn9EcnSXboHOghLSK6Xp9DQQ==
X-Received: by 2002:a17:906:c00f:: with SMTP id e15mr36561522ejz.458.1622640275809;
        Wed, 02 Jun 2021 06:24:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwtzGMwLAUU1O9hso14QGvyxJCgY0jrcJpE7S4rWWpRuQMT/j0VxL2N2oXQPuieX0XXAyNhoQ==
X-Received: by 2002:a17:906:c00f:: with SMTP id e15mr36561505ejz.458.1622640275665;
        Wed, 02 Jun 2021 06:24:35 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-185-9.adslplus.ch. [188.155.185.9])
        by smtp.gmail.com with ESMTPSA id bc4sm928548edb.63.2021.06.02.06.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 06:24:35 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-samsung-soc@vger.kernel.org, krzk@kernel.org
Subject: Re: [PATCH] arm64: defconfig: Enable Exynos UFS driver
Date:   Wed,  2 Jun 2021 15:24:32 +0200
Message-Id: <162264024536.63589.10570196675573160566.b4-ty@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210531170057.7730-1-alim.akhtar@samsung.com>
References: <CGME20210531165414epcas5p1aae4ea3815fcbadad8b48a9210742489@epcas5p1.samsung.com> <20210531170057.7730-1-alim.akhtar@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 May 2021 22:30:57 +0530, Alim Akhtar wrote:
> Enable the Exynos UFS controller and PHY configs. They need to be
> buildin to ensure UFS devices gets detected on exynos7 and its
> variant boards.

Applied, thanks!

[1/1] arm64: defconfig: Enable Exynos UFS driver
      commit: 5be91fe8d91b3aed5192b763fd6f2d11c7cd354d

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
