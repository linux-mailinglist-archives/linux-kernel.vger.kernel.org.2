Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B79A13537B3
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 11:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhDDJ6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 05:58:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:50122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229483AbhDDJ6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 05:58:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3BA0761380;
        Sun,  4 Apr 2021 09:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617530293;
        bh=Jlm5k1Z0ghnp4ZK0Sxl+YdBR3Xn/bXcOpc7QvzAXWm4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EjMI/GQt3ZAEjJZV5R+LoKiX4vXeuSzROuvCN/4cvD68gAe6IOzH4Z3Sw8pvzvk8q
         q9f9mpgTpla/OI4ksdI/5trIW0+FCLvN0AfQg6sbcw0qDg4zqIxBqetAR541Ktlbon
         988bst4fvx1zrpeluf6DiSlzA+mq2YZ5n67VJKz4=
Date:   Sun, 4 Apr 2021 11:58:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     dev.dragon@bk.ru
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: rtl8192u: ieee80211: fixed a trailing
 statements coding style issue.
Message-ID: <YGmNsBUqRtu6/lMA@kroah.com>
References: <20210404051500.6644-1-dev.dragon@bk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210404051500.6644-1-dev.dragon@bk.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 04, 2021 at 08:15:00AM +0300, dev.dragon@bk.ru wrote:
> From: Dmitrii Wolf <dev.dragon@bk.ru>
> 
> Signed-off-by: Dmitrii Wolf <dev.dragon@bk.ru>
> ---
>  drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
