Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 181CA3122CC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 09:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhBGIgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 03:36:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:59594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229977AbhBGIeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 03:34:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC98C64E30;
        Sun,  7 Feb 2021 08:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612686809;
        bh=CRF6ov8HZYQgEMXDSLagshxMHLuVPb+BGxWwtc4e66E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nl8xpCtGkMfGXg5YCYtqrLhodKgeY4c/Lr9EQ6MkFxnx2AMTdNdR3SVtlsoRx9reB
         /wdrtE4kD398a4E08oKcvXYG9I+tX2kcIGJ8GlJ+rsd2HdRIF+myMP+uiNKT5P8HrR
         0Ids3NNMBPsOx3loFGmyDQqqghGuIwGpCZHBKoH4=
Date:   Sun, 7 Feb 2021 09:33:26 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: emxx_udc: Fix incorrectly defined global
Message-ID: <YB+l1t/k4VuSw3B9@kroah.com>
References: <20210207000030.256592-1-memxor@gmail.com>
 <20210207173441.2902acac@canb.auug.org.au>
 <20210207073827.7l7h3475tqgxxfte@apollo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210207073827.7l7h3475tqgxxfte@apollo>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 07, 2021 at 01:08:27PM +0530, Kumar Kartikeya Dwivedi wrote:
> On Sun, Feb 07, 2021 at 12:04:41PM IST, Stephen Rothwell wrote:
> > 
> > Given that drivers/staging/emxx_udc/emxx_udc.h is only included by
> > drivers/staging/emxx_udc/emxx_udc.c, shouldn't these variables just be
> > declared static in emxx_udc.c and removed from emxx_udc.h?
> >
> 
> Either would be correct. I went this way because it was originally trying to
> (incorrectly) define a global variable instead. I guess they can be static now
> and when more users are added, the linkage can be adjusted as needed.
> 
> Here's another version of the patch:

<snip>

Please resend in the proper format that a second version of a patch
should be in (the documentation describes how to do this.)

thanks,

greg k-h
