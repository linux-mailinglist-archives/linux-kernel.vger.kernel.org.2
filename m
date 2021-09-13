Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 159544098FD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 18:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237403AbhIMQ0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 12:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbhIMQ0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 12:26:19 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B03C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 09:25:03 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id gp20-20020a17090adf1400b00196b761920aso421572pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 09:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zuPUItXSPj0PAMYdwf9A90s2GvyBeXQIkWyfA3MX9Lw=;
        b=U6fT/FIGLJV6UN6XFl+2eeN+TRUZp/d9f4Gg2Zbqy3odIfJdjZOTqd46CvX/KDp3HJ
         l9NcuwruLjOciU4rNSPnw25+GPJ2jd8CxB3ex/8zoq8XYFzXRSWfYXGrhbuRogDihdNJ
         bkKEWOmUymMUjtmwdyOwrATS0g2Sa/NwvqMgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zuPUItXSPj0PAMYdwf9A90s2GvyBeXQIkWyfA3MX9Lw=;
        b=DV4PvPPLW7pRDg8KG3ZbpJnxnkqy5V1Sp2LbCMBgZ2WWoz0BL1LDOq5q4Jj/dVquNw
         XLrDjK7cgsuUkWyUcfZAeaazejrJNl7wu6iWRAEwWtTyN2xbXmV/dYRFOrOcit6rZWPU
         TQ/kwQkEmobG3mB6TmeYMMa0AvhzQb0itti30shwXyhu3W6c4FsITnXssIQKGKePUuc1
         NLOHwxHHNNk9MalTMaYiIt6SZl70OZOHpR4lgybA2mdXe6NWofciW+7txFfNgOefUG8V
         3zcS90edY8KRJewEjhk0Q/O/p3cSLlW4GCpKMf/vKPGN0yVw55EAA/HELw9gDtleix0J
         udhA==
X-Gm-Message-State: AOAM533TCVaIY+vcNwVwHFS6gtllNEU+LZf53K4YHK+PG3dwedVj9jFH
        Jis5V88KRSOcuX/y73iVi595Qw==
X-Google-Smtp-Source: ABdhPJwL9ixBG8I68USpTyltJTZ5dkFKkNfUYvRlELRdAaw67LR4GDId05Pp5su+VZlRqT4yZ5cSdQ==
X-Received: by 2002:a17:90a:194a:: with SMTP id 10mr426324pjh.176.1631550303604;
        Mon, 13 Sep 2021 09:25:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d10sm7621291pfq.205.2021.09.13.09.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 09:25:02 -0700 (PDT)
Date:   Mon, 13 Sep 2021 09:25:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 07/10] arm64: remove GCC version check for
 ARCH_SUPPORTS_INT128
Message-ID: <202109130925.3B30E9E1@keescook>
References: <20210910234047.1019925-1-ndesaulniers@google.com>
 <20210910234047.1019925-8-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910234047.1019925-8-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 04:40:44PM -0700, Nick Desaulniers wrote:
> Now that GCC 5.1 is the minimally supported compiler version, this
> Kconfig check is no longer necessary.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
