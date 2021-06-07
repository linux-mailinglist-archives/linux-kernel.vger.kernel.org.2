Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D9F39D42E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 06:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbhFGEu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 00:50:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:55508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229436AbhFGEu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 00:50:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3280D61185;
        Mon,  7 Jun 2021 04:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623041334;
        bh=EWyASbRXeuLyxVdzAPa97YHDjp/K/i7H5bcZUa7jljs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WnLdW8LoBAa0MrYdVR1Z8eF8Nm/M8UlEQCVEKVa4ukP3fszY3wLYromhnHTL4fBIa
         sWg+d0p2kg5t04KdEQM51GrYdW5jDFJYIZ7w0QYXcF2zKsDxaUGDfgzpK1UPzOkvLP
         KJRXp0ik4WpaLGaGvAiDp7nKPoXXHNe6aMFsTFFs=
Date:   Mon, 7 Jun 2021 06:48:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ricky WU <ricky_wu@realtek.com>
Cc:     "arnd@arndb.de" <arnd@arndb.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "rui_feng@realsil.com.cn" <rui_feng@realsil.com.cn>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "vaibhavgupta40@gmail.com" <vaibhavgupta40@gmail.com>,
        "yang.lee@linux.alibaba.com" <yang.lee@linux.alibaba.com>,
        "keitasuzuki.park@sslab.ics.keio.ac.jp" 
        <keitasuzuki.park@sslab.ics.keio.ac.jp>,
        "chris.chiu@canonical.com" <chris.chiu@canonical.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] misc: rtsx: separate aspm mode into MODE_REG and MODE_CFG
Message-ID: <YL2lMWusp3ISYHJu@kroah.com>
References: <20210604144211.6470-1-ricky_wu@realtek.com>
 <YLo9O/gGOuFIsVH0@kroah.com>
 <3b0e8f86e1d04552beece07b61709734@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b0e8f86e1d04552beece07b61709734@realtek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 02:34:36AM +0000, Ricky WU wrote:
> > -----Original Message-----
> > From: Greg KH [mailto:gregkh@linuxfoundation.org]
> > Sent: Friday, June 4, 2021 10:48 PM
> > To: Ricky WU
> > Cc: arnd@arndb.de; bhelgaas@google.com; rui_feng@realsil.com.cn;
> > ulf.hansson@linaro.org; vaibhavgupta40@gmail.com;
> > yang.lee@linux.alibaba.com; keitasuzuki.park@sslab.ics.keio.ac.jp;
> > chris.chiu@canonical.com; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] misc: rtsx: separate aspm mode into MODE_REG and
> > MODE_CFG
> > 
> > On Fri, Jun 04, 2021 at 10:42:11PM +0800, ricky_wu@realtek.com wrote:
> > > From: Ricky Wu <ricky_wu@realtek.com>
> > >
> > > Divide Realtek Card Reader Group into two different modes
> > > ASPM_MODE_CFG: 8411 5209 5227 5229 5249 5250 Change back to use
> > > original way to control aspm
> > 
> > What is "aspm"?
> > 
> Active State Power Management (ASPM)

Great, please spell it out in the changelog text when you resubmit this.

> rtsx_comm_set_aspm: ASPM control function for our driver
> to make sure not enter power saving in process of init and card_detcct

Ok, can you please say all of this in the changelog text?

> > > +#define ASPM_MODE_CFG		0x01
> > > +#define ASPM_MODE_REG		0x02
> > > +	u8				aspm_mode;
> > 
> > Why not use an enum?
> > 
> 
> It is ok, we can have a V2 to use enum

Please do so.

thanks,

greg k-h
