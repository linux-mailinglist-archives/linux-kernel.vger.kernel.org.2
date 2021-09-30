Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C057041E37C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 23:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236840AbhI3VvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 17:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhI3VvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 17:51:16 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F3CC06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 14:49:33 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id l8so27679545edw.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 14:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FEOblmC0YUCEiWaIMk7PSN1i7kz3y2CTmP64nyEY6xY=;
        b=UmuryMZoRAKJ59bKvenZZV8El+IqNmrMKDsWe8MMB9yQVbNNgL88EtSJdjAIejm9oO
         kbZLkx0Vl9iz2zX2HfwHdt7Aym/qI3bkHAl47BI3na90LyXPYLgSKiCnWfk32Dto8hwn
         tlWDXHKG+Q2cc/I2KATh47GJBWsp/XxlHsR//1U2WPkmQ0OrUraQvsR/RH8M0mFGOvHH
         Dd++xJdH+UmFuEzyuaqiVgNQ8vKxRuMClZxlsfc7ZNNi2611CxKWKT5Xg/Rd3mPkGwwU
         7C3D1VZSE51gM9ovSxmuji4D2bWPABK093UM93vUb+aEHV7BhdHPbI/mJ1oa90N/x7W7
         pTMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FEOblmC0YUCEiWaIMk7PSN1i7kz3y2CTmP64nyEY6xY=;
        b=7SOLm4qEQgKrCREZnQQHej6hglWA9wdRfokf8xs1P+gh0sgKtUwBtGnOmIuUzbwS1f
         XhFDnp2DhE+uk1wC3FJ1CjGm3R+JcnZbme7bGsexjKdxT0cK6YKsnp0BXnfjpUMqgwGM
         nC4PdsRhlDxuxSpF8z0A0NdRfip6bIth5IwZ0eofUr5CemLNDMH2sQDvc83L+hN+GESw
         wqESHBKCjO4tNBzTgm5wCb/FjCAb77kiv6L5DhHsov2Ddrb1egmth/3cxsYpGpJQSwdu
         fSGUn/RNZhBjdddJXCqwH+XprUTiNa63VkTUb7fcVx4wm5JNkHk1/nKQk4UACGLowQ58
         0tCA==
X-Gm-Message-State: AOAM533Ajb1NXnmoY5wB66nqBxBALZ5QGyUJRkOAZKllFlKXcO5tsdMy
        cN7MK3bPzYtFD0fwHlrXZGtQkwN3xRc=
X-Google-Smtp-Source: ABdhPJxEAUFLydNFx3P6tcdpsrekpJIwuSj1IYXnvIlRWEsyYFpSx2DC+9KuyUFAUad0bIuxOCEA5A==
X-Received: by 2002:a17:906:3693:: with SMTP id a19mr1902627ejc.237.1633038571983;
        Thu, 30 Sep 2021 14:49:31 -0700 (PDT)
Received: from tom-desktop (net-5-94-68-71.cust.vodafonedsl.it. [5.94.68.71])
        by smtp.gmail.com with ESMTPSA id p15sm2149853edy.67.2021.09.30.14.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 14:49:31 -0700 (PDT)
Date:   Thu, 30 Sep 2021 23:49:29 +0200
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        Yujia Qiao <rapiz@foxmail.com>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Marcos Antonio de Jesus Filho <mdejesusfilho@gmail.com>,
        Aldas =?utf-8?B?VGFyYcWha2V2acSNaXVz?= <aldas60@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] staging: vt6655: fix camelcase in bShortSlotTime
Message-ID: <20210930214929.GB45822@tom-desktop>
References: <20210926162527.21462-1-tomm.merciai@gmail.com>
 <20210926162527.21462-2-tomm.merciai@gmail.com>
 <YVHilhCk3cgGhXrZ@kroah.com>
 <20210927213515.GA6953@tom-desktop>
 <YVKdVCaVwmPG7DVx@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVKdVCaVwmPG7DVx@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 06:43:00AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Sep 27, 2021 at 11:35:15PM +0200, Tommaso Merciai wrote:
> > On Mon, Sep 27, 2021 at 05:26:14PM +0200, Greg Kroah-Hartman wrote:
> > > On Sun, Sep 26, 2021 at 06:25:18PM +0200, Tommaso Merciai wrote:
> > > > Replace camel case variable bShortSlotTime with snake case
> > > > variable b_short_slot_time.
> > > 
> > > That is a very odd variable name.  Why did you pick that one?
> > > 
> > > What deos it mean?
> > > 
> > > You do understand where the original naming format came from here, and
> > > what it was trying to represent, right?  If not, please go read up on
> > > it:
> > > 	https://en.wikipedia.org/wiki/Hungarian_notation
> > > 
> > > That style is not used in Linux, and so, when converting from it, do not
> > > attempt to keep the same style present here, that is kind of pointless,
> > > don't you agree?
> > 
> >   You are definitely right. What do you think about "short_slot_time"?
> 
> "time" implies that this will hold a value of time, right?
> 
> What exactly does this variable do?  That might help in naming it
> better.

  Is a boolean variable, if true short slot time mode is enabled, false 
  not right?
  A good solution could be: "short_slot_mode"? What do you think about?

  thanks,
  tommaso

> 
> thanks,
> 
> greg k-h
