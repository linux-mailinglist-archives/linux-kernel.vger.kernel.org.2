Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEAA239BF42
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 20:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhFDSEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 14:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbhFDSEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 14:04:35 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6652FC061789
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 11:02:49 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id o9so5663310pgd.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 11:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7U248OZHmRHfE56ap11uOYWLh2Oj9oUs8HhAokr7948=;
        b=YqtsSNRVN80ZtmaX+D/vu9uMnL9o6GGfOD67EFhHjxE6EHoxE0MuiU2GasmARJkKun
         2Uc49rKEatd4mg/VtG3R4vcWcJzdwoDxLK5dT0rD4JtlT7EMrUNykqG4mzplsKDlXPSc
         4KVkQKuovqTBGcu3vasC7Ht/TAKfoq1pQ0zFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7U248OZHmRHfE56ap11uOYWLh2Oj9oUs8HhAokr7948=;
        b=L08X2c/9AUJf1hMddXnqIHow4voN5z1YYECCi3LMgzzBDRP2eDdEvtGziKk5b1Bi2u
         LAMh0TIXmfGuRRxoYRAjHds27NJRZgXGYSIjyeMXA0mDVB8AWTf8gRew9xart1/A0qV5
         yvy1SGPPa0UTjXcu8hYBT2e/ZUNqEsNofyEVdtccgfkHCZ+rQgqf8P+l+eZNqDQtfZPB
         VORZ9VUMYvGkRNWfAs9HNL6kGxEFHHHvLzO89o2Sz3Gm35wvqK5fBhPX5oD82xML8Oe3
         hC65mfPUS/V2VOiW5/08A+I2JZcQ2rtdh3ETFXk2o0TasPfd9Y0cNoH4qG0QoBgopDbd
         WYEA==
X-Gm-Message-State: AOAM532CftEU0IrOoGQY/ZpZwV5yg2REX5tQqhZlYDJlKJMZaV0jhN7V
        yEDY9M8EyCxjtpf2LHb3QYn2bA==
X-Google-Smtp-Source: ABdhPJy3qCOhOZJm6ROVr7YN2yWzAXjLH9mrb6EYJbimkOTij6MmFUd61XSroTtrCCeAtGwpFPagUQ==
X-Received: by 2002:a62:e102:0:b029:2e9:fc9f:1199 with SMTP id q2-20020a62e1020000b02902e9fc9f1199mr5556909pfh.33.1622829768891;
        Fri, 04 Jun 2021 11:02:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x22sm2303487pfn.10.2021.06.04.11.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 11:02:47 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Russell King <linux@armlinux.org.uk>,
        Tony Lindgren <tony@atomide.com>,
        Dave Gerlach <d-gerlach@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@gooogle.com>
Subject: Re: [PATCH] ARM: avoid cpuidle link warning
Date:   Fri,  4 Jun 2021 11:02:37 -0700
Message-Id: <162282975447.3081447.17719954433562444000.b4-ty@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201230155506.1085689-1-arnd@kernel.org>
References: <20201230155506.1085689-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Dec 2020 16:54:56 +0100, Arnd Bergmann wrote:
> Since commit 83109d5d5fba ("x86/build: Warn on orphan section placement"),
> we get a warning for objects in orphan sections. The cpuidle implementation
> for OMAP causes this when CONFIG_CPU_IDLE is disabled:
> 
> arm-linux-gnueabi-ld: warning: orphan section `__cpuidle_method_of_table' from `arch/arm/mach-omap2/pm33xx-core.o' being placed in section `__cpuidle_method_of_table'
> arm-linux-gnueabi-ld: warning: orphan section `__cpuidle_method_of_table' from `arch/arm/mach-omap2/pm33xx-core.o' being placed in section `__cpuidle_method_of_table'
> arm-linux-gnueabi-ld: warning: orphan section `__cpuidle_method_of_table' from `arch/arm/mach-omap2/pm33xx-core.o' being placed in section `__cpuidle_method_of_table'
> 
> [...]

Applied to for-next/orphans, thanks!

[1/1] ARM: cpuidle: Avoid orphan section warning
      https://git.kernel.org/kees/c/d94b93a91015

-- 
Kees Cook

