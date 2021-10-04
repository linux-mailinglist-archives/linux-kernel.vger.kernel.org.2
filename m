Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 914BE421609
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 20:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236342AbhJDSHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 14:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234389AbhJDSHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 14:07:10 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E847CC061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 11:05:20 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id r2so17322281pgl.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 11:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0iPpm+LltGiRi7xAAdW5SmPgdzwJsCyUCqWs1KUg+Po=;
        b=ZNVZ75C0oqeFlmwh9JI4f3TV7YRZKMcBK0WKFScjCS9y7lzeMm/KRZZA4H8TiRZp/h
         FbeT+hca6B6B3IldhdMlCvhP2uJ8ah4zZ2IovLFbjSjmwxrbSYTfZEpohWkWeQoQIk2L
         DXx1lszBqNHa/ED6pzChbiB5CXg9exmrLBngI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0iPpm+LltGiRi7xAAdW5SmPgdzwJsCyUCqWs1KUg+Po=;
        b=hiESOYdUTGnNGZfmJldNF8UXQMtrKJ4hS34qr6Vz2l+wzu47is3bTfM3l5oE7VrMIc
         cjnJBu9A4APEGWX9brgeRP+Zhf9fMJDIk6oY8mF2JFmVLvjcMbWJjYmza+Y99+Ghwfk+
         MkX4zy6VkXJPkLTrY1muP7jONb4v4yBmEwsT+88VCa6wlTR8NJunWp+qe1ULI9kORgQN
         RpuYrqyu/zi8Qk5Hxg05pftV7WOOSF7OudPBclG3WYtwarXpITcwfNcZovNXDxHMStJm
         4Uaq9WzTaRpNd4Eg7a5vaAT/AaB1vgDP+6tf1a7boqp5Pa0a0Gdk4bvsgouAyWrkeabL
         KTKg==
X-Gm-Message-State: AOAM5330YAswS+o2nDj8Q9xZ7QgnHwZGwJjl80t5Gf8K7q6PgDk1COe6
        iA6u4GaCq9/cARSCotPkjzdLVQ==
X-Google-Smtp-Source: ABdhPJxO0QaWv8cAURIP5bfSsg6/37MkK4znRztUplixEjKkMW63xfr1uJrJIiRkSENOFYw+Nx7SjQ==
X-Received: by 2002:aa7:81c7:0:b0:44c:517f:a759 with SMTP id c7-20020aa781c7000000b0044c517fa759mr9730318pfn.3.1633370719844;
        Mon, 04 Oct 2021 11:05:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y23sm7934721pje.34.2021.10.04.11.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 11:05:19 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        "KE . LI" <like1@oppo.com>, Stephen Boyd <swboyd@chromium.org>,
        Fangrui Song <maskray@google.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Padmanabha Srinivasaiah <treasure4paddy@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Joe Perches <joe@perches.com>, Jessica Yu <jeyu@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>, llvm@lists.linux.dev
Subject: Re: [PATCH v6] kallsyms: strip LTO suffixes from static functions
Date:   Mon,  4 Oct 2021 11:00:55 -0700
Message-Id: <163337043811.3396838.458236649388694225.b4-ty@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211004162936.21961-1-ndesaulniers@google.com>
References: <202110020501.RKX4zca7-lkp@intel.com> <20211004162936.21961-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Oct 2021 09:29:33 -0700, Nick Desaulniers wrote:
> Similar to:
> commit 8b8e6b5d3b01 ("kallsyms: strip ThinLTO hashes from static
> functions")
> 
> It's very common for compilers to modify the symbol name for static
> functions as part of optimizing transformations. That makes hooking
> static functions (that weren't inlined or DCE'd) with kprobes difficult.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] kallsyms: strip LTO suffixes from static functions
      https://git.kernel.org/kees/c/6eb4bd92c1ce

Also,if you get a moment, can you set up patatt (or b4) to sign your
outgoing patches? DKIM is nice, but I'd like to see more folks signing
their emailed patches: https://github.com/mricon/patatt

tl;dr:

add to ~/.gitconfig:
[patatt]
    signingkey = openpgp:FINGERPRINT-HERE

# install git sendemail hook (assuming you send with git)
$ patatt install-hook

# or do it manually before sending:
$ patatt sign $file-with-email

Thanks!

-- 
Kees Cook

