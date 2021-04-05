Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D777B353C17
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 08:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbhDEGYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 02:24:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:40302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229454AbhDEGYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 02:24:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D20B610F7;
        Mon,  5 Apr 2021 06:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617603871;
        bh=tbXdrJMlzPOqhqieloe8dsSt+Ms5HiJFXHzl+w1kIN0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rL360vxoLFR4NYxNV2CQM7iQ4zLSyNHyr+66DWWfXdZ1I+P5Ax5sJ/P0kIATJL3oY
         YoawE2190ntYf5qqAagiMgK67OBf20mUWt6ck0aspwflmvPrPWicA+jsYAcK5fFCfD
         xo0bhEA7eCNapjV3wc3JAi3U4yicdvQ2e22a1D6E=
Date:   Mon, 5 Apr 2021 08:24:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Arend van Spriel <arend@broadcom.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] debugfs: Fix use-after-free in
 debugfs_create_devm_seqfile()
Message-ID: <YGqtHb/CMbiE6w0c@kroah.com>
References: <20210404004504.5547-1-samuel@sholland.org>
 <YGmQAWBN4+uQCIUa@kroah.com>
 <2a36734b-c76c-7554-5f16-913ffebe288f@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a36734b-c76c-7554-5f16-913ffebe288f@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 04, 2021 at 12:26:10PM -0500, Samuel Holland wrote:
> On 4/4/21 5:08 AM, Greg Kroah-Hartman wrote:
> > On Sat, Apr 03, 2021 at 07:45:04PM -0500, Samuel Holland wrote:
> >> This function uses devres to clean up its allocation, but it never removes the
> >> file referencing that allocation. This causes a use-after-free and an oops if
> >> the file is accessed after the owning device is removed.
> > 
> > What in-kernel user of this is having this problem?
> > 
> > The driver should clean up the debugfs file, it is not the debugfs
> > core's job to auto-remove the file.
> 
> The function returns void. debugfs_remove() requires the dentry pointer,
> which the caller does not have. How is the driver expected to clean up
> the file?

Like it does for any other debugfs function (you will not that almost
all of them return void now.)

You remove the parent directory.

> Do you expect the driver to remove the file as a side effect of
> recursively removing its parent?

Yes.

> If so, that conflicts with the documentation for
> debugfs_create_devm_seqfile(), which describes NULL as
> a valid parent:
> 
> @parent: a pointer to the parent dentry for this file.  This should be a
>      directory dentry if set.  If this parameter is %NULL, then the
>      file will be created in the root of the debugfs filesystem.
> 
> There is one in-kernel caller that uses a NULL parent, in
> drivers/gpio/gpio-tegra.c

That code should be fixed up, putting a driver-specific file in the root
of debugfs is a bit rude.

> > The resource is what is being cleaned up by the devm usage in debugfs,
> > that's all, not the file.
> > 
> > Please fix up the driver that is creating the file but then not removing
> > it.
> 
> In that case, the function documentation should be modified to state
> that the driver is responsible for removing the parent directory, and
> that NULL is not a valid parent here. I can send a patch doing that instead.

Please feel free to fix up allmost of the debugfs functions as I think
they all say the same thing :)

I've been slowly cleaning up the debugfs api, but have not been paying
that much attention to the documentation yet, sorry.

thanks,

greg k-h
