Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F129042C920
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 20:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238660AbhJMS5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 14:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbhJMS5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 14:57:50 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69725C061746
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 11:55:47 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id w14so2474583pll.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 11:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CeDioKlYWP/Ln2/sv3Boh4vbm3yoXHdApCIilZ4yhGw=;
        b=adSofeNpkzFQ7ekSQ+w/o5WGdQNGCajwgRa++HMYHPPE9dE7+IC42Fj/GAeu8fYZ2r
         T/XBrlk0nCBGvuFRp8tBJuAGrzUUCHkF6HcKiI/zzyA7Z6Ea0LF0Z2ezCoSZ8jcy8UHd
         LFxEWL7AMGZDGCcK2aRmNHSiq6g3Eol3eDjVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CeDioKlYWP/Ln2/sv3Boh4vbm3yoXHdApCIilZ4yhGw=;
        b=drfQEyf3g1o+QfrcS1Cx/r7I5eOotX9jMfqGSyjKq1l879wJkDGw5HGLcA9JVEJRTm
         QrMcA2hgAVlvMh5JE1ET7VUdRYhKiGgRJYfnA6a84hquGdGjNWKAF2rDz2ZC5kOmalOO
         +qNLcarMZx7KfiA6e6DK9U4Cy1eI1EP6pXRpFEMNax4kQSxwUFwgK2p22nkfWXHtn1bz
         Kae3QA64g/WQMbgl04HmI98CS2ZRAo6ZGeYLt8h7gHBiq1IQG/ZIDGhPRa06nPrF2zOZ
         duXRXwQZwPefS9SgPK2xPS0/6NtO2lygch9utuYm5Lk9lrPsjoqS8nbTqLSnC0mIlV3v
         +AYQ==
X-Gm-Message-State: AOAM530iYbEMip9EVRx8FfJ/YSRObr01BknjWYjuuH1OHwTFnxGNXvNx
        1Z9vqmWdPDRui2rQIBSK95PLTg==
X-Google-Smtp-Source: ABdhPJwbaTpa6edmN31oVJb/gCU2mYzliazMjcWHBH0jE37kLU9+/IH13a8ovSasYEkmTLsZf/xfDg==
X-Received: by 2002:a17:90a:bd04:: with SMTP id y4mr1109096pjr.9.1634151346914;
        Wed, 13 Oct 2021 11:55:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j6sm225896pfb.175.2021.10.13.11.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 11:55:46 -0700 (PDT)
Date:   Wed, 13 Oct 2021 11:55:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v5 12/15] x86, module: Ignore __typeid__ relocations
Message-ID: <202110131155.3A730AB3@keescook>
References: <20211013181658.1020262-1-samitolvanen@google.com>
 <20211013181658.1020262-13-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013181658.1020262-13-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 11:16:55AM -0700, Sami Tolvanen wrote:
> The R_X86_64_8 __typeid__* relocations are for constants the compiler
> generates for indirect call type checking with CONFIG_CFI_CLANG. Ignore
> them when loading modules.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
