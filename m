Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70D933A83C1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 17:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbhFOPQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 11:16:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:33630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230314AbhFOPQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 11:16:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DED8A611CE;
        Tue, 15 Jun 2021 15:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623770068;
        bh=IzB5h1ZE9j+R3TQcYq1sBmFD5Zy2pT3QMw3r4msr8HQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uSU45e6y6uDykQa/k+PLIsz9MZpxn4MWPlx/9lPC7E2taushKD9MQyuy5J882K2Of
         95ip4ywIYi0GruqTaK0lOQ/VFhXFcnw4bgAX141tA3gng3akj9LfQyeiomGU/F+DWc
         6nA0gJIgEIvh4z51hhrrY8mHaoQsCr8C+YSzAiJM=
Date:   Tue, 15 Jun 2021 17:14:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 1/4] devres: Make locking straight forward in
 release_nodes()
Message-ID: <YMjD0kUXZasI+vyY@kroah.com>
References: <20210517122946.53161-1-andriy.shevchenko@linux.intel.com>
 <YK421dBVoXLElvKB@smile.fi.intel.com>
 <YMM3HYt2q5i35OUv@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMM3HYt2q5i35OUv@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 01:12:45PM +0300, Andy Shevchenko wrote:
> On Wed, May 26, 2021 at 02:53:57PM +0300, Andy Shevchenko wrote:
> > On Mon, May 17, 2021 at 03:29:43PM +0300, Andy Shevchenko wrote:
> > > It seems for the sake of saving stack memory of couple of pointers,
> > > the locking in release_nodes() callers becomes interesting.
> > > 
> > > Replace this logic with a straight forward locking and unlocking scheme.
> > 
> > Any comments on the series?
> 
> Greg, Rafael, anything I should do here?

Sorry for the delay.  This looks good to me, and it's a step forward
into adding tracing to the driver core, which I've wanted to add for a
while now.

So I'll take it, thanks!

greg k-h
