Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 523F539B6D0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 12:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbhFDKMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 06:12:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:55506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229612AbhFDKMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 06:12:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5BEA161400;
        Fri,  4 Jun 2021 10:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622801454;
        bh=4kWHAKUYAptvdKTKP+IbuMyYHMt0OC7/Pc06+tOzKc4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1Sh3CdH2m9fiTr7q3uyeVG7/UceoCd/YukBTmlIRkrcSwnhac3DvYhl4jR6NxQ4mR
         X27T9H025rqgbA9HwDphxqLY42KSp2HaEaBAWvRL/D+VZEDfp6pJvqm3Y2UcyWopF5
         2y+3Xdnc/iRxNCM9onoseb87VN2dYcfhtDijhbaw=
Date:   Fri, 4 Jun 2021 12:10:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Phy <linux-phy@lists.infradead.org>
Subject: Re: [GIT PULL]: Generic phy fixes for v5.13
Message-ID: <YLn8K6IvsGG7LOLr@kroah.com>
References: <YLnraMuKUKPtktfZ@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLnraMuKUKPtktfZ@vkoul-mobl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 02:29:20PM +0530, Vinod Koul wrote:
> Hello Greg,
> 
> Please pull to recive few fixes for phy subsystem.
> 
> The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:
> 
>   Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-fixes-5.13

Pulled and pushed out, thanks.

greg k-h
