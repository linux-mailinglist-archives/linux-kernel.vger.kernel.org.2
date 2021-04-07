Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2C3356F5D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 16:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344960AbhDGOzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 10:55:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230426AbhDGOzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 10:55:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E61A61363;
        Wed,  7 Apr 2021 14:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617807298;
        bh=T3bdSkR62iNXCFNvEUgWE4U9vYx3ZLghfahBzX69+J8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qkl6gp2hy6ajVoGP2vncEY4HbHaohQtNNsyEYyHtUcFMkmlVkVmHl000rB+4IPWL0
         sBbwisc/EGoMNr4LLXTu7/eFnyuhUOgs3OxdQ7wu8WqoOYw5JgjlA2JYfbgWjSj7aZ
         FN8RZuvElC1WR76jaLFWgarG4WGkuTzBbHIm9tEM=
Date:   Wed, 7 Apr 2021 16:53:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Phy <linux-phy@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [GIT PULL]: Generic phy updates for v5.13-rc1
Message-ID: <YG3HX6jAqNBQSoc4@kroah.com>
References: <YG2psdeBIlfYODdJ@vkoul-mobl.Dlink>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG2psdeBIlfYODdJ@vkoul-mobl.Dlink>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 06:16:41PM +0530, Vinod Koul wrote:
> Hello Greg,
> 
> Please pull to receive generic phy updates for this cycle. This is usual
> pull includes bunch of new driver/device support and updates to bunch of
> drivers.
> 
> The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:
> 
>   Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-for-5.13

Pulled and pushed out, thanks.

greg k-h
