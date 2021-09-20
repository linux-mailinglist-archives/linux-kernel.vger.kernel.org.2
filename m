Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C117411367
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 13:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236619AbhITLP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 07:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236497AbhITLP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 07:15:26 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6157C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 04:13:59 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id g8so59936172edt.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 04:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p5az8nB81DwwNgXGTxU9ukK7VAEPLsys0uqjmS5Tnv4=;
        b=jY0gnQxKtfoHLReTbt5tv1J2b8p8UMD4UpXbJp0u5T/PV/r2z8u48dBkTvV0gO2ZUj
         /LiRt0DewGx4DPgmtD9+lIe1x/4dwr373259WBlybTWGt3Cnak+l+YEqXN7M0zfMDVu1
         3azCzuk3zNEQsRoI3yw4RP8eDTEvdNFSqu2fat4MGWc1AgALPC3gX24prJgVHA6pnBVT
         0TqkiKPjyJvdwTDu82RbawjQQFASYTeToMas16awrm9Mbq0RnbIg42i8XFIyNmJlknzG
         UBQvzrvQNW+qzeAX0yuWvDRMEU8AdfIZyNRPEHRnHzjPFYi865bxQtw6vj5DFpvj3LXo
         a5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p5az8nB81DwwNgXGTxU9ukK7VAEPLsys0uqjmS5Tnv4=;
        b=Pr2FeHCfakJJj+ARdUXwSFNmuDarJRm23N1FsDa2D9y1YU9KzNswEaEL3nXY3muToI
         qtoJMoDN7+sfRTKxpgGXB0uTiKBeCQJMUL5Z+AYcWPpqsYvcV3yqMoVj5HpKdeEbNEjd
         99xPxF1tT4jBSi8kG4FtnHb+TO5y9YFLg7HSZ3mDOWWC3ie+xmHl2jsQbturOENPeh6K
         t3q/y0gtdYvkIfl1ZkC+OlOZYbs1UPwwJwjfMjBQ2dCS5N1kLBLP0/1S6g2l2AtMYhOe
         5vKGe902saAWIUw+hbd9dZOtmZPoJNDZLeyYNKaQ5MfZ2JKyaTt/hCAx5wqQl3dBZVZ1
         0bQA==
X-Gm-Message-State: AOAM532jt47Hgnff3l1ItXCzp2pPmRb9CTYkvpVJC7VtBeA4Vbdbq0vI
        8GRAQyw8GPMCp+l+HvUdr3AyhGxee8U=
X-Google-Smtp-Source: ABdhPJw69bCPeGc+pArhaAIB76bErwEstQbaX/JKGGqb00nLLe4X/r85yGsdukQFaixTebA+OUxOhg==
X-Received: by 2002:a17:906:c2cf:: with SMTP id ch15mr27480613ejb.107.1632136438450;
        Mon, 20 Sep 2021 04:13:58 -0700 (PDT)
Received: from localhost.localdomain (host-79-47-104-104.retail.telecomitalia.it. [79.47.104.104])
        by smtp.gmail.com with ESMTPSA id la1sm6020197ejc.48.2021.09.20.04.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 04:13:57 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     saurav.girepunje@hotmail.com, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, straube.linux@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: core: remove the function power_saving_wk_hdl
Date:   Mon, 20 Sep 2021 13:13:54 +0200
Message-ID: <1651026.4NJzAxWbHA@localhost.localdomain>
In-Reply-To: <YUhkFvz4BpLv0eoN@kroah.com>
References: <YTub30ZRG3oLbxQW@user> <45c4de06-f618-4352-91ea-885edecdf8bb@gmail.com> <YUhkFvz4BpLv0eoN@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, September 20, 2021 12:36:06 PM CEST Greg KH wrote:
> On Sat, Sep 18, 2021 at 10:52:50PM +0530, Saurav Girepunje wrote:
> > 
> > 
> > On 13/09/21 9:48 pm, Greg KH wrote:
> > > On Fri, Sep 10, 2021 at 11:24:39PM +0530, Saurav Girepunje wrote:
> > > > Remove the function power_saving_wk_hdl() as it just calling
> > > > the rtw_ps_processor().Instead of power_saving_wk_hdl() call directly
> > > > rtw_ps_processor().
> > > > 
> > > > Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> > >
> > > []
> > > 
> > > Also does not apply to my tree.  Please rebase against my staging-next
> > > branch and resend.
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > > 
> > 
> > Hi Greg,
> > 
> > I always do rebase against your staging-testing branch. Can you help me 
to
> > understand.When we need to rebase on staging-next. Do we always need to
> > rebase against staging-next..!
> 
> Yes, you should.  When you are working on code that lots of other people
> are working on, there will be conflicts like this, and you just need to
> stay on top of it.
> 
> thanks,
> 
> greg k-h
> 

Sorry, Greg. I'm confused... :(

As far as I know, everyone here make patches for staging-testing. You apply 
them to staging-testing first and, about 24 hours later, you merge them into 
staging-next. 

In fact I receive two distinct messages, one after the other, when you apply 
to staging-testing and then to staging-next. 

This is the what I've always done here and you haven't ever asked me to 
rebase against staging-next... So, why are you asking for doing that rebase 
on staging-next to Saurav?

Thanks,

Fabio



