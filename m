Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3E92357C6E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 08:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbhDHGT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 02:19:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:35472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230418AbhDHGTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 02:19:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C98026113E;
        Thu,  8 Apr 2021 06:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617862776;
        bh=iqSCp7HTQcNYcIH9yAGkaZpmwBCAxBBfN48dZyIRzbo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FwGee+n+6Mn9jwCGSymw8awX1e/sDKzbNlpfMomrFqMNMvzqPNgf0OrxNZ3gez8hi
         h6rGetOpMR5k9cUxtRKJ1QKYeDs+Q0wfyIlAZlSfxiGb70hFMz5M8eIbNI7oAHnDI7
         sB2Y2u1JLCAaCUF2I+4YeOb5DW9ri2MKXE+ZY8GI=
Date:   Thu, 8 Apr 2021 08:19:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Min Li <min.li.xe@renesas.com>
Cc:     "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 2/2] misc: Add Renesas Synchronization
 Management Unit (SMU) support
Message-ID: <YG6gdRiEkiYxKKm9@kroah.com>
References: <1617816815-3785-1-git-send-email-min.li.xe@renesas.com>
 <1617816815-3785-2-git-send-email-min.li.xe@renesas.com>
 <YG3vu9XQ94w5dlbp@kroah.com>
 <OSBPR01MB47733C009A6B6F2F697E12ACBA759@OSBPR01MB4773.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSBPR01MB47733C009A6B6F2F697E12ACBA759@OSBPR01MB4773.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 07:43:44PM +0000, Min Li wrote:
> > 
> > Why do you need 4 files here?  Can't you do this all in one?  There's no need
> > for such a small driver to be split up, that just causes added complexity and
> > makes things harder to review and understand.
> > 
> 
> We will add more functions and boards down the road. So the abstraction here is for future consideration  

Do not add additional complexity today for stuff that you do not need
today.  Add it when you need it.

> > >  include/uapi/linux/rsmu.h |  64 +++++++++++
> > 
> > Where are you documenting these new custom ioctls?  And why do you even
> > need them?
> > 
> 
> Other than comments in the header itself, no additional documenting. Do you know if Linux has specific place to document custom ioctls? 
> Renesas software needs to access these ioctls to provide GNSS assisted partial timing support. More specifically, RSMU_GET_STATE would tell us if a specific DPLL
> is locked to GNSS and RSMU_GET_FFO would tell us how much of frequency offset for the DPLL to lock to the GNSS.

Please provide some sort of documentation and at the least, a pointer to
the software that uses this so that we can see how it all ties together.

thanks,

greg k-h
