Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C02C420614
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 08:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbhJDGzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 02:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbhJDGzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 02:55:47 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FBFC061745
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 23:53:58 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id k21-20020a05600c0b5500b0030d6ac87a80so1335457wmr.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 23:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=1+yRLUnhpmaWWCNXpDEKrZP3K3a7LQ8nn1GLZE5//Ao=;
        b=pn5sO0H8oitatRvO+y7mqvbbiJu9juKT7Tr63ThTuogaIpS/2BvI4YRBuabb3k32XE
         0B8R0Cxh1AHhlKcqi0v4AWxrarUXw1l5PdJFIzQUu4aN3UNbis3sppJfPwavUtrrteo/
         Q7T/DVv6/l3+Vrx4kon5g5Fwi0Qq0uB7x7ZwpGLIu6Sijdn7tOgPqD1GuaOZass+5Tb7
         8mb8SXJQj05iBQke4VtLACXs1JnHw7KFJEmRB4KvLnkJplkvxAaoMhvA2SGyprTaI+WE
         pnNAoMmZbCx5sV4Xn3tI8YvzE4dgoG3UFrwet5S9OWNYEiLCkJnmL8QZX/Vxvrxvpj76
         6wGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1+yRLUnhpmaWWCNXpDEKrZP3K3a7LQ8nn1GLZE5//Ao=;
        b=UhS6bFpzcPjWwCbIcNvtZZDx2oT7TogbUBIhXpNqMDIuVKdDwQOA6DbcI4KVNIa0dx
         RkRlJtmgYhVR2smVSRKOo1YjkXj0Pc9N4Vab3yOYO6k7kCrx+ei3+T9EMemFKEqLbin9
         vNCz/szx5pQPZnwKZGtWYCB8oVhvw271Vq9Q/y4j2onnwbM1lrIU2tviLoxqy4KVnDTi
         sSdnKmaFZDE+DXmluYXnuDugAgBOIoZFH5csCPVb90CzIAtafbtWX2dCN8nYRC15Zx1O
         0FLDqZCkY/axOcGmy1+t9MOEQKVPYHzQQqxCiMpU1zOokZsmPik5le1l2y2U3pLiYK19
         /stA==
X-Gm-Message-State: AOAM5300JEMin7WClzCUBirVOmINQAk+FZmIfGFnna4a1vnbLLlgiu59
        yFa5HpxYqnW1mcGySwIHhVScMoeAnm02DA==
X-Google-Smtp-Source: ABdhPJwZH7GttjJpcT/NmFyoTSqcgrydFrv2EXfKcGlzVYc1qOYGHKBjqHkanfK5K+FzPGI9xZ26lQ==
X-Received: by 2002:a1c:a914:: with SMTP id s20mr8071511wme.6.1633330437133;
        Sun, 03 Oct 2021 23:53:57 -0700 (PDT)
Received: from google.com ([95.148.6.233])
        by smtp.gmail.com with ESMTPSA id h18sm13154634wrs.75.2021.10.03.23.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 23:53:56 -0700 (PDT)
Date:   Mon, 4 Oct 2021 07:53:54 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Orlando Chamberlain <redecorating@protonmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3] mfd: intel-lpss: Add support for MacBookPro16,2 ICL-N
 UART
Message-ID: <YVqlAsb1127/KXnb@google.com>
References: <20211001084905.4133-1-redecorating@protonmail.com>
 <YVbf9J3jgAmBY+ch@smile.fi.intel.com>
 <YVdP9PwNrjmKxKac@google.com>
 <YVdR4bdpr9/E+GNf@smile.fi.intel.com>
 <20211002032810.3729-1-redecorating@protonmail.com>
 <YVg8vsdU89wjC9/7@smile.fi.intel.com>
 <20211002111221.1c3076f3@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211002111221.1c3076f3@localhost>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 02 Oct 2021, Orlando Chamberlain wrote:

> On Sat, 02 Oct 2021 21:04:30 +1000
> "Andy Shevchenko" <andriy.shevchenko@linux.intel.com> wrote:
> 
> > You ignoring my Reviewed-by tag. Any reason why?
> 
> Sorry, I'm new to this and assumed it needed to be reviewed again after
> any changes (including to the commit message).
> 
> > Besides that you are posting patches as continuation of the thread.
> > It may be problematic for some tools, like `b4`, although I dunno if
> > Lee is using such tools.
> 
> I'll make a v4 with the reviewed-by line. I'll make it a reply to the
> first version of the patch, and hopefully that'll be the first place
> tools like `b4` look.

You only need to add the *-by lines to *new* submissions.

Please don't submit new versions just to add *-by lines.

`b4` doesn't support replied-to patch-sets, so even replying-to the
very first submission/version won't help here.  Submissions need to be
completely separate.

FWIW: As it happens, I do use `b4`, but I don't use the auto-apply-set
functionality.  I either apply patches individually or select (tag)
the ones I wish to apply, so I do not suffer from this problem like
some others do.

> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > > Signed-off-by: Orlando Chamberlain <redecorating@protonmail.com>
> > > ---
> > > v2->v3: Mention "ICL-N" in commit message.
> > >  drivers/mfd/intel-lpss-pci.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/mfd/intel-lpss-pci.c
> > > b/drivers/mfd/intel-lpss-pci.c index c54d19fb184c..a872b4485eac
> > > 100644 --- a/drivers/mfd/intel-lpss-pci.c
> > > +++ b/drivers/mfd/intel-lpss-pci.c
> > > @@ -253,6 +253,8 @@ static const struct pci_device_id
> > > intel_lpss_pci_ids[] = { { PCI_VDEVICE(INTEL, 0x34ea),
> > > (kernel_ulong_t)&bxt_i2c_info }, { PCI_VDEVICE(INTEL, 0x34eb),
> > > (kernel_ulong_t)&bxt_i2c_info }, { PCI_VDEVICE(INTEL, 0x34fb),
> > > (kernel_ulong_t)&spt_info },
> > > +	/* ICL-N */
> > > +	{ PCI_VDEVICE(INTEL, 0x38a8),
> > > (kernel_ulong_t)&bxt_uart_info }, /* TGL-H */
> > >  	{ PCI_VDEVICE(INTEL, 0x43a7),
> > > (kernel_ulong_t)&bxt_uart_info }, { PCI_VDEVICE(INTEL, 0x43a8),
> > > (kernel_ulong_t)&bxt_uart_info }, --
> > > 2.33.0
> > >
> > >  
> > 
> 
> 
> 

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
