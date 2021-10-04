Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2995E420753
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 10:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbhJDIas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 04:30:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:42020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230448AbhJDIar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 04:30:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 32F026124D;
        Mon,  4 Oct 2021 08:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633336138;
        bh=eI9K+FdEUc770AAGxrZZk//bSz1Abgk9hrD65ZUmRds=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lxbasZykJadj3uTomyBc9nHrTnV3nez6vl1UjbODrERf/EGPG0VKZQA3jXr8OmjBv
         xeRZd88cBHoxsQ18qUJf/LP6CAy3MPoh9l7iIjGwh6EZBexhtss+1C3ardTw8zFcIA
         jmgMQLQs8kLMTa2qgE/oLo5vik5mS3WfdQPu1m8E=
Date:   Mon, 4 Oct 2021 10:28:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull] habanalabs fixes for 5.15-rc4
Message-ID: <YVq7SF3QRlPTKRIe@kroah.com>
References: <20210929093039.GA108003@ogabbay-vm2.habana-labs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929093039.GA108003@ogabbay-vm2.habana-labs.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 12:30:39PM +0300, Oded Gabbay wrote:
> Hi Greg,
> 
> One important fix for the habanalabs driver for 5.15.
> It fixes an issue where we return -EINTR in the IOCTL that waits
> on command submission completion, and the user-space will try
> to immediately call that IOCTL again with the same
> arguments structure it used in the previous call. More details
> in the commit itself.
> 
> Thanks,
> Oded
> 
> The following changes since commit bb8a4fcb2136508224c596a7e665bdba1d7c3c27:
> 
>   ipack: ipoctal: fix module reference leak (2021-09-27 17:38:49 +0200)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git tags/misc-habanalabs-fixes-2021-09-29

Pulled and pushed out, thanks.

greg k-h
