Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 336BC39A1EF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 15:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhFCNOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 09:14:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:52886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230414AbhFCNOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 09:14:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 81C5A613B8;
        Thu,  3 Jun 2021 13:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622725988;
        bh=W0H05tujlzZGpKDp66E8foU1Iit3ZDa5QdveP9Ti2ek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jJl0Caiu4C/9rTSWq2sRssp61HNPP63yD+74s2fYbixYzZSD+wu1VBWfFgva+hRQ/
         VVU6D2pJKfcyQLpFzIwZDtE4wgQBhhEb5RjfXdWLabfMpoSoFL1FiYPCUQrVd0i5Qg
         QgDu7CaltvxRGLmA1cBQ+K1OttXnov2C9O64fvEU=
Date:   Thu, 3 Jun 2021 15:13:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel@collabora.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/1] Initialize debugfs/ksysfs earlier?
Message-ID: <YLjVYaVfNGEkqPAQ@kroah.com>
References: <20210603125534.638672-1-adrian.ratiu@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603125534.638672-1-adrian.ratiu@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021 at 03:55:33PM +0300, Adrian Ratiu wrote:
> Hi Greg & all,
> 
> I would like to add a new debugfs file like in the next patch but
> I'm having a problem with commit 56348560d495 ("debugfs: do not
> attempt to create a new file before the filesystem is initalized").

You should have had a problem before that commit happened as well,
right?

> 
> The problem is debugfs is initialized after the driver core, during
> the core initcall, so I get an -ENOENT failure due to the above commit.
> 
> My first reaction is to move the ksysfs_init() and debugfs_init() calls
> before the driver core init which works. Would that be ok?
> 
> An alternative would be to create the new debugfs file somewhere else
> than the driver core, but I'm not sure where would be a good location,
> maybe in debugfs_init()? Doesn't seem right.

I don't really want the driver core to be messing with debugfs at all,
why is that needed?  I'll respond on your patch...

thanks,

greg k-h
