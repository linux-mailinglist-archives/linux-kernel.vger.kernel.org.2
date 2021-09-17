Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D1140FA1E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 16:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239193AbhIQO0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 10:26:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:44228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233943AbhIQO0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 10:26:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 080CC61130;
        Fri, 17 Sep 2021 14:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631888715;
        bh=E3mDeuPqZnj6PmvtQ1rG0uL0Gs/zr9Vd7ruFoBx6kjw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CL3wJLEORe0FSJds0lt6cQbmZbbV2FUxBVcFvbKEd/M0xwnqiK14HilCsgQ5fquCY
         o0XpxOg0PaPl3TiEM/VkHyEff89fN1j3aFTwkm/HZGvl9oM/pVN+/oiGdMLzDsge8h
         cIem6CuJFxaaxECQ048pYUmsrxPiluEerWksUfUk=
Date:   Fri, 17 Sep 2021 16:25:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Fabio Aiuto <fabioaiuto83@gmail.com>, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: protect sleepq_len access by
 sleep_q.lock
Message-ID: <YUSlSDz3k9CZdGbP@kroah.com>
References: <20210913130346.2390-1-fabioaiuto83@gmail.com>
 <d6d6c6bf-b787-aac9-4767-4bf54c5437ac@redhat.com>
 <20210913133915.GA1414@agape.jhs>
 <30e138d5-fc51-bbcd-4dfc-3264c258c0bc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30e138d5-fc51-bbcd-4dfc-3264c258c0bc@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 05:12:19PM +0200, Hans de Goede wrote:
> Hi Fabio,
> 
> On 9/13/21 3:39 PM, Fabio Aiuto wrote:
> > Hello Hans,
> > 
> > On Mon, Sep 13, 2021 at 03:24:44PM +0200, Hans de Goede wrote:
> >> Hi Fabio,
> >>
> >  
> >>> Note that sleep_q.lock is already taken inside
> >>> rtw_free_xmitframe_queue so we just wrap sleepq_len
> >>> access.
> >>>
> >>> Moved pxmitpriv->lock after sleep_q.lock release to
> >>> avoid locks nesting.
> > 
> >>>  	rtw_free_xmitframe_queue(pxmitpriv, &psta->sleep_q);
> >>> +	spin_lock_bh(&psta->sleep_q.lock);
> >>
> >> AFAICT this needs to be above the rtw_free_xmitframe_queue() ?
> > 
> > as I wrote on the changelog, the sleep_q.lock is already
> > taken inside rtw_free_xmitframe_queue. If I put the
> > sleep_q.lock above that function a soft lock occurs when
> > I disconnect.
> > 
> > So I put it just below rtw_free_xmitframe_queue.
> > 
> > Things works fine this way.
> > 
> > Please tell me if there's a best way to do it.
> 
> Hmm I see, this may work, but the sleepq_len access
> really should be protected by the same lock as the freeing
> of the queue is without dropping it in between.
> 
> That rtw_free_xmitframe_queue() takes the sleep_q.lock
> then to me that signals that other (higher-level) functions should
> not take sleep_q.lock at all, since this is then private to the
> functions operating on the sleep_q.
> 
> I've an idea how we we can possibly tackle this, but I'm not sure
> yet I will try to make some time to look into this tomorrow or
> the day after.

I'm just going to go and revert the original change here until you all
can sort it out :)

thanks,

greg k-h
