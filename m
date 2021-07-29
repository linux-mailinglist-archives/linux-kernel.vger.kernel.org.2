Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 653003DA5AF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 16:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239511AbhG2OIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 10:08:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:49234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238414AbhG2OBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 10:01:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B7A460F46;
        Thu, 29 Jul 2021 14:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627567239;
        bh=dfkJ5JWovbN7hrPh+/DOSX2blRKtDHtFfpmCFJcwVBA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lDjgwEqBeUxy8ewu5AMQ3JFDqXpJeM7vG8T/ti9w7t0fMs7/564vxsdmgXmjLNecy
         QIMzMQ/rhxOMnSU6gqKlKJxBZpIjuK8YPaCq9rbWtXryVkyNeWvtq6obKcFKUmv8hX
         zUuKtVTEuNZvuNb1VS80UwK/RHGSsrQ3a5yUBgMk=
Date:   Thu, 29 Jul 2021 16:00:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Phillip Potter <phil@philpotter.co.uk>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-staging@lists.linux.dev, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: Re: [PATCH v4 0/6] staging: r8188eu: add newer/better RTL8188eu
 driver
Message-ID: <YQK0ZMY34AFYtzN4@kroah.com>
References: <20210727232219.2948-1-phil@philpotter.co.uk>
 <20210728074605.pp5rs4c65tofnqot@viti.kaiser.cx>
 <CAA=Fs0mH9YAVhr24YeE3jpZrnuDGhOuhj=Sb9Ekkpb-xoC5LYg@mail.gmail.com>
 <20210729133730.lnxqzawnvksp4skg@viti.kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729133730.lnxqzawnvksp4skg@viti.kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2021 at 03:37:30PM +0200, Martin Kaiser wrote:
> Hi Phil and all,
> 
> Thus wrote Phillip Potter (phil@philpotter.co.uk):
> 
> > I see what you are saying for sure - I think we've both sunk a fair
> > few patches into the existing driver :-)
> 
> > That said, from what Larry has mentioned, this newer driver would
> > still be a better bet overall due to the additional work that has
> > already happened on it out-of-tree. The Realtek driver you reference
> > probably has no CFG80211 support etc. would be my guess, but I am
> > going off what others have suggested in terms of proposing this
> > patchset. I can't honestly say what the risk of this happening again
> > would be, but minimal I'd imagine.
> 
> ok, understood. That's an important feature. I see that Greg accepted
> your patches, there's no point in arguing any more ;-)
> 
> Greg and Larry: Would you mind sharing your ideas about getting
> rtl8188eu support mainline? Do you imagine that we clean up this driver
> until it can be moved out of staging?

Yes, it's that "simple" :)

> If so, we'd probably have to resolve name conflicts with other realtek
> drivers and rename lots of functions.

Odds are that will happen as the code is cleaned up, right?

> Or would a cleanup of the new rtl8188eu driver be a preparation for
> adding bits and pieces of it to rtlwifi?

Do you think it will fit into that framework?

thanks,

greg k-h
