Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBECE356888
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 11:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350418AbhDGJ4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 05:56:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:37914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350410AbhDGJ4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 05:56:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B51761382;
        Wed,  7 Apr 2021 09:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617789383;
        bh=BwRDnij+mE+hDNk3Ct/IamYuy8Ht3UxxQhXaDlPe++Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t/LX4EGIuAEdIVDu6tZP9BVt8jYC9VZjhKYagd5TuDYOzIIJrKbPVsEaM2M+elvDD
         qzjDkpSyHa99Htmc6TGy7tK9OPfAsrADAVRTW2HTks0Grz6AbSjhLAdwkeOZ9OqzIu
         z0BKTmGiBjGh1J8SoD7GjhkZF5Rwks3igJWEOtlU=
Date:   Wed, 7 Apr 2021 11:56:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/2] MAINTAINERS: add regressions mailing list
Message-ID: <YG2BxMBLqEt4mkgS@kroah.com>
References: <cover.1617786974.git.linux@leemhuis.info>
 <f959331ed0e1a8ed59be9771fcab64378bd6977d.1617786974.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f959331ed0e1a8ed59be9771fcab64378bd6977d.1617786974.git.linux@leemhuis.info>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 11:21:55AM +0200, Thorsten Leemhuis wrote:
> Add the newly created regression mailing list finally created after it
> already had been agreed on during the maintainers summit 2017 (see
> https://lwn.net/Articles/738216/ ). The topic was recently discussed
> again, where an idea to create a broader list for all issues was
> discussed, but Linus preferred a more targeted list:
> https://lkml.kernel.org/r/CAHk-=wgiYqqLzsb9-UpfH+=ktk7ra-2fOsdc_ZJ7WF47wS73CA@mail.gmail.com/
> 
> Hence, the creation for that list was asked for and granted:
> https://bugzilla.kernel.org/show_bug.cgi?id=212557
> 
> In the end it became regressions@lists.linux.dev instead of
> linux-regressions@lists.linux.dev as 'Linux' is redundant in the latter
> case.
> 
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> ---
> I was a bit unsure how to add that list to MAINTAINERS. I considered
> adding a 'M:' with my name and email address there as well, but getting
> CCed on a lot of regression reports might be a bit much. I also left a
> 'S: supported' out, as that doesn't make much sense in this case afaics;
> and I checked, there are other entries that don't have those two (but
> it's rare).

Put your name there, you are the "maintainer of regressions!"  :)

Seriously, it's good to do that, maintainers entries that just have no
one "responsible" always seem to end up being a black hole.

> 
> Ciao, Thorsten
> ---
>  MAINTAINERS | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 03b2096a5f8f..dd5743d1f743 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15212,6 +15212,10 @@ F:	Documentation/devicetree/bindings/regmap/
>  F:	drivers/base/regmap/
>  F:	include/linux/regmap.h
>  
> +REGRESSIONS
> +L:	regressions@lists.linux.dev
> +K:	regression

A bit more information here perhaps?  This will not really help anyone
out to know what to do.

thanks,

greg k-h
