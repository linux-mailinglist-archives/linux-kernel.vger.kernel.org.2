Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B63839154E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 12:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234176AbhEZKtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 06:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234063AbhEZKtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 06:49:06 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB30FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 03:47:34 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id 124so449586qkh.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 03:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=exoErGopz9r9cmPj/pYTClm6/JTZ0qnY8Xv04MntANI=;
        b=HtZQ/bpZsETEJcs3hZ5U3xBUjslSxSDA5XLgGKcYpNKpwxKxHEBF6X54A5uhwprlbq
         ZME7cv4tAK4W0YLv6UhFO3vpsoopFR7WNbD7BJnHfWN1wX82F2ea0iRk7q/4QtY1nzBS
         74Dnj74ikMda+k7NSSlmUYuwVckorHM2wlIx3U+ZNC09A3RP5e3aYBFyNXyO3+uWgIfk
         gXUgr0KYzVSYwMqMzm8JhW0tkONUqFlBmK+5RuTI9QHxhPFmD5Zp+1oD1evn0ylyLILV
         KSNLXLssT0DGXXGgmqh0oPasqEOl/S71T3BtagDyboyDc8jAFvpwlkV5HUjvcUsXH1N3
         5oLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=exoErGopz9r9cmPj/pYTClm6/JTZ0qnY8Xv04MntANI=;
        b=G+CAJqR5IUCYLMinAPMh3ywwpS0EwqiIsXJy7xZeJwf2DvftokeBCLj30xz+TDDLRg
         qsk5KRKkxCTniLU+GVGzBpM9h9tp7kJINLUITDI3r/I7RCrD8fnFzh7o6qR+FCpiJccn
         wk4UVFhvA5s+brwvBCFb+S9tqFD8zkoJ4BAUht5y580t+hoobxkF7EJ4tIh81YUY26Vq
         ITRXg87wdLSY1VoYsKe4QmwgOeixKdZCFURyru7JT4/RjAQIhYDoY8N6JLuMJMuk7Q8z
         HkTMEmYsLDGH/J4Qsf2+7uzi/niYl9LT6E9j+Nola2Ya3eOBB7BIHDBxc7nzeru3+pfn
         fTPg==
X-Gm-Message-State: AOAM5330sKfP+JaI1TJxl4kAvzLUwRe8aQ/qP4dN9Tt6c8KIXZ/wpAH1
        s3Qh6Jv+mk1n2fjsg31YUyo=
X-Google-Smtp-Source: ABdhPJxyYsXpqATJqMsGypLpbQUz+iPDDWELGalSguhvQhCkFOCsWoxBCaoz/Xi74Z4TNPCtRBoChw==
X-Received: by 2002:a37:38d:: with SMTP id 135mr43048087qkd.136.1622026054097;
        Wed, 26 May 2021 03:47:34 -0700 (PDT)
Received: from errol.ini.cmu.edu (pool-108-39-255-32.pitbpa.fios.verizon.net. [108.39.255.32])
        by smtp.gmail.com with ESMTPSA id m10sm1241071qkk.113.2021.05.26.03.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 03:47:33 -0700 (PDT)
Date:   Wed, 26 May 2021 06:47:31 -0400
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Stafford Horne <shorne@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kgugala@antmicro.com,
        mholenko@antmicro.com, pczarnecki@internships.antmicro.com,
        davidgow@google.com, florent@enjoy-digital.fr, joel@jms.id.au
Subject: Re: [PATCH] drivers/soc/litex: remove 8-bit subregister option
Message-ID: <YK4nQ9lnJXrKAWSE@errol.ini.cmu.edu>
References: <20210521183621.224260-1-gsomlo@gmail.com>
 <YKhF4x/vOTmGTnB9@antec>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKhF4x/vOTmGTnB9@antec>
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 22, 2021 at 08:44:35AM +0900, Stafford Horne wrote:
> On Fri, May 21, 2021 at 02:36:21PM -0400, Gabriel Somlo wrote:
> > Since upstream LiteX recommends that Linux support be limited to
> > designs configured with 32-bit CSR subregisters (see commit a2b71fde
> > in upstream LiteX, https://github.com/enjoy-digital/litex), remove
> > the option to select 8-bit subregisters, significantly reducing the
> > complexity of LiteX CSR (MMIO register) accessor methods.
> > 
> > NOTE: for details on the underlying mechanics of LiteX CSR registers,
> > see https://github.com/enjoy-digital/litex/wiki/CSR-Bus or the original
> > LiteX accessors (litex/soc/software/include/hw/common.h in the upstream
> > repository).
> > 
> > Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> > Cc: Stafford Horne <shorne@gmail.com>
> > Cc: Florent Kermarrec <florent@enjoy-digital.fr>
> > Cc: Mateusz Holenko <mholenko@antmicro.com>
> > Cc: Joel Stanley <joel@jms.id.au>
> > 
> > ---
> >  drivers/soc/litex/Kconfig |  12 -----
> >  include/linux/litex.h     | 100 +++++++-------------------------------
> >  2 files changed, 17 insertions(+), 95 deletions(-)
> 
> ...
> 
> >  static inline void litex_write64(void __iomem *reg, u64 val)
> >  {
> > -	_litex_set_reg(reg, sizeof(u64), val);
> > +	_write_litex_subregister(val >> LITEX_SUBREG_SIZE_BIT, reg);
> > +	_write_litex_subregister(val, reg + LITEX_SUBREG_ALIGN);
> >  }
> 
> I wonder if it would be more clear to remove the macros and just write as:
> 
> static inline void litex_write64(void __iomem *reg, u64 val)
> {
> 	_litex_set_reg(reg, sizeof(u64), val);
> 	_write_litex_subregister(val >> 32, reg);
> 	_write_litex_subregister(val, reg + 0x4);
> }
> 
> >  static inline u8 litex_read8(void __iomem *reg)
> >  {
> > -	return _litex_get_reg(reg, sizeof(u8));
> > +	return _read_litex_subregister(reg);
> >  }
> >  
> >  static inline u16 litex_read16(void __iomem *reg)
> >  {
> > -	return _litex_get_reg(reg, sizeof(u16));
> > +	return _read_litex_subregister(reg);
> >  }
> >  
> >  static inline u32 litex_read32(void __iomem *reg)
> >  {
> > -	return _litex_get_reg(reg, sizeof(u32));
> > +	return _read_litex_subregister(reg);
> >  }
> >  
> >  static inline u64 litex_read64(void __iomem *reg)
> >  {
> > -	return _litex_get_reg(reg, sizeof(u64));
> > +	return ((u64)_read_litex_subregister(reg) << LITEX_SUBREG_SIZE_BIT) |
> > +		_read_litex_subregister(reg + LITEX_SUBREG_ALIGN);
> >  }
> 
> Same here.
> 
> This all looks good to me.  Just a bit of style preference/question for
> discussion, for me it's easier to read without the macro's but it just may be
> me.  The macro's make sense when they could change, but now it's just something
> to double check when reading the code.
> 
> Though they are used here in the init code which we could remove too now:
> 
>         pr_info("LiteX SoC Controller driver initialized: subreg:%d, align:%d",
>                 LITEX_SUBREG_SIZE, LITEX_SUBREG_ALIGN);

Since nobody else seems to have any strong feelings on the topic, I'll
just send out a v2 with the changes suggested above in a few minutes.

Thanks,
--Gabriel
