Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC7443AF6A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 11:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234904AbhJZJtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 05:49:49 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:40072
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233450AbhJZJtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 05:49:42 -0400
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id F31B73F19C
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 09:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1635241637;
        bh=OvY8h6gQ2XLx4TLJDVhHrNnjSYAKrKTXm/TLCkBAtZY=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=KRLozsfwsB9rv9f0uUlEfxQCs4uoMjKP2BVYDnO3Vee/Co+JgenMd/2TqGJ1az4LN
         4+mM1GkiKnpUAAdIUJ/gXyH8UfAKtUyA8XRJbTu5yMQ6+5UH1TkCicuMGo4rHK7l4/
         NQa1RKxB/w5kJUzKCYdQieGDcLGyV6p09XsrZOZEhQ/mPPzi4QqOeqvHKtKAfg+V4a
         lgU39Nr/WnjCe0sj6fDeocT29nG/DnMPnXLsRW0dKh4CU4RgEMFXuBcLXUQGc+MphC
         dibQSAWzeJOwL0QZ7fQMkYdxT5+InuNHeo4NZP+AWjmeygUPAVoIO9T7y8jYoHNqMz
         NER+6+2JPrubw==
Received: by mail-lj1-f198.google.com with SMTP id v17-20020a2e7a11000000b002118bb7d585so846353ljc.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 02:47:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OvY8h6gQ2XLx4TLJDVhHrNnjSYAKrKTXm/TLCkBAtZY=;
        b=2ZJRfPki3h0+pjziWCmUxBos+rRJ7EvKIojRHyXhiTwINc1IT8ldrSaVaGy8xLaEl3
         D6b9MQU7taVOSwVCMvPshA040vnqtlzBhCVH/c7NkrnN+BGYhOcWlBSsTPsXnoVyTqyE
         VqjGuTqXLGimp+Tm5bAvJAd/9Bkv6VQDDcs/NUZ0Hu0DT8LJwTdh/b56R7xQRYTFAhXe
         uJZkUO2aqvB6csNEc5oPrZqWbr+rSlF7pZu9PAqBDMHDIBR+MZz5Kf2+lkkIXyJhDLbC
         DjcbWM8t5NwX7JEWhCaRp7Gbgk2fwFk2MsHAWDDCaL48w2FqOWTnPk60PSrP8ZMI2r9F
         f/Gw==
X-Gm-Message-State: AOAM532/y6rnur1vJ+HHdSlaI4WsJ/dqT0mnYB0hZXW7hzFJWmHtSvxR
        JvefaMbkkApr1iPw1ug5TJdFwUbgkQka3PU/D+YZxtExJSdjFEUyqcqbTPMUSjUATKOW4fMtHxi
        hi5v+tNRBE/T/Ox82byhAITdvzPQwzWXJg8dJn6NRMw==
X-Received: by 2002:a05:6512:15a9:: with SMTP id bp41mr10418011lfb.552.1635241637425;
        Tue, 26 Oct 2021 02:47:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyW5YMz5Q07ZGmdN2Jxfc2u5ScIopNPNG6mpx68Wmg7E4kYJBAnPU+zL0heH2Y7f+IctqKkog==
X-Received: by 2002:a05:6512:15a9:: with SMTP id bp41mr10417987lfb.552.1635241637269;
        Tue, 26 Oct 2021 02:47:17 -0700 (PDT)
Received: from kozik-lap.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id v17sm113794lfo.167.2021.10.26.02.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 02:47:16 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] ARM: samsung: s3c for v5.16
Date:   Tue, 26 Oct 2021 11:47:09 +0200
Message-Id: <20211026094709.75692-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211026094709.75692-1-krzysztof.kozlowski@canonical.com>
References: <20211026094709.75692-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-5.16

for you to fetch changes up to aa519471715ce73034ffaa52fc85681de31c1acf:

  ARM: s3c: Use strscpy to replace strlcpy (2021-09-20 10:13:47 +0200)

----------------------------------------------------------------
Samsung mach/soc changes for v5.16

A minor fix for theoretical issue when handling IRQ setup code errors in
S3C24xx and a cleanup for S3C64xx.

----------------------------------------------------------------
Jackie Liu (1):
      ARM: s3c: irq-s3c24xx: Fix return value check for s3c24xx_init_intc()

Jason Wang (1):
      ARM: s3c: Use strscpy to replace strlcpy

 arch/arm/mach-s3c/irq-s3c24xx.c   | 22 ++++++++++++++++++----
 arch/arm/mach-s3c/mach-mini6410.c |  2 +-
 2 files changed, 19 insertions(+), 5 deletions(-)
