Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF1A4342500
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 19:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhCSSnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 14:43:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:32846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229974AbhCSSmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 14:42:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C7D4561976;
        Fri, 19 Mar 2021 18:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616179358;
        bh=dv0/gyk9NYMKLd7GwJvBW0EOOHZzOvGVRp5vARPvBHs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U+rrUWShoYh0QXWbB/5zegpX5mInbLIMJ/uaDWNwV0NhnZBM0irOcVngTSb8HYuRq
         Dp5Royfq0IbzNs9zA9OPb+tHLpbzeE5JpzNi4BqavtY1CCjQws0cwFmxIFBprM2fUG
         qbYJppBzAN/6bdm5iXYwQJJiCf7jUQjoXVrSeFEfCf1u3Qx7Q9RPzj1s/RvmxJFwxz
         KchiRiN2mHf3/C44PjF+x8LFqSBjdin0tymkz+duJaCMt7HMx9NJS8VdHRVmDRktNs
         jU44BfYi9dWIuthoO5thdSj9M50y2ectJ48xyYyXtnC0AXw9d6Y2L5yAjlkg3182+7
         xiPHFwaCkraDw==
Date:   Fri, 19 Mar 2021 11:42:34 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] clang-format: Update ColumnLimit
Message-ID: <20210319184234.jsudy6solmtrq6vz@archlinux-ax161>
References: <20210319183714.8463-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319183714.8463-1-ansuelsmth@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 07:37:14PM +0100, Ansuel Smith wrote:
> Update ColumnLimit value, changed from 80 to 100.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .clang-format | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/.clang-format b/.clang-format
> index c24b147cac01..3212542df113 100644
> --- a/.clang-format
> +++ b/.clang-format
> @@ -52,7 +52,7 @@ BreakConstructorInitializersBeforeComma: false
>  #BreakConstructorInitializers: BeforeComma # Unknown to clang-format-4.0
>  BreakAfterJavaFieldAnnotations: false
>  BreakStringLiterals: false
> -ColumnLimit: 80
> +ColumnLimit: 100
>  CommentPragmas: '^ IWYU pragma:'
>  #CompactNamespaces: false # Unknown to clang-format-4.0
>  ConstructorInitializerAllOnOneLineOrOnePerLine: false
> -- 
> 2.30.2
> 

Not sure how opinions have changed since but this has come up before:

https://lore.kernel.org/r/20200610125147.2782142-1-christian.brauner@ubuntu.com/

Cheers,
Nathan
