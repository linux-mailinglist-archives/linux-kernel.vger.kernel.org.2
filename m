Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E071A36C4A1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 13:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235748AbhD0LI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 07:08:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:56030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235592AbhD0LIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 07:08:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 14609613BF;
        Tue, 27 Apr 2021 11:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619521642;
        bh=BRo/eDbvQlGm4UOtynp97IJmtV6Q9jckxoge1aD3P8U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jh9JnGp093zCnvaYasdWoryRUgj3/L5MRDmtQuQg+BjWAOQ5OEKlzlzlPzObTz7JH
         VbDJ1wAQrKlzmrXhiU8SgoM45udYfooPBeyhxbiU1X+pP71xcuOFSxzRHtud+Rj1Yz
         hgjA3Lg0mDE/PVEvfTG0zXZmwOvFuEt3V2SijFM0=
Date:   Tue, 27 Apr 2021 13:07:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] fbtft: Replace custom ->reset() with generic one
Message-ID: <YIfwZ/oPVB9splQq@kroah.com>
References: <20210416142044.17766-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416142044.17766-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 05:20:41PM +0300, Andy Shevchenko wrote:
> The custom ->reset() repeats the generic one, replace it.
> 
> Note, in newer kernels the context of the function is a sleeping one,
> it's fine to switch over to the sleeping functions. Keeping the reset
> line asserted longer than 20 microseconds is also okay, it's an idling
> state of the hardware.
> 
> Fixes: b2ebd4be6fa1 ("staging: fbtft: add fb_agm1264k-fl driver")

What does this "fix"?  A bug or just a "it shouldn't have been done this
way"?

And as others pointed out, if you could put "staging: fbtft:" as a
prefix here, that would be much better.

thanks,

greg k-h
