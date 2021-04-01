Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5217352403
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 01:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236084AbhDAXea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 19:34:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:46326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235847AbhDAXeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 19:34:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 75A5D6112E;
        Thu,  1 Apr 2021 23:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617320053;
        bh=ohek8UUkVa/WNRVimemVyrb/6iFVB0Xi3zFzl5e8oWw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T8b/8Ep9Qwp2hbgR7w43giAhu/eYWGHHiX/wis/WSBibeFvaVhd3y/dqO8FrcIthm
         L7fnT8cztFZD9RWrfYvmq8AtYPyGcmOEBPW9ThBGYbwdw4H+MnQELcU3pPRLrYsqHt
         fl1geUu6hmD4Va1dG6tqHwaruKcCfLCC/IAY6kIU=
Date:   Fri, 2 Apr 2021 01:34:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 1/1] driver core: enable trace events (devres)
Message-ID: <YGZYcQLXejdKFzvd@kroah.com>
References: <20210401212129.82552-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401212129.82552-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2021 at 12:21:29AM +0300, Andy Shevchenko wrote:
> Enable trace events for driver core. For now only devres is supported.

That says _what_ this does, but not _why_ this is needed or wanted.

And you really don't even describe the "what" at all here either :(

Please be much more verbose when adding new features.

thanks,

greg k-h
