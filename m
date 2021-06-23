Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3333B15F7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 10:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbhFWIh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 04:37:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:54532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229833AbhFWIh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 04:37:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9AFFE6112D;
        Wed, 23 Jun 2021 08:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624437309;
        bh=8YCFSY5VsJCT63ajemEnOr9JzZBCsow0txviF6oFvQA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fems5e7yd2tsP1vO8tEXQWyALM5OcUOhBEGn5Me/WDm+V908htKYb8hc4aZsWtkPG
         hIdoPv8eeyOZ6xDdURZK9rY8/dF/o/mERttv0NxK/xTiA6r7NoUw23s8KV0mhgIoqS
         c1weLOtXhV8YakoOVHAxIitd2C0+T30HBGsnqza0=
Date:   Wed, 23 Jun 2021 10:34:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linux Phy <linux-phy@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [GIT PULL]: Generic phy updates for v5.14 version 2
Message-ID: <YNLyA6d1h1TLVcML@kroah.com>
References: <YNLun13SP+PyYCEf@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNLun13SP+PyYCEf@matsya>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 01:49:43PM +0530, Vinod Koul wrote:
> Hello Greg,
> 
> As discussed, here is the updated pull request after reverting the
> offending commit.
> 
> Again very sorry for missing this in the review.
> 
> The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:
> 
>   Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-for-5.14_v2

That worked, thanks!

greg k-h
