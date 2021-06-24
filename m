Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93CCA3B2AED
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 11:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhFXJEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 05:04:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:59258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229956AbhFXJEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 05:04:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC76C613BE;
        Thu, 24 Jun 2021 09:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624525340;
        bh=h87b/fb9ZwuekR4dcIZVJniKAviAAIF30Dx8w4avA+M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RiNM2u5MdfXa0UGru1PxpWSv/6IY9qFO5kTYr6Oa5CqzvWYRrMtVzlkj9U3idPSEt
         pGl6HqdkErfX0GgRGdlkAeCEDXSOQGyukUhw/8I+rF/Ab4Rra1QXTe4+vXGIQoDkrI
         Ghma4ZC7h/kCKzSv/Kf1YEvEPg7Q+RaOUda6Z/Zk=
Date:   Thu, 24 Jun 2021 11:02:17 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Christian =?iso-8859-1?Q?L=F6hle?= <CLoehle@hyperstone.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kobject: Safe return of kobject_get_path with NULL
Message-ID: <YNRKGUgXW9gciMzO@kroah.com>
References: <CWXP265MB2680094534A5559B0A904B76C4089@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
 <YNNPHvFWoeI4UwEZ@kroah.com>
 <CWXP265MB26809893E168B75CF57ECC86C4079@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CWXP265MB26809893E168B75CF57ECC86C4079@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 06:42:41AM +0000, Christian Löhle wrote:
> Hey Greg,
> 
> >> Prevent NULL dereference within get_kobj_path_length
> >> 
> >> Calling kobject_get_path could provoke a NULL dereference
> >> if NULL was passed. while fill_kobj_path will return
> >> with a sane 0 for NULL, kobjet_get_path_length did not.
> >
> >Who passes NULL into that function?  Shouldn't that be fixed first?
> 
> It seems to me like here specifically it was a sd_open on some no longer
> existing device. I agree, but could not find a fix for that, and even if, it might
> not have been in the current tree.
> But when looking at the kobject code it felt like it was meant to be safe for
> NULL, (like any parent in the tree can be NULL), but the do while does hide that
> a bit.
> So is it not meant to be safe?

Not always, no.  It's better to fix the root problem and not paper over
it by doing something like this.

> I will try to find the sd_open issue some more, but cannot reproduce the issue
> consistently enough right now.
> 
> 
> >Pleaase always run your patches through checkpatch.pl so you do not get
> >maintainers asking you to use checkpatch.pl...
> 
> I did, so please tell me what part bothers you, so I can get that fixed, either in v2
> or maybe even in checkpatch.pl?
> (Only thing I spotted now is the kobjet typo)

You should put a blank line after variable definitions and before the
code logic.  Normally checkpatch catches that, odd it did not here...

thanks,

greg k-h
