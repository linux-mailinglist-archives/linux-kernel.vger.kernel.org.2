Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 346533B52DC
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 12:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbhF0Ksu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 06:48:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:48358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229526AbhF0Ksr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 06:48:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 72C2561C32;
        Sun, 27 Jun 2021 10:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624790783;
        bh=PV6l6fYWNTaGKab6hbcfIhwT3cpcANIbwQrktMaN8dA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dUxE0iXTJ2uCEdbolda7dX4IWa7cjbu+gEPMxYaBkDB/J/eJcjU66F2atIQrL8Hc2
         oJ5XEVQ7zrDI94H/ZN3bRwIrrtgTdWtIqH5KksajoySI7ms7oH7bHcvi5+rrsvdtj6
         E/f7p+vNi4OXS8JymOh6R3jdGc1/FbWmqa4Rmjgo=
Date:   Sun, 27 Jun 2021 12:46:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Weilong Chen <chenweilong@huawei.com>
Cc:     viro@zeniv.linux.org.uk, keescook@chromium.org,
        linux-kernel@vger.kernel.org
Subject: Re: [linux-next] rootfs: rootflags take effect when mount rootfs
Message-ID: <YNhW/XQlZxfJR9Us@kroah.com>
References: <20210626011655.351057-1-chenweilong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210626011655.351057-1-chenweilong@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 26, 2021 at 09:16:55AM +0800, Weilong Chen wrote:
> The kernel root filesystem may use the rootflags parameters
> when mount, especially for tmpfs, to setup a variety of features.
> 
> For example:
> 1. Add 'rootflags=huge=always' to boot args.
> 2. When the OS bootup:
> rootfs on / type rootfs (..., huge=always)
> Then we can get the hugepage performance improvement of tmpfs.
> 
> Signed-off-by: Weilong Chen <chenweilong@huawei.com>
> ---
>  fs/namespace.c       | 5 +++--
>  include/linux/init.h | 2 +-
>  init/do_mounts.c     | 4 +++-
>  3 files changed, 7 insertions(+), 4 deletions(-)

No documentation update for this new user/kernel api you added?
