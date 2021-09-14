Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77AA240B40F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 18:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235231AbhINQCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 12:02:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:57258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234037AbhINQCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 12:02:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 24E4061151;
        Tue, 14 Sep 2021 16:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631635280;
        bh=YvnFp+LTkAmgQGEWe/SBIyJmwTJ98eh4cA8SOGc7JFg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PoeDqNqBcSWSq1v+Ma1vPWkDVmsjzdnoNH6UUs+V6Q3jziaFY5UXhmF6yE+k8LOuV
         pDIwhVhEAeUXWFuhV5EeEvCu0y0iAINaXs+FMhZ25+5/eDn0gkyBgAhx6/AcGRtBPc
         31mYGojmg8mqOzxoHcqd2Ulah1rFqBjib1XZWeJ5lzPbBLEYEMapC3jKYkDOHgpjkR
         LqMlFFUi3jwDRzRs1YHR1Nyn/M4GJVKCySeFzIh1e1MhE1vYXWNWDgjVlIaq0Qt3Q4
         BzM1A+Kvw2V8cMZCtlJqdHDZao17Q0Xc+WLssKOlpqzZiP/Ifx5gUFIEprQGxpaP0d
         W3t5hV+r1gz+A==
Subject: Re: [PATCH] gen_compile_commands: add missing sys import
To:     andreas@rammhold.de, Nick Desaulniers <ndesaulniers@google.com>
Cc:     llvm@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210914154441.1726853-1-andreas@rammhold.de>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <026a4e82-da46-a559-06d5-18cff798ad96@kernel.org>
Date:   Tue, 14 Sep 2021 09:01:17 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210914154441.1726853-1-andreas@rammhold.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On 9/14/2021 8:44 AM, andreas@rammhold.de wrote:
> From: Andreas Rammhold <andreas@rammhold.de>
> 
> The sys.exit was being used at multiple locations within the script but
> never imported. This lead to the script exiting with a error instead of
> with the nicely formatted (useful) error output.
> 
> Signed-off-by: Andreas Rammhold <andreas@rammhold.de>
> ---
>   scripts/clang-tools/gen_compile_commands.py | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/clang-tools/gen_compile_commands.py b/scripts/clang-tools/gen_compile_commands.py
> index 0033eedce003e..1d1bde1fd45eb 100755
> --- a/scripts/clang-tools/gen_compile_commands.py
> +++ b/scripts/clang-tools/gen_compile_commands.py
> @@ -13,6 +13,7 @@ import logging
>   import os
>   import re
>   import subprocess
> +import sys
>   
>   _DEFAULT_OUTPUT = 'compile_commands.json'
>   _DEFAULT_LOG_LEVEL = 'WARNING'
> 

Thank you for the patch! Someone else submitted the exact same fix and 
it is now pending in the kbuild tree:

https://git.kernel.org/masahiroy/linux-kbuild/c/776f04ca2c29f13d483a3effc0c27404fe901143

I am curious, how did you discover this? Did you hit one of those error 
paths?

Cheers,
Nathan

