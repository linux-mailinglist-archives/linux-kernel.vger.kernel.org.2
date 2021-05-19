Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24277389212
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 16:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354921AbhESO5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 10:57:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:48730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242805AbhESO5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 10:57:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F6A5610A8;
        Wed, 19 May 2021 14:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621436148;
        bh=ClfjTj6vY4YvufBD/Qb0lGE5WKoSi7Gcm47l5UXBMVk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M4gDaXF3H/efxJL5GQz3p7hVKk/K3AUe3UMy3zSE9YDw5f7AWJd9MFQSKJfRsj3lr
         NhkAPK4RbzbvVf5Xx8zUG+wd/IEyWwN+7Nq+DxMzvaa+TW32Yd/mt91LGmXTWC8zek
         oLCu1XELyBoA+Yt6k7zk0eAR44w0WyBMpvhiO6VA=
Date:   Wed, 19 May 2021 16:55:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hriday Hegde <hridayhegde1999@gmail.com>
Cc:     Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: android: ashmem: Declared file operation with
 'const' keyword
Message-ID: <YKUm8tf3bKvCf1YI@kroah.com>
References: <20210519081958.7223-1-hridayhegde1999@gmail.com>
 <YKTM8KmXI8bXUSqp@kroah.com>
 <0ddb894f-f66f-f31b-ef8a-0646e0a99b9f@gmail.com>
 <YKTfbdFhvM7fbpet@kroah.com>
 <08cf8110-cf84-8784-c919-eba27474b796@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08cf8110-cf84-8784-c919-eba27474b796@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

That is correct, when compiling (i.e. building), the compiler shows that
this is not a correct change.

thanks,

greg k-h
