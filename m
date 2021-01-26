Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E382D30585B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 11:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235744AbhA0K0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 05:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S314201AbhAZXAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 18:00:39 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8E4C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 14:59:59 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id m6so11385217pfk.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 14:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v4vLMnE79I5H4BnynTTOoA+/hZLJz2auYrPML1aX3qo=;
        b=Y8/ezfvkoAt+Zv1miXw4RTWhl+j87Mf7SfwiJlLpIBYP3EkeDaGdtkiq+c1+uOIImD
         sIpkEj2JvabE8/tJMIdj2Bs/sfcNrSumUuIQdHpvJeTZXf7G4xKB3GFUdKeBQ/dn3evm
         S9F3TMkc+7WC25HJeiKQJDMssxuJZ53Jpn9cQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v4vLMnE79I5H4BnynTTOoA+/hZLJz2auYrPML1aX3qo=;
        b=smHM3FHZVOB4UijEswSrMf0YCrcvhjDY8EsPNMU5xpPC/ieN99bYyJd/TAbsxkdpf3
         qw/aXLcIqolxmSYSeUkfxulXlQd3rxBCVf4GPKPculES2ZJVL+39a6IWBAudFgLaDkkF
         qme7/P+fm/hHnYbVgpi8e4aYLvBFFmRHBMt3t8yG8pkE8y4dKF5eY9lNX1ahkc6DZG4t
         bgL9Gfbz/GyB7vy3Q2cHazpmqvxD0XfgwEqQh5fdCqiUhDwUs5Wm7dfE3SRe2KsbafGu
         TzjjCDi0t65XCkcWwh0AYhc9WNUJFcaAOHvZpQ294c0crRbfGd2986L6rM07COdy38Ri
         7qXA==
X-Gm-Message-State: AOAM531umKSuw1o+5GvoJTx4K+46qdK2VDA3QoDcVpihhi6ou6rq1K51
        AskMJPgz0PdBRV5oLZzSsyyvTg==
X-Google-Smtp-Source: ABdhPJzptUM+GfHxvz2Hj8TNGijHu7CJwFy+CWJ6D4Qp/44KIYDHOsDBy1RsJyotEUll8V8ms7LqCg==
X-Received: by 2002:aa7:9a48:0:b029:1b7:bb17:38c9 with SMTP id x8-20020aa79a480000b02901b7bb1738c9mr7461264pfj.51.1611701999000;
        Tue, 26 Jan 2021 14:59:59 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w20sm61139pga.90.2021.01.26.14.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 14:59:58 -0800 (PST)
Date:   Tue, 26 Jan 2021 14:59:57 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Justin Forbes <jforbes@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: Re: [PATCH RFC] gcc-plugins: Handle GCC version mismatch for OOT
 modules
Message-ID: <202101261459.C90E9F97D@keescook>
References: <efe6b039a544da8215d5e54aa7c4b6d1986fc2b0.1611607264.git.jpoimboe@redhat.com>
 <202101251401.F18409FDD1@keescook>
 <20210125221953.wng3gk3qc32eahil@treble>
 <202101260955.F83D191B@keescook>
 <20210126184316.hpcy6gqp5vsq6ckq@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126184316.hpcy6gqp5vsq6ckq@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 12:43:16PM -0600, Josh Poimboeuf wrote:
> On Tue, Jan 26, 2021 at 09:56:10AM -0800, Kees Cook wrote:
> > On Mon, Jan 25, 2021 at 04:19:53PM -0600, Josh Poimboeuf wrote:
> > > On Mon, Jan 25, 2021 at 02:03:07PM -0800, Kees Cook wrote:
> > > > On Mon, Jan 25, 2021 at 02:42:10PM -0600, Josh Poimboeuf wrote:
> > > > > When a GCC version mismatch is detected, print a warning and disable the
> > > > > plugin.  The only exception is the RANDSTRUCT plugin which needs all
> > > > > code to see the same struct layouts.  In that case print an error.
> > > > 
> > > > I prefer this patch as-is: only randstruct needs a hard failure. The
> > > > others likely work (in fact, randstruct likely works too).
> > > 
> > > I'm curious about this last statement, why would randstruct likely work?
> > > 
> > > Even struct module has '__randomize_layout', wouldn't basic module init
> > > go splat?
> > 
> > No; the seed is part of the generate includes -- you'll get the same
> > layout with the same seed.
> 
> Right, but don't you need the plugin enabled to make use of that seed,
> so the structs get interpreted properly by the module?  Or am I
> completely misunderstanding how this plugin works?

Having the plugin enabled or not is part of the Kconfig ... you can't
build anything if you change Kconfig. I feel like I'm missing
something...

-- 
Kees Cook
