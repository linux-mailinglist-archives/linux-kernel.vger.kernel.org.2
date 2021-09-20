Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B975410FCE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 09:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbhITHGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 03:06:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:47196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233878AbhITHGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 03:06:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ABDB860FF2;
        Mon, 20 Sep 2021 07:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632121480;
        bh=3HJwf9Vj204///SUVc6TgDLSOf+Svg/+F0Hg3VxKguU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p5cOqgEnOK1qt6XhbH6hBm1pGifuAvWmtztDGhcG1bG0SlMURGh5jZ8ZA/BN4C8+f
         AjgIsSHdAEpEJottg2tPaNAe66xzY0rEXzOkefOXRC28vkEqnyEHSYa067IIb2brFS
         CgGMP4b0R61d1JEO0F8SYFOZqBg8n0qYl6hJiVe4=
Date:   Mon, 20 Sep 2021 09:04:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull] habanalabs fixes for 5.15-rc3
Message-ID: <YUgyhtS4I0HG78WC@kroah.com>
References: <20210919094413.GA25155@ogabbay-vm2.habana-labs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210919094413.GA25155@ogabbay-vm2.habana-labs.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 19, 2021 at 12:44:13PM +0300, Oded Gabbay wrote:
> Hi Greg,
> 
> Some important fixes for the habanalabs driver for 5.15.
> They fix a couple of bugs that can result in kernel BUG,
> data race, kernel log spamming, etc.
> 
> Full details are in the tag.
> 
> Thanks,
> Oded
> 
> The following changes since commit 25a1433216489de4abc889910f744e952cb6dbae:
> 
>   mcb: fix error handling in mcb_alloc_bus() (2021-09-14 11:22:26 +0200)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git tags/misc-habanalabs-fixes-2021-09-19

Pulled and pushed out, thanks.

greg k-h
