Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4668B31D5A3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 08:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbhBQHMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 02:12:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:35044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230303AbhBQHMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 02:12:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EE5A764E04;
        Wed, 17 Feb 2021 07:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613545912;
        bh=FTzZy1+mlY4jv8+ZdbLcvn9lAPWJCOljHpoQiyFn9S8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=THn6EDBmXDj49dC0hs/2dp/JLilvYiR/hrlLWKJgkpmMohB7/EWB0i6gCDZhrxavm
         hMH+N/I/63h2u2BFKDQMKlblR1i71BrVEdyw4V8UgRrKZ0l+DT3oDzM6lwSRVvgPm6
         YTcVwqsBMfMrQ359T/spIARdb0RUNnCVuJwhJpOk=
Date:   Wed, 17 Feb 2021 08:11:49 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Min Li <min.li.xe@renesas.com>
Cc:     "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2] misc: Add Renesas Synchronization Management
 Unit (SMU) support
Message-ID: <YCzBtRaVJcoJ1DzA@kroah.com>
References: <1613092575-17311-1-git-send-email-min.li.xe@renesas.com>
 <YCYw5xXe16fSj6eI@kroah.com>
 <OSBPR01MB4773472EE0C8D34456C79121BA8B9@OSBPR01MB4773.jpnprd01.prod.outlook.com>
 <YCak7Eu2X0dzapPz@kroah.com>
 <OSBPR01MB47733B3FE2242E0338DC5983BA8B9@OSBPR01MB4773.jpnprd01.prod.outlook.com>
 <YCeNlIDDO+2SqNkx@kroah.com>
 <OSBPR01MB477356F3FBDCB752286C65D0BA879@OSBPR01MB4773.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSBPR01MB477356F3FBDCB752286C65D0BA879@OSBPR01MB4773.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 07:50:49PM +0000, Min Li wrote:
> > 
> > Yes, that line.
> > 
> > The documentation should tell you how to do that, as per my patch bot:
> > 
> > - This looks like a new version of a previously submitted patch, but you
> >   did not list below the --- line any changes from the previous version.
> >   Please read the section entitled "The canonical patch format" in the
> >   kernel file, Documentation/SubmittingPatches for what needs to be done
> >   here to properly describe this.
> > 
> > thanks,
> > 
> > greg k-h
> 
> Hi Greg
> 
> I read documentation. Am I supposed to add the "---" marker line manually by myself when doing "git commit --amend"? git commit will
> always add a "---" marker line before the actual change like below
> 
> Signed-off-by: Min Li <min.li.xe@renesas.com>
> ---
> Changes since v1:
> -Provide more background for purpose of the change.
> -Provide compat_ioctl support
> -Fix ioctl cmd definition
> ---
>  drivers/misc/Kconfig      |  13 ++
>  drivers/misc/Makefile     |   3 +

You add the text after you have created the patch with 'git
format-patch' by editing the text file before sending it off to us.  You
don't add it to the changelog comment itself.

hope this helps,

greg k-h
