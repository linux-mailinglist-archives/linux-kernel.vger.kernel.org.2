Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC1242152E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 19:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbhJDRcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 13:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbhJDRcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 13:32:00 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8C6C061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 10:30:10 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id bm13so17573357edb.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 10:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uRZ0kluIbaQGUSF6giV2hb1heaS0871QoCZ1Ehr1pUg=;
        b=i7ceyLMc4pxpN/Zt2Quq8JjmaWLU9f+NZs0lDCxoTgMvKgMFVuRPSp0LWs06t9A+HW
         duI+Odjkzm0HYU1G2dxSECYG3lVKVr5uBNIAxvd/PFvvGAsqez74QBtgLVaRjEjvEyZr
         OSxWZ85eoPt9vqxZYZIrY/KjApVPPAYrsSJfSwHpP/TknWjLZ4zvSn8BJKpuG0EKMvxJ
         GYqoJy2JWd+XM/Zoyz7/czdbcTvCeBE9UXgg7UgbvleYiQDECWdfzj1Uz3t9Bl1kVKPY
         gdgWL4N9FF7cEO9PPuAj81WewHhAFA0edmRtHWQpALZEdlpHFpswKjjJuwwWKpzqIdrN
         CdwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uRZ0kluIbaQGUSF6giV2hb1heaS0871QoCZ1Ehr1pUg=;
        b=VbVaQJgVoIppCXmLSA7nem1i8r7KDNSOgPy/XdmZJHpt1TVkjjDKCANi7QIWpG3EpI
         sAHrZBdX8x5VvihUIQYFVzYeICeDvNnbN6oML1vtpw/0ahVopgXAzRWPk9T4CFgok7a1
         DgDfYbklgn4MCHbmYXJWfkC1WCO3DIKeKi1U8KXzSKXuDg3KuaIsLsQjih4Wf8WVjRTY
         QmyBuM/LBX5vhOzVDV/V3/v2KE9FagVybvqheIAMQl+8BSnaRu/bzF9iVp03VnRozgd1
         MI0bl2X/0Gh9RMsg76VWJSgEYOUx8m8q2bIBOYGqB0j1d0t9YWNryflIQPAHOpqg/KMZ
         z+tA==
X-Gm-Message-State: AOAM531I+IMRlqpP2ODySK87+jJs73rb8uoWsPTLG9r1PyWxTgAfRKp0
        qcCCgKBd9A19RiYjLlhjgX0=
X-Google-Smtp-Source: ABdhPJxk5wQ1uOcA8wh5ohIzlCCBxQPATxQBQpiTgcTke6I3l5bBxp8Qy230808OsuXVgzzMdjQuyA==
X-Received: by 2002:a17:907:75e1:: with SMTP id jz1mr18915383ejc.439.1633368609369;
        Mon, 04 Oct 2021 10:30:09 -0700 (PDT)
Received: from tom-desktop (net-5-94-68-71.cust.vodafonedsl.it. [5.94.68.71])
        by smtp.gmail.com with ESMTPSA id q18sm6882546ejc.84.2021.10.04.10.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 10:30:08 -0700 (PDT)
Date:   Mon, 4 Oct 2021 19:30:06 +0200
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Forest Bond <forest@alittletooquiet.net>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        Yujia Qiao <rapiz@foxmail.com>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Marcos Antonio de Jesus Filho <mdejesusfilho@gmail.com>,
        Aldas =?utf-8?B?VGFyYcWha2V2acSNaXVz?= <aldas60@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] staging: vt6655: fix camelcase in bShortSlotTime
Message-ID: <20211004173006.GA13458@tom-desktop>
References: <20210926162527.21462-1-tomm.merciai@gmail.com>
 <20210926162527.21462-2-tomm.merciai@gmail.com>
 <YVHilhCk3cgGhXrZ@kroah.com>
 <20210927213515.GA6953@tom-desktop>
 <YVKdVCaVwmPG7DVx@kroah.com>
 <20210930214929.GB45822@tom-desktop>
 <20211004102632.GT2048@kadam>
 <20211004125806.GA140797@tom-ThinkBook-14-G2-ARE>
 <20211004131525.GU2048@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211004131525.GU2048@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 04:15:25PM +0300, Dan Carpenter wrote:
> On Mon, Oct 04, 2021 at 02:58:06PM +0200, Tommaso Merciai wrote:
> > On Mon, Oct 04, 2021 at 01:26:32PM +0300, Dan Carpenter wrote:
> > > On Thu, Sep 30, 2021 at 11:49:29PM +0200, Tommaso Merciai wrote:
> > > > On Tue, Sep 28, 2021 at 06:43:00AM +0200, Greg Kroah-Hartman wrote:
> > > > > On Mon, Sep 27, 2021 at 11:35:15PM +0200, Tommaso Merciai wrote:
> > > > > > On Mon, Sep 27, 2021 at 05:26:14PM +0200, Greg Kroah-Hartman wrote:
> > > > > > > On Sun, Sep 26, 2021 at 06:25:18PM +0200, Tommaso Merciai wrote:
> > > > > > > > Replace camel case variable bShortSlotTime with snake case
> > > > > > > > variable b_short_slot_time.
> > > > > > > 
> > > > > > > That is a very odd variable name.  Why did you pick that one?
> > > > > > > 
> > > > > > > What deos it mean?
> > > > > > > 
> > > > > > > You do understand where the original naming format came from here, and
> > > > > > > what it was trying to represent, right?  If not, please go read up on
> > > > > > > it:
> > > > > > > 	https://en.wikipedia.org/wiki/Hungarian_notation
> > > > > > > 
> > > > > > > That style is not used in Linux, and so, when converting from it, do not
> > > > > > > attempt to keep the same style present here, that is kind of pointless,
> > > > > > > don't you agree?
> > > > > > 
> > > > > >   You are definitely right. What do you think about "short_slot_time"?
> > > > > 
> > > > > "time" implies that this will hold a value of time, right?
> > > > > 
> > > > > What exactly does this variable do?  That might help in naming it
> > > > > better.
> > > > 
> > > >   Is a boolean variable, if true short slot time mode is enabled, false 
> > > >   not right?
> > > >   A good solution could be: "short_slot_mode"? What do you think about?
> > > 
> > > No.  That's a confusing name.  What is a short slot mode anyway?
> > > 
> > > regards,
> > > dan carpenter
> > 
> >   Hi Dan,
> >   My bad sorry, "short_slot_time_en".
> 
> Ah, never mind.  It means something for the protocol.  I thought it was
> driver specific.  Just use short_slot_mode like you original suggested.
> The "_en" doesn't add anything.
> 
> In the commit message you out include the information from here so that
> reviewers who don't know the wifi spec will understand the meaning.

  Thanks for the tip.

  Tommaso

> 
> regards,
> dan carpenter
> 
