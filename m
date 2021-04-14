Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F09DD35ECF8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 08:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347655AbhDNGNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 02:13:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:35832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345785AbhDNGNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 02:13:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B92F760FD8;
        Wed, 14 Apr 2021 06:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618380764;
        bh=SVl6fC2hA8BERhXd9uZqX6yd7oj73bDw+Hpi/Uh5zAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k3ppnHNKq94ztT+O8YtO63A2M4zoKZRLgexU4LqkKs1vhGFl9Em6cox1Lf4vYZ0FR
         eC1adlXj7sILnqCfumw0evIYpnZVQf5in+2a2WeuxSQQuC589/2atUnDgVd4TToAXz
         aBVMa5Oav75exIRRFGGx8nEshuscz90LspAB2jW4=
Date:   Wed, 14 Apr 2021 08:12:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: core: remove unused including <linux/version.h>
Message-ID: <YHaH2Tw05L661Vy3@kroah.com>
References: <1618380340-108958-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1618380340-108958-1-git-send-email-yang.lee@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 02:05:40PM +0800, Yang Li wrote:
> Fix the following versioncheck warning:
> ./drivers/usb/core/hcd.c: 14 linux/version.h not needed.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/usb/core/hcd.c | 1 -
>  1 file changed, 1 deletion(-)

I am now adding any patch sent to me from the "Abaci Robot" to my local
blacklist and they will be ignored as you have constantly kept ignoring
my simple request to do basic build testing of your patches before
sending them out.

Because you have not done that, you are obviously trying to waste
developer and reviewer's time with stuff like this, which is not
acceptable at all.

*plonk*

