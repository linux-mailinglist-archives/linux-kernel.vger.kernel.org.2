Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9770C325738
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 21:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbhBYUCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 15:02:13 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:38984 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbhBYUBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 15:01:52 -0500
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 11PK0gIu027339
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 05:00:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 11PK0gIu027339
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1614283243;
        bh=hjxgfb7OoD8gXwhyW+y1zIEGPtqCV+ZySXEB9w2W51M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QIkyhvbW6TeuW5d3uzEYa6KnhlvKugr9RSRx5Abzl8yrmwYaWbat43yT2gc10vvIp
         /sYUXthN4wKPY6SD9gIqgLh9enGQ/8ewSJqHmrsH1Kx2YIEthNDFK61Gryqqb19BcQ
         OcYmr/gJ+AyEBr8E+dWxsUNQAPhfan3OskS5Z87HNgYqO50zcCLGPAccGoUTpzzvvV
         woSPnZVh9AT6Lu197tsziTP+3ROVZKNwD7iIgu7WpRlG+y/o4A6VPGifhJ+ZoaM7Wi
         yPTUIIPoqcvweq8kMqKEeaPz/Sdz4++ilX7HFiuNPW7i5MgU4lyKXPho1qEG2xjbOR
         n9kbbFNYdxLlQ==
X-Nifty-SrcIP: [209.85.210.182]
Received: by mail-pf1-f182.google.com with SMTP id d12so1802960pfo.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 12:00:43 -0800 (PST)
X-Gm-Message-State: AOAM533PYEqM+o3w2AalJkArHtRcjq4ZcYQoxl5F29opK56g6CdDlj4y
        5E8Oan1qHbQRwgbyb7lr+WAgtLYDwfPUtWRQaFs=
X-Google-Smtp-Source: ABdhPJzULKt6omFpyOcWInZWBePyKCF6l7m7SUnk4M9Cq09Z2+ID7WisXsvtNZr1i2g0egr8tWQ3yJKttXwADfKxdm8=
X-Received: by 2002:a62:1412:0:b029:1ec:bc11:31fd with SMTP id
 18-20020a6214120000b02901ecbc1131fdmr4691213pfu.76.1614283242144; Thu, 25 Feb
 2021 12:00:42 -0800 (PST)
MIME-Version: 1.0
References: <20210225143456.3829513-1-arnd@kernel.org>
In-Reply-To: <20210225143456.3829513-1-arnd@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 26 Feb 2021 05:00:05 +0900
X-Gmail-Original-Message-ID: <CAK7LNASE8vgFTgBiYiDJvfi1J1kxtLjkMLgTxXSLPJCvLYn4UA@mail.gmail.com>
Message-ID: <CAK7LNASE8vgFTgBiYiDJvfi1J1kxtLjkMLgTxXSLPJCvLYn4UA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: lto: add _mcount to list of used symbols
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 11:35 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Some randconfig builds fail with undefined references to _mcount
> when CONFIG_TRIM_UNUSED_KSYMS is set:
>
> ERROR: modpost: "_mcount" [drivers/tee/optee/optee.ko] undefined!
> ERROR: modpost: "_mcount" [drivers/fsi/fsi-occ.ko] undefined!
> ERROR: modpost: "_mcount" [drivers/fpga/dfl-pci.ko] undefined!
>
> Since there is already a list of symbols that get generated at link
> time, add this one as well.
>
> Fixes: fbe078d397b4 ("kbuild: lto: add a default list of used symbols")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  scripts/lto-used-symbollist.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/lto-used-symbollist.txt b/scripts/lto-used-symbollist.txt
> index 38e7bb9ebaae..406ada65e926 100644
> --- a/scripts/lto-used-symbollist.txt
> +++ b/scripts/lto-used-symbollist.txt
> @@ -1,5 +1,6 @@
>  memcpy
>  memmove
>  memset
> +_mcount
>  __stack_chk_fail
>  __stack_chk_guard
> --
> 2.29.2
>


Applied to linux-kbuild/fixes. Thanks.



-- 
Best Regards
Masahiro Yamada
