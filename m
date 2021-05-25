Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC15390BC6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 23:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbhEYVsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 17:48:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:50332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229610AbhEYVs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 17:48:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 74B4E613CC;
        Tue, 25 May 2021 21:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1621979215;
        bh=rMjDKhEBpaXg2FGIeyQojtDCfZ0+6jZ1tqyvpj3OmLY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UFvh6wekkkcPJFxCYY+fE0xmJQh02ILWsv0jukXePsFCoM0XNqg3tTynxLNTA6L/2
         0fDIwK6Bx8T2ZW7DyphkyOgqRsQyHZZBaPBBojxSoTE9TZ+Q+/CqzdkJi00dw/vHwj
         4LNeEBy2g6UdcCdf9/JkZyKTEH0V1nVZu8QZmHYk=
Date:   Tue, 25 May 2021 14:46:54 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Trent Piepho <tpiepho@gmail.com>
Cc:     linux-kernel@vger.kernel.org, andy@kernel.org, oskar@scara.com,
        Daniel Latypov <dlatypov@google.com>,
        Yiyuan Guo <yguoaz@gmail.com>
Subject: Re: [PATCH v2 1/2] lib/math/rational.c: Fix divide by zero
Message-Id: <20210525144654.e41cb942a2804d08127ad48f@linux-foundation.org>
In-Reply-To: <20210525144250.214670-1-tpiepho@gmail.com>
References: <20210525144250.214670-1-tpiepho@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 May 2021 07:42:49 -0700 Trent Piepho <tpiepho@gmail.com> wrote:

> If the input is out of the range of the allowed values, either larger
> than the largest value or closer to zero than the smallest non-zero
> allowed value, then a division by zero would occur.
> 
> In the case of input too large, the division by zero will occur on the
> first iteration.  The best result (largest allowed value) will be found
> by always choosing the semi-convergent and excluding the denominator
> based limit when finding it.
> 
> In the case of the input too small, the division by zero will occur on
> the second iteration.  The numerator based semi-convergent should not be
> calculated to avoid the division by zero.  But the semi-convergent vs
> previous convergent test is still needed, which effectively chooses
> between 0 (the previous convergent) vs the smallest allowed fraction
> (best semi-convergent) as the result.

Is there any known userspace workload which can trigger this?

IOW, should it be backported into -stable and fast-tracked into 5.13 or
will a 5.14 merge suffice?

