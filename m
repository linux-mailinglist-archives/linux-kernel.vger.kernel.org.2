Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6667A37B582
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 07:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhELFfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 01:35:09 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:52969 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230017AbhELFfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 01:35:08 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 14C5Xual020758;
        Wed, 12 May 2021 07:33:56 +0200
Date:   Wed, 12 May 2021 07:33:56 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/nolibc: Implement msleep()
Message-ID: <20210512053356.GA20749@1wt.eu>
References: <20210511110159.57286-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511110159.57286-1-broonie@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Tue, May 11, 2021 at 12:01:59PM +0100, Mark Brown wrote:
> +static __attribute__((unused))
> +void msleep(unsigned int msecs)
> +{
> +	struct timeval my_timeval = { 0, msecs * 1000 };
> +
> +	sys_select(0, 0, 0, 0, &my_timeval);
> +}
> +

Just a quick question, is there any reason for not keeping most of the
precision like this and allow applications to use it beyond 4294 seconds
like this ?

	struct timeval my_timeval = { msecs / 1000, (msecs % 1000) * 1000 };

Another thing that comes to my mind is that sleep() returns the remaining
number of seconds if the syscall was interrupted, and I think it could be
very useful in small tests programs to do the same at the subsecond level
in simple scheduling loops for example. Copying what we're doing in sleep()
we could have this:

        if (sys_select(0, 0, 0, 0, &my_timeval) < 0)
                return my_timeval.tv_sec * 1000 + (my_timeval.tv_usec + 999) / 1000;
        else
                return 0;

And since that's an inline function it will be optimized away if the result
is not used anyway, resulting in the same code as the void version in this
case.

What do you think ?

Thanks!
Willy
