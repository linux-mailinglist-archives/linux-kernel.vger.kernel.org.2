Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7BB413248
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 13:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbhIULLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 07:11:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:40466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232234AbhIULLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 07:11:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9D57B61168;
        Tue, 21 Sep 2021 11:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632222608;
        bh=WPWygvd9qrCxVUUypIqJhcz2akqvfJ6mG+LND9A7AiE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vKwpewliQCZ9Wm6gWMI8+GzlcddouW07cPNu+Gf4KVhWQWd61D3nOveSSl/60rEaH
         rFsdDV6hlEODTl15R4Zf1/Pg5pBE3h4ZbmOWe1Qa9qnmMPZSqm4MbyD8jC5ctSl2/m
         jIcCY7UVORPKOu8hI7nV0CEwUdiWA5b6z75QJtWWvUVfFmKSrbH3wRjyK24zPIfDxR
         9WVoiKQmbDe/6g7epXaKUHc2IP6XOe9apJ4bMmStxOQFWPpJC0jtVia9vWG0x1pSoZ
         wKC2QKMS26+W0iN2an4SLWd/15Zmv7v6fn09hnkv2oDGU0K6Q2I/6k1pc49T1OEnTE
         EIoRKYaWgt1fw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mSdf3-0002M3-Ol; Tue, 21 Sep 2021 13:10:06 +0200
Date:   Tue, 21 Sep 2021 13:10:05 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Himadri Pandya <himadrispandya@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] USB: serial: use wrappers for usb_control_msg()
Message-ID: <YUm9jX6nG+n2q3SV@hovoldconsulting.com>
References: <20210801203122.3515-1-himadrispandya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210801203122.3515-1-himadrispandya@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2021 at 02:01:16AM +0530, Himadri Pandya wrote:
> There are many usages of usb_control_msg() that can use the new wrapper
> functions usb_contro_msg_send() & usb_control_msg_recv() for better
> error checks on short reads and writes.

As I said before, there no need to worry about short writes as that will
always return an error. So this description (and some of the commit
messages) needs a bit of work.

> They can also be used to avoid
> allocating redundant dma buffers that are generally required to use
> usb_control_msg(). 

The DMA buffers are anything but redundant; they are required. But the
wrappers can be used to not have to manage the dma buffers explicitly.

> Hence use them whenever possible and avoid using
> usb_control_msg() directly.
> 
> Changes in v2:
>  - Drop unnecessary use of wrappers
>  - Drop unrelated style changes
> 
> Additional Info:
> - This is a super late follow-up on v1 that was submitted a while
> ago(my sincere apologies). (All patches are rebased and
> compile tested.)
> - v1 patches: https://lkml.org/lkml/2020/11/4/40
> - Patches that introduced the wrapper functions:
>   https://lkml.org/lkml/2020/9/14/859

No worries, I'll go review the patches now.

Johan
