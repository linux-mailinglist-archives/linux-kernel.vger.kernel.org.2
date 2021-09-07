Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57F03402F65
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 22:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345958AbhIGUIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 16:08:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:36446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230362AbhIGUIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 16:08:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BADE0610E9;
        Tue,  7 Sep 2021 20:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631045218;
        bh=pZvpWUpWcuO/wG2ergj6sy0KyKSMIXliQiAr8bwFSXY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ICc32nMj8K9B6kPwuYklgEEN60W7xkGeLOMHitcsEvlGAQmnS8Dr12J5Rq0bOQmUB
         +cJSkLcGBSUliEvKjeCxS0ZoQ6isClBNrXvvXQWcTLDiCKx9YhjziQ8K1ut0UjYRQY
         p4/IfkCrdKS+Lavdadr7yYE1Hbs9trEQx9KrXt5d7ySJ42JaUGYXv0qxOYtYvP17c0
         DmyOvYrBKtdyVVq3FPfBn8mmh6Mu31W697cbq5PbHgStyMrjKYmF5SIWm/wwhwhsTv
         IXiPohbN89VsocgWiP1/Na56MFfgDVRlhnquR190O4bgd7EnNs55/1W099jHPi3h3x
         cSEufNUbTS5Yg==
Date:   Tue, 7 Sep 2021 13:06:54 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Kortan <kortanzh@gmail.com>
Cc:     ndesaulniers@google.com, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] fix missing 'sys' package
Message-ID: <YTfGXn4cTZ87zTP1@archlinux-ax161>
References: <20210907094336.16558-1-kortanzh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210907094336.16558-1-kortanzh@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kortan,

Thank you for the patch! I have some comments inline.

The commit title/subject should have a prefix to it. You can see the
prefix for this particular file by running:

$ git log --oneline --format=%s scripts/clang-tools/gen_compile_commands.py
gen_compile_commands: extract compiler command from a series of commands
gen_compile_commands: prune some directories
scripts/clang-tools: switch explicitly to Python 3
Makefile: Add clang-tidy and static analyzer support to makefile

So your commit title would be:

gen_compile_commands: fix missing 'sys' package

On Tue, Sep 07, 2021 at 05:43:36PM +0800, Kortan wrote:

There needs to be a message here. It is obvious once you look at the
file that we call sys.exit() so we need the import but that needs to be
explained up front here. checkpatch.pl would have warned you about this:

WARNING: Missing commit description - Add an appropriate one

total: 0 errors, 1 warnings, 7 lines checked

Otherwise, the change looks good to me. Please make these corrections
and send a v2 of the patch, which can be done with the '-v#' flag to
'git format-patch' (e.g. '-v2' in this case).

> Signed-off-by: Kortan <kortanzh@gmail.com>
> ---

Describe the diff between v1 and v2 here like:

v1 -> v2:

* Fix commit title

* Improve commit message

then be sure to also include Masahiro Yamada and the linux-kbuild
mailing list as he will pick up the patch.

Masahiro Yamada <masahiroy@kernel.org>
linux-kbuild@vger.kernel.org

Please use our new mailing list as well:

llvm@lists.linux.dev

Cheers,
Nathan

>  scripts/clang-tools/gen_compile_commands.py | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/clang-tools/gen_compile_commands.py b/scripts/clang-tools/gen_compile_commands.py
> index 0033eedce003..1d1bde1fd45e 100755
> --- a/scripts/clang-tools/gen_compile_commands.py
> +++ b/scripts/clang-tools/gen_compile_commands.py
> @@ -13,6 +13,7 @@ import logging
>  import os
>  import re
>  import subprocess
> +import sys
>  
>  _DEFAULT_OUTPUT = 'compile_commands.json'
>  _DEFAULT_LOG_LEVEL = 'WARNING'
> -- 
> 2.33.0
> 
> 
