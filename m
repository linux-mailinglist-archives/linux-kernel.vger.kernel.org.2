Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4343E1384
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 13:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240817AbhHELI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 07:08:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:59778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240738AbhHELIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 07:08:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0377460F22;
        Thu,  5 Aug 2021 11:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628161691;
        bh=RnT92SYGhIXN6hiGQaaRNCG7tySLmSwCS/xmeQhHUFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VgV4jVsdJM70+IBj4940m2mPNjfXTckt4k+3FQufmbq+1RHziKfLwFl1WPBkc2VvD
         rOLw+BJYv1zMbSVx9FQjgjGHAo1tFn0I2ibyuq74Xv2U+qx7M91W9B26+mIig2YEAP
         HpfWKSpDqfRi5Mtdk8d8/pTqeC63lKpNae+QSPB8=
Date:   Thu, 5 Aug 2021 13:08:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: r8188eu: remove RT_TRACE and DBG_88E prints
 from ioctl_linux.c
Message-ID: <YQvGmNUGjAqTMBU9@kroah.com>
References: <20210802073917.8647-1-martin@kaiser.cx>
 <20210804141916.13832-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804141916.13832-1-martin@kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2021 at 04:19:16PM +0200, Martin Kaiser wrote:
> We should use the standard mechanism for debug prints. Remove the
> prints that use driver-specific macros.
> 
> Remove all "IOL tests" from rtw_dbg_port as these tests don't make sense
> without a success/fail print at the end. (The rtl8723bs driver removed
> the tests as well.)
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
> v2:
>  - remove IOL tests
> 
>  drivers/staging/r8188eu/os_dep/ioctl_linux.c | 851 +------------------
>  1 file changed, 33 insertions(+), 818 deletions(-)

Can you add this to the other series you are going to resend so I know
what is the latest to review?

thanks,

greg k-h
