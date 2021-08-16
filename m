Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 223453ED7C9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 15:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237649AbhHPNnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 09:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237600AbhHPNni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 09:43:38 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F02C077B54
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 06:33:32 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h13so23726916wrp.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 06:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=mZFg4xEN3Bxhc0hUWQKABU041LJFnqWbJu4YrSNKR7w=;
        b=AnmI6+P/ZIIlH7o0KaSk/b+Dpr/NS2SOnfJ9FiwQ1nJFwJbm/bA4LOlsFoy6sSv8pG
         Pt5+zAAQPVFAEl/ZR8NvhFinTcoRgkM5H1NhA7eETZKjQqeNTo839BJQWuNrAAToM/mD
         vxEvJiIvrLtfE+O6/5Ului1L1KjUhMyRVZQVx28M+nS3bkHhb8/jyAzbUpVDT+SUq50r
         3g8ihz3T+VCOQ/+O/GDLTIbrVklwV178Kj6+bS+cilDyUsQF6BLeoOhs+Z9gvhGxsRyj
         ufqAl3nNbXIQiq8o3r9MdfOYbB2ybBiemd4dX487bOA2QyGCShkGANVgI/PHE+jnarJM
         NJBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mZFg4xEN3Bxhc0hUWQKABU041LJFnqWbJu4YrSNKR7w=;
        b=H4ai9Vy/nIhgUBafAo9euaoE2IOkK6AUckfI2sbPHuHE01ecH0RdkoQP1QEDSpctbz
         5BC49otT4pfX7nnSkEo8QYPz1HQKVSigBWZUnuGgIy+Qle55am/7QcxmL/d7VZQtuPZZ
         Rmb+PrjV6GGiVpiXp3peE46LrryVeCygAc+b1VhracYYBJSYvoer6DnbDHKUpUsXaM0i
         o4ajfb80dIdz6mHYPRlsMPnzQiJhtiN90bqbVJFjuBFqOojL5BdHXGG12+VOqWF4O4JU
         b5EBlRcwNiNw+bbkRNgit38Wnq8NU5zCqEt3xc2CH35XjjMSW9KiWxtYhXc2IGsIxC0z
         fsrw==
X-Gm-Message-State: AOAM5336U/EUxHluWsJGIWdsXpZtPq4X2f2V6UppL99Q8pv3CLCni3qx
        lwgGwxFK4yNisfCP33ZiEXXyBA==
X-Google-Smtp-Source: ABdhPJxhP6si53hvzcde8UfcYZRShfYYtrA+OlcdUQoeifyfNzAtOHpkX5O+H/nXCggbhWeaTlka0w==
X-Received: by 2002:adf:a3cc:: with SMTP id m12mr9987121wrb.97.1629120810815;
        Mon, 16 Aug 2021 06:33:30 -0700 (PDT)
Received: from google.com ([2.31.167.59])
        by smtp.gmail.com with ESMTPSA id y4sm10280669wmi.22.2021.08.16.06.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 06:33:30 -0700 (PDT)
Date:   Mon, 16 Aug 2021 14:33:28 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Hoan Tran <hoan@os.amperecomputing.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v1 3/4] mfd: intel_quark_i2c_gpio: Convert GPIO to use
 software nodes
Message-ID: <YRppKOxp4Jya5iEI@google.com>
References: <20210726125436.58685-1-andriy.shevchenko@linux.intel.com>
 <20210726125436.58685-3-andriy.shevchenko@linux.intel.com>
 <YRpihHP3kDz5nYV9@google.com>
 <CAHp75VdcWsNFervoU7e4_m7qVKAnWXzF2z2mUgKg06-qmwn-2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VdcWsNFervoU7e4_m7qVKAnWXzF2z2mUgKg06-qmwn-2A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Aug 2021, Andy Shevchenko wrote:

> On Mon, Aug 16, 2021 at 4:11 PM Lee Jones <lee.jones@linaro.org> wrote:
> > On Mon, 26 Jul 2021, Andy Shevchenko wrote:
> >
> > > The driver can provide a software node group instead of
> > > passing legacy platform data. This will allow to drop
> > > the legacy platform data structures along with unifying
> > > a child device driver to use same interface for all
> > > property providers, i.e. Device Tree, ACPI, and board files.
> > >
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > ---
> > >  drivers/mfd/intel_quark_i2c_gpio.c | 70 ++++++++++++++++--------------
> > >  1 file changed, 37 insertions(+), 33 deletions(-)
> >
> > Doesn't seem to want to apply.
> 
> Would it be okay for you to pull the immutable tag?

What immutable tag?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
