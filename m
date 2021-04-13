Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8974E35DC72
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 12:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241910AbhDMKZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 06:25:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:44162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230088AbhDMKZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 06:25:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 266A6613BC;
        Tue, 13 Apr 2021 10:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618309495;
        bh=ONbuNQKp4fLe2bXBPC0OBnwwqYpiefNv8y21f4kKdvQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vMn9xkkjtmrWuorc5uSelPm2QrS+0jAN9sEyslN3+Wac72MPnsWzYwQpT64qjE1x6
         0LEaGRZmMHFdgPjsOVOpp9WwSIXrJd91lpoiipqpZV39NBecaOIo4ZFryDpwu91DV6
         Uc1FXC0/ZxIX8y9seQrHLp09QBGPQJGUQ5uwcrVU=
Date:   Tue, 13 Apr 2021 12:24:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc:     Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Youn <John.Youn@synopsys.com>
Subject: Re: [PATCH 07/12] usb: dwc2: Update enter clock gating when port is
 suspended
Message-ID: <YHVxdVDSPgmtIBRd@kroah.com>
References: <cover.1618297800.git.Arthur.Petrosyan@synopsys.com>
 <9ed1da9780cddf995841cc5867f195024f5a16d9.1618297800.git.Arthur.Petrosyan@synopsys.com>
 <2dc3798a-6a89-b363-aade-e127decfdf20@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2dc3798a-6a89-b363-aade-e127decfdf20@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 12:22:35PM +0300, Sergei Shtylyov wrote:
> Hello!
> 
> On 13.04.2021 10:17, Artur Petrosyan wrote:
> 
> > Updates the implementation of entering clock gating mode
> > when core receives port suspend.
> > Instead of setting the required bit fields of the registers
> > inline, called the "dwc2_host_enter_clock_gating()" function.
> > 
> > Signed-off-by: Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
> > ---
> >   drivers/usb/dwc2/hcd.c | 19 ++++---------------
> >   1 file changed, 4 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
> > index 27f030d5de54..e1225fe6c61a 100644
> > --- a/drivers/usb/dwc2/hcd.c
> > +++ b/drivers/usb/dwc2/hcd.c
> [...]
> > @@ -3323,22 +3322,12 @@ int dwc2_port_suspend(struct dwc2_hsotg *hsotg, u16 windex)
> >   		break;
> >   	case DWC2_POWER_DOWN_PARAM_HIBERNATION:
> >   	case DWC2_POWER_DOWN_PARAM_NONE:
> > -	default:
> > -		hprt0 = dwc2_read_hprt0(hsotg);
> > -		hprt0 |= HPRT0_SUSP;
> > -		dwc2_writel(hsotg, hprt0, HPRT0);
> > -		hsotg->bus_suspended = true;
> >   		/*
> > -		 * If power_down is supported, Phy clock will be suspended
> > -		 * after registers are backuped.
> > +		 * If not hibernation nor partial power down are supported,
> 
>    s/not/neither/?

It's fine, not a big deal at all.

greg k-h
