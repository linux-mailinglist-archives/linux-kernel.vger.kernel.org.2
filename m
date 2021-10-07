Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84BA5424E61
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 09:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbhJGH65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 03:58:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:55146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240316AbhJGH64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 03:58:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C04B861029;
        Thu,  7 Oct 2021 07:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633593422;
        bh=EUlwA4dsoXeeKLviFdk42tbmlamxNeb1B3c2EGU0Mhs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EAJNopuYrLItO+XEKtnfkTRAloz9GOXNkovZYuxxQabEa8YAYliAqHwCee8rFCsjr
         a9jjfvvhR9Cr8xKNHpl5jgN4fboQQVr6vixK8vDYFuiSUtjADqhLELfCKuGFhoXnXF
         ZCeOOM4bbbT1AS6CKoikB/VauRkmgvfBoZX6tYiYfOX7Ss9pm4M6HGFu6vcNnwAsO5
         jOjDd6f6EnRn9fCLfzu19zKAkcDmxC7eimmIhOgOT8QnBMTL2OIdq2qVPl4s869GWa
         ngLfz/hS75alb8EE4YrzHeEWzcUby44PvfORD62JajwVv19gWeaZRMsJ/AJPRVH4uZ
         3Y8vjGKgBsK/Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mYOGz-0006jn-Gv; Thu, 07 Oct 2021 09:57:01 +0200
Date:   Thu, 7 Oct 2021 09:57:01 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Yu-Tung Chang <mtwget@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] USB: serial: option: add Quectel EC200S-CN module
 support
Message-ID: <YV6oTZae5zbgX8cV@hovoldconsulting.com>
References: <20210930021112.330396-1-mtwget@gmail.com>
 <YV6mD02BVLXXcTr8@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YV6mD02BVLXXcTr8@hovoldconsulting.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2021 at 09:47:28AM +0200, Johan Hovold wrote:
> On Thu, Sep 30, 2021 at 10:11:12AM +0800, Yu-Tung Chang wrote:
> > Add usb product id of the Quectel EC200S-CN module.
> > 
> > usb-devices output for 0x6002:
> > T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  3 Spd=480 MxCh= 0
> > D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
> > P:  Vendor=2c7c ProdID=6002 Rev=03.18
> > S:  Manufacturer=Android
> > S:  Product=Android
> > S:  SerialNumber=0000
> > C:  #Ifs= 5 Cfg#= 1 Atr=e0 MxPwr=500mA
> > I:  If#=0x0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=06 Prot=00 Driver=cdc_ether
> > I:  If#=0x1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
> > I:  If#=0x2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)
> > I:  If#=0x3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)
> > I:  If#=0x4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)
> 
> Looks good now, but for completeness, could you also mention here what
> the three ports are used for (and which is which)?

I've applied the patch now, so no need to resend, but please list the
three ports in a reply if you have that information.

Johan
