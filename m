Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCA744E5AD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 12:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234837AbhKLLqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 06:46:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:38596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234144AbhKLLqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 06:46:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF04960F5B;
        Fri, 12 Nov 2021 11:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636717403;
        bh=dKpfDmG6ocfPhcD3bOXlWfj54si9WcvQHXi/ZKCnCf8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sDJOkN0MTf7JFjQriM0IwyWxsDXh8GF3vvnKPEU20hXOhTzeg8g4y7LXkwUVtzuY2
         3Q6hWTGK93eluvYOAulTCfkmXYVrXMSHovXKeRNTfoOghmQjAoPHmJpcFTO6LUZj9X
         qTsogP57eL8lPMaEseKceaabTgQpxyH5U6cUSalM=
Date:   Fri, 12 Nov 2021 12:43:20 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Super Zhang <superzmj@fibocom.corp-partner.google.com>
Cc:     johan@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: add Fibocom FM101-GL variants
Message-ID: <YY5TWKrX29tHG+Lh@kroah.com>
References: <20211112110638.751141-1-superzmj@fibocom.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211112110638.751141-1-superzmj@fibocom.corp-partner.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 07:06:38PM +0800, Super Zhang wrote:
> Update the USB serial option driver support for the Fibocom
> FM101-GL Cat.6
> LTE modules as there are actually several different variants.
> - VID:PID 2cb7:01a4, FM101-GL for laptop debug M.2 cards(adb
>   interface)
> - VID:PID 2cb7:01a2, FM101-GL are laptop M.2 cards (with
> MBIM interfaces for /Linux/Chrome OS)
> 
> T:  Bus=02 Lev=01 Prnt=01 Port=03 Cnt=01 Dev#=  2 Spd=5000
> MxCh= 0
> D:  Ver= 3.20 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 9 #Cfgs=  1
> P:  Vendor=2cb7 ProdID=01a2 Rev= 5.04
> S:  Manufacturer=Fibocom Wireless Inc.
> S:  Product=Fibocom FM101-GL Module
> S:  SerialNumber=86bffe63
> C:* #Ifs= 7 Cfg#= 1 Atr=a0 MxPwr=896mA
> A:  FirstIf#= 0 IfCount= 2 Cls=02(comm.) Sub=0e Prot=00
> I:* If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=0e Prot=00
> Driver=cdc_mbim
> I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30
> Driver=(none)
> I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40
> Driver=(none)
> I:* If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40
> Driver=(none)
> I:* If#= 5 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40
> Driver=(none)
> I:* If#= 6 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=40
> Driver=(none)
> 

Any chance you can not line-wrap these lines?


> T:  Bus=02 Lev=01 Prnt=01 Port=03 Cnt=01 Dev#=  3 Spd=5000 MxCh= 0
> D:  Ver= 3.20 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 9 #Cfgs=  1
> P:  Vendor=2cb7 ProdID=01a4 Rev= 5.04
> S:  Manufacturer=Fibocom Wireless Inc.
> S:  Product=Fibocom FM101-GL Module
> S:  SerialNumber=86bffe63
> C:* #Ifs= 7 Cfg#= 1 Atr=a0 MxPwr=896mA
> A:  FirstIf#= 0 IfCount= 2 Cls=02(comm.) Sub=0e Prot=00
> I:* If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=0e Prot=00
> Driver=cdc_mbim
> I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30
> Driver=(none)
> I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40
> Driver=(none)
> I:* If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01
> Driver=(none)
> I:* If#= 5 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=40
> Driver=(none)
> I:* If#= 6 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=40
> Driver=(none)
> 
> Signed-off-by: Super Zhang <superzmj@fibocom.corp-partner.google.com>

This is not a valid email address for you, please use your normal
corporate address, I doubt google wants to take responsibility for this
:)

thanks,

greg k-h
