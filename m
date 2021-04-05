Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA9F353C1B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 08:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbhDEGhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 02:37:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:40728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229454AbhDEGhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 02:37:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5BF4D6136A;
        Mon,  5 Apr 2021 06:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617604635;
        bh=5gVVDApxDE727+sQmgX9LOvwnQ1a2o/ReODaf2h5t3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Va6HTzdtHEQKMGkzW68DUK/FRLooxyw1XvN4z6CxHnPAJKZa1wW79ljuNEehzkhyX
         STWawxUVDnrXJkWyCXLOzviovq5212Cfzy4gyd5/+ZrN8RNk+Qr5SVAG/f1ypND6Fq
         e2cgbUw0bOFcRiJh+8vm6EsT/clpKdpMBqvdYBis=
Date:   Mon, 5 Apr 2021 08:37:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Min Li <min.li.xe@renesas.com>
Cc:     "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH next 2/2] misc: Add Renesas Synchronization Management
 Unit (SMU) support
Message-ID: <YGqwGeSCdJwH33od@kroah.com>
References: <1617487714-8312-1-git-send-email-min.li.xe@renesas.com>
 <1617487714-8312-2-git-send-email-min.li.xe@renesas.com>
 <YGmQKyweNi3lWoGM@kroah.com>
 <OSBPR01MB477323303D45865B0B2AD96CBA779@OSBPR01MB4773.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSBPR01MB477323303D45865B0B2AD96CBA779@OSBPR01MB4773.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2021 at 01:52:39AM +0000, Min Li wrote:
> > 
> > Any specific reason you are not using the misc_device api?  That would clean
> > up this driver a lot, there's no need to create a whole class just for a single
> > driver.
> > 
> 
> Hi Greg
> 
> No specific reason. I just didn't know the existence of misc_register API. 

Your file is in drivers/misc/ :)

> Do you recommend using this API to create the device?

Yes.

> If yes, can you tell me how to obtain a appropriate MINOR number from
> miscdevice.h?

No need to reserve one, we don't do that anymore, just ask for a dynamic
value and the next availble one will be given to your driver
automatically.

thanks,

greg k-h
