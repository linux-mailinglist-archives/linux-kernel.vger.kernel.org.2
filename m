Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C962F3FE8D3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 07:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236762AbhIBFjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 01:39:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:47062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233259AbhIBFjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 01:39:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD6D760238;
        Thu,  2 Sep 2021 05:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630561106;
        bh=m18FpiLBSK7KlI93MGFmMVv4otj/+kpXK+v2g3j6SLc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lfQJV8Poe69lhdEp3tgOm/sLbkYKdgo7JaVc0gKQDNqka75lwFTf37+UaK5/XMEkj
         yC8QEX0Mt/9ZlwzNimbK74D7R1WNXYZejR+tXlgbxgaScY9moCUzjm6eAjyIEx+Byq
         UaJq6RZETK+XVeufMdoCZbSkAD8d+Fl1Tj1vSCmA=
Date:   Thu, 2 Sep 2021 07:38:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] driver core: platform: Add the helper function
 devm_platform_get_and_ioremap_resource_byname()
Message-ID: <YTBjTVp4CTX9cTAm@kroah.com>
References: <20210902052459.31890-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902052459.31890-1-caihuoqing@baidu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021 at 01:24:58PM +0800, Cai Huoqing wrote:
> Since provide the helper function devm_platform_ioremap_resource_byname()
> which is wrap platform_get_resource_byname() and devm_ioremap_resource().
> But sometimes, many drivers still need to use the resource variables
> obtained by platform_get_resource(). In these cases, provide this helper
> function devm_platform_get_and_ioremap_resource_byname().
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>  drivers/base/platform.c         | 30 ++++++++++++++++++++++++++----
>  include/linux/platform_device.h |  3 +++
>  2 files changed, 29 insertions(+), 4 deletions(-)

We can not add new functions that no one uses.  Please resend this as
part of a patch series that uses the new function so we can be sure to
see if it really is needed or not.

Also your patch series was not threaded properly, please use 'git
send-email' for your future patches.

thanks,

greg k-h
