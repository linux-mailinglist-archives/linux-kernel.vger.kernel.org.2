Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9B73EDA24
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 17:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236593AbhHPPrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 11:47:51 -0400
Received: from smtpout2.vodafonemail.de ([145.253.239.133]:52054 "EHLO
        smtpout2.vodafonemail.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbhHPPrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 11:47:49 -0400
Received: from smtp.vodafone.de (smtpa03.fra-mediabeam.com [10.2.0.34])
        by smtpout2.vodafonemail.de (Postfix) with ESMTP id 45035126B40;
        Mon, 16 Aug 2021 17:47:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arcor.de;
        s=vfde-smtpout-mb-15sep; t=1629128833;
        bh=m1mi6bLDUEDrkJ7ZnqskJsntQYuUnUwLjU1TKGtFcDA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=f29BxauoAD8TRfzHiuyQTxJConnlmP8o1bfDF0rWiRmHTAXoThx+RbCsN0pEK2iFn
         +5LEwMfXauMxawcwbfosSG468GgsqTpZb9TXNJkGfGxr2xagc68OT1OHrg+EbsGSUA
         pcEFxzI40yPgSnatadx9aWzSjeSROYzZotY1W/ek=
Received: from arcor.de (p57a2393d.dip0.t-ipconnect.de [87.162.57.61])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp.vodafone.de (Postfix) with ESMTPSA id 89DE7140281;
        Mon, 16 Aug 2021 15:47:10 +0000 (UTC)
Date:   Mon, 16 Aug 2021 17:47:03 +0200
From:   Reinhard Speyerer <rspmn@arcor.de>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] [V2,1/1]USB: serial: option: add Foxconn T77W175
 composition 0x901d
Message-ID: <YRqId0FDc+ByYdVY@arcor.de>
References: <20210816035404.4210-1-slark_xiao@163.com>
 <YRoqAJmGBpV/OuZL@arcor.de>
 <d1d16fd.6f62.17b4e3ffa26.Coremail.slark_xiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1d16fd.6f62.17b4e3ffa26.Coremail.slark_xiao@163.com>
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 2320
X-purgate-ID: 155817::1629128833-00000B26-D289C0D7/0/0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 05:17:00PM +0800, Slark Xiao wrote:
> 
> At 2021-08-16 17:04:00, "Reinhard Speyerer" <rspmn@arcor.de> wrote:
> >On Mon, Aug 16, 2021 at 11:54:04AM +0800, Slark Xiao wrote:
> >> Foxconn SDX55 T77W175 device is working in PCIe mode normally.
> >> You can find the PCIe support in drivers/bus/mhi/pci_generic.c file.
> >> But in some scenario, we need to capture the memory dump once it crashed.
> >> So a diag port under USB driver is needed.
> >> 
> >> Only interface 0 is used:
> >> jbd@jbd-ThinkPad-P1-Gen-4:~$ lsusb | grep 05c6
> >> Bus 003 Device 010: ID 05c6:901d Qualcomm, Inc. Generic Mobile Broadband Adapter
> >> jbd@jbd-ThinkPad-P1-Gen-4:~$ lsusb -t | grep "Dev 10"
> >>     |__ Port 7: Dev 10, If 0, Class=Vendor Specific Class, Driver=option, 480M
> >> 
> >> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> >> ---
> >>  drivers/usb/serial/option.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >> 
> >> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> >> index 039450069ca4..c275f489c1cc 100644
> >> --- a/drivers/usb/serial/option.c
> >> +++ b/drivers/usb/serial/option.c
> >> @@ -2068,6 +2068,7 @@ static const struct usb_device_id option_ids[] = {
> >>  	  .driver_info = RSVD(0) | RSVD(1) | RSVD(6) },
> >>  	{ USB_DEVICE(0x0489, 0xe0b5),						/* Foxconn T77W968 ESIM */
> >>  	  .driver_info = RSVD(0) | RSVD(1) | RSVD(6) },
> >> +	{ USB_DEVICE(QUALCOMM_VENDOR_ID, 0x901d) },				/* Foxconn T77W175 PCIE+USB mode*/
> >>  	{ USB_DEVICE(0x1508, 0x1001),						/* Fibocom NL668 (IOT version) */
> >>  	  .driver_info = RSVD(4) | RSVD(5) | RSVD(6) },
> >>  	{ USB_DEVICE(0x2cb7, 0x0104),						/* Fibocom NL678 series */
> >> -- 
> >> 2.25.1
> >> 
> >> 
> >
> >Hi Slark,
> >
> >since this entry uses the Qualcomm USB VID it would be a good idea to make
> >the option driver only bind to the DIAG interface in case other UE vendors
> >have the ADB interface provided by this composition enabled:
> > [...]
> 
> Hi Reinhard,
>   So should I use USB_DEVICE_INTERFACE_NUMBER(QUALCOMM_VENDOR_ID, 0x901d, 0x00) to bind Diag port only?
> 
> Thanks

Hi Slark,

I think this would the preferred approach.

I'll let Johan advise on the preferred position of the new entry in the
device id table.

Regards,
Reinhard
