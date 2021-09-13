Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D786B4098EB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 18:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237095AbhIMQYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 12:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237418AbhIMQYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 12:24:21 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD02C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 09:23:05 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id bb10so6184093plb.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 09:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IC7oL0JUrM22EcE083uTd4WakOlCzqk1n4A+MT+gbuo=;
        b=Dv28Qr4sJFjDOYLDU48B2m3YRxMAK1cTI/0ryWkdMK0ku6pEe9KH3Dg/aF6mc/tip8
         mH+HjdU/39tuqvVEEjMG3Q4wOmJcesWCIjud5DvYaLj8ZEs9WFYjoQH3hvTtSIbpgiZR
         5vx8g1BU83l8wLRn3fFDPlKjPnPJVFM4PiaYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IC7oL0JUrM22EcE083uTd4WakOlCzqk1n4A+MT+gbuo=;
        b=HBQ1J+asu3iQdqOMNl6MxQMQaH85+lMN5roKsbwYUDtjuKATfUPsSo6LKZhCW3bUn2
         igyKW+BKltEkIpm7Em1Xv8U3Df4cqj3x5TE9GWkozfDlTv+muoHbP1Gw7S59ycCk7n+B
         PlnScGDGLk/g0ZHdkr/OsRW3gqwCJIMLUYYRx404HB9XN81Ik7ZDuUGsRE4fCn6KHTmf
         LL73xKRGCZ44QdTl4xgOw0wq8BwgvuWby/dVu747h/iPqpjHf8PZ2W1w6ydiYGcQiCWB
         rAtrI2j145R6oAAfgsFTCmKMORhC7BGgFp7TFJDiVHsVwmQuEimu6gU6qEn8WaI41SuR
         jQgA==
X-Gm-Message-State: AOAM532Ax6169QfxoRWBPQmsRwJb1I5TdzeiGsYmUJIAWMxH2fpaAJNK
        I2CcTC4+W9Cz55tQHsmDRWTXeQ==
X-Google-Smtp-Source: ABdhPJxAhMJ+xb2U0bX9o4J3JRfI19rLe3U8+GpBilj7bgw0EAxYDgRGJFBv3Oy/j8amGsIoxN7Ubw==
X-Received: by 2002:a17:903:22ce:b0:13b:9a00:f090 with SMTP id y14-20020a17090322ce00b0013b9a00f090mr3806029plg.11.1631550184622;
        Mon, 13 Sep 2021 09:23:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 131sm7830033pfw.72.2021.09.13.09.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 09:23:04 -0700 (PDT)
Date:   Mon, 13 Sep 2021 09:23:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/10] Kconfig.debug: drop GCC 5+ version check for DWARF5
Message-ID: <202109130923.8BB83C791@keescook>
References: <20210910234047.1019925-1-ndesaulniers@google.com>
 <20210910234047.1019925-5-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910234047.1019925-5-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 04:40:41PM -0700, Nick Desaulniers wrote:
> Now that the minimum supported version of GCC is 5.1, we no longer need
> this Kconfig version check for CONFIG_DEBUG_INFO_DWARF5.
> 
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
