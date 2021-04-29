Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3EE36E8A5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 12:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240333AbhD2K0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 06:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbhD2K0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 06:26:35 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E835BC06138B;
        Thu, 29 Apr 2021 03:25:47 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id e7so77817978edu.10;
        Thu, 29 Apr 2021 03:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vWUqzDcIYyNtlaUQtK5aS5vhflRni0UZwh7Hr23COe0=;
        b=mMlYgWU6vGBm3MdIgBW1T/cskesGE4awH1fU3eyfNCNvSAQhBj9c1TmtREUMJiD5Ci
         mquByqy/x84469lW2uW37BthDunxdUMNzVa7iW+a9MnPfMpMCXLTfHsg1xz1iP+gfPDU
         tIRuxjGd2dh48bY1S6irw1XFFTeS9uv4vYoCm77AM9tSpuHogSm9sp/JDITIpjK7VyQl
         5+k8pcltsEeXZSGJ49r9DHCY7Y++OTsdvt8GdannpJTYK37q1iyy8XyWblB4mp/xAZeM
         YhNWKk2Xyn/PUd2hAwoKz+0zb3kXxi+oJhBMiurcRR5JZF6mnGxpssqzMxt38DdPGCXu
         9IRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vWUqzDcIYyNtlaUQtK5aS5vhflRni0UZwh7Hr23COe0=;
        b=OB6qPjiLB2no+OOa+HVnKyQEriA2GNwGOALVsSiivWtEx3gbW44kJ4gAZWFZWeDkBu
         hlVnt874WkRUTDFnpwPK+s2oClf7WYKtn5JthM1WkoDPTeLQDseukuh+NNktb9rp/paE
         mSWExJMYDvs8+AFCF6B4f6FU0yuBh6dkMnkXDpEwr8JLxww+0UL6Hmp+u+UARYpgRVK4
         VMx4pGIdQkc6ZUqE3IAcNvT2J+kvjcObhle8BL1onE+LwAZXUhJpxjgS+353dL4y4Clg
         Op4EDxdKvF4zuhPdwtX3BjgdCUliVdH2EiH2I3iH0E6LMjBO5Pe+zAPFdAR57ii1PMHS
         XqtQ==
X-Gm-Message-State: AOAM532XNIVR7KMNplZE4uv4SsIK6qSU0mI1Zen2X2C+2upOUhbYPNsh
        CnN9HYjPs+BcbPqcxvnWzuQ=
X-Google-Smtp-Source: ABdhPJzofCqquTNo1xEfJ8jQID96SYM0bCFV0mtDFwrvDGs0P28BYXtfg5FFOBQdzOxHhVbFMxZNpg==
X-Received: by 2002:a05:6402:c98:: with SMTP id cm24mr9756782edb.18.1619691946678;
        Thu, 29 Apr 2021 03:25:46 -0700 (PDT)
Received: from agape.jhs ([5.171.81.14])
        by smtp.gmail.com with ESMTPSA id h19sm1536071ejc.94.2021.04.29.03.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 03:25:46 -0700 (PDT)
Date:   Thu, 29 Apr 2021 12:25:43 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: module parameters permission
Message-ID: <20210429102543.GG1409@agape.jhs>
References: <20210429095819.GE1409@agape.jhs>
 <YIqE1B3qMK+5AwQj@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIqE1B3qMK+5AwQj@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 12:05:08PM +0200, Greg KH wrote:
> On Thu, Apr 29, 2021 at 11:58:20AM +0200, Fabio Aiuto wrote:
> > Hi all,
> > 
> > I'm trying to declare module parameters this way:
> > 
> > 
> >    params: {
> >         scull_major: i32 {
> >             default: 0,
> >             permissions: bindings::S_IRUGO as i32,
> >             description: b"Major number",
> >         },
> >         scull_minor: i32 {
> >             default: 0,
> >             permissions: bindings::S_IRUGO as i32,
> >             description: b"Minor number",
> >         },
> > 
> > i.e. using S_IRUGO macro exposed by bindgen. But I have the
> > following compiler error:
> > 
> > error: proc macro panicked
> >   --> samples/rust/rust_scull.rs:12:1
> >    |
> > 12 | / module! {
> > 13 | |     type: RustScull,
> > 14 | |     name: b"rust_scull",
> > 15 | |     author: b"Alessandro Rubini, Jonathan Corbet",
> > ...  |
> > 44 | |     },
> > 45 | | }
> >    | |_^
> >    |
> >    = help: message: Expected Literal
> > 
> > the same if I remove as i32 casts.
> > 
> > if I write permissions as in samples/rust/rust_module_parameters.rs
> > 
> >     params: {
> >         my_bool: bool {
> >             default: true,
> >             permissions: 0,
> >             description: b"Example of bool",
> >         },
> >         my_i32: i32 {
> >             default: 42,
> >             permissions: 0o644, <-------
> >             description: b"Example of i32",
> >         },
> > 
> > I get no error.
> > 
> > What's the right way to use S_I*UGO macros?
> 
> Not at all, use the octal values instead please.
> 
> That's the way that we have declared a while ago, and I think
> checkpatch.pl will even catch if you try to do this in any new code.
> Please don't force us to deal with S_* defines in rust code as well.
> 
> thanks,
> 
> greg k-h

thank you I didn't know that. I will use octal than.

Anyway I'd like to know what was the matter with those bindings...

fabio
