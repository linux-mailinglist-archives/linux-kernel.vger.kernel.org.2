Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8954638F5A7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 00:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhEXWb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 18:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbhEXWb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 18:31:57 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D43C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 15:30:28 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 29so10064115pgu.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 15:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h5bxqul8WqbGdR7TLIhFeTTvOZiYlcHzZYUJx+gQS64=;
        b=iS1lBdEObb/AWXS3jxY2V0Q5IHvO54uEAfaOi05U8WCppNf/R93Sy1YK2E4Jsuw5JE
         Lbs6p6hLyl6AKpHj9aOdYwRC6BiBR1jdH478DO8npj0cjJEmLJamLhhzfuoVoeFfrovR
         EAvhg8NKfS+K5UU5usLU5rKuVyAxiAKqzTQJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h5bxqul8WqbGdR7TLIhFeTTvOZiYlcHzZYUJx+gQS64=;
        b=dBrcrKESTeBN6a1o+3Qx0upSb3sl/QBPIfb0hLOKHiWzXRko3WO358zJDX1nScIfw9
         VPxo7ADFSeQHr0E5hOMO/v9RqYPqgTnSTYYBFgTg8vtkC4VR7nebQ4yVIULTQir9U5hm
         rYO3lnNHZAPbFiTkfLDL/Tn2MfNdKJzAA2+UcrWuKb+YnY2N2FQWwH/smJk0CJDftFCK
         nl2+q0vcPO4/r7sMGx404t8PqZjQFdxUpJdyCYE9IP2PdyZgGFU434R2unlD/tiZiAg1
         u7mejEKtcU7fsoWUKvfGxpASTR+CA3fEmCR1roctQf92M2M5XbtW3gmWCF7x/iyAzSDM
         Z2nw==
X-Gm-Message-State: AOAM5305ra9B2c/tutQcaw13wnJdeeKXwjTr0dwcQIHIXQbirIwvNdWG
        b8B7n9qhCyBNbCa7dm1Oiniztw==
X-Google-Smtp-Source: ABdhPJxARWoYGFAEFqeBB8+Wpq+tunfa42080V18BSAJNiRquZFLiaArF+8fGbhYWgSP88O8336TwQ==
X-Received: by 2002:a63:d40d:: with SMTP id a13mr15643488pgh.382.1621895427908;
        Mon, 24 May 2021 15:30:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a12sm12571934pfg.102.2021.05.24.15.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 15:30:27 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        clang-built-linux@googlegroups.com,
        Candle Sun <candlesea@gmail.com>, linux-kbuild@vger.kernel.org,
        Fangrui Song <maskray@google.com>,
        linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] Makefile: LTO: have linker check -Wframe-larger-than
Date:   Mon, 24 May 2021 15:29:18 -0700
Message-Id: <162189535579.438777.12852956339898107122.b4-ty@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210312010942.1546679-1-ndesaulniers@google.com>
References: <20210312010942.1546679-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Mar 2021 17:09:41 -0800, Nick Desaulniers wrote:
> -Wframe-larger-than= requires stack frame information, which the
> frontend cannot provide. This diagnostic is emitted late during
> compilation once stack frame size is available.
> 
> When building with LTO, the frontend simply lowers C to LLVM IR and does
> not have stack frame information, so it cannot emit this diagnostic.
> When the linker drives LTO, it restarts optimizations and lowers LLVM IR
> to object code. At that point, it has stack frame information but
> doesn't know to check for a specific max stack frame size.
> 
> [...]

Applied to for-linus/clang/features, thanks! This should be in -next
tomorrow and I'll send it on for -rc4 at the end of the week.

[1/1] Makefile: LTO: have linker check -Wframe-larger-than
      https://git.kernel.org/kees/c/24845dcb170e

-- 
Kees Cook

