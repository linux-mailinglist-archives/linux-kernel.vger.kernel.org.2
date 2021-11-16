Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94117452EFC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 11:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbhKPK2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 05:28:13 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:56096
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234038AbhKPK1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 05:27:51 -0500
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1CA783F1A9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 10:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1637058294;
        bh=xdzOaEzowN0jMoh6RE3+pROKnNJBbC68O6pUo7WQAnA=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=mUrr5ktBkp4CBnl4aURxW8EUIwiL10DnZEaa3Wky29PM/M4PKXfyjMtuDhH/5ElUm
         DtcZhxt0S6y/+TxytjDrqN3cogUm/WMyNYz/USztd5E9bR9cQ3NwtWu2EmHwjTh1r0
         uRNbhK2ahcrnBBWpTKot5NV3aEIovEm07JlHi6c9gdbNOpW8nZ1hp7B8n/At+Jd6eQ
         HA0+MegeljCfEuYmMp3PHFEJvy3f1nxd5TrbF8Uu9JkmMiYG/j0+fGlBujxpPadUb7
         pHLP5R5afY3O64K2anO6Yq+/hc7UlB0jpzqh6E6B6QzuG9fN6O7ZjndyoMA3trW5hr
         mpmt8ilZnNFIw==
Received: by mail-lf1-f71.google.com with SMTP id q26-20020ac2515a000000b0040adfeb8132so2155247lfd.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 02:24:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xdzOaEzowN0jMoh6RE3+pROKnNJBbC68O6pUo7WQAnA=;
        b=FzpgD1Xo9m9XSzS755zU9zeC6DvsDyZIvOdi17SQtgAmq/JU5HRl9/XcH1YDPqP9g6
         xVQbCz5Tri84aq9Mwhu/FWb9sY/DZfrMKM6Jhowuu8dlsPXdU9o/HMLNiID8WqYEMOrM
         F+Fo04N+KTcWWGhl1dvg3+jgZb5wsj+cbMI5w+aIoArDN6za/DwpNKQa8DXhc/tZD4YY
         U+FofE1Do3WM1UzacMFnJDd50mV2K8EcY9zmrOwmRoFNSuvHIrEeWjlT8yTGgcRXdDQV
         mgk8vnMYA88hDCz+Cwkr8nGqCKPjZOdpaEaCEeKVRE+D4dFs0mkTzQO2a9kaBy244ITe
         h9Zw==
X-Gm-Message-State: AOAM531+Vvw1vwPcVUetjH4/of5+20xuwqHPuS0QgiDTxFfiVJhEgsCi
        h8WAyfHMhbQch96zMPoGQvtkUTmzxmE1YcIrmU4GgkEU4NaiOEIdjgxhfBbww4VtA7HdZYxlqEJ
        T43oFgYpUcwoNq5aWXdHC3pziXJ2r4QmsXCINbcJuXA==
X-Received: by 2002:ac2:4153:: with SMTP id c19mr5772025lfi.625.1637058293463;
        Tue, 16 Nov 2021 02:24:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwec5MCIeMaJIXMiZN5/vQORmItQtZQR2MyWOiTecq7LDNfdDlwu8d4GbrPq0UY5ox6v35u8g==
X-Received: by 2002:ac2:4153:: with SMTP id c19mr5772011lfi.625.1637058293289;
        Tue, 16 Nov 2021 02:24:53 -0800 (PST)
Received: from localhost.localdomain (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id l28sm429000lfj.240.2021.11.16.02.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 02:24:52 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: s3c/jive: add one more "fallthrough" statement
Date:   Tue, 16 Nov 2021 11:24:14 +0100
Message-Id: <163705825120.25687.2885204324289014996.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211116092053.4042799-1-arnd@kernel.org>
References: <20211116092053.4042799-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2021 10:20:42 +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> clang warns about one missing fallthrough that gcc ignores:
> 
> arch/arm/mach-s3c/mach-jive.c:250:2: error: unannotated fall-through between switch labels [-Werror,-Wimplicit-fallthrough]
> 
> Add it here as well.
> 
> [...]

Applied, thanks!

[1/1] ARM: s3c/jive: add one more "fallthrough" statement
      commit: 7f9ec9b59c278f31b0c2c8fabcf564e6fc02d4d8

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
