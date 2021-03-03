Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6655632BBF3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 22:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359019AbhCCNUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 08:20:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:57660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1357104AbhCCISO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 03:18:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 315DE64E4A;
        Wed,  3 Mar 2021 08:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614759452;
        bh=UiQu6fevYpFehrRZuCMSJyx8SynobJ/7rfL9r6cCz4M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x3s5cSLc9wrP5L4Sk7wRvHQ6hWxFEP9rM7OE4KEnq7/oarMPWGJepdGCRqe8r4Kc2
         hg6EgOy/WYdyCyJTHz+qVJ05fXFoNBTO/ueVgonmiMqQgOZ0/GN3yLbjzz0gmGQheW
         QJpXqzwW+7b1oLyGkCTVTzCGaXb6IemhUnAovW8o=
Date:   Wed, 3 Mar 2021 09:17:22 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull resend] habanalabs fixes for 5.12-rc2
Message-ID: <YD9GEtb7yvMyAyab@kroah.com>
References: <20210303081321.GA6609@CORE.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303081321.GA6609@CORE.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 10:13:21AM +0200, Oded Gabbay wrote:
> Hi Greg,
> 
> This pull request contains some fixes of the habanalabs driver for
> 5.12-rc2.
> Nothing too scary, more details are in the tag.
> 
> Thanks,
> Oded
> 
> The following changes since commit fe07bfda2fb9cdef8a4d4008a409bb02f35f1bd8:
> 
>   Linux 5.12-rc1 (2021-02-28 16:05:19 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git tags/misc-habanalabs-fixes-2021-03-03

Pulled and pushed out, thanks.

greg k-h
