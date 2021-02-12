Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B57DD319D36
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 12:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbhBLLSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 06:18:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:37126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229782AbhBLLSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 06:18:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A03D64DE0;
        Fri, 12 Feb 2021 11:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613128687;
        bh=tJzhvntznc/FRgHjBqWUd1r8SrDuRwD4WNhViT1t8Kw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0/H3daOncA5CdDesBRodDPOIXcbcpgwfDaqND/4FmuthL+L826Bbz2SflEx8kFDTi
         Gz4fUukJ5xeBxWqkPdKYl1HF01tu3GDWzvBQMGwcwxhpcyYxjvHPOrVdLZ678WmCLs
         t2Oc4nDK8yAaiRyr7UrziIYVYsnqc3FXFBwTykkY=
Date:   Fri, 12 Feb 2021 12:18:03 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] soundwire updates for v5.12-rc1
Message-ID: <YCZj6zO/n45w6NQF@kroah.com>
References: <20210212111422.GN2774@vkoul-mobl.Dlink>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212111422.GN2774@vkoul-mobl.Dlink>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 04:44:22PM +0530, Vinod Koul wrote:
> Hello greg,
> 
> Few more patches came in late and would be great to have in upcoming
> merge window. Please pull to receive a fix for Intel laptops and support
> for _no_pm in sdw regmap (acked by Mark)
> 
> The following changes since commit 6d7a1ff71cbb326fadfbedb7f75c1fc8f5c84d84:
> 
>   soundwire: bus: clarify dev_err/dbg device references (2021-02-07 17:49:17 +0530)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-2_5.12-rc1

Pulled and pushed out, thanks.

greg k-h
