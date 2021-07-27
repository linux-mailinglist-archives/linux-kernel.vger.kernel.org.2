Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCE93D7B6C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 18:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbhG0Qzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 12:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhG0Qzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 12:55:39 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98042C061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 09:55:39 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id a20so16686613plm.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 09:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QQoNCG1M1L8gK5ht1u6i2Ce3nKisRclgMdzn1xxe0eA=;
        b=jjBH51zUezd5bHvHk2ASWyXfi/yE/hVl6TAbgIpIABp4TeK3z7dG6HRwMZyiX5+Uhr
         a6U01JsaicvYDXPV5eWNA74GYSKK3+dAz3K4NPb+QpZw1GBER7K/0A3/JA7fwCcebkLv
         DkML+5g5G0AB3ow5jYxg7xrwzK4rw+Pd1JdiP1fEiMEc0D/P/JbLUOS6bSJL41YL3OgM
         sVVdfnaOqm7nj/xywAY66pDFHS2AoF8rLfw1ChGaMJuSP5eWCOB948CVrk4OS9lTyffk
         G4J7eMP7Ae0MiVdbiEUqHVJdA1dHAyux1kr2yd50gg8BdOcLWBq80La8TAyzVvBc2ppi
         X81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QQoNCG1M1L8gK5ht1u6i2Ce3nKisRclgMdzn1xxe0eA=;
        b=YXPouxveeiRKN+0+HVcTAQTpdHXkybkOWcG2SKH6J4PbFIvnw0asD0iwxKyIJ/OT9S
         njrE+7R7yLEaYaD8Y4xTSb3KhnF1blJi/n9Wbjyld8nmWnubXMQjzv8jzx4rzej9ffT3
         KxVBf7R3PlfWRDZZ58gxM79rzxv0++1RPPE5EreaeyIrdYyDLqsCYCYSgdIjOsxBHx5B
         ImZQxHjM4Oxlb+EQxS0jrWERoLVHuWqH1h8A5uuV5FpzyaAC3hIou9bB4LKt4kE3+U7d
         l4+yUA5Gw6aIA2gLaqqEqGHfOBt4d4DnZP3A1VubrKA55KO1EwnXSpoZHAYAy4SALl0s
         AHFw==
X-Gm-Message-State: AOAM531X0w3Imh9m6+SInw2ueE3j9QIVp6Lk6eskcdCkXWRy0H1TQwEC
        6gA0wbVfeKiB42BsPwow8vQ=
X-Google-Smtp-Source: ABdhPJwY8lsfzvJMPbJsMFM8vgp5/st1KXukwiUobKcGkNjEncAvzMHeMUy7vLecay+P05ELFWikBQ==
X-Received: by 2002:a17:90a:ce17:: with SMTP id f23mr2453653pju.236.1627404939233;
        Tue, 27 Jul 2021 09:55:39 -0700 (PDT)
Received: from ojas ([122.161.53.213])
        by smtp.gmail.com with ESMTPSA id k16sm4169671pfu.83.2021.07.27.09.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 09:55:38 -0700 (PDT)
Date:   Tue, 27 Jul 2021 22:25:26 +0530
From:   Ojaswin Mujoo <ojaswin98@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     nsaenz@kernel.org, stefan.wahren@i2se.com,
        dan.carpenter@oracle.com, phil@raspberrypi.com,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/5] staging: vchiq: Make creation of vchiq cdev
 optional
Message-ID: <20210727165526.GA13711@ojas>
References: <cover.1626882325.git.ojaswin98@gmail.com>
 <846c424dd4aae14d1cc28c8f30877a06e2b7dd10.1626882325.git.ojaswin98@gmail.com>
 <YQAJLao8H1Hl5VVf@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQAJLao8H1Hl5VVf@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 03:25:01PM +0200, Greg KH wrote:
> On Wed, Jul 21, 2021 at 09:50:52PM +0530, Ojaswin Mujoo wrote:
> > Before this commit, vchiq cdev (/dev/vchiq) was always created during
> > platform initialization. Introduce a new Kconfig option
> > CONFIG_VCHIQ_CDEV which determines if the cdev will be created or not.
> > 
> > Signed-off-by: Ojaswin Mujoo <ojaswin98@gmail.com>
> > ---
> >  drivers/staging/vc04_services/Kconfig                  | 10 ++++++++++
> >  drivers/staging/vc04_services/Makefile                 |  5 ++++-
> >  .../vc04_services/interface/vchiq_arm/vchiq_arm.h      |  9 +++++++++
> >  3 files changed, 23 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/vc04_services/Kconfig b/drivers/staging/vc04_services/Kconfig
> > index 4b886293f198..63caa6818d37 100644
> > --- a/drivers/staging/vc04_services/Kconfig
> > +++ b/drivers/staging/vc04_services/Kconfig
> > @@ -19,6 +19,16 @@ config BCM2835_VCHIQ
> >  		Defaults to Y when the Broadcom Videocore services
> >  		are included in the build, N otherwise.
> >  
> > +if BCM2835_VCHIQ
> > +
> > +config VCHIQ_CDEV
> > +	bool "VCHIQ Character Driver"
> > +	help
> > +		Enable the creation of VCHIQ character driver to help
> > +		communicate with the Videocore platform.
> 
> I'll take this, but this really should say more about what this really
> is for.  Who needs this?  Why will I know if I want a character driver
> interface?  What tools talk to this?
> 
> Or conversely, why would I want to turn this off?
> 
> Can you send a follow-on patch that makes this more descriptive?
Hello Greg,

Sure, I can send in a follow up patch explaining this in more detail.

Thank you,
Ojaswin
> 
> thanks,
> 
> greg k-h
