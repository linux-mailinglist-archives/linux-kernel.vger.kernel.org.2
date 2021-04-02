Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30979352B63
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 16:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235762AbhDBOWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 10:22:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:47358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235650AbhDBOWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 10:22:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A3A5461106;
        Fri,  2 Apr 2021 14:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617373371;
        bh=ZHGMCwFkN9/sqIEO3VlehKW8i47S79nC1w/CrD3aC8M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nDTzW3TqWgF12iWLpP009uWWChnFc1CGLdurCvflnEC6h+aGKNyX7Puje01xG2oDw
         /zwYYh9ADj0d+ESQFFUIRvpf82uMe6ddOCCyEaWwf0T9ODlI1F4tlLXfXrG/jnL9Du
         avhdjUm167hD8ykSpxyZk94OydG1d8uoVvdPmRa4=
Date:   Fri, 2 Apr 2021 16:22:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Min Li <min.li.xe@renesas.com>
Cc:     "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH next 2/2] misc: Add Renesas Synchronization Management
 Unit (SMU) support
Message-ID: <YGcouOYV/FlROZJv@kroah.com>
References: <1616772851-29774-1-git-send-email-min.li.xe@renesas.com>
 <YGBy0LfM5z+8GCpU@kroah.com>
 <OSBPR01MB4773E0C511E724307E7A2C0DBA7E9@OSBPR01MB4773.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSBPR01MB4773E0C511E724307E7A2C0DBA7E9@OSBPR01MB4773.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 05:03:53PM +0000, Min Li wrote:
> > 
> > Where is patch 1/2 of this series?
> > 
> > Also, please fix up the errors that the testing bot found, and properly version
> > your patch submission so I know which one is the "latest" one to look at.
> > 
> 
> Hi Greg
> 
> The first patch is mfd so I was not sure if I should send that to you guys in the first place. 

Then the patches are independant and they should be sent as such,
otherwise it causes confusion and our tools get messed up when trying to
grab the whole "series" of patches.

Can you please fix this up and just send two independant patches?

thanks,

greg k-h
