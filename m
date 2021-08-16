Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD363ED0D6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 11:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234976AbhHPJHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 05:07:01 -0400
Received: from smtpout2.vodafonemail.de ([145.253.239.133]:39778 "EHLO
        smtpout2.vodafonemail.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235284AbhHPJG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 05:06:26 -0400
Received: from smtp.vodafone.de (smtpa08.fra-mediabeam.com [10.2.0.39])
        by smtpout2.vodafonemail.de (Postfix) with ESMTP id 0876C125C9C;
        Mon, 16 Aug 2021 11:04:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arcor.de;
        s=vfde-smtpout-mb-15sep; t=1629104652;
        bh=chbgSvyqMrs/RDUVSKxoE0r4FFnnKpAGJRedrJBuPsc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=S3c5pipw6JNaSo1hvzEImvC0BAwfwWtInpC7XKjHCLjPMuSXSbmpLzS/R8o8/Th3W
         mX6IEUm/EEhgdQ/ttL7ug3kyf7wK1hL5yE/9WQiWRmy8hnEvMqWAPswqfgH6caZjjX
         kXaTm3FajkG0YOja/irfCR2M8eEWXYns7W74xAsc=
Received: from arcor.de (p5b28106c.dip0.t-ipconnect.de [91.40.16.108])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp.vodafone.de (Postfix) with ESMTPSA id 67B1D1401B3;
        Mon, 16 Aug 2021 09:04:11 +0000 (UTC)
Date:   Mon, 16 Aug 2021 11:04:00 +0200
From:   Reinhard Speyerer <rspmn@arcor.de>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [V2,1/1]USB: serial: option: add Foxconn T77W175
 composition 0x901d
Message-ID: <YRoqAJmGBpV/OuZL@arcor.de>
References: <20210816035404.4210-1-slark_xiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816035404.4210-1-slark_xiao@163.com>
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 3612
X-purgate-ID: 155817::1629104651-00007455-FE839557/0/0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 11:54:04AM +0800, Slark Xiao wrote:
> Foxconn SDX55 T77W175 device is working in PCIe mode normally.
> You can find the PCIe support in drivers/bus/mhi/pci_generic.c file.
> But in some scenario, we need to capture the memory dump once it crashed.
> So a diag port under USB driver is needed.
> 
> Only interface 0 is used:
> jbd@jbd-ThinkPad-P1-Gen-4:~$ lsusb | grep 05c6
> Bus 003 Device 010: ID 05c6:901d Qualcomm, Inc. Generic Mobile Broadband Adapter
> jbd@jbd-ThinkPad-P1-Gen-4:~$ lsusb -t | grep "Dev 10"
>     |__ Port 7: Dev 10, If 0, Class=Vendor Specific Class, Driver=option, 480M
> 
> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> ---
>  drivers/usb/serial/option.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> index 039450069ca4..c275f489c1cc 100644
> --- a/drivers/usb/serial/option.c
> +++ b/drivers/usb/serial/option.c
> @@ -2068,6 +2068,7 @@ static const struct usb_device_id option_ids[] = {
>  	  .driver_info = RSVD(0) | RSVD(1) | RSVD(6) },
>  	{ USB_DEVICE(0x0489, 0xe0b5),						/* Foxconn T77W968 ESIM */
>  	  .driver_info = RSVD(0) | RSVD(1) | RSVD(6) },
> +	{ USB_DEVICE(QUALCOMM_VENDOR_ID, 0x901d) },				/* Foxconn T77W175 PCIE+USB mode*/
>  	{ USB_DEVICE(0x1508, 0x1001),						/* Fibocom NL668 (IOT version) */
>  	  .driver_info = RSVD(4) | RSVD(5) | RSVD(6) },
>  	{ USB_DEVICE(0x2cb7, 0x0104),						/* Fibocom NL678 series */
> -- 
> 2.25.1
> 
> 

Hi Slark,

since this entry uses the Qualcomm USB VID it would be a good idea to make
the option driver only bind to the DIAG interface in case other UE vendors
have the ADB interface provided by this composition enabled:

$ sed 30q 901D
#!/bin/sh
#
# Copyright (c) 2014,2017-2018, The Linux Foundation. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of The Linux Foundation nor the names of its
#       contributors may be used to endorse or promote products derived from
#       this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
# INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT ARE DISCLAIMED.  IN NO
# EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
# INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# DESCRIPTION: DIAG + ADB

echo "Switching to composition number 0x901D"  > /dev/kmsg


[Ideally these compositions would also be available via kernel.org and/or
 codeaura.org but so far I have been unable to find them there.]

Regards,
Reinhard
