Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11F3237A712
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 14:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbhEKMvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 08:51:13 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51484 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbhEKMvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 08:51:11 -0400
Received: from mail-vs1-f72.google.com ([209.85.217.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lgRps-0003fk-OK
        for linux-kernel@vger.kernel.org; Tue, 11 May 2021 12:50:04 +0000
Received: by mail-vs1-f72.google.com with SMTP id i16-20020a67c2100000b0290227fd428db0so9620826vsj.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 05:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3CHScK0w/i5BRJ15ikgMVAxlFb6izuOHy9b40Y6y9vo=;
        b=YKuffHR3N8flzUunU3kZiQD1nXqWAAF1hO7oUdSsRcD2SW+9UTtbgrRBa0Qv1EONzv
         hwUN0C8jaQsSCMDc7fenunN48aH0g4CWW+1PSkRCvcmaS/jHauUaIfLqPlgxAcXeb2Db
         jcFDSL1VskO73WVF+MuHQllRg6QjWynGWE9tVvy1T2IdyleeYlNRgllrUgS4epKsfKlZ
         EaHSl1KnCbLeG/eMZm1HC2qwfeK9R+nYxlADVIrAfY1B17SOjl7eazouw7BziBMwLlG4
         rXEQ+CJ/OpQFNdosHxQulUk27RRhZO4E1oZGDVf19I5ns3JN9kbBMngxre20HEAy+a2f
         LDCQ==
X-Gm-Message-State: AOAM533DG6IMeZilidEi6zr5C/8v/h4eaCogwnIuyck9svBHFa++RHai
        bCTN9e+oykHicxGgbqgPaQo0XRGfRNDtr3Lxo5I934mpqJepE8xtDOTxeOZloIO9WzUlPb7T73o
        19jREqymiyhXKtgobufVVLMfxFtmtpa+/5y52x5Xi1Q==
X-Received: by 2002:a67:bc19:: with SMTP id t25mr25273952vsn.47.1620737403464;
        Tue, 11 May 2021 05:50:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFyE9m8eV4zf4aEFSPxqmMKcHRhOhyNthNh2rU/fKLb6yhq3wMSKshAYjkfs7OpwF11Pw/2A==
X-Received: by 2002:a67:bc19:: with SMTP id t25mr25273930vsn.47.1620737403336;
        Tue, 11 May 2021 05:50:03 -0700 (PDT)
Received: from localhost.localdomain ([45.237.48.2])
        by smtp.gmail.com with ESMTPSA id d25sm2162175vsh.5.2021.05.11.05.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 05:50:02 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-arm-kernel@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org,
        Christophe Kerello <christophe.kerello@st.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [PATCH 1/2] memory: stm32-fmc2-ebi: add missing of_node_put for loop iteration
Date:   Tue, 11 May 2021 08:49:58 -0400
Message-Id: <162073739433.14559.11646873146475181222.b4-ty@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210423101815.119341-1-krzysztof.kozlowski@canonical.com>
References: <20210423101815.119341-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Apr 2021 12:18:14 +0200, Krzysztof Kozlowski wrote:
> Early exits from for_each_available_child_of_node() should decrement the
> node reference counter.  Reported by Coccinelle:
> 
>   drivers/memory/stm32-fmc2-ebi.c:1046:1-33: WARNING:
>     Function "for_each_available_child_of_node" should have of_node_put() before return around line 1051.

Applied, thanks!

[1/2] memory: stm32-fmc2-ebi: add missing of_node_put for loop iteration
      commit: 2f9dc6a357ff3b82c1e54d29fb5d52b8d4a0c587
[2/2] memory: atmel-ebi: add missing of_node_put for loop iteration
      commit: 907c5bbb514a4676160e79764522fff56ce3448e

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
