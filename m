Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1B75369827
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 19:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243317AbhDWRTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 13:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbhDWRTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 13:19:13 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8540C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 10:18:36 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id h141so425553iof.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 10:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sbzRYAY/cbRVyjGotWkxK2tIQ5GU/0Fy+o6WAo96tSw=;
        b=LnQKdiZvwNIQPnnnzSwOf6iGpU3KjD0EZClP8lJg0/LgqC2SJ+hx2cMZoRoQoAPv4u
         t6+D0K/KXt/o7ZDSehB5g4ERQlod7MdI/onUjW0KBDC1Dql1tmD+MRXCi9SWEzn6F1YG
         EJIFU8XeIHbUXeTv6u9Z97TcB0sdvP6hY3uqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sbzRYAY/cbRVyjGotWkxK2tIQ5GU/0Fy+o6WAo96tSw=;
        b=d/PP7UQ3NOszbM0Kf/KKr7O2ayhwNvVdb/lu25RUNrfdMvCttqHCkUjSgel+MYvHpu
         eaBotfPCXX8op/2wMKCi4EDmZd1NN7RcyLYmuLDIK3QA/VQ6aANgQeeYo+85hcMwFJFf
         NHfQnuNVbbdt7MKa/VzGU7XNP71a9VDljhYhUtlzvdG1Jtd3ZMamK8705yDEf/vj7oo9
         i1NnibrE92+JJg4bFHqdUkwk23S0B7EV7drq24XjUhn77ZrsJ1tMYF8vqjozQxAStNGu
         bzf/3ZN7xPhVa+s2XBUY8YXZJlsC4472uu4CU8lLLrg57D2ef7s0i+OsXUfmpbcDEku2
         Vh8Q==
X-Gm-Message-State: AOAM533lRaSw1DyZGBqDvb86VV6XymikpMLzA9UP1o2dAfqOGChwYMsp
        SxRT2dM95ey/wCa+IEbxEfV7CvqHdXZzhNWW
X-Google-Smtp-Source: ABdhPJxCfs0IntX9HOavgRFigZVVFY05Ci5ePrLpuroJgMSGmIxiaoZ9hkn/aUklBjJ9keL9KOyu8w==
X-Received: by 2002:a02:7f13:: with SMTP id r19mr4535009jac.113.1619198315797;
        Fri, 23 Apr 2021 10:18:35 -0700 (PDT)
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com. [209.85.166.174])
        by smtp.gmail.com with ESMTPSA id s14sm2813072ilj.14.2021.04.23.10.18.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 10:18:35 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id r5so1097017ilb.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 10:18:35 -0700 (PDT)
X-Received: by 2002:a92:ca06:: with SMTP id j6mr4010549ils.234.1619198314820;
 Fri, 23 Apr 2021 10:18:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210423063227.GA17429@xsang-OptiPlex-9020>
In-Reply-To: <20210423063227.GA17429@xsang-OptiPlex-9020>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 23 Apr 2021 10:18:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg8iAG6bBB+zdoZvZx1XYmyAXrWL0gPs_eTrTt+tXN0Tw@mail.gmail.com>
Message-ID: <CAHk-=wg8iAG6bBB+zdoZvZx1XYmyAXrWL0gPs_eTrTt+tXN0Tw@mail.gmail.com>
Subject: Re: [mm/vunmap] e47110e905: WARNING:at_mm/vmalloc.c:#__vunmap
To:     kernel test robot <oliver.sang@intel.com>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Harish Sriram <harish@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 11:15 PM kernel test robot
<oliver.sang@intel.com> wrote:
>
> commit: e47110e90584a22e9980510b00d0dfad3a83354e ("mm/vunmap: add cond_resched() in vunmap_pmd_range")

Funky. That commit doesn't seem to have anything to do with the oops.

The oops is odd too:

> [  198.731223] WARNING: CPU: 0 PID: 1948 at mm/vmalloc.c:2247 __vunmap (kbuild/src/consumer/mm/vmalloc.c:2247 (discriminator 1))

That's the warning for an unaligned vunmap():

  2247          if (WARN(!PAGE_ALIGNED(addr), "Trying to vfree() bad
address (%p)\n",
  2248                          addr))
  2249                  return;

> [  198.744933] Call Trace:
> [  198.745229] free_module (kbuild/src/consumer/kernel/module.c:2251)

  2248          /* This may be empty, but that's OK */
  2249          module_arch_freeing_init(mod);
  2250          module_memfree(mod->init_layout.base);
  2251          kfree(mod->args);

That's the "module_memfree()" - the return address points to the
return point, which is the next line.

And as far as I can tell, the only thing that assigns anything but
NULL to that init_layout.base is

                ptr = module_alloc(mod->init_layout.size);

which uses __vmalloc_node_range() for the allocation.

So absolutely nothing in this report makes sense to me. I suspect it's
some odd memory corruption.

Oliver - how reliable is that bisection?

Does anybody else see what might be up?

            Linus
