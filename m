Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182F8427F42
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 07:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhJJFfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 01:35:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:60626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230215AbhJJFfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 01:35:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 06EC960F57;
        Sun, 10 Oct 2021 05:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633844027;
        bh=fFtb1mrI1ST0Z8ENmJv/UKksOGpmgzo0n0USEL4Xz6g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=smXj9SNPXY/VYJ7AwIAIvQr4XCStM2hHJtZQ52RReVdA1DR3fY6BMbjoILsiYXcwh
         LzZBmcysuTwVBN1I7oual3OdQG2egw9nzEpa0t649Lm+Cwnop68l+yIPNjj2bTErdx
         9Ws+cgeAupflqf4h+gvutPzjmvOuBurPcGpE1nhM=
Date:   Sun, 10 Oct 2021 07:33:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xianting Tian <xianting.tian@linux.alibaba.com>
Cc:     jirislaby@kernel.org, amit@kernel.org, arnd@arndb.de,
        osandov@fb.com, shile.zhang@linux.alibaba.com,
        linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 2/3] tty: hvc: pass DMA capable memory to put_chars()
Message-ID: <YWJ7NuapWOZ4QirJ@kroah.com>
References: <20211009114829.1071021-1-xianting.tian@linux.alibaba.com>
 <20211009114829.1071021-3-xianting.tian@linux.alibaba.com>
 <YWGD8y9VfBIQBu2h@kroah.com>
 <3516c58c-e8e6-2e5a-2bc8-ad80e2124d37@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3516c58c-e8e6-2e5a-2bc8-ad80e2124d37@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 09, 2021 at 11:45:23PM +0800, Xianting Tian wrote:
> 
> 在 2021/10/9 下午7:58, Greg KH 写道:
> > Did you look at the placement using pahole as to how this structure now
> > looks?
> 
> thanks for all your commnts. for this one, do you mean I need to remove the
> blank line?  thanks
>

No, I mean to use the tool 'pahole' to see the structure layout that you
just created and determine if it really is the best way to add these new
fields, especially as you are adding huge buffers with odd alignment.

thanks,

greg k-h
