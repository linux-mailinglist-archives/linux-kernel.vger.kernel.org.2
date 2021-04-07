Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85BC0356967
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350931AbhDGKXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:23:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:44282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235325AbhDGKXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:23:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A2867610D0;
        Wed,  7 Apr 2021 10:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617791004;
        bh=GVI/CJ7tbqSphedOWlTuzX+dxcsHHCkBtzLwBBxqfKE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sPFHdIjDtxtYxNYw7wnd34dvp0Fy6Ox3BIdt389hG+6ol/q5sz6uiFFHfe6GJph+p
         LpituZkQfOMI6WA+rwz5PU5DdsMRSo+6oJp/mCQNQLwqFfTE5S9t5FMo1uuprYKshS
         Tfade1EHSsNUonmYZlJt7Pap3h6dukLjAtbgLRzM=
Date:   Wed, 7 Apr 2021 12:23:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 1/1] serial: sh-sci: Respect deferred probe when
 getting IRQ
Message-ID: <YG2IGQ8f0n+joxom@kroah.com>
References: <20210407101713.8694-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407101713.8694-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 01:17:13PM +0300, Andy Shevchenko wrote:
> With platform_get_irq() and its optional variant it's possible to get
> a deferred probe error code. Since the commit ed7027fdf4ec ("driver core:
> platform: Make platform_get_irq_optional() optional") the error code
> can be distinguished from no IRQ case. With this, rewrite IRQ resource
> handling in sh-sci driver to follow above and allow to respect deferred
> probe.
> 
> Fixes: ed7027fdf4ec ("driver core: platform: Make platform_get_irq_optional() optional")

I've already reverted this commit, sorry.  Please feel free to resend
this as a patch series.

thanks,

greg k-h
