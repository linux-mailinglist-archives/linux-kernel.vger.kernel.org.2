Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6704421B44
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 02:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhJEAms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 20:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbhJEAmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 20:42:36 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2700AC0613EC
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 17:40:44 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id c33so13668470uae.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 17:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=eu6xQaZ+L/7SEbm2kM+MqievePKlsmmZKrxh7/j0Gx0=;
        b=bYFTdC458YYvLwQWaj0LutyFeNvzV2xOB8z/FiTrRLph+G40abtUQCO7uUSITFUICI
         Q6cb7RZQtPqpGs1yeUuyknrm9ehOepAPItJA8O2rB7N9n70BN4qJD5/t5kPv0rOI0Olo
         z+WrLDXkCwM0aBqbChhu8CfCefkTcdgpyO95qPPdXZo2FLQ11C484aoaDvJM5o9Mky2r
         0a3Fx1sjtyjW9RyIr49QLvfFzsBMDZpA/g9eacX+dNIQGaE4K57YpCuR6FAcdRC9ab7f
         ahCVe92QuHDG7m5m1873+sqz6WK3jJ+wF4u0SVZ5H6bnIJz83eua1IRqSJyST4qk98SY
         IODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=eu6xQaZ+L/7SEbm2kM+MqievePKlsmmZKrxh7/j0Gx0=;
        b=Yj+1to4PO0mscHWnXswzmn7vZ2UpOxcWXpeFGY7PHJ41gIpjAKzy+Y95zjglttyCPp
         Y1owP6eNex6gzS0PGykxytXY+pQOXH7rmttLBtOahrMpXx9e7RdXTBXS/IdTXGSi2xDI
         59BpCzcopxvSaKQA8YcsXNyI3Gbt6Sm8cQMNJ7AKcDh2GBu1xdBRVseXo6QKrfzIxS80
         +U+HOp6lKIH6OFjjgOFpskozKbZLIeBUuxnnDpVBpdiWnpCJaWvwTGPH5b8mcf4t0JMs
         IO1AAAbjBNVJR8UAaABtOny7TbWdGgSnJitf/6yfw59pcc29Jfq8jxSuYsatzUDHfVyY
         SXmw==
X-Gm-Message-State: AOAM531YQTj2LT1SyVNQXWGLV2KKqW1J/vaYk+hmA8jXMNfu7Yaj5nP2
        BxbD88pJcEA/uyn17S6MeOp9mg==
X-Google-Smtp-Source: ABdhPJww3mVtU7cqIbTqZq2nACjciZnsKEYgEPbhUhT9+QN5X45mMFKcavhdWpRrezYolgErPY2PnA==
X-Received: by 2002:ab0:494a:: with SMTP id a10mr10097245uad.90.1633394443206;
        Mon, 04 Oct 2021 17:40:43 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id g20sm8030772vkf.33.2021.10.04.17.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 17:40:42 -0700 (PDT)
Date:   Mon, 04 Oct 2021 17:40:42 -0700 (PDT)
X-Google-Original-Date: Mon, 04 Oct 2021 17:40:37 PDT (-0700)
Subject:     Re: [PATCH 05/10] riscv: remove Kconfig check for GCC version for ARCH_RV64I
In-Reply-To: <202109130923.E294BFD5C@keescook>
CC:     ndesaulniers@google.com, akpm@linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux@rasmusvillemoes.dk, nathan@kernel.org, masahiroy@kernel.org,
        joe@perches.com, arnd@kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     ndesaulniers@google.com, keescook@chromium.org
Message-ID: <mhng-387507df-2708-4ea1-9854-780fcb35eb1d@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Sep 2021 09:23:45 PDT (-0700), keescook@chromium.org wrote:
> On Fri, Sep 10, 2021 at 04:40:42PM -0700, Nick Desaulniers wrote:
>> The minimum supported version of GCC is now 5.1. The check wasn't
>> correct as written anyways since GCC_VERSION is 0 when CC=clang.
>>
>> Cc: Paul Walmsley <paul.walmsley@sifive.com>
>> Cc: Palmer Dabbelt <palmer@dabbelt.com>
>> Cc: Albert Ou <aou@eecs.berkeley.edu>
>> Cc: linux-riscv@lists.infradead.org
>> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>
> Yeah, good catch for Clang too.
>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>

Only this patch ended up in my inbox.  Where you guys planning on 
keeping this whole series together, or did you want me to pick this for 
the RISC-V tree?
