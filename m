Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC5DF358BBB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 19:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbhDHRyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 13:54:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:59956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231676AbhDHRyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 13:54:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A9B5761105;
        Thu,  8 Apr 2021 17:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617904447;
        bh=LGu89Nt2dhReu7dyzA/zwL5c1xULE9DtTJXEEFM9FAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W8toxZeD9903P30RCtxrgYTbt01OvkXVNW6RByPqXeMns0gP8sZuM+itTjFBOtQGb
         Q+z0aotmKGB6Kb0chNTTZKQ0BF4CS5TvKNMvyFKNYE6WxGQZV/k3H7Tr+X+lb3hQ3b
         4wWOW8kiapoTTfrTOT5ZZOxWzCUT8FxdzgKCyel4=
Date:   Thu, 8 Apr 2021 19:54:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Min Li <min.li.xe@renesas.com>
Cc:     "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 2/2] misc: Add Renesas Synchronization
 Management Unit (SMU) support
Message-ID: <YG9DPEyOIXqS2Vss@kroah.com>
References: <1617846650-10058-1-git-send-email-min.li.xe@renesas.com>
 <1617846650-10058-2-git-send-email-min.li.xe@renesas.com>
 <YG6hOuOO5EL9xTwH@kroah.com>
 <OSBPR01MB4773182AF8FD263D65D52949BA749@OSBPR01MB4773.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSBPR01MB4773182AF8FD263D65D52949BA749@OSBPR01MB4773.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 05:26:40PM +0000, Min Li wrote:
> > 
> > Again, please make this only one file.
> > 
> Hi Greg, the 2 boards have some same named registers in idt82p33_reg.h and idt8a340_reg.h
> so if I put them all in the same file, there will be name conflicts. 

That does not make sense, this is only one kernel module, with one .h
file in this patch, I do not see those other files you are talking
about...

And if you have named registers that are identical, and yet you only
work on one device, that feels like a design flaw somewhere :)

thanks,

greg k-h
