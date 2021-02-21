Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132FD320918
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 08:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbhBUHyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 02:54:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:52376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229519AbhBUHyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 02:54:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9124364EE0;
        Sun, 21 Feb 2021 07:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613894051;
        bh=T4ZGnWP0mt5q4bxr+WnaZean0geOmlQdGCVFSSSNZB0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RO71vkrMN7dkDIikcNffmGhhzhwqzUBK+l3OUC28QUcorxXMA4o8us9MpeX+LdClM
         Vs7V9LZjBs60y5A4o7zraYBO00Wpfso2AYV5zxifEsRkKSwYiMtqxnXaz7mw+C0BhZ
         sz419BKGC2MoakC/oShv1N6r0lOs2F9nXsvS2O3M=
Date:   Sun, 21 Feb 2021 08:54:06 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Liu, Shuo A" <shuo.a.liu@intel.com>
Cc:     Yejune Deng <yejune.deng@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virt: acrn: Use vfs_poll() instead of f_op->poll()
Message-ID: <YDIRnrVYAGkYXcxp@kroah.com>
References: <20210220145351.14464-1-yejune.deng@gmail.com>
 <714d4648-46d7-bc44-a9a2-5ce3c919897c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <714d4648-46d7-bc44-a9a2-5ce3c919897c@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 21, 2021 at 09:50:42AM +0800, Liu, Shuo A wrote:
> 
> 
> On 2/20/2021 22:53, Yejune Deng wrote:
> > Use vfs_poll() is a more advanced function in acrn_irqfd_assign().
> > as the same time, modify the definition of events.
> > 
> > Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
> 
> Thanks for the update.
> Reviewed-by: Shuo Liu <shuo.a.liu@intel.com>
> 
> Hi Greg,
> Need i do more work on this patch?
> Or you will review and apply on your tree directly?

Please resend it to me with your signed-off-by on it.

thanks,

greg k-h
