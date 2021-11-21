Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3891A4584BF
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 17:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234900AbhKUQul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 11:50:41 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:49314
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229641AbhKUQuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 11:50:40 -0500
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 97CB53F1A9
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 16:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1637513252;
        bh=XsoOn3ND/sAh8NvQQ/Y8cZAkyJcKJL0OKHYA60c2Nrg=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=J57g+2R4lZJY1pViwSwuno+DQRf18ijqYdd3Mo+sVbYuz8RUyBz8I5XoIp2EiJumL
         Yp7qz7YT2cehe3O9HDO4098syfFw3f8ADCJ+Qev1VO639CTpDH2Vwgz3dz2vMKT0Vu
         1VtAQKCEuA1+ACTBglrm/WUWhGlEeBEj7ncL15O861gAm5IUIlnCTpA7kZRWBV32fz
         Qh42f3U/J7lx16lNIPbahDznxp6X16PVO3fdX0O5JnocJFz++ocCaZMh9U1njctfx6
         gPmJHMeF36J0QOWkAKr/3cxjMhZGVSjlcB6UIQlUtpLpk4Gav9Jwk3WfntyK3exrjT
         kILr5IeazFz7g==
Received: by mail-lf1-f71.google.com with SMTP id bi30-20020a0565120e9e00b00415d0e471e0so4972834lfb.19
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 08:47:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XsoOn3ND/sAh8NvQQ/Y8cZAkyJcKJL0OKHYA60c2Nrg=;
        b=zm+4nQlbN5WQylbgtp5nrIUHGS4w5u810I/jfzEi9Ir0eLldUx8X1aRE+tsyUXM6i0
         i/IlGKaPMDBem7axgXi3A3rEwrQrKZRktybLlHuhTmeckAHnRUxzSDjBrKBTtj4kEwYJ
         b2pnv6UDN93jHx7COqUg5wZIOuHdPYZ96b0fWHnYa6846CXDDoztFU/GRFKGUOSzbP/t
         +Le+/v4K+eLHjaf66LoUVHpPYuxzjsB7klvpby8YOIgV56Xu8YAD5Le33/5iiVtCSzNu
         UdJsZWbmnUHoFpn6VNWIA27tbS8lAv866mol/MbuumHLD9enymhRyLVVu9Svsu1ol9Nw
         fjFA==
X-Gm-Message-State: AOAM531p50TOf8qgBhGQq84E+WoN+0Tt7BW49vZzYItNoV+xuDvCrDvF
        71DCVJN4F0v+5mRX9TAQO+hmd6VscB+QuqjfsTxVUN8zP54Zvk5coLOQwbKrvoHRBhE6dZ/nmrf
        qOI+EcXPZJVi04eJHCDxDfgLRLfoqhxGEPuwDVelZOQ==
X-Received: by 2002:ac2:42c6:: with SMTP id n6mr48523142lfl.553.1637513252033;
        Sun, 21 Nov 2021 08:47:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy4hlDfeLcmS9sY/YWfSzCQe00z2kJ8KKHqYotO5YUEAImib8DLKRzP+dSEWcZ5jYW2Y1Jxyg==
X-Received: by 2002:ac2:42c6:: with SMTP id n6mr48523115lfl.553.1637513251856;
        Sun, 21 Nov 2021 08:47:31 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id s15sm631835ljj.14.2021.11.21.08.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Nov 2021 08:47:31 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will McVicker <willmcvicker@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@armlinux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v2 1/2] arm64: defconfig: Enable Samsung I2C driver
Date:   Sun, 21 Nov 2021 17:47:29 +0100
Message-Id: <163751324653.4740.10340111836301836511.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211121150558.21801-1-semen.protsenko@linaro.org>
References: <20211121150558.21801-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Nov 2021 17:05:57 +0200, Sam Protsenko wrote:
> i2c-s3c2410 driver is needed for some arm64 Exynos SoCs, e.g. Exynos850.
> 
> 

Applied, thanks!

[1/2] arm64: defconfig: Enable Samsung I2C driver
      commit: 0e9a9debf0427164fb845403a6eb9439558f1684
[2/2] arm: samsung: Remove HAVE_S3C2410_I2C and use direct dependencies
      commit: 3ac5f9db26bb7a227ccbf160c36a5567b5394299

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
