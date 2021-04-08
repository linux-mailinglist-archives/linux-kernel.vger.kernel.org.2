Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98CD358BF1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 20:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbhDHSKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 14:10:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:36690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231716AbhDHSKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 14:10:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 637BA610CA;
        Thu,  8 Apr 2021 18:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617905424;
        bh=b6UhGDmqyefe9/qRro35BT4OuGSkRxu8JrK/cweYHaU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vRbXIvaTTZpAhWapgDxanygLRb1k8inDDUlUr8Zx8mZm/oe+AuTPhbbIM9XR03qKN
         Hwfww9S3q127AT1zTg8PvyqEwhPCuPJBIY4Zj2bHkOVwlFX/Nn7uj5KKZnc0FktKnP
         uDqqPeNpqKJaXRwElGGzhjNmn4Txdqp4tcugEEfI=
Date:   Thu, 8 Apr 2021 20:10:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Min Li <min.li.xe@renesas.com>
Cc:     "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 2/2] misc: Add Renesas Synchronization
 Management Unit (SMU) support
Message-ID: <YG9HDbMu3EbS3ekW@kroah.com>
References: <1617846650-10058-1-git-send-email-min.li.xe@renesas.com>
 <1617846650-10058-2-git-send-email-min.li.xe@renesas.com>
 <YG6hOuOO5EL9xTwH@kroah.com>
 <OSBPR01MB4773182AF8FD263D65D52949BA749@OSBPR01MB4773.jpnprd01.prod.outlook.com>
 <YG9DPEyOIXqS2Vss@kroah.com>
 <OSBPR01MB47730AA300DB8DBE08E74FEEBA749@OSBPR01MB4773.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSBPR01MB47730AA300DB8DBE08E74FEEBA749@OSBPR01MB4773.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 06:01:42PM +0000, Min Li wrote:
> > 
> > That does not make sense, this is only one kernel module, with one .h file in
> > this patch, I do not see those other files you are talking about...
> > 
> > And if you have named registers that are identical, and yet you only work on
> > one device, that feels like a design flaw somewhere :)
> > 
> 
> Hi Greg, the register files are in the 1/2 patch for the mfd part of the change. 
> The reason they have same named register is because they are all synchronization 
> devices and they share some similar features

But what does that have to do with the misc device?

totally confused,

greg k-h
