Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B49AF456008
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 17:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbhKRQER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 11:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbhKRQEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 11:04:16 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116F1C061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 08:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bLyYtzBJtGfdAn90Z7we9HaBKQkcvI+sJjyTeDMw2Os=; b=aYSBw0dcNSCAhpIshmXqFv/GzW
        frBO/V/ReYGf9GaLhXC6Z/QfTyytJ4MtFYT1XDsL20EYHb4yJ7IMc7h5EzOHjfcVkLCSlRHhtYxy3
        HqhbeofNxqFudyl6Zm6n86uI0TxbpwO24s28+ypGT/KNdB50/7W4o26hSQwjuMMFGARQdS0TMMo3K
        1dZo6cg2CvPtimiHW5/iz/H+31mrqMsiRqMlYtRU+xJkErKKQwb8MKU6ycp9ZI1ycgfqBq0DrmKLc
        7+qDNVjetvkvu17E0iiPYKpQXiXCFqFFsK8NohYLMi23yRmQBQMY4L1fztc0KLZO+lRJg2ddt9Vqx
        2J2fGdXw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mnjqO-00GiaS-BD; Thu, 18 Nov 2021 16:01:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D1A33300093;
        Thu, 18 Nov 2021 17:00:58 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AA5F630553074; Thu, 18 Nov 2021 17:00:58 +0100 (CET)
Date:   Thu, 18 Nov 2021 17:00:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Eric Dumazet <edumazet@google.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Alexander Duyck <alexanderduyck@fb.com>,
        linux-um@lists.infradead.org
Subject: Re: [tip:x86/core 1/1] arch/x86/um/../lib/csum-partial_64.c:98:12:
 error: implicit declaration of function 'load_unaligned_zeropad'
Message-ID: <YZZ4upqWGMOY+r56@hirez.programming.kicks-ass.net>
References: <202111180219.YkyoBMpf-lkp@intel.com>
 <CANn89iJfh+x-s4GtWJcyRFpMmSvvyq-r1TGV4sDLXy3F50zD6w@mail.gmail.com>
 <CANn89iJj4zeNUiXCmG=rSejbHAwPhBEPKUv1tPL9ig=e4vg7pQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iJj4zeNUiXCmG=rSejbHAwPhBEPKUv1tPL9ig=e4vg7pQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Nov 17, 2021 at 11:40:35AM -0800, Eric Dumazet wrote:
> On Wed, Nov 17, 2021 at 10:55 AM Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Wed, Nov 17, 2021 at 10:46 AM kernel test robot <lkp@intel.com> wrote:
> > >
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
> > > head:   d31c3c683ee668ba5d87c0730610442fd672525f
> > > commit: d31c3c683ee668ba5d87c0730610442fd672525f [1/1] x86/csum: Rewrite/optimize csum_partial()
> > > config: um-x86_64_defconfig (attached as .config)
> > > compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> > > reproduce (this is a W=1 build):
> > >         # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=d31c3c683ee668ba5d87c0730610442fd672525f
> > >         git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
> > >         git fetch --no-tags tip x86/core
> > >         git checkout d31c3c683ee668ba5d87c0730610442fd672525f
> > >         # save the attached .config to linux build tree
> > >         make W=1 ARCH=um SUBARCH=x86_64
> > >
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > >
> > > All errors (new ones prefixed by >>):
> > >
> > >    arch/x86/um/../lib/csum-partial_64.c: In function 'csum_partial':
> > > >> arch/x86/um/../lib/csum-partial_64.c:98:12: error: implicit declaration of function 'load_unaligned_zeropad' [-Werror=implicit-function-declaration]
> > >       98 |   trail = (load_unaligned_zeropad(buff) << shift) >> shift;
> > >          |            ^~~~~~~~~~~~~~~~~~~~~~
> > >    cc1: some warnings being treated as errors
> > >
> > >
> >
> > Hmmm... it seems we need to guard this with CONFIG_DCACHE_WORD_ACCESS ?
> 
> Perhaps something like the following ?

Dear um folks, is this indeed the best solution? It's a bit sad to have
to add this to x86_64, but if that's the way it is...

> 
> diff --git a/arch/x86/lib/csum-partial_64.c b/arch/x86/lib/csum-partial_64.c
> index 5ec35626945b6db2f7f41c6d46d5e422810eac46..d419b9345d6dba2e924887671bc6f11c3e17ebd7
> 100644
> --- a/arch/x86/lib/csum-partial_64.c
> +++ b/arch/x86/lib/csum-partial_64.c
> @@ -91,12 +91,23 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
>                         : "memory");
>                 buff += 8;
>         }
> -       if (len & 7) {
> -               unsigned int shift = (8 - (len & 7)) * 8;
> +       len &= 7;
> +       if (len) {
>                 unsigned long trail;
> +#ifndef CONFIG_DCACHE_WORD_ACCESS
> +               union {
> +                       unsigned long   ulval;
> +                       u8              bytes[sizeof(long)];
> +               } v;
> 
> -               trail = (load_unaligned_zeropad(buff) << shift) >> shift;
> +               v.ulval = 0;
> +               memcpy(v.bytes, buff, len);
> +               trail = v.ulval;
> +#else
> +               unsigned int shift = (sizeof(long) - len) * BITS_PER_BYTE;
> 
> +               trail = (load_unaligned_zeropad(buff) << shift) >> shift;
> +#endif
>                 asm("addq %[trail],%[res]\n\t"
>                     "adcq $0,%[res]"
>                         : [res] "+r" (temp64)
