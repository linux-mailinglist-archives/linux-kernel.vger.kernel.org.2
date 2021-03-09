Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85029332BE5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 17:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhCIQX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 11:23:57 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:20316 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbhCIQXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 11:23:41 -0500
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 129GNJBx005049
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 01:23:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 129GNJBx005049
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1615307000;
        bh=TIFH9xhkHj6kVADAbgz3gFzBFF7nUnImlAibwle3Rlw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sxoWG3sPUUzPXU5AWoWQkqazsyuG5RbdRcBckLvrjPmcYgDJPWuaqMg1e2zVVs14t
         sCmZ2yGfg4+YHq+DXAjLeTSC4pfLGMo+FKy3HEDSfVyWyR9goYAcD3DXOlQZ+i00Xs
         Q8oV6VhArhlAL81akg4gxXI7AlJhJCzb1ueJDG87kRzW748nWjtBr3t5C4XwNxLkWF
         IQ6TeKnccOMqxDhwgWlRA7j+qcJqn8hTU6LRIg7ibrf62QrBAl5s+2dE+ZSVTOWVCJ
         xEV3djw7Q3jNhUcxVKTisK+fHqOltNPvQgCEjaIf2Ka1TyVUDRuXdcXffD9A7Rzrwm
         5z80PREm1dWHQ==
X-Nifty-SrcIP: [209.85.216.43]
Received: by mail-pj1-f43.google.com with SMTP id j14-20020a17090a588eb02900cefe2daa2cso1013523pji.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 08:23:20 -0800 (PST)
X-Gm-Message-State: AOAM533ptgROdGdaxV2+Z3G/OuiZz52HeXR3abPAuNchJrA6Xn7fNEgn
        /ZshOaL5R4p4XbY6n62fej4G5qVR2I6vEkLZDDY=
X-Google-Smtp-Source: ABdhPJzWxQTmDwEHhiQi40DG9dzcIe0x2DGuxcT8g1h24Crz0e/hZbsD1YYGYVgKjCLtL1R0DWmcaPj0Lk9ksjH07Pc=
X-Received: by 2002:a17:90a:dc08:: with SMTP id i8mr5248101pjv.153.1615306999242;
 Tue, 09 Mar 2021 08:23:19 -0800 (PST)
MIME-Version: 1.0
References: <20210308062820.6166-1-jslaby@suse.cz>
In-Reply-To: <20210308062820.6166-1-jslaby@suse.cz>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 10 Mar 2021 01:22:42 +0900
X-Gmail-Original-Message-ID: <CAK7LNATFvqyzbrVv6X7ooTLqb++35GFT=OtXivRXnQngpa8Wxw@mail.gmail.com>
Message-ID: <CAK7LNATFvqyzbrVv6X7ooTLqb++35GFT=OtXivRXnQngpa8Wxw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: dummy-tools, support MPROFILE_KERNEL checks for ppc
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 8, 2021 at 3:28 PM Jiri Slaby <jslaby@suse.cz> wrote:
>
> ppc64le checks for -mprofile-kernel to define MPROFILE_KERNEL Kconfig.
> Kconfig calls arch/powerpc/tools/gcc-check-mprofile-kernel.sh for that
> purpose. This script performs two checks:
> 1) build with -mprofile-kernel should contain "_mcount"
> 2) build with -mprofile-kernel with a function marked as "notrace"
>    should not produce "_mcount"
>
> So support this in dummy-tools' gcc, so that we have MPROFILE_KERNEL
> always true.
>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Masahiro Yamada <masahiroy@kernel.org>

Applied to linux-kbuild/fixes. Thanks.


> ---
>  scripts/dummy-tools/gcc | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/scripts/dummy-tools/gcc b/scripts/dummy-tools/gcc
> index 0d0589cf8184..7b10332b23ba 100755
> --- a/scripts/dummy-tools/gcc
> +++ b/scripts/dummy-tools/gcc
> @@ -73,6 +73,15 @@ if arg_contain -S "$@"; then
>                 echo "%gs"
>                 exit 0
>         fi
> +
> +       # For arch/powerpc/tools/gcc-check-mprofile-kernel.sh
> +       if arg_contain -m64 "$@" && arg_contain -mlittle-endian "$@" &&
> +               arg_contain -mprofile-kernel "$@"; then
> +               if ! test -t 0 && ! grep -q notrace; then
> +                       echo "_mcount"
> +               fi
> +               exit 0
> +       fi
>  fi
>
>  # To set GCC_PLUGINS
> --
> 2.30.1
>



-- 
Best Regards
Masahiro Yamada
