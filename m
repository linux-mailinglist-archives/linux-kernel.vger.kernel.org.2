Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1844F42E196
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 20:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbhJNStJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 14:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbhJNStI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 14:49:08 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386AEC061753
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 11:47:03 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id f11so2346330pfc.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 11:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=flE15Vag1x2qH6k6oFaTp0PZRJ1ZGZb8THhO62QsLjE=;
        b=BeR9rE+h6oOZjaOHDA370v0suUCXLikBJQsw9Cy8vwaf1/MG0Ui7pXfraYG/Nyb0qd
         iqaQ02SSXwqqNyFydlvvqyk1qE2NADJLiuipogiDTsBcouXv5GaZVVwijXEiHrpht0kN
         02AqT5qkbHDgVntpqt7nKyIht9C8bmQJYVhdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=flE15Vag1x2qH6k6oFaTp0PZRJ1ZGZb8THhO62QsLjE=;
        b=LJW8t2tCeE6L0pmt/mEFh9eUo3DGSx3mg9cNlE/5jLsHh0uwONaJX82EOzL0RS+NH1
         WnN4Ajqm2lztVECJDn//rfUXywHQ4gdQhcXQfTjPU1xpRieSaT5LmPiiecSemAjxTPdO
         WOx/00FjKm81YyT8gUNdSRElWy3SOCzUUS6Rys9gco6gDAMDVvW4jypU+Ew86z4GK+xF
         wx8UH2wH5ots07dC6tDM6TqF8V26yQB6225K5f373GBcldQHY699K4GD2S9LoZdm+djV
         zGH3wASTJVT2jqGTm1+A6BLA6fpUA8UepMHXB1PS+QImlYuAv5piO6tuZPGwFlAGV5qo
         8j8Q==
X-Gm-Message-State: AOAM531y2cVxMSPV5nsU8vxr0S+/1yLdInDaPEcfB+xP/ToMOAe36B4l
        bJlW3J9c5c/7AQX5U1lof8H05JYORGzjLg==
X-Google-Smtp-Source: ABdhPJzYq661wv4AErhvhHm19916LjgZM0cmC1UFXDThhI7WtsP5/hjhJSDpBPLelZ054c+1Ggo7wA==
X-Received: by 2002:a62:7dd0:0:b0:44c:b0b8:6eaa with SMTP id y199-20020a627dd0000000b0044cb0b86eaamr7036185pfc.73.1634237222778;
        Thu, 14 Oct 2021 11:47:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o12sm2954984pgn.33.2021.10.14.11.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 11:47:02 -0700 (PDT)
Date:   Thu, 14 Oct 2021 11:47:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Sami Tolvanen <samitolvanen@google.com>, x86@kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v5 09/15] x86: Use an opaque type for functions not
 callable from C
Message-ID: <202110141141.870A67E@keescook>
References: <20211013181658.1020262-1-samitolvanen@google.com>
 <20211013181658.1020262-10-samitolvanen@google.com>
 <YWgSwmzPFrRbMC1P@zn.tnic>
 <202110140904.41B5183E@keescook>
 <YWhpbu/Y6V2p/zlY@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWhpbu/Y6V2p/zlY@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 07:31:26PM +0200, Borislav Petkov wrote:
> On Thu, Oct 14, 2021 at 09:07:57AM -0700, Kees Cook wrote:
> Looking at the changelog, DECLARE_ASM_FUNC_SYMBOL, makes a lot more
> sense to me even if it doesn't specify the aspect that it is not called
> by C but who cares - it is generic enough.

Around we go. :) Josh[1] and Steven[2] explicitly disagreed with
that name, leading to the current name[3]. Do you want it to be
DECLARE_ASM_FUNC_SYMBOL() over those objections?

I'd really like to finish this shed -- I need to take the bikes in from
the rain. :P

-Kees

[1] https://lore.kernel.org/lkml/20211006032945.axlqh3vehgar6adr@treble/
[2] https://lore.kernel.org/lkml/20211006101654.6a5be402@gandalf.local.home/
[3] https://lore.kernel.org/lkml/CABCJKufCaOXOUF43a-PQshO8aEsMNhZ2EiyGMSOp9ZGn57G=pg@mail.gmail.com/

-- 
Kees Cook
