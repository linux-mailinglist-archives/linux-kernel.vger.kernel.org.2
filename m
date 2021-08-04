Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B99D3E00C5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 14:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237937AbhHDMDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 08:03:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:54942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237148AbhHDMDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 08:03:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5852A60F22;
        Wed,  4 Aug 2021 12:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628078582;
        bh=tgNOdqKx8V6QH+68UnW8H7w3PF0OXwRdh17tL2J0lI4=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=jJ8mkuR3a/L15l+BrLwwYhROuzmLkYaIb59uUY8GuW70X5+5qaTy+HNWxZWlWsiaV
         RL3C/ExqI64NQLUzoEap/qfohCT7jEOQbifJc+/zuk1xwNJ8rnyDqrrC7B/Ib789vu
         9sm6Oue0MbCdVTpPgdg1tNPu4+zUI2DMshPp6T78=
Date:   Wed, 4 Aug 2021 14:03:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Salah Triki <salah.triki@gmail.com>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        Ross Schmidt <ross.schm.dev@gmail.com>,
        Marco Cesati <marcocesati@gmail.com>,
        Brother Matthew De Angelis <matthew.v.deangelis@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ivan Safonov <insafonov@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tablet: acecad: update the reference count of the usb
 interface structure
Message-ID: <YQqB9Pl1tvloKHWZ@kroah.com>
References: <20210731160938.GA909566@pc>
 <20210804105838.GE1931@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804105838.GE1931@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2021 at 01:58:38PM +0300, Dan Carpenter wrote:
> On Sat, Jul 31, 2021 at 05:09:38PM +0100, Salah Triki wrote:
> >  drivers/input/tablet/acecad.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/input/tablet/acecad.c b/drivers/input/tablet/acecad.c
> > index a38d1fe97334..85fe134a30ee 100644
> > --- a/drivers/input/tablet/acecad.c
> > +++ b/drivers/input/tablet/acecad.c
> > @@ -151,7 +151,7 @@ static int usb_acecad_probe(struct usb_interface *intf, const struct usb_device_
> >  		goto fail2;
> >  	}
> >  
> > -	acecad->intf = intf;
> > +	acecad->intf = usb_get_intf(intf);
> >  	acecad->input = input_dev;
> >  
> >  	if (dev->manufacturer)
> 
> As I mentioned earlier, you need to drop the reference if
> input_register_device() fails.

Also as mentioned in other threads, this is not needed at all.
