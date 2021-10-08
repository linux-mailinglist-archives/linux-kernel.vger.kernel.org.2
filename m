Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B24744272F7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 23:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243411AbhJHVUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 17:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242456AbhJHVUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 17:20:45 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4B9C061755
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 14:18:50 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id cs11-20020a17090af50b00b0019fe3df3dddso7800977pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 14:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rHy4HvfxK920/DAzRQ2LEGB6EW308Wa/3xEBO3I3ZhE=;
        b=BhVVj3vKt/JTppbgAK2mAsECRb50DXsS6r6M65L9zK/mN6kuIBXR6Buqs3rERRipGg
         1fFkRryHhsSY6tHK3Na1GTCd6pXVcac06u0Oi8e9R8Y/sXRYy7YNOsnPYVgk2OqMOeIz
         29j82p/ttntW9wToU6jvggtbtH4TaDHv5o6HA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rHy4HvfxK920/DAzRQ2LEGB6EW308Wa/3xEBO3I3ZhE=;
        b=5hKdwFxMU0/PjKnY/TctYAG07X6SzeAYRODAqZFgVaaTl/E13Dg24NGwFkpD9U0oSM
         BKXDm/Z33GAG6nUODsmSwpMlGa0mG3VSxGcjyP/yTloR8lKWmkrKZdt2qZV4sR6iwvyU
         8yUi9aAiKab/Jj6y4ZH2rfnhteL4ZQvxBKGw3QZRugGpi/Bp3UV6HPt6Y1d5FIqj4MgV
         F/iYmEma9HhS+z/2S4BS69jda3ece3EbGAdx0vpTnIYdidoYUyLtCtqmaHIuM/FiosUV
         I3IznQGr65gGtjs0eTimC/QyL7R/a+t9Qko2XIqaNVCpy6XUhCdOxx7v593UGhLiA00+
         wtPg==
X-Gm-Message-State: AOAM531tlqPtuiRK2Ec26YWHwNR/TYBaLlHJSA+LC75biYD+vp9orh7J
        RhD2U3h3RK8+5+H4QzpPi55uGA==
X-Google-Smtp-Source: ABdhPJyv4C5+P+SgYIf226CgVLrqAnPgnVXY5QUVMiim6AYeLnzTfC3cD84QYWdFL1q3lMAKjijtkw==
X-Received: by 2002:a17:902:ea05:b0:13f:4b5:cda2 with SMTP id s5-20020a170902ea0500b0013f04b5cda2mr11620979plg.86.1633727928442;
        Fri, 08 Oct 2021 14:18:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n1sm228706pfo.116.2021.10.08.14.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 14:18:47 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>, stable@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] lkdtm: Fix content of section containing lkdtm_rodata_do_nothing()
Date:   Fri,  8 Oct 2021 14:17:49 -0700
Message-Id: <163372786562.2954264.14524923434528443035.b4-ty@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <8900731fbc05fb8b0de18af7133a8fc07c3c53a1.1633712176.git.christophe.leroy@csgroup.eu>
References: <8900731fbc05fb8b0de18af7133a8fc07c3c53a1.1633712176.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Oct 2021 18:58:40 +0200, Christophe Leroy wrote:
> On a kernel without CONFIG_STRICT_KERNEL_RWX, running EXEC_RODATA
> test leads to "Illegal instruction" failure.
> 
> Looking at the content of rodata_objcopy.o, we see that the
> function content zeroes only:
> 
> 	Disassembly of section .rodata:
> 
> [...]

Applied to for-next/lkdtm, thanks!

[1/1] lkdtm: Fix content of section containing lkdtm_rodata_do_nothing()
      https://git.kernel.org/kees/c/19c3069c5f5f

Also, can you take a moment and get "patatt" set up[1] for signing your
patches? I would appreciate that since b4 yells at me when patches aren't
signed. :)

-Kees

[1] https://github.com/mricon/patatt

-- 
Kees Cook

