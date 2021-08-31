Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCFA23FCE49
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 22:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240899AbhHaUTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 16:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239995AbhHaUTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 16:19:42 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD768C061796
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 13:18:46 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id n18so346896pgm.12
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 13:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=r9GlhdKOosTzO8LRW6O4s9OUHVsB4FP+bxUhxdd1GR0=;
        b=aC14HTofppYVFRnQldibqoCSawNZyB3QTtPZsQ5Xl2i/syvuj8VfSSNcb7EJP3CXRx
         OWe5enRZUx9hRSbnxOUDwbKWt8w41283gOFBdZR8lZjPp/eh622bK2yTcNMuhLmnl9iH
         H6eQlQOAb54RKUtP5lPFn0G3Pa04FZSehFVA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r9GlhdKOosTzO8LRW6O4s9OUHVsB4FP+bxUhxdd1GR0=;
        b=CwX4V1EKTH9Ec7krorTUpSe19y3BdmQQA8Y61Gf+SL/QCdbRInAoJ7RXxJzVT3Opbu
         DtMIs/wgGhRW/pfNXp0+GeNWLG9lgJwBHb0bBsq725XEYMvJe4cdXgaj1Ykl+nFuhv20
         jjkuQnuFhtz5OWoim2rAei8qv4UwmJ29DOy4Np6u/SmHIfzIjy+xdJoYYKvo7ZC3ZDOr
         pQCiP/Y6a+AMzHYLE0313mJ6BZtiT8jw+ADNvuPmRPnB25rAzd08ihQQB/JdyHx7XYye
         Vy00Hc5yd6u/c8Eqvu39aHp4EUr3bs1b4kBsfxQUqPMSkxmW2pBRjOk9VHX2vIQuMjUL
         lhzg==
X-Gm-Message-State: AOAM530W82bm57tpOuvfkkSXRHCZHJXq01yA0QrXY4IbFeoz8gFVK4D8
        KKf3l90qhoPZmKpK5HClO0QDJQ==
X-Google-Smtp-Source: ABdhPJxUlk5jlKKeD4jMzypYtqK2meJMhtPOJBqKR+4e1VA7wvJwaaCFKtaKWS7ohBKeuH3xgQxHZA==
X-Received: by 2002:a62:ab04:0:b0:405:c1c0:543c with SMTP id p4-20020a62ab04000000b00405c1c0543cmr4085848pff.36.1630441126251;
        Tue, 31 Aug 2021 13:18:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d7sm22416029pgu.78.2021.08.31.13.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 13:18:45 -0700 (PDT)
Date:   Tue, 31 Aug 2021 13:18:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Keith Packard <keithp@keithp.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 4/5] Makefile: Enable -Warray-bounds
Message-ID: <202108311317.DFFFCFC74@keescook>
References: <20210827163015.3141722-1-keescook@chromium.org>
 <20210827163015.3141722-5-keescook@chromium.org>
 <20210831043128.GA2749311@roeck-us.net>
 <202108311042.FFE1818D@keescook>
 <3ab153ec-2798-da4c-f7b1-81b0ac8b0c5b@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ab153ec-2798-da4c-f7b1-81b0ac8b0c5b@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 12:40:53PM -0700, Guenter Roeck wrote:
> The configuration doesn't matter; it fails for me for all configurations,
> including defconfig, alllnoconfig, and allmodconfig.
> Key is to use gcc 11.2. The image builds just fine with gcc 9.4 and 10.3.

Ah! Yes, heh. That would be my problem; I've got 10.3 for my builders.
Thanks! I will give 11.2 a spin.

-- 
Kees Cook
