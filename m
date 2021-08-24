Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 227DF3F5F68
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 15:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237657AbhHXNqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 09:46:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:56690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237403AbhHXNql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 09:46:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 79F1D601FF;
        Tue, 24 Aug 2021 13:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629812757;
        bh=gbyfwyBl+3sjTR1TrDd8LA5MAl4lkrvpI+04lctKP3o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=isjmp9rvh2NKkrEuFjZiN0Vu1ULLzvhpJp+3u/slKfxRzbwm+RuUiaOC0oMYFayqS
         sNiAmL+/ieEt3vaLtGtwjwtGeq3TbPwuiS+EUo/ak4G/nfYBRg8Jcv3TPTi5QlHqNw
         6pTWcmVh/NV31xr9j9q+45iD+ob632ManldTBa0Y=
Date:   Tue, 24 Aug 2021 15:36:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Phy <linux-phy@lists.infradead.org>
Subject: Re: [GIT PULL]: Generic phy updates for v5.15
Message-ID: <YST1wr4RGKnt9RDK@kroah.com>
References: <YSR/UHNxE6iu3GBc@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSR/UHNxE6iu3GBc@matsya>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 10:40:40AM +0530, Vinod Koul wrote:
> Hello Greg,
> 
> Here is the update for v5.15, sorry this time it is bit late than
> normal. Will make sure this hits early next time.
> 
> The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:
> 
>   Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-for-5.15

Pulled and pushed out, thanks.

greg k-h
