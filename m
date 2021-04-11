Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D403B35B20F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 08:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbhDKGyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 02:54:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:59786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229804AbhDKGyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 02:54:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 78A5D611CE;
        Sun, 11 Apr 2021 06:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618124025;
        bh=BnvZp9JvzBondkJXFaXSNX45KxgvR5Sy5/kbr59IvZo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sp/kVLYiu78JvUcaF6oetSj4kFAa1muOGmqqtSrmKVjswzUh8aUEOtdXaYf0oxYfd
         4JdChdbWj0g/Mre9guOjsnL+4MafHoLYnVKVjuXRT+rLMwwXrUKHrj0jyv5LPqJhDC
         1ASACT5ykzAE+lfWcX9jX4OZUPJp4oDplv73TmXM=
Date:   Sun, 11 Apr 2021 08:52:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull] habanalabs pull request for kernel 5.13
Message-ID: <YHKcvQMTKKCIXS6g@kroah.com>
References: <20210410200142.GA336@CORE.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210410200142.GA336@CORE.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2021 at 11:01:42PM +0300, Oded Gabbay wrote:
> Hi Greg,
> 
> This is habanalabs pull request for the merge window of kernel 5.13.
> It contains changes and new features, support for new firmware.
> Details are in the tag.
> 
> Thanks,
> Oded
> 
> The following changes since commit b195b20b7145bcae22ad261abc52d68336f5e913:
> 
>   Merge tag 'extcon-next-for-5.13' of git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon into char-misc-next (2021-04-08 08:45:30 +0200)

Pulled and pushed out, thanks.

greg k-h
