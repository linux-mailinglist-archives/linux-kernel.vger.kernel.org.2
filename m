Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1192A3CCD26
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 06:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbhGSElU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 00:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbhGSElQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 00:41:16 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36D1C061762
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 21:38:16 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id i16so219936pgi.9
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 21:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nRiPjpHg8p/fI+JBr5UGxn/81/0ZwiuSlfZGEmNldAM=;
        b=fLdEDtA6uh3yfIM/JL1hdXhuMOh8XsGkXWhbuiRJMzjwf76dgBOJV4APlr/5Giy5gY
         ZhSMYctYE+RbXvrnESdksrVYx2Z1AUQWiXBc6u5ov721th1+drCFo0PyYerMBcQiIhLZ
         K9P571JObcfRRaGQ8ZcMm9ldqkURJJ7WRsOF62euZ2WSmo5hQfk5jrYqjxslKG+AWjSn
         yWJ7U491Gs7dkbHo3gY/KNEc7kW66cO/wU2XaYXNN1QCNh4TN/2uUWK6aXeoKLnUDITJ
         9BdN0X2wcSxG/C1vMgNCK44ECdkqIUhREyYAorRQC66OgymqS9AhGzX5lTobV5oHNs65
         AAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nRiPjpHg8p/fI+JBr5UGxn/81/0ZwiuSlfZGEmNldAM=;
        b=RMdK1H1QsLNUHj9TaHHci2HyVHsQm/hgGRSR3kdpbiarPy1yCo5jpkZhgjeJpQtmgb
         +xcQQtrP4ORb+NPGOLCwTAr+Y/iaUt/O0+D38xArQ+nBYnZfZuIOlp/6GulkrIhtPevw
         fr47xTZ1uCKxpbyxtaGtcYlIxcEgo/inEjrrDI4Z9sZU1Fxiavf97DgEZFgOFSxlsMzG
         03vZ0WZj+IzZp1cLTt3kKTSmxR+oienQcJT/T2eS17AgD48YtDHKIWqQvN1SOPCoBrOT
         YkyzqkaV8xH0ElHrbtmFU+tkvIZHkDeGg5OiteiXwoqk+LofY5Okl12qzyPnoWti2dPC
         8otg==
X-Gm-Message-State: AOAM532kl1kaSzDiwyBvh+LfoVmgWVrBtrcK3QaDFdkuXkRlwxNAlv6h
        F8jWWyGijv3XPEbcL+0chiI=
X-Google-Smtp-Source: ABdhPJzlcLQwXaGWEF3q8oEEpv1Sb+88fgtObzKglj42hW5K06OZ0OaO77yQhbPswNPIUCeq9lwfAA==
X-Received: by 2002:a63:5809:: with SMTP id m9mr7460587pgb.342.1626669496154;
        Sun, 18 Jul 2021 21:38:16 -0700 (PDT)
Received: from localhost (g142.61-125-55.ppp.wakwak.ne.jp. [61.125.55.142])
        by smtp.gmail.com with ESMTPSA id e30sm20659037pga.63.2021.07.18.21.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 21:38:15 -0700 (PDT)
Date:   Mon, 19 Jul 2021 13:38:13 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Subject: Re: [PATCH] openrisc: don't printk() unconditionally
Message-ID: <YPUBtf2OvD9Y017n@antec>
References: <20210719023309.15808-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719023309.15808-1-rdunlap@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 18, 2021 at 07:33:09PM -0700, Randy Dunlap wrote:
> Don't call printk() when CONFIG_PRINTK is not set.
> Fixes the following build errors:
> 
> or1k-linux-ld: arch/openrisc/kernel/entry.o: in function `_external_irq_handler':
> (.text+0x804): undefined reference to `printk'
> (.text+0x804): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `printk'
> 
> Fixes: 9d02a4283e9c ("OpenRISC: Boot code")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Thanks!

This looks OK to me, I will queue it for 5.15 unless anyone thinks it should go
in now.

-Stafford

> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: openrisc@lists.librecores.org
> ---
>  arch/openrisc/kernel/entry.S |    2 ++
>  1 file changed, 2 insertions(+)
> 
> --- linux-next-20210716.orig/arch/openrisc/kernel/entry.S
> +++ linux-next-20210716/arch/openrisc/kernel/entry.S
> @@ -547,6 +547,7 @@ EXCEPTION_ENTRY(_external_irq_handler)
>  	l.bnf	1f			// ext irq enabled, all ok.
>  	l.nop
>  
> +#ifdef CONFIG_PRINTK
>  	l.addi  r1,r1,-0x8
>  	l.movhi r3,hi(42f)
>  	l.ori	r3,r3,lo(42f)
> @@ -560,6 +561,7 @@ EXCEPTION_ENTRY(_external_irq_handler)
>  		.string "\n\rESR interrupt bug: in _external_irq_handler (ESR %x)\n\r"
>  		.align 4
>  	.previous
> +#endif
>  
>  	l.ori	r4,r4,SPR_SR_IEE	// fix the bug
>  //	l.sw	PT_SR(r1),r4
