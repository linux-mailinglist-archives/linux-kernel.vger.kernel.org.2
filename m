Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625B338D21E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 01:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbhEUXqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 19:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbhEUXqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 19:46:02 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8EEC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 16:44:38 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id f22so7677416pfn.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 16:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=54Yvrqwkkv9Pyf5QLd+bUzEhNlI0C7R+z0A7cK+JbqA=;
        b=IJlQnnsxbJ9lKPP0+jb909KBULxbZhIAxAYAt2m6YxcOUyCXsaECxNg7du1WVbInNI
         dred2T9s7og4KwopF9VAJBO2lseaR4ZwB1uwhVpu1vxSPvbEYH7DRmbRvlPG+IApVWE2
         ofzBoYBBk1lcQonLdAwrlf4QhtmuGcmJpCbAHpjnB9ymNBdSY6TDpCcBmsU2YdyekpXY
         /yg79jIbiJawH6vxTu2s2hSXcuPVwOpHBdWP4WX+Grmiz1jnx4Y3i4htnvN0AEKu5Gix
         StNIRwkwZN0jUh8EKmvs8rrfnyJckzRKG5T/VeDkdtPnxA8rtr/JfPT7L+94FwHHDb+X
         gBNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=54Yvrqwkkv9Pyf5QLd+bUzEhNlI0C7R+z0A7cK+JbqA=;
        b=Kr+lJ2bPH3dtCMyhJzFK0msKUP/YlviCXuS1/l2386GOMZ94p3cxXEEK6E+MV+E9Z6
         Pkxw4zhxyZEfSRTkwBUzcaUDxmnJ8pW/7Zx8DiKfzdOjDHTHWYcx9vseZFs73zTb6g3p
         PvTnzMpzxkL2RDbVS3LMTuz8udZexgpGH3jlZ4NZ8gBdz2t7UiqvGdhQwTXJ0Am961F7
         IuF1BK8uJcxxG2bGYKmsmJeWa9WpxMCEjrMe50z5GEYtIvCrdfGpCIJg0QR9DutzVcZM
         ZeLvSF8KVawRuWLZUpSeVpBD7Ef6y3caJHzQtOGKNEfk+5h4Py/JyfHhqIbgjsM4A4gj
         4TMQ==
X-Gm-Message-State: AOAM5320QBMNZtWr5tj0Suet1K0mTdrlbQrYHTFZSJ9wnIlZ2zzsO3FO
        yXYeM41ckNSNETUCP2unbqo=
X-Google-Smtp-Source: ABdhPJyy4BnljQo9Qo6tyC9SflNJSSoI15hg78Lsz8U+UqMCZQYx3KjgXJi59dT9sqntKgQfHJJ5JA==
X-Received: by 2002:a63:1d61:: with SMTP id d33mr1191261pgm.331.1621640678178;
        Fri, 21 May 2021 16:44:38 -0700 (PDT)
Received: from localhost (g1.222-224-229.ppp.wakwak.ne.jp. [222.224.229.1])
        by smtp.gmail.com with ESMTPSA id t12sm9491502pjw.57.2021.05.21.16.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 16:44:37 -0700 (PDT)
Date:   Sat, 22 May 2021 08:44:35 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Gabriel Somlo <gsomlo@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kgugala@antmicro.com,
        mholenko@antmicro.com, pczarnecki@internships.antmicro.com,
        davidgow@google.com, florent@enjoy-digital.fr, joel@jms.id.au
Subject: Re: [PATCH] drivers/soc/litex: remove 8-bit subregister option
Message-ID: <YKhF4x/vOTmGTnB9@antec>
References: <20210521183621.224260-1-gsomlo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521183621.224260-1-gsomlo@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 02:36:21PM -0400, Gabriel Somlo wrote:
> Since upstream LiteX recommends that Linux support be limited to
> designs configured with 32-bit CSR subregisters (see commit a2b71fde
> in upstream LiteX, https://github.com/enjoy-digital/litex), remove
> the option to select 8-bit subregisters, significantly reducing the
> complexity of LiteX CSR (MMIO register) accessor methods.
> 
> NOTE: for details on the underlying mechanics of LiteX CSR registers,
> see https://github.com/enjoy-digital/litex/wiki/CSR-Bus or the original
> LiteX accessors (litex/soc/software/include/hw/common.h in the upstream
> repository).
> 
> Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: Florent Kermarrec <florent@enjoy-digital.fr>
> Cc: Mateusz Holenko <mholenko@antmicro.com>
> Cc: Joel Stanley <joel@jms.id.au>
> 
> ---
>  drivers/soc/litex/Kconfig |  12 -----
>  include/linux/litex.h     | 100 +++++++-------------------------------
>  2 files changed, 17 insertions(+), 95 deletions(-)

...

>  static inline void litex_write64(void __iomem *reg, u64 val)
>  {
> -	_litex_set_reg(reg, sizeof(u64), val);
> +	_write_litex_subregister(val >> LITEX_SUBREG_SIZE_BIT, reg);
> +	_write_litex_subregister(val, reg + LITEX_SUBREG_ALIGN);
>  }

I wonder if it would be more clear to remove the macros and just write as:

static inline void litex_write64(void __iomem *reg, u64 val)
{
	_litex_set_reg(reg, sizeof(u64), val);
	_write_litex_subregister(val >> 32, reg);
	_write_litex_subregister(val, reg + 0x4);
}

>  static inline u8 litex_read8(void __iomem *reg)
>  {
> -	return _litex_get_reg(reg, sizeof(u8));
> +	return _read_litex_subregister(reg);
>  }
>  
>  static inline u16 litex_read16(void __iomem *reg)
>  {
> -	return _litex_get_reg(reg, sizeof(u16));
> +	return _read_litex_subregister(reg);
>  }
>  
>  static inline u32 litex_read32(void __iomem *reg)
>  {
> -	return _litex_get_reg(reg, sizeof(u32));
> +	return _read_litex_subregister(reg);
>  }
>  
>  static inline u64 litex_read64(void __iomem *reg)
>  {
> -	return _litex_get_reg(reg, sizeof(u64));
> +	return ((u64)_read_litex_subregister(reg) << LITEX_SUBREG_SIZE_BIT) |
> +		_read_litex_subregister(reg + LITEX_SUBREG_ALIGN);
>  }

Same here.

This all looks good to me.  Just a bit of style preference/question for
discussion, for me it's easier to read without the macro's but it just may be
me.  The macro's make sense when they could change, but now it's just something
to double check when reading the code.

Though they are used here in the init code which we could remove too now:

        pr_info("LiteX SoC Controller driver initialized: subreg:%d, align:%d",
                LITEX_SUBREG_SIZE, LITEX_SUBREG_ALIGN);


-Stafford

>  #endif /* _LINUX_LITEX_H */
> -- 
> 2.31.1
> 
