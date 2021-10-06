Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF7CE423731
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 06:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhJFEre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 00:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbhJFErd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 00:47:33 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A0DC061753
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 21:45:42 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id a73so1410058pge.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 21:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=quxNMOpbZ24MOq3KZoHOOn2yobNmyLXsT3D28csEkrA=;
        b=YRE/jdD2nYQgI4h4Yk7HNHaVl9XRgi6izcHOr5AJu7TPFjGNIK7e+z2Kdd90LW7Ekp
         reHJl1TBJZDHk89OeWYo3J3rRzSOeXd0QvcRO6AgKEbvT5RQPzjpMjYmenTguHRQczu7
         9xabq9VgqQY2nBCStWAmAI3miJDxTJREtcZGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=quxNMOpbZ24MOq3KZoHOOn2yobNmyLXsT3D28csEkrA=;
        b=o17APe9pKaqSSH+TatMzE3m+fR6VLuuCwIbhl/NidUa3tGiDbwqoprWUHtEm66xnLs
         IvqxZHotGdRVbL/qsiEbQCaC7veckFf4st21iyDmu9mHWC5sEaDar4cAJuxrlwgq5hOy
         z2R4ZDu0AqVLdyxQHOtkIUd8a48rMqJDoGoBZ0ZI/SaiJ3tKAxMQgjYuLzTKpujb2lpA
         9rIkVGmFaI7AaMrcjFJpaVoJjuvL4psFdPhfaYHir9kQypyqEygAG8GtPSxOxIei29+b
         X7l3JdGIEdpTTGAjK+o0bhDBQkvsq+UbfwLQkMhZk9w2G32rFeWGCgV/jDql9i7e/yAB
         DQQg==
X-Gm-Message-State: AOAM532FzxI45ToD0BCEMXQJ8BpVzPGm5UGY3pMz7RvG8l9SydAW4crM
        HJXdY9Gm6nrj1Stp3Gx95aXF9A==
X-Google-Smtp-Source: ABdhPJyZOnpykJxNG6K62ilDOaaSr5RnIEprCosrgWRRuMvHvONvOL87uxmFNVQ9silawNWqunsSYQ==
X-Received: by 2002:a63:590e:: with SMTP id n14mr18571231pgb.434.1633495541757;
        Tue, 05 Oct 2021 21:45:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s37sm10837282pfg.44.2021.10.05.21.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 21:45:41 -0700 (PDT)
Date:   Tue, 5 Oct 2021 21:45:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Nicolas Schier <n.schier@avm.de>, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] sparc: Add missing "FORCE" target when using if_changed
Message-ID: <202110052144.25B30F2D4F@keescook>
References: <20210923215418.3936726-1-keescook@chromium.org>
 <YU1WYLN4eptJhuIX@deb-nschier.ads.avm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YU1WYLN4eptJhuIX@deb-nschier.ads.avm.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 06:38:56AM +0200, Nicolas Schier wrote:
> On Thu, Sep 23, 2021 at 02:54:18PM -0700, Kees Cook wrote:
> > Fix observed warning:
> > 
> >     /builds/linux/arch/sparc/boot/Makefile:35: FORCE prerequisite is missing
> > 
> > Fixes: e1f86d7b4b2a5213 ("kbuild: warn if FORCE is missing for if_changed(_dep,_rule) and filechk")
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > Cc: sparclinux@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Acked-by: Nicolas Schier <n.schier@avm.de>

Thanks!

Masahiro, are you able to add this to your kbuild tree?

-Kees

> 
> > ---
> > I'm not sure if this should go via sparc or via kbuild. :)
> > ---
> >  arch/sparc/boot/Makefile | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/sparc/boot/Makefile b/arch/sparc/boot/Makefile
> > index 849236d4eca4..45e5c76d449e 100644
> > --- a/arch/sparc/boot/Makefile
> > +++ b/arch/sparc/boot/Makefile
> > @@ -22,7 +22,7 @@ ifeq ($(CONFIG_SPARC64),y)
> >  
> >  # Actual linking
> >  
> > -$(obj)/zImage: $(obj)/image
> > +$(obj)/zImage: $(obj)/image FORCE
> >  	$(call if_changed,gzip)
> >  	@echo '  kernel: $@ is ready'
> >  
> > @@ -31,7 +31,7 @@ $(obj)/vmlinux.aout: vmlinux FORCE
> >  	@echo '  kernel: $@ is ready'
> >  else
> >  
> > -$(obj)/zImage: $(obj)/image
> > +$(obj)/zImage: $(obj)/image FORCE
> >  	$(call if_changed,strip)
> >  	@echo '  kernel: $@ is ready'
> >  
> > @@ -44,7 +44,7 @@ OBJCOPYFLAGS_image.bin := -S -O binary -R .note -R .comment
> >  $(obj)/image.bin: $(obj)/image FORCE
> >  	$(call if_changed,objcopy)
> >  
> > -$(obj)/image.gz: $(obj)/image.bin
> > +$(obj)/image.gz: $(obj)/image.bin FORCE
> >  	$(call if_changed,gzip)
> >  
> >  UIMAGE_LOADADDR = $(CONFIG_UBOOT_LOAD_ADDR)
> > @@ -56,7 +56,7 @@ quiet_cmd_uimage.o = UIMAGE.O $@
> >                       -r -b binary $@ -o $@.o
> >  
> >  targets += uImage
> > -$(obj)/uImage: $(obj)/image.gz
> > +$(obj)/uImage: $(obj)/image.gz FORCE
> >  	$(call if_changed,uimage)
> >  	$(call if_changed,uimage.o)
> >  	@echo '  Image $@ is ready'
> > -- 
> > 2.30.2
> > 

-- 
Kees Cook
