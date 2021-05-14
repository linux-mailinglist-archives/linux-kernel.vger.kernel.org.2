Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 133B33808BD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 13:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbhENLoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 07:44:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:59446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231433AbhENLof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 07:44:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 19E6B61457;
        Fri, 14 May 2021 11:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620992604;
        bh=gIAAi7Doig6rhs/h2Olonq+YDcMN+whb09ZfjqXO6Cw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z+k3QNWQExai9fOKQaRZxECkKCK6tMUELvHKYCRFw4aESU7Tixrndvzt0Ah5fZfaE
         tN/WVMn76uhSE/xQY3gu1oGFO/LmVHa4yk8n5vYPlp1cMvbhOwYf8OLIU4M2w19skk
         +zTtT5VAqmR/TiQPStTzrdZ/nX4flTvQv1yXRJgQ=
Date:   Fri, 14 May 2021 13:43:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     fbarrat@linux.ibm.com, ajd@linux.ibm.com, arnd@arndb.de,
        mpe@ellerman.id.au, imunsie@au1.ibm.com, mikey@neuling.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] cxl: Fix an error message
Message-ID: <YJ5iWao53ELg4yTC@kroah.com>
References: <fa2b2c9c72335ab4c3d5e6a33415e7f020b1d51b.1620243401.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa2b2c9c72335ab4c3d5e6a33415e7f020b1d51b.1620243401.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2021 at 09:38:49PM +0200, Christophe JAILLET wrote:
> 'rc' is known to be 0 here.
> Initialize 'rc' with the expected error code before using it.
> 
> While at it, avoid the affectation of 'rc' in a 'if' to make things more
> obvious and linux style.
> 
> Fixes: f204e0b8ce ("cxl: Driver code for powernv PCIe based cards for userspace access")

You need a full 12 digits for the SHA1, otherwise our scripts complain
about it :(

I'll fix it up here, but please fix your tools.

thanks,

greg k-h
