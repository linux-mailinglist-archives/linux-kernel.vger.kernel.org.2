Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD5B411481
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 14:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238332AbhITMdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 08:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237977AbhITMdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 08:33:00 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD76FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 05:31:33 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id co2so14215008edb.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 05:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QF62yZU/+6ZlNBgifI+CKDXHp7smsglUxz2zwn/P9Js=;
        b=BIQ65kDNI2MjvluQh9ZbK1D+WAgv856aLhVPB344B0zC3lOTzqT0nTur//LWsvTIql
         Nu8G/WTmWD8+QWMoAbhvx6O+Jl+3hsBsORCHufIaxRh7QO45ywEbS+fVP684px2oq0fP
         iwYgC01hRbt8EFXEes05Q5N//RZUqdcwCjAv+EK8WkMxq8tqQxRgLLozgQRC1SG5M/GY
         RaklyaWH10OeXLTI97MqmFOYitTq9B+wyUmNTkuqixiGMvua0nXh0iAO9yBgtUoYdFjw
         4QL/F69RNamvD6rdvxU51v/4TxOuXUnR2bV6Dix3/rbVIsj37xrz+Wga2zx0+TSk5Vn2
         Q0HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QF62yZU/+6ZlNBgifI+CKDXHp7smsglUxz2zwn/P9Js=;
        b=cSOAqM5+Lnr8rjfl/OxhzUquYC8mVT1vD0HHLqe5ZHkugpl1uxk1z+BQONkZIEmlBp
         E/qnxB11SZRoZAWmuCy4+QYEK8p/Ko3rYAL9G1e81NHRWHbH44EODpeSe5nC7C5ERzTz
         oMuYvefABgMaSBKHkzgdGpbfSfSdNsAlkRBpbkUQw7iPeFzV0qsyzPXYGQeRbYtjjRN2
         UEqbkJ3bhdcCwkLyHPPyQ7CL9eSKFKY1euVNO0uRcLZN1cBqlAstp05arioMoi2xcLkR
         3tI4aBvejgipnlsobYLwpo0FqstlUyholrrCuwyWY3HpMNWo3Mofg7vDoKwaZAj8vFLi
         q+zQ==
X-Gm-Message-State: AOAM5308uals822Db4VHel2rUG6fmYyrNDKpFyRDF+eRl50XfVntkNct
        1o5IkC5ooS0weO/KcFzyAkiNA01KTDw=
X-Google-Smtp-Source: ABdhPJx4FpoKeFR3v7F4JywM6LFdSEJqy65UotZ4K0nnuDn8lAATcflVL/UyTXsQFT+21B23hvURtw==
X-Received: by 2002:a17:906:ccca:: with SMTP id ot10mr27637430ejb.429.1632141089969;
        Mon, 20 Sep 2021 05:31:29 -0700 (PDT)
Received: from localhost.localdomain (host-79-47-104-104.retail.telecomitalia.it. [79.47.104.104])
        by smtp.gmail.com with ESMTPSA id dc8sm6916098edb.28.2021.09.20.05.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 05:31:29 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Saurav Girepunje <saurav.girepunje@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        saurav.girepunje@hotmail.com, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, straube.linux@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: core: remove the function power_saving_wk_hdl
Date:   Mon, 20 Sep 2021 14:31:28 +0200
Message-ID: <2311011.CixZWWR6MO@localhost.localdomain>
In-Reply-To: <20210920113221.GP2088@kadam>
References: <YTub30ZRG3oLbxQW@user> <1651026.4NJzAxWbHA@localhost.localdomain> <20210920113221.GP2088@kadam>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, September 20, 2021 1:32:21 PM CEST Dan Carpenter wrote:
> On Mon, Sep 20, 2021 at 01:13:54PM +0200, Fabio M. De Francesco wrote:
> > On Monday, September 20, 2021 12:36:06 PM CEST Greg KH wrote:
> > > On Sat, Sep 18, 2021 at 10:52:50PM +0530, Saurav Girepunje wrote:
> > > > 
> > > > 
> > > > On 13/09/21 9:48 pm, Greg KH wrote:
> > > > > On Fri, Sep 10, 2021 at 11:24:39PM +0530, Saurav Girepunje wrote:
> > > > > > Remove the function power_saving_wk_hdl() as it just calling
> > > > > > the rtw_ps_processor().Instead of power_saving_wk_hdl() call 
directly
> > > > > > rtw_ps_processor().
> > > > > > 
> > > > > > Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> > > > >
> > > > > []
> > > > > 
> > > > > Also does not apply to my tree.  Please rebase against my staging-
next
> > > > > branch and resend.
> > > > > 
> > > > > thanks,
> > > > > 
> > > > > greg k-h
> > > > > 
> > > > 
> > > > Hi Greg,
> > > > 
> > > > I always do rebase against your staging-testing branch. Can you help 
me 
> > to
> > > > understand.When we need to rebase on staging-next. Do we always need 
to
> > > > rebase against staging-next..!
> > > 
> > > Yes, you should.  When you are working on code that lots of other 
people
> > > are working on, there will be conflicts like this, and you just need to
> > > stay on top of it.
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > > 
> > 
> > Sorry, Greg. I'm confused... :(
> > 
> > As far as I know, everyone here make patches for staging-testing.
> 
> Nope.  It's only you.

And Saurav (at least) :)

I've been misled and in turn I misled Pavel. This is due to a guide in 
kernelnewbies.org that explicitly says to use staging-testing:

https://kernelnewbies.org/OutreachyfirstpatchSetup

In that page the is a section ("Set up your Linux kernel code repository") 
which says: "[] Then use the revision control system called git to clone Greg 
Kroah-Hartman's staging tree repository: git clone -b staging-testing git://
git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git".

I assumed that those instructions must be followed also by developers that 
are not (anymore) in the Outreachy program.

Obviously, I was wrong in assuming the above.

Thanks for your reply, Dan.

Regards,

Fabio

> 
> The staging-testing branch can be rebased so maybe you will write a
> patch against something that never makes it to staging-next and everyone
> will be puzzled.
> 
> That's unlikely to happen and we won't be puzzled for long because we
> try not to invest too much time wondering why patches don't apply.
> 
> regards,
> dan carpenter
> 




