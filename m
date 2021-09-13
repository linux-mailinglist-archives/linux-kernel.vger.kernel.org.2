Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB474098DD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 18:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236539AbhIMQXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 12:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232931AbhIMQXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 12:23:32 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43107C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 09:22:16 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id t20so6712746pju.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 09:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x9bengKu+CI5Uy0lxK3X1t9kIOqgRUCo1n/+q3eZAGw=;
        b=atKV3P/8k/Yz8cBigFlc9fXFfyCBqkZFUT4+RKL1Z2tJeLgayOQJvz/EPJpYdPW+vj
         XB9aylqdgIXvWFV2ZaZmy7g73rqq2+ki3DTPisx3U9sGYtJi4LOl5LCUNRzaLaxNkygQ
         4aw/h2na3FhYoUcmwmfGh87UYgO68GUZMKRGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x9bengKu+CI5Uy0lxK3X1t9kIOqgRUCo1n/+q3eZAGw=;
        b=GHNdahb9JT7Tur8skaDss2dLHq9hxS7P2OpkFPDj4zGKg3EyIOdsQJvh/30NRoTH/r
         t7jmhJCsi34pvlmsImHVtXlOlxbZw5I7gtWw5Ce6JhWvUru0R0xA/OO544LuKZ2191KG
         kL1/0MPu6QNvHm8QDqUYY1Cqtbcipok4FWbvQnoKPyfmi0epPZI0zCcfodz36qzcJlKR
         YEbJ3Dgl08mt1Cfq7Gk2GkJvyAllPXHNvozoCNxQX/Uex5tIrhwDMg2kzgcqhAcgFDkk
         7NeHbxtivtvBBQIa2Na+n/hucPgnu2et8pnh2bQrQWIOgk2tmXY+HS6ZYXIPykbL9a4g
         jE+A==
X-Gm-Message-State: AOAM530c1HM712N6uTthzQy9SAbt/+8onFMp4TNP2nTIIiHOUD+uk5F6
        qYKOcPi4ZuRmZADijfT5vbMKww==
X-Google-Smtp-Source: ABdhPJzjqGdWhTndUENRXXSU0o8Taq3svhepsDvQaON2wiOrnYg1dZyKG9Bszyg7IEOrraOFxs5ykg==
X-Received: by 2002:a17:90a:eb0b:: with SMTP id j11mr369315pjz.173.1631550135873;
        Mon, 13 Sep 2021 09:22:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h10sm2302588pjs.51.2021.09.13.09.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 09:22:15 -0700 (PDT)
Date:   Mon, 13 Sep 2021 09:22:14 -0700
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
Subject: Re: [PATCH 03/10] mm/ksm: remove old GCC 4.9+ check
Message-ID: <202109130922.D8C51303@keescook>
References: <20210910234047.1019925-1-ndesaulniers@google.com>
 <20210910234047.1019925-4-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910234047.1019925-4-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 04:40:40PM -0700, Nick Desaulniers wrote:
> The minimum supported version of GCC has been raised to GCC 5.1.
> 
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
