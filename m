Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEE43595B6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 08:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbhDIGoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 02:44:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:38212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233296AbhDIGoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 02:44:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 25587600D1;
        Fri,  9 Apr 2021 06:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617950643;
        bh=V+LPiS0wXCRM9r81HlzxVPlmm7L5lizNQhFVG2u7um8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pzv2hpNuXzf7F2BF2g/8vlx74EDIbL7qL/ClY0Xvd4vd3JULuQgf4b+YJQdg7hSlD
         ZGU4109EA9e2jqdJPwHBZquTapquati/4XiTBK075OuqzsAqVtAHfkfWF0iUBdhFZC
         ignMUzPm3nLcLUuWtkvLes7qLJJK9N/o9mhke3AY=
Date:   Fri, 9 Apr 2021 08:44:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Min Li <min.li.xe@renesas.com>
Cc:     "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 2/2] misc: Add Renesas Synchronization
 Management Unit (SMU) support
Message-ID: <YG/3sZZZbsqdzARx@kroah.com>
References: <1617846650-10058-1-git-send-email-min.li.xe@renesas.com>
 <1617846650-10058-2-git-send-email-min.li.xe@renesas.com>
 <YG6hOuOO5EL9xTwH@kroah.com>
 <OSBPR01MB4773182AF8FD263D65D52949BA749@OSBPR01MB4773.jpnprd01.prod.outlook.com>
 <YG9DPEyOIXqS2Vss@kroah.com>
 <OSBPR01MB47730AA300DB8DBE08E74FEEBA749@OSBPR01MB4773.jpnprd01.prod.outlook.com>
 <YG9HDbMu3EbS3ekW@kroah.com>
 <OSBPR01MB47730D5F401A895C84849CCDBA749@OSBPR01MB4773.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSBPR01MB47730D5F401A895C84849CCDBA749@OSBPR01MB4773.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 06:59:19PM +0000, Min Li wrote:
> > 
> > But what does that have to do with the misc device?
> > 
> 
> Hi Greg, MFD driver is the start of everything. Once MFD driver is loading, it will spawn 2 devices,  
> one is for phc driver, which is under /driver/ptp and the other one is for this misc driver.  
> Both PHC and misc drivers are operating on the same device. 
> They are both calling exported functions from mfd drivers to access the device through i2c/spi 
> and the register definitions are located in include/Linux/mfd/idt8a340_reg.h or idt82p33_reg.h
> depending on which device was found by mfd driver through device tree node.

I don't think it's a good idea to have the same defines with different
values in different files, that's just a problem waiting to happen...

good luck!

greg k-h
