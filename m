Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 880F93E9EC3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 08:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234597AbhHLGrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 02:47:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:53936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231253AbhHLGrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 02:47:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 87E2460EB9;
        Thu, 12 Aug 2021 06:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628750817;
        bh=YsjAUE0JzYW/Ne5nsjhvS55vm6pDwGdT0PyX4b+w704=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GB7TGjcPQyWIxWGZvmqonkxPb9ZO52BjgHA1NPgr35nOb+YsYO5SUbhp8fSQSdSE5
         HLAcOG/r/2lEMoiG3HAR3dbaxCzPjqoxH580p90ovRINFv2P87SpDUMGqk5YSywpLD
         ZiWqO9BFY6wLW6sBJ0IQ0JQPEBPWqzktlt9pMToA=
Date:   Thu, 12 Aug 2021 08:46:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     johan@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] [v2,1/1] This aims to support Foxconn SDX55
Message-ID: <YRTD3szluseOmv8f@kroah.com>
References: <20210811085635.4699-1-slark_xiao@163.com>
 <YRO3nDjt52EF1uVz@kroah.com>
 <20ff1e24.a43.17b380ffaf4.Coremail.slark_xiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20ff1e24.a43.17b380ffaf4.Coremail.slark_xiao@163.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2021 at 09:52:56AM +0800, Slark Xiao wrote:
> At 2021-08-11 19:42:20, "Greg KH" <gregkh@linuxfoundation.org> wrote:
> >On Wed, Aug 11, 2021 at 04:56:35PM +0800, Slark Xiao wrote:
> >> Foxconn SDX55 T77W175 device is working in PCIe mode normally.
> >> You can find it in drivers/bus/mhi/pci_geneirc.c file.
> >> But in some scenario, we need to capture the memory dump once it crashed.
> >> So a diag port driver is needed.
> >> 
> >> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> >> ---
> >>  drivers/usb/serial/qcserial.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >> 
> >> diff --git a/drivers/usb/serial/qcserial.c b/drivers/usb/serial/qcserial.c
> >> index 83da8236e3c8..d8b58aea3c60 100644
> >> --- a/drivers/usb/serial/qcserial.c
> >> +++ b/drivers/usb/serial/qcserial.c
> >> @@ -111,6 +111,7 @@ static const struct usb_device_id id_table[] = {
> >>  	{USB_DEVICE(0x16d8, 0x8002)},	/* CMDTech Gobi 2000 Modem device (VU922) */
> >>  	{USB_DEVICE(0x05c6, 0x9204)},	/* Gobi 2000 QDL device */
> >>  	{USB_DEVICE(0x05c6, 0x9205)},	/* Gobi 2000 Modem device */
> >> +	{USB_DEVICE(0x05c6, 0x901d)},	/* Foxconn SDX55 QDL */
> >
> >Why is this not sorted?
> >
> >And the subject needs some work still...
> >
> >thanks,
> >
> >greg k-h
> 
> Hi Greg,
>   Sorry,  can you show me where should I put it at?

If it belongs in this list, then it should be in sorted order, which you
did not do here, so that would be a good idea, right?

>   According to Bjørn comment, I think I need to create a new layout for Foxconn SDX55 device.

That is up to you and Bjørn to work out :)

thanks,

greg k-h
