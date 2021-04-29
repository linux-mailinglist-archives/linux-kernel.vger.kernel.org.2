Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB74536E52A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 08:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbhD2Gzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 02:55:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:57412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229814AbhD2Gzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 02:55:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F06A6141E;
        Thu, 29 Apr 2021 06:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619679305;
        bh=MwMz82hw2zlO0Xlg+tehPqJXtowu2LTKbKEv/YGYl7w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f4RfcpBrvonll+RNLrdlZhlpVHyXb9riZqN1E8XFh/918b69u7jDOAMmpGfj4h+ae
         LHs2Mcy+yH7w7TaBJIuOVRnf/dasi1jRI8i8+hiLWfylzf1aagCY/aNmCGOheJIUiQ
         tff4pW0Ob6mX3yZD7BGocDSUGKvwbKwlIqaD12WX4SVivJUlIfghym9QYeE754ruCC
         fcPyYFjPhgZ2H7u16osUANhNr8m4h6Mg//lDLrt32QODpOwfRwssDgp6CvmalO+xC6
         M/4UPD0dLYvE/LX9QXfhtUUuwpMrLljMJVzA9wunzFKBcIMHlkLXIbfC2k/Ryp3iAQ
         hALdNzlMWV8Sw==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lc0Zy-0005eB-Nw; Thu, 29 Apr 2021 08:55:18 +0200
Date:   Thu, 29 Apr 2021 08:55:18 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Tung Pham <Tung.Pham@silabs.com>
Cc:     Pho Tran <photranvan0712@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hung Nguyen <Hung.Nguyen@silabs.com>,
        Pho Tran <Pho.Tran@silabs.com>
Subject: Re: [PATCH v9] USB: serial: cp210x: Add support for GPIOs on CP2108
Message-ID: <YIpYVk0bwIXFyAuE@hovoldconsulting.com>
References: <20210408103607.2077-1-photranvan0712@gmail.com>
 <YIA8HD0S6C+x5ZC9@hovoldconsulting.com>
 <CO1PR11MB48829DEA0747C1B19278868E81429@CO1PR11MB4882.namprd11.prod.outlook.com>
 <YIksjb9IjOwSpPgw@hovoldconsulting.com>
 <CO1PR11MB4882A90461E033F8EA301C07815F9@CO1PR11MB4882.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR11MB4882A90461E033F8EA301C07815F9@CO1PR11MB4882.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 02:54:09AM +0000, Tung Pham wrote:

> So my questions again are:
> 
>  1) Have you verified that the struct cp210x_quad_port_config above
>     actually matches what the device uses?
> 
>  2) Do you have any documentation of the structures as expected by the
>     device firmware (not your library)?
> 
> 
> Tung Pham: the device return some unused bytes, and manufacturing
> library already discard these byte to assign value to PORT_CONFIG, so
> you don't see padding byte on PORT_CONFIG structure.   you can find
> the structure  of port setting in this code: 
> 
> https://www.silabs.com/documents/public/software/USBXpressHostSDK-Linux.tar
> 
> 
> \USBXpressHostSDK-Linux\USBXpressHostSDK\CP210x\srcpkg\cp210xmanufacturing_1.0.tar\cp210xmanufacturing_1.0\cp210xmanufacturing\cp210xmanufacturing\src\CP2104Device.cpp
> 
> CP210x_STATUS CCP2104Device::GetPortConfig(PORT_CONFIG* PortConfig)

Thanks for confirming.

Johan
