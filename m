Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6B9392963
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 10:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235369AbhE0IVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 04:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235169AbhE0IVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 04:21:45 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B46C061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 01:20:12 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id m18so3812824wrv.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 01:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=k6dbtL5w5RlvIzNdRNZ57xncbv8zTf6eZsZWwpPwI+s=;
        b=N3C2bnBjw80NU5FPpV5/z6CDkguDVnVaxmRqAT1yv0QBpTtgymbOI8mKrxd6SfT0Kf
         kTH69uffjIWp+vNPqxLr0t8M+Ir9hNDqkZlHkO0oM4SL/ICgUICX++lLr65KyYJpwPxI
         s97yZlgBOL+yOgSP5zjQBjaCT+KLQa4MxRMJwVV4PYktrMVXe/ckw/mrO8HeRlblclsh
         0lH3W1so7MtDQQFGff47judGgQznHh3YUql5femsXkjd/RanlWj/AH4mOxYq8o6IGSqV
         dxJBj347ITuK5cAxhao0B03+S02ItBIRoB7ScpOsORZnGnw5Q91R+7B381BjWoVCS/gM
         0tig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=k6dbtL5w5RlvIzNdRNZ57xncbv8zTf6eZsZWwpPwI+s=;
        b=YmBfkgc2NsPw6wSUDPqKEu4koucpqb5GDbKufFDZUJGwgG8VKR3czFueG/Q/7+Fmwp
         vFy7k3mS9yElmif94Vga0hhRefpPhB27Tya0ogzqO8XN/XE9vnq74IzSNgI9Tz6WFlfL
         KNqh1ux9MEXCrgp2wtli113BdkkOoFi5eycDnO9xjuzkBkZHNA9FK7vz38CuObnXxui6
         BFx5xoVgzlfXssFTXTMLlU/A8+jSKGOIyDmwbnCItGCtsvC2UVs4tu1d0ERfZ7m4gCnI
         WXnBpHovDrCt2JF4Cn5sq/cJ+//FCk0UJXH4P/TrrFAQEBn5Q5M6TPJMJGNo4iL+qmP4
         SuCA==
X-Gm-Message-State: AOAM533l4fgFUCY1MESSfLiPs4trtZFI4SyWbjSukauN7jCVdYJgVDXl
        MkoA7YR7UBhixLhBMckv0n3J80rBSEZAig==
X-Google-Smtp-Source: ABdhPJye39L96Brf0ldnY7+YWAJeCTjq69tHOAbuoGQ+zYBJi5Z7zCXQe4FP2prKjQ5vGlXXXnYEgA==
X-Received: by 2002:adf:db4e:: with SMTP id f14mr1972400wrj.48.1622103610807;
        Thu, 27 May 2021 01:20:10 -0700 (PDT)
Received: from dell ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id x10sm2036924wrt.65.2021.05.27.01.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 01:20:10 -0700 (PDT)
Date:   Thu, 27 May 2021 09:20:08 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Andrew J. Kroll" <ag784@freenet.buffalo.edu>,
        processes-Sapan Bhatia <sapan@corewars.org>
Subject: Re: [PATCH v2 1/1] tty: n_tty: Fix some misdocumented functions
Message-ID: <20210527082008.GG543307@dell>
References: <20210526083125.549626-1-lee.jones@linaro.org>
 <3c8f2e14-f0a7-409f-e17e-ff7d94b48566@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3c8f2e14-f0a7-409f-e17e-ff7d94b48566@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 May 2021, Jiri Slaby wrote:

> On 26. 05. 21, 10:31, Lee Jones wrote:
> > Fixes the following W=1 kernel build warning(s):
> > 
> >   drivers/tty/n_tty.c:623: warning: expecting prototype for process_echoes(). Prototype was for __process_echoes() instead
> >   drivers/tty/n_tty.c:1109: warning: expecting prototype for isig(). Prototype was for __isig() instead
> >   drivers/tty/n_tty.c:1268: warning: expecting prototype for n_tty_receive_char(). Prototype was for n_tty_receive_char_special() instead
> >   drivers/tty/n_tty.c:2132: warning: Excess function parameter 'buf' description in 'n_tty_read'
> > 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Jiri Slaby <jirislaby@kernel.org>
> > Cc: "Andrew J. Kroll" <ag784@freenet.buffalo.edu>
> > Cc: processes-Sapan Bhatia <sapan@corewars.org>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> > 
> > v2: Rebased
> > 
> >   drivers/tty/n_tty.c | 10 +++++-----
> >   1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
> > index 0ec93f1a61f5d..56d3b43d8a3a4 100644
> > --- a/drivers/tty/n_tty.c
> > +++ b/drivers/tty/n_tty.c
> ...
> > @@ -1248,7 +1248,7 @@ n_tty_receive_signal_char(struct tty_struct *tty, int signal, unsigned char c)
> >   }
> >   /**
> > - *	n_tty_receive_char	-	perform processing
> > + *	n_tty_receive_char_special	-	perform processing
> 
> No, please move the doc to the function in this case instead.

Oh, so this *really* is the doc for n_tty_receive_char()?

> >    *	@tty: terminal device
> >    *	@c: character
> >    *
> > @@ -2042,11 +2042,11 @@ static int job_control(struct tty_struct *tty, struct file *file)
> >   }
> > -/**
> > +/*
> 
> Why this?

Because the author has missed:

  void **cookie, unsigned long offset

Once these descriptions are provided, it can be re-promoted.

> >    *	n_tty_read		-	read function for tty
> >    *	@tty: tty device
> >    *	@file: file object
> > - *	@buf: userspace buffer pointer
> > + *	@kbuf: userspace buffer pointer
> >    *	@nr: size of I/O
> >    *
> >    *	Perform reads for the line discipline. We are guaranteed that the
> > 
> 
> thanks,

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
