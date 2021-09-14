Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1C440B4AD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 18:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbhINQci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 12:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhINQch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 12:32:37 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CC5C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 09:31:19 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id u15so15149914wru.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 09:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rammhold-de.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NPkoCja56SwOOlp6HJUjYEvj6VOAZ4czZ+lgAWW9WVo=;
        b=rlUTTN3Jx33rjHJqzkcQrLaAsRM2MC//hWRESRE+TrZgAdqN4b94uu3/pzQfswUHzu
         elRgvzf5lt7geWuw+1hJo5d5dABBLuJPEOA2/10/D+w6aa/LfRXvlkamglQhAOyTiONH
         6v78ZiaEzFndIKXusgbjcM3h4e8AGqYfdB2dg6VA9VUgnRPg9i5PkUfb1+KwgHaMlfrH
         FV61EVxan/fJMHuHPHMfhAIvuAmPwOzVibIuqAC9kD9wLchndW+aQ1Mv6H62ORkEn/9h
         UGbc5QFNDvwiYWhtxmsJlSBncG1ZzW4apmwckgAa4u0k4FPcuWZQFh3qDs6bKrcuhW0Q
         /sGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NPkoCja56SwOOlp6HJUjYEvj6VOAZ4czZ+lgAWW9WVo=;
        b=TONgLQvc5efgHttfC24Hv+sr1ISSHz0Ps7XvUcctKS8caAAUmyYcmEjFIKwU4EHvFV
         Ko2hO3qYzEYWa+91Z4ywJp4V89YNqMGsbah+0rQtu0q8yuXorl9jFd3cN540L6XD2MYL
         GOWZOeIdSXOfAsvjoYBU2yt6JAVcH4B2+GwMtymgZKuF4zRnic8ouOorta7hHCPbvMOa
         /t4RLGowgBLeZAWgaIW+dHAL8d2IX0PE3iscoSnQd1/9N8wtpdsJfTpvPsxisTp7jnq1
         eDzOMpFB48f22+BlRf+76TG54CwjQjPIIgGU26DCt8DywdbefrKUp1MXKFcDOUezSLcq
         TZDg==
X-Gm-Message-State: AOAM5318mEgKq1Udofqt7GDeyrYm5WF/KHDxlcYDLX74JX5vVVCIOgmS
        R2J7i8Z5tw8iTQoimFAwAXl3h/L/0KKPSA==
X-Google-Smtp-Source: ABdhPJw3BuDvFqjY+aHNxKx4Pv3sODFBF6JZagddy4yGgL6h1YUNGw5aA9TsAOX5KG+7sWUz6FMS3w==
X-Received: by 2002:a05:6000:1186:: with SMTP id g6mr56174wrx.126.1631637078128;
        Tue, 14 Sep 2021 09:31:18 -0700 (PDT)
Received: from localhost ([2a00:e67:5c9:a:2e15:c474:2ef7:bc26])
        by smtp.gmail.com with ESMTPSA id z17sm11421076wrh.66.2021.09.14.09.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 09:31:17 -0700 (PDT)
Date:   Tue, 14 Sep 2021 18:31:12 +0200
From:   Andreas Rammhold <andreas@rammhold.de>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gen_compile_commands: add missing sys import
Message-ID: <20210914163112.23jm4u37ouyxatjh@wrt>
References: <20210914154441.1726853-1-andreas@rammhold.de>
 <026a4e82-da46-a559-06d5-18cff798ad96@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <026a4e82-da46-a559-06d5-18cff798ad96@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09:01 14.09.21, Nathan Chancellor wrote:
> Hi Andreas,
> 
> On 9/14/2021 8:44 AM, andreas@rammhold.de wrote:
> > From: Andreas Rammhold <andreas@rammhold.de>
> > 
> > The sys.exit was being used at multiple locations within the script but
> > never imported. This lead to the script exiting with a error instead of
> > with the nicely formatted (useful) error output.
> > 
> > Signed-off-by: Andreas Rammhold <andreas@rammhold.de>
> > ---
> >   scripts/clang-tools/gen_compile_commands.py | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/scripts/clang-tools/gen_compile_commands.py b/scripts/clang-tools/gen_compile_commands.py
> > index 0033eedce003e..1d1bde1fd45eb 100755
> > --- a/scripts/clang-tools/gen_compile_commands.py
> > +++ b/scripts/clang-tools/gen_compile_commands.py
> > @@ -13,6 +13,7 @@ import logging
> >   import os
> >   import re
> >   import subprocess
> > +import sys
> >   _DEFAULT_OUTPUT = 'compile_commands.json'
> >   _DEFAULT_LOG_LEVEL = 'WARNING'
> > 
> 
> Thank you for the patch! Someone else submitted the exact same fix and it is
> now pending in the kbuild tree:
> 
> https://git.kernel.org/masahiroy/linux-kbuild/c/776f04ca2c29f13d483a3effc0c27404fe901143

Oh! I should have send the patch when I originally comitted it.. Good
that it is fixed now. :-)

> I am curious, how did you discover this? Did you hit one of those error
> paths?

I can't recall the exact story anymore. I was looking into why the
keyring didn't offer the TPM backend on my new device. I did a fresh
checkout of the source tree on the device and set out to get clangd
working in the source tree with my neovim.


At first I tried to call the script without compiling the kernel. That
failed with some obvious error.

It could have been that I ended up in one of the error paths. Naturally
I digged into how this whole machinery works and that lead to opening
the file. Neovim, being setup for Python development, showed me that
there was an undefined symbol / missing import. I verified that and then
added the import.

As far as I can remeber I did end up compiling the kernel and/or then
running `make compile_commands.json`. Ever since then it just worked!

Thank you for working on this! :-)
