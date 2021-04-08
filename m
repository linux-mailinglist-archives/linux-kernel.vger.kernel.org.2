Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55FBF357C7B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 08:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbhDHGUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 02:20:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:35858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231166AbhDHGUw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 02:20:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C28B561178;
        Thu,  8 Apr 2021 06:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617862841;
        bh=7hFowIWUdB1Lgit5lHIa9J9UinB7xnpzVMK6aSXV2e8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oRGWIc5ODA1lw+fHM5PaAJFIXs5k90Br1GwXl1y9CKRCjBDP8h2dsULB7NT8sNLeg
         GO+jBSu8aR4jWvorcwHj7lmdcTCAX7mm0YXB7izjYKGOy7ny+rsVUiKR2tafnZ8Tk6
         Ml7QbkbgQJ3e45mUht2o5l6qmdH51WtLscJg/urU=
Date:   Thu, 8 Apr 2021 08:20:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Min Li <min.li.xe@renesas.com>
Cc:     "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 2/2] misc: Add Renesas Synchronization
 Management Unit (SMU) support
Message-ID: <YG6gtoOtqJSv63fg@kroah.com>
References: <1617816815-3785-1-git-send-email-min.li.xe@renesas.com>
 <1617816815-3785-2-git-send-email-min.li.xe@renesas.com>
 <YG3wRJnootNdV0cc@kroah.com>
 <OSBPR01MB4773A83DF7D1CDA4DBFD9E84BA759@OSBPR01MB4773.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSBPR01MB4773A83DF7D1CDA4DBFD9E84BA759@OSBPR01MB4773.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 08:00:38PM +0000, Min Li wrote:
> > 
> > Do you really meen "+" here?  (sorry, have to ask.)
> > 
> 
> I don't know. All of our Linux kernel code has GPL-2.0+ and I just blindly inherit it.

You should ask your managers :)

> 
> > > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > 
> > You should not need this as it's a driver, so you should only use the
> > dev_dbg() family of print message functions, no need for pr_*() calls.
> > 
> I have one call to pr_err in rsmu_init
> 
> pr_err("Unabled to register %s platform driver", DRIVER_NAME); 
> 

My recommendation in another email shows that the line above is not
needed...

thanks,

greg k-h
