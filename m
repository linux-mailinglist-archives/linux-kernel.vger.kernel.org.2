Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F01F38B88A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 22:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238851AbhETUmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 16:42:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:33304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237395AbhETUmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 16:42:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 63F6B613BB;
        Thu, 20 May 2021 20:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1621543273;
        bh=bzP4CK6SG5evDgM7IOYbwPymXk/YVnKcwkLZ4LLAG8k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0tm4FUJNzumcZJg3H10jpiJ2NVV3BDOCO/nEbEsAD8PyEHCzN8tpY660StQCVKQP9
         3Zz4cSfYes9zphNic1o/yqlZ2gleZWmFx+GW36YlDAtDbHD0FrYqm9CaiBmfUrIAbL
         0ll3l7ddy/aGpKEaWBvgEapQ8cUtqSSOzF2K1PVA=
Date:   Thu, 20 May 2021 13:41:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Yury Norov <yury.norov@gmail.com>,
        linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: Re: [PATCH] linux/bits.h: Fix compilation error with GENMASK
Message-Id: <20210520134112.ee15f156f1b7dbd3d8f16471@linux-foundation.org>
In-Reply-To: <20210511203716.117010-1-rikard.falkeborn@gmail.com>
References: <20210511203716.117010-1-rikard.falkeborn@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 May 2021 22:37:15 +0200 Rikard Falkeborn <rikard.falkeborn@gmail.com> wrote:

> --- a/include/linux/const.h
> +++ b/include/linux/const.h
> @@ -3,4 +3,12 @@
>  
>  #include <vdso/const.h>
>  
> +/*
> + * This returns a constant expression while determining if an argument is
> + * a constant expression, most importantly without evaluating the argument.
> + * Glory to Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
> + */
> +#define __is_constexpr(x) \
> +	(sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))

Boggle.

Could someone please sometime enhance that comment a bit?  What need
does this thing satisfy and how on earth does it work?

