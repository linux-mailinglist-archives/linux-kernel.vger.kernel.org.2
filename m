Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0AA40D6FB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 12:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235852AbhIPKEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 06:04:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:60612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235287AbhIPKEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 06:04:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D222F60F6C;
        Thu, 16 Sep 2021 10:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631786599;
        bh=nYLXu40n5BlNNZ1ZZo4YAdI74ZwOUPwUslx5aAK6Hq8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O+Vb4svGeHChlaklUGMZbA+r4Dh4W+rnNEV6FdaLFumpFYtv64HuipBv5qho6Cd1S
         oGVFyszd3nNUuAXEjtFULgYOA0YCaSmLXdYbJwccvfgEdoFUK8dFJ45bgF0zd2OmmI
         mSMF8XrFv7j6Bf3JN4PEKgHz/SwHBZJSz0NTPrxfd0w2QKEq745vKVt9KZ0X5Um3c9
         qKaQLJIsRFE67j0EaIviAmjT13ZJdi/8sFdgFm3c0XfX4oY10uIm/XfMWpL/DNQYjE
         GjLJ+HkYYNe0Vq4OF8lOCFqeoSj+xQV74yEEeFNYNa9ihMAzU/zyfkMa/Ps04F5bMm
         JfK5jGYZhROHg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mQoEi-0005SF-Nx; Thu, 16 Sep 2021 12:03:20 +0200
Date:   Thu, 16 Sep 2021 12:03:20 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/16] tty: drop tty_flip_buffer_push
Message-ID: <YUMWaCpT4s8dQKiy@hovoldconsulting.com>
References: <20210914091134.17426-1-jslaby@suse.cz>
 <20210914091415.17918-1-jslaby@suse.cz>
 <20210914091415.17918-9-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914091415.17918-9-jslaby@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 11:14:15AM +0200, Jiri Slaby wrote:
> Since commit a9c3f68f3cd8d (tty: Fix low_latency BUG) in 2014,
> tty_flip_buffer_push() is only a wrapper to tty_schedule_flip(). All
> users were converted, so remove tty_flip_buffer_push() completely.

Did you consider inlining tty_flip_buffer_push() or unexporting
tty_schedule_flip() instead?

The name tty_flip_buffer_push() is arguable more descriptive since the
work may already be running and is also less tied to the implementation.

The ratio of drivers using tty_flip_buffer_push() over
tty_schedule_flip() is also something like 186 to 15 so that would
amount to a lot less churn too.

Also, can you please start adding cover letters to your series to
provide an overview of what it is you're trying to accomplish?

Johan
