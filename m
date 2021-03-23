Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5046C3458D9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 08:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhCWHhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 03:37:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:50040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229494AbhCWHha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 03:37:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D66D619BA;
        Tue, 23 Mar 2021 07:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616485050;
        bh=sGWQWXCZmoy4ECjGmTkT6fZzN3SkK/zgrN3oibUa1Pw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X7AgwW1H5OVlYQS0jbEtK+PHcYdmKpowf9Gv10uB6TXnGd4sr0A6ZVo2V7fiG7IJj
         EN2gxi7y3Gngk/zqB0SJxnXV4894vtzdHK38qPOIBoNJBH7wBC3z+EYMNHUVIdN+4a
         w0ftjS8YqLFinLP459eHqRG2KW3nBKnZYjPPcfTs=
Date:   Tue, 23 Mar 2021 08:37:27 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, vkoul@kernel.org,
        vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        hui.wang@canonical.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, bard.liao@intel.com
Subject: Re: [PATCH] soundwire: intel: move to auxiliary bus
Message-ID: <YFmatyAoMZmBmkuZ@kroah.com>
References: <20210323004325.19727-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323004325.19727-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 08:43:25AM +0800, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> Now that the auxiliary_bus exists, there's no reason to use platform
> devices as children of a PCI device any longer.
> 
> This patch refactors the code by extending a basic auxiliary device
> with Intel link-specific structures that need to be passed between
> controller and link levels. This refactoring is much cleaner with no
> need for cross-pointers between device and link structures.
> 
> Note that the auxiliary bus API has separate init and add steps, which
> requires more attention in the error unwinding paths. The main loop
> needs to deal with kfree() and auxiliary_device_uninit() for the
> current iteration before jumping to the common label which releases
> everything allocated in prior iterations.

The init/add steps can be moved together in the aux bus code if that
makes this usage simpler.  Please do that instead.

thanks,

greg k-h
