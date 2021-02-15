Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F371831BB68
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 15:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhBOOwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 09:52:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:34522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229721AbhBOOw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 09:52:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E57BD64DF4;
        Mon, 15 Feb 2021 14:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613400707;
        bh=cmvN9HzH4BR1Cs5d66pNovNDeUIP8+tTBh8GRES+jhk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i9jf/TrU7ovhWBnvTeiwLXtib7zknqE0raAQtIl0SBdpqqWjNu/0OYYvTbEFlSDmw
         h2sR48B+LzEaskYnS+r8aUmfc17mMmwa5oZcj+CESQY95cn2Lma+nbm7RjWn7tDG+P
         rXkuDjmFz+hTb3NRv2y/XhsAtnpsrndvCPVJN1MY=
Date:   Mon, 15 Feb 2021 15:51:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alaa Emad <alaaemadhossney.ae@gmail.com>
Cc:     mchehab+huawei@kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend] staging: hikey9xx: hi6421-spmi-pmic: fixing
Message-ID: <YCqKgM4RD8nGCS7E@kroah.com>
References: <20210215143652.14122-1-alaaemadhossney.ae@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210215143652.14122-1-alaaemadhossney.ae@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 04:36:52PM +0200, Alaa Emad wrote:
> This patch fix the following issues in hi6421-spmi-pmic.c file:
> 
> drivers/staging/hikey9xx/hi6421-spmi-pmic.c:51: WARNING: please, no space before tabs
> drivers/staging/hikey9xx/hi6421-spmi-pmic.c:52: WARNING: please, no space before tabs
> drivers/staging/hikey9xx/hi6421-spmi-pmic.c:53: WARNING: please, no space before tabs
> drivers/staging/hikey9xx/hi6421-spmi-pmic.c:69: WARNING: please, no space before tabs
> drivers/staging/hikey9xx/hi6421-spmi-pmic.c:180: CHECK: Alignment should match open parenthesis
> drivers/staging/hikey9xx/hi6421-spmi-pmic.c:238: CHECK: Alignment should match open parenthesis
> 
> 
> Signed-off-by: Alaa Emad <alaaemadhossney.ae@gmail.com>
> 
> ---
>  drivers/staging/hikey9xx/hi6421-spmi-pmic.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Why is this a "resend"?  What caused it to be needed to be resent?

And your subject line is really odd, how does it match up with other
commits for this file?

thanks,

greg k-h
