Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8269A414260
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 09:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbhIVHNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 03:13:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233024AbhIVHNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 03:13:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2FEDE61156;
        Wed, 22 Sep 2021 07:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632294696;
        bh=yxr8NwWPu+PUAvGLOodKkJu+rQJl50G7dN5h5BcR4ac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vS81OGacSdPaQk1uO6u9wE4l6gGnKqWe62ahPNb3jlzhlUj9f87H/Lfvy/He91zk1
         L+COx0tNywGKNBC5A5yQKfaVLICrdnJxn41U8pTor59/S85KZJw9Id3byQjsyC9XlH
         MAmowrPiiFek+Ho5tdj+/b58Sb2502s+fI6Tikfc=
Date:   Wed, 22 Sep 2021 09:11:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Peter Korsgaard <peter@korsgaard.com>
Cc:     Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2] MAINTAINERS: usb, update Peter Korsgaard's entries
Message-ID: <YUrXJTDE0YX6pkgb@kroah.com>
References: <20210922063008.25758-1-jslaby@suse.cz>
 <87r1dhqecp.fsf@dell.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1dhqecp.fsf@dell.be.48ers.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 09:05:58AM +0200, Peter Korsgaard wrote:
> >>>>> "Jiri" == Jiri Slaby <jslaby@suse.cz> writes:
> 
>  > Peter's e-mail in MAINTAINERS is defunct:
>  > This is the qmail-send program at a.mx.sunsite.dk.
>  > <jacmet@sunsite.dk>:
>  >       Sorry, no mailbox here by that name. (#5.1.1)
> 
>  > Peter says:
>  > ** Ahh yes, it should be changed to peter@korsgaard.com.
> 
>  > However he also says:
>  > ** I haven't had access to c67x00 hw for quite some years though, so maybe
>  > ** it should be marked Orphan instead?
> 
>  > So change as he wishes.
> 
>  > Signed-off-by: Jiri Slaby <jslaby@suse.cz>
>  > Cc: Peter Korsgaard <peter@korsgaard.com>
>  > Cc: Linus Torvalds <torvalds@linux-foundation.org>
>  > Cc: linux-usb@vger.kernel.org
>  > ---
>  > [v2]
> 
>  > - Change the e-mail in DM9601 instead of dropping the old one.
>  > - Make C67X00 an orphan.
> 
> Thanks!
> 
> Acked-by: Peter Korsgaard <peter@korsgaard.com>

Thanks, I'll take this through my tree now.

greg k-h
