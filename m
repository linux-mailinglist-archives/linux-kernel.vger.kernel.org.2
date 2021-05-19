Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8EFC3891F6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 16:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354844AbhESOwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 10:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354786AbhESOwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 10:52:31 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A33C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 07:51:10 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id f75-20020a1c1f4e0000b0290171001e7329so3493767wmf.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 07:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VV7/9JaD44d0SIqii9fxOh5N5w8JV1LAcaGfCsGPjYk=;
        b=O/bCuWPT0xvna7IdB8ZdNA2ka107ndSdOAyZEuHtgtrVI3lxb674JM47G7q8AkrBnC
         2f2zdiVvgFKVOmXxyEXLdsFYauT/ueWr6wB2qvXtqOkqWGME4wE/ExM9tbgwgpRKmM0/
         UHLTxIkIUCff3AOpeiv1Jvk9rKv5uh3mr7xzEZG1wf/OnAbpEsXhwa7ZdpzGhI7mHTWg
         XGdC07AaB6yef11bTrh08hxTlgENe840S1h685chWWw2xfUrTfcsv3nrFLfJcOvJNhgm
         ApW5MdcnmADSnpiMWG97IkY/+DeAVxKh5wKmzs6DWkrs8tr9evufmYeSMhzpmKyKPoxW
         rD9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VV7/9JaD44d0SIqii9fxOh5N5w8JV1LAcaGfCsGPjYk=;
        b=pcnWgaeK95XoyXFEn8twJQB4DYxWzCYgrMEzXz4vaaPaWWT/bN5iafSMKYRVdIxWVD
         xKCnm7YvgGhszTDSYPXHIcSqHr5DQOrumtxVjSJTj0gG5TEI3EEG4Acr/Kaxp+LcEkV1
         FTKWUG7F8XY8nT7PSdOHxe4nKPxd62pq4wRnG4BkXd8+JSrKNNmGXD7VJHD+4YjOeKe8
         v1SjQ9EbuvyrotAEscnzxos0s8yWZyP5k3dUP6wtuuLWMcK7dGon2ohWFo4vn0E4I1IV
         tBG7Un08TDEXUSzIMTzB9e3gTJv2ENLcT1OyZ4okJ+nm6xR9YkOsB9oAKJ/xBUfpteJz
         9UzQ==
X-Gm-Message-State: AOAM533t/QeQ0nZPALQyRAQVeUsq/O8mNEdXKfdKsfVBg9LBqA7wPGA4
        hI4F4sGj5AP7floQEVh9AxSun0V71aDPpA==
X-Google-Smtp-Source: ABdhPJwoFOT8mTousPrM/DH9tL/Vw5xPCW7VkUP6JtNW1ZqT8fi+zWPR13Hbu8vaW3NV6mBwMehlKw==
X-Received: by 2002:a7b:cc10:: with SMTP id f16mr12281481wmh.24.1621435869272;
        Wed, 19 May 2021 07:51:09 -0700 (PDT)
Received: from agape.jhs ([5.171.80.197])
        by smtp.gmail.com with ESMTPSA id c6sm7772219wru.50.2021.05.19.07.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 07:51:09 -0700 (PDT)
Date:   Wed, 19 May 2021 16:51:06 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Hriday Hegde <hridayhegde1999@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: android: ashmem: Declared file operation with
 'const' keyword
Message-ID: <20210519145105.GC1417@agape.jhs>
References: <20210519081958.7223-1-hridayhegde1999@gmail.com>
 <YKTM8KmXI8bXUSqp@kroah.com>
 <0ddb894f-f66f-f31b-ef8a-0646e0a99b9f@gmail.com>
 <YKTfbdFhvM7fbpet@kroah.com>
 <08cf8110-cf84-8784-c919-eba27474b796@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08cf8110-cf84-8784-c919-eba27474b796@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hriday,

On Wed, May 19, 2021 at 08:06:14PM +0530, Hriday Hegde wrote:
> On 19-05-2021 15:20, Greg Kroah-Hartman wrote:
> > A: http://en.wikipedia.org/wiki/Top_post
> > Q: Were do I find info about this thing called top-posting?
> > A: Because it messes up the order in which people normally read text.
> > Q: Why is top-posting such a bad thing?
> > A: Top-posting.
> > Q: What is the most annoying thing in e-mail?
> >
> > http://daringfireball.net/2007/07/on_top
> >
> > On Wed, May 19, 2021 at 03:00:08PM +0530, Hriday Hegde wrote:
> >> I am not really sure how to do that and how to reflect it in the patch i followed what was taught in the Beginners course and it does not mention building. I know i need to test it out but is running 'patch -p1 < x.patch what i need to do?
> > That does not build the code you changed, right?
> >
> > I'm sure whatever course you took, it did reference the fact that you
> > need to ensure that your change actually works properly by the very
> > least being able to be compiled correctly.  Please go over those
> > instructions again.
> >
> > good luck!
> >
> > greg k-h
> 
> I am using the A Beginner's Guide to Linux Kernel Development (LFD103) by the linux foundation for this but i cant find any commands to as to build and test , the only way i tried compiling is with a custom Makefile and it didn't work, i've got a few errors so the const keyword might not work here since the variable is being written to.
> 
> 

try following this tutorial from scratch:

https://kernelnewbies.org/FirstKernelPatch

it's simply complete and helps a lot, from
gathering all tools needed to contribute to the
community to sending whole patchsets.

In your emails don't go over 80-100 character per line,
when you ask things or your mails will be difficult
to read.

thank you,

fabio
