Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D2E424D1A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 08:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240184AbhJGGOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 02:14:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:52904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231190AbhJGGOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 02:14:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C3749611AE;
        Thu,  7 Oct 2021 06:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633587159;
        bh=4bNba4XP77DpWNOzvphD9BElhgRpTGFdKWEav49aN7s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eym2bM4OT795k6yVuj2jToVv0MuAZgGMIIrbX679g22jNsQAHlR93GgJmqrBFU+aE
         thCSFgesuQacFzqnvYS/wpa0/H+XV0Uu742osGel8y+OZGs+D7Hwfzb9bNQcU0DfwB
         iTF4VhLvfGYb1hebuAgyeMZdsi1fzkIH6IdLeaGE=
Date:   Thu, 7 Oct 2021 08:12:37 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     openbmc@lists.ozlabs.org, Jeremy Kerr <jk@codeconstruct.com.au>,
        Joel Stanley <joel@jms.id.au>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] sysfs: add sysfs_remove_bin_file_self() function
Message-ID: <YV6P1dM6U6sSsefc@kroah.com>
References: <20211007000954.30621-1-zev@bewilderbeest.net>
 <20211007000954.30621-2-zev@bewilderbeest.net>
 <YV6EVcKUQj5DNiXZ@kroah.com>
 <YV6Moz5eCsf6ZZWb@hatter.bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YV6Moz5eCsf6ZZWb@hatter.bewilderbeest.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 10:58:59PM -0700, Zev Weiss wrote:
> On Wed, Oct 06, 2021 at 10:23:33PM PDT, Greg Kroah-Hartman wrote:
> > On Wed, Oct 06, 2021 at 05:09:46PM -0700, Zev Weiss wrote:
> > > This is simply the bin_attribute analog to sysfs_remove_file_self().
> > 
> > No, no binary sysfs file should be triggering a remove.
> > 
> > binary sysfs files are "pass-through-only" from userspace to hardware,
> > the kernel should not be even knowing what is read/written to them.
> > 
> > What do you think this is needed for?
> > 
> 
> So, I initially set out to be able to activate/deactivate specific DT nodes
> at runtime by using the device-tree "reserved" status as defined in the spec
> (but not currently used anywhere in the kernel) to mean essentially "create
> a device for this but don't bind a driver to it" (leaving it to userspace to
> invoke bind/unbind or similar), and added initial support for the specific
> driver I'm concerned with at the moment (aspeed-smc) -- that was the
> previous patch series linked in the cover letter of this one.
> 
> In the discussion of that series, Rob suggested as an alternate approach:
> 
> > Another possibility is making 'status' writeable from userspace. It is
> > just a sysfs file.
> 
> That seemed sort of appealing to me, and this seemed like the most obvious
> way to go about implementing it.  Given that DT properties are binary
> attributes, I gather you'd consider that a non-starter though?

Why would a text attribute of "status" be a binary sysfs file?  That
feels really wrong as again, binary sysfs files are not supposed to be
parsed or handled by the kernel at all, they are only a pass-through.

thanks,

greg k-h
