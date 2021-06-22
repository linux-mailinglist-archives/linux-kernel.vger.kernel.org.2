Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCF53B0182
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 12:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhFVKjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 06:39:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:47082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229612AbhFVKjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 06:39:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DC97A613B2;
        Tue, 22 Jun 2021 10:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624358227;
        bh=aGDr2kHV1XjGSuOnw8gw8WZJoVU47T4vBUWdjUHOFBE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GjTYW2XaGYIpBdBK2TRrc+Z3INOZcoynFpSooH8ZXcUo9+8JX5Kx/T87HSqIy3cAw
         Azk+HKaSldEtcxB3Qfy3BqdiYpEbENQbkdgHnW/NSMlSFszySLtbSk3vajABBsz1C6
         WL5DSrOertbKXuVLh0hYr4vON1rsOFCeVRCTvMj8=
Date:   Tue, 22 Jun 2021 12:36:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL]: soundwire updates for v5.14-rc1
Message-ID: <YNG9SS0qubJ/Mu8q@kroah.com>
References: <YNFzwibyyESNJx9w@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNFzwibyyESNJx9w@vkoul-mobl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 10:53:14AM +0530, Vinod Koul wrote:
> Hello Greg,
> 
> Please pull to receive the soundwire subsystem updates for this cycle.
> 
> The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:
> 
>   Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-5.14-rc1

Pulled and pushed out, thanks.

greg k-h
