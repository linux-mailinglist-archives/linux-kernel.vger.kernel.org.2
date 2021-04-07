Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 602B735737A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 19:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354959AbhDGRsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 13:48:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:53590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233520AbhDGRsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 13:48:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9334B61242;
        Wed,  7 Apr 2021 17:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617817723;
        bh=Bl1TSMjQXnBImiNgr2TIPAn05mRqViRp1gxvrOcjVmI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PsADUkkbbBE/CbIJf4hYc5BlwdK8WqeKMx0wiI+MxrYgiLyZS5xuNpGp71Nq3YT1N
         C1M5XSke4YwB8umNYwmROH20i25jBz8MXDMSIYslfbxJZJfr0ThoZRa71nK+hthtdo
         ksPTcKng6ChmwVy29arDzQVbXp6+9NvpkQDH8k/g=
Date:   Wed, 7 Apr 2021 19:48:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     min.li.xe@renesas.com
Cc:     derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] misc: Add Renesas Synchronization
 Management Unit (SMU) support
Message-ID: <YG3weJsOd2IZ5jRQ@kroah.com>
References: <1617816815-3785-1-git-send-email-min.li.xe@renesas.com>
 <1617816815-3785-2-git-send-email-min.li.xe@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617816815-3785-2-git-send-email-min.li.xe@renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 01:33:35PM -0400, min.li.xe@renesas.com wrote:
> +static int
> +rsmu_open(struct inode *iptr, struct file *fptr)
> +{
> +	return 0;
> +}
> +
> +static int
> +rsmu_release(struct inode *iptr, struct file *fptr)
> +{
> +	return 0;
> +}

If you do nothing in an open/release function, then there is no need to
have them at all, you can remove them.

But this feels odd, how do you know what device you are using in your
ioctl command?

thanks,

greg k-h
