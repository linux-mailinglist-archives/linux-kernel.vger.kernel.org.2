Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2B83DE613
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 07:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbhHCFOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 01:14:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:60424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233737AbhHCFOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 01:14:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 24BA160EE7;
        Tue,  3 Aug 2021 05:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627967638;
        bh=xa4VRMf9MHhvAN8b2TBx4R7NfCpyIy5U5JlFqM/1uNE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S8P8vaGLwYMlwvmup3upXwU24mcWEGu0OPG2JbwWw6crE1YM/9PHqg2+0oCTThMjD
         /Vp/V2SSevpk0kSCYZOaIHagSTH6YGEXyweYO4PSWbcqrrLkE14aXLMOrNVfw7vKQo
         k/lPh15+fJcfzvJRSQ0xGxW2SyAKUouVwqkdYvHs=
Date:   Tue, 3 Aug 2021 07:13:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pete Zaitcev <zaitcev@redhat.com>
Cc:     Salah Triki <salah.triki@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: class: usblp: replace conditional statement with
 min()
Message-ID: <YQjQlG907psQo/iB@kroah.com>
References: <20210803002806.GA1541734@pc>
 <20210802205022.357279fc@suzdal.zaitcev.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802205022.357279fc@suzdal.zaitcev.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2021 at 08:50:22PM -0500, Pete Zaitcev wrote:
> On Tue, 3 Aug 2021 01:28:06 +0100
> Salah Triki <salah.triki@gmail.com> wrote:
> 
> > Replace conditional statement with min() in order to make code cleaner. Issue
> > found by coccinelle.
> 
> > +++ b/drivers/usb/class/usblp.c
> >  		request, !!dir, recip, value, index, len, retval);
> > -	return retval < 0 ? retval : 0;
> > +	return min(retval, 0);
> >  }
> 
> I'm very much against this change. The function min() is there
> for numeric values. But here we have a situation where we
> do one thing if there was an error, and another thing if
> there was no error.
> 
> This sort of abuse is exactly why blindly clicking heels
> whenever a tool tells you is not optimal.
> 
> If the objective is to shut the tool up, please consider
> the following instead:
> 
> diff --git a/drivers/usb/class/usblp.c b/drivers/usb/class/usblp.c
> index 9596e4279294..bbcbcf199fa9 100644
> --- a/drivers/usb/class/usblp.c
> +++ b/drivers/usb/class/usblp.c
> @@ -264,7 +264,9 @@ static int usblp_ctrl_msg(struct usblp *usblp, int request, int type, int dir, i
>         dev_dbg(&usblp->intf->dev,
>                 "usblp_control_msg: rq: 0x%02x dir: %d recip: %d value: %d idx: %d len: %#x result: %d\n",
>                 request, !!dir, recip, value, index, len, retval);
> -       return retval < 0 ? retval : 0;
> +       if (retval < 0)
> +               return retval;
> +       return 0;
>  }

I agree with Pete here, this is the "correct" fix for this, using min()
is not ok here.

thanks,

greg k-h
