Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C821C316FA6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 20:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234484AbhBJTHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 14:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234443AbhBJTHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 14:07:25 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4E6C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 11:06:45 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id i71so3090183ybg.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 11:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rb6kfpEn37w3Z1+tXOK4d0Lp/MyJ0dZikm/EZhBTBJE=;
        b=gMQ9qLxOMXqeZRBQfMAxo3v4WFHEriibFaPJY46u2B9xDSxTA1TpJYCL8L3R09JbXD
         5rHuzBhTj/OKWT06LMJpupCXgXEaCjuxy2VrqzAW3irefuof9osnOi/rdA8qkwaevUvh
         y/fwRf7f8VRnZNIuBI67yeEM7wTrtZJVytOPc8yA0dyoIL0o4YftK8CyEDXN8cv/t6NN
         nEDQMX87mgvou5Ej6AmK5NEANvEq+Tk/GisEMcx8hU+pB8zUxh0cao6qAkYVO1QjV02x
         6oRy9tGJlZcAVVovmiqxthDkeKgXRVZT3Bx/2woqESGL7XvnZxieb1A1KnZ7F6AQX/dF
         UXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rb6kfpEn37w3Z1+tXOK4d0Lp/MyJ0dZikm/EZhBTBJE=;
        b=ZMFlWfIFotiU4CFuHCrY+huheVRNpbQJlkcTJDHURAMUi/cDGfz9ZIy2wsPfSsb4q0
         Kzz6XvDMfWB/iDhVg61kFtO2RdZw63lp6icv3Z1Lh9oJqSjE/dsF0AC7eOWKNJoF2rBB
         uftVoy8X2GMG61aOElgOn+Uyq6JHzHS8Xqn3Ye/v0oLHBUEBTATwrh6Dh2LZunE2hlbs
         r5iPyw0NiK71Kuo/RYb5aP2vWU8ahGgEbzOS67wVnQp3EEeBIj2j/6WX3JpPHD6+PpCt
         Vyc0zBhc2Kj6DHc7YZ7W+yEQPSG7X9WFZq7UX6zkHxPjSIazxDR08Rh4GczzGO+XxMNy
         AsKQ==
X-Gm-Message-State: AOAM530jyXH3nLo1FWroCmLpEHExIOLTdEi8svJgzepe/B3as0jvunxO
        N1jiQzwD5nKn6pOjT2absAAoEUZTqVI6cc9YjmSyhA==
X-Google-Smtp-Source: ABdhPJw1Lz7E9I7pVPuCoZatjSA617zeIkbI3DiWdFuwhGM91ygzg4rd+NoZ9M8J6+reng2esEJaOR/O/8WvDcKhHmE=
X-Received: by 2002:a25:aa43:: with SMTP id s61mr6831176ybi.32.1612984004474;
 Wed, 10 Feb 2021 11:06:44 -0800 (PST)
MIME-Version: 1.0
References: <20210210214720.02e6a6be@canb.auug.org.au> <YCQjfqH415zIhhyz@kroah.com>
In-Reply-To: <YCQjfqH415zIhhyz@kroah.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 10 Feb 2021 11:06:08 -0800
Message-ID: <CAGETcx88Ln2XxuLN7P2BVhzB=OQxPLLsBN7WLL1j2JtR4+Z8ow@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the driver-core tree
To:     Greg KH <greg@kroah.com>, Rob Herring <robh+dt@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 10:18 AM Greg KH <greg@kroah.com> wrote:
>
> On Wed, Feb 10, 2021 at 09:47:20PM +1100, Stephen Rothwell wrote:
> > Hi all,
> >
> > After merging the driver-core tree, today's linux-next build (sparc64
> > defconfig) failed like this:
> >
> > drivers/of/property.o: In function `parse_interrupts':
> > property.c:(.text+0x14e0): undefined reference to `of_irq_parse_one'
> >
> > Caused by commit
> >
> >   f265f06af194 ("of: property: Fix fw_devlink handling of interrupts/interrupts-extended")
> >
> > CONFIG_OF_IRQ depends on !SPARC so of_irq_parse_one() needs a stub.
> > I have added the following patch for today.
> >
> > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > Date: Wed, 10 Feb 2021 21:27:56 +1100
> > Subject: [PATCH] of: irq: make a stub for of_irq_parse_one()
> >
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > ---
> >  include/linux/of_irq.h | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)

Thanks Stephen!

-Saravana

>
> Thanks for this, I'll go queue it up now.
>
> greg k-h
