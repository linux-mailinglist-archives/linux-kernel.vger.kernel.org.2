Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB273F1396
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 08:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbhHSGcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 02:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbhHSGcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 02:32:52 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245B4C061575
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 23:32:17 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id nt11so4282624pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 23:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5dAjMEOi1u5hcGe7TyoRwNUw/I8hhdTgfzLeFcN4Q8o=;
        b=KqmpKHQRcCzunFkJgijQHZkIJ4JIL/IdZDwlGxxEpu/SpC72hIUu7EHorZp28qzuPj
         UGHb+ts9oyhH28rO0hWMJSFZsU8WCkODH51xgUHZJhGyBJ+V9erized3H7gY6x4d4E4J
         WQ0q4DYwVSgl4v5SUbFeww4VYnZwS9CyPEISI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5dAjMEOi1u5hcGe7TyoRwNUw/I8hhdTgfzLeFcN4Q8o=;
        b=ERr48Rz8FTbZ6L0sUWHi7gR0dSohBq+ZW8O0IrDTEkIaW89Ptw+VfcZpzWGWyo6HBg
         K55nytnpx2H53vgN7coZ0j1zhxY4hMcNsmOqGpxoz6/AughP1MfSMoD7Bko41c9s494K
         erKwv5tXCfjaOvaqmZi0ykz6P7sitXHOMXEO7tTA4+D+TKqgVom+a6on4Es/QGbdZwVv
         zR4TML8RjrLOKZLAlxDx7xG6B2k721KEf38GrToVL86llSCHstodw8Jy1eruQQrLygld
         MONsPbyiMj2CS0+gDX9Yakm1AmA1dWuYDPnuoKir+S8lu6dufc0RSe2i6wRwmQdjgO31
         IENA==
X-Gm-Message-State: AOAM533iz4cResCT/8SDGWKnrJz30iIZnJkq+AuVF2D/542RxF6tFpRt
        3m/NCVrE+tL6vlEtB/qFDEpQhg==
X-Google-Smtp-Source: ABdhPJwKJS/uO09vlswMJG+Z0q+TpTEyZ5QVAn9QjYiKntsrleHXbQ3FhRvyK5yp0MWHH3TPk3d+Mw==
X-Received: by 2002:a17:902:a5c5:b029:12c:9108:d83 with SMTP id t5-20020a170902a5c5b029012c91080d83mr10537901plq.33.1629354736716;
        Wed, 18 Aug 2021 23:32:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n185sm2046693pfn.171.2021.08.18.23.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 23:32:15 -0700 (PDT)
Date:   Wed, 18 Aug 2021 23:32:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 07/13] kbuild: do not remove 'linux' link in
 scripts/link-vmlinux.sh
Message-ID: <202108182331.70B390B@keescook>
References: <20210819005744.644908-1-masahiroy@kernel.org>
 <20210819005744.644908-8-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819005744.644908-8-masahiroy@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 09:57:38AM +0900, Masahiro Yamada wrote:
> arch/um/Makefile passes the -f option to the ln command:
> 
>     $(Q)ln -f $< $@
> 
> So, the hard link is always re-created, and the old one is removed
> anyway.

Hah, yeah, that's a bit of ARCH=um redundancy.

Reviewed-by: Kees Cook <keescook@chromium.org>

> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  scripts/link-vmlinux.sh | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index a6c4d0bce3ba..7b9c62e4d54a 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -206,7 +206,6 @@ vmlinux_link()
>  			-Wl,-T,${lds}				\
>  			${objects}				\
>  			-lutil -lrt -lpthread
> -		rm -f linux
>  	fi
>  }
>  
> -- 
> 2.30.2
> 

-- 
Kees Cook
