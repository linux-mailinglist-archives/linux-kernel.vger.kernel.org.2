Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8078A432FC4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 09:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234435AbhJSHl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 03:41:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:53718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229967AbhJSHl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 03:41:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5DD2D61374;
        Tue, 19 Oct 2021 07:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634629155;
        bh=zCuVcv5fM+E8emUmc3P30IDvwocH9twtXy4yMTvCVYQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YCcklrs+qMifwmxnp+R0TjXTkUfrwr8qd0DaazB2JZ7GWWe08nnXCfpW3dobufi/2
         tb5YTBSQqAtwT/hVF3sFwLC4P7KwJxefd1J5XzbdDFbPa5tJJiA+qUXUlEvzvUXXtx
         TdoWmqwOgbHwziixPe3riLxGF6Pewh1+O5j8KiZg=
Date:   Tue, 19 Oct 2021 09:38:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     linux-kernel@vger.kernel.org, jgg@ziepe.ca, daniel.vetter@ffwll.ch,
        ogabbay@habana.ai, airlied@gmail.com
Subject: Re: [git pull] habanalabs pull request for kernel 5.16
Message-ID: <YW5196JYmvy+OE7L@kroah.com>
References: <20211018100250.GA1132625@ogabbay-vm-u20.habana-labs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018100250.GA1132625@ogabbay-vm-u20.habana-labs.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 01:02:50PM +0300, Oded Gabbay wrote:
> Hi Greg,
> 
> This is habanalabs pull request for the merge window of kernel 5.16.
> It's a relatively small pull request as Gaudi code is mostly mature.
> Please note this contains the peer-to-peer support with DMA-BUF code.
> 
> Full details are in the tag.
> 
> Thanks,
> Oded
> 
> The following changes since commit 22d4f9beaf32a7cda9edeafdf5e99bec3de32c51:
> 
>   Merge 5.15-rc6 into char-misc-next (2021-10-18 09:29:27 +0200)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git tags/misc-habanalabs-next-2021-10-18

Pulled and pushed out, thanks.

greg k-h
