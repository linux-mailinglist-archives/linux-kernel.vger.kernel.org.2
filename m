Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F254078EB
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 16:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhIKOto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 10:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbhIKOtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 10:49:41 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9E2C061574
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 07:48:29 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id b8so3504808ilh.12
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 07:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vN9qXWbO5z/Pyq2w4tejEYUV3TDdw1Ekd9NcwYO/Sr4=;
        b=EqRj3ceR2ylzqQemmvi3AjVrJUDDlxoVqc9j7bFOrZox4/ihRs+pUZ7vfpT8X93Uf3
         GFHYosIyoi1SQ3RXanv5qpNQS9J4kVnuhSd2I75ea1T6cPp6CQ3T1N5WLDiUJVG+XKfK
         Q2Cy0vk9jqLzVuRVTjGbTVJmuQ4jLPp8xPsTqU8SEU9XFzCowHmx81UJ+1rXrK8dJiPD
         tHGgmd8ZBqylmJPLn3GK5Sbvmv2KlYDNmpdi2wtW5clrA/aoYHM6yTHaGiaqaZP3gnAV
         YwmMiJlL7kOijqSOxFQq3xKw5M/rUJ7aV2mBAIN9X17wjyGAcypQlBtlXxFKcZSRa7/4
         v+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vN9qXWbO5z/Pyq2w4tejEYUV3TDdw1Ekd9NcwYO/Sr4=;
        b=Vgwor5GmVmu7a3WIAIlciKZ9Bzp27VVPwqaD5g0K07M54pxljhtTqbDW34Pw07WXo2
         JJwintrZ/b1VHSD3vwhuQ09dThCuGCRE7jsImafYaipRgjs3rSX3a7kOtThnajmDWYrS
         UsFWnVMKv3/1GJz3Ci9Rgm+cEE1skr8H4CwaVLE67F5VXH41yWghC+JylMQxViVfySsl
         4d82cy65adoKpFAxkpMAd8TZq53k1/F6vvuB5R/9rF9RNB6+hfdmdjXhYpkuIvorjyCi
         7wGoOZeNZ26NdWqSEC8pw7Aer19KWpoueiSihe/73JtYcnBtqNB/26q6ihMlA0KQdP9W
         DZkQ==
X-Gm-Message-State: AOAM531TenPDq3AoX2rBsi/cTkV9ZPjqCMYUwRaUmA4oAyjnZAZPHHO4
        2KDg3wek7fM0dVr27uC4/s3hp10xhj5iNqmbfQtNRZJsUiXKYQ==
X-Google-Smtp-Source: ABdhPJyLMuWK0KoUXdPbYAgl2/QDYjwNj6VzuR8i4KuH/s+NPpi6jvmJ8vzeoaolWjdqQz617BDqMPXUQlY6QIWE1sA=
X-Received: by 2002:a92:d3cf:: with SMTP id c15mr2006806ilh.131.1631371708603;
 Sat, 11 Sep 2021 07:48:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210911082505.115758-1-laoar.shao@gmail.com> <20210911122216.GX4323@worktop.programming.kicks-ass.net>
In-Reply-To: <20210911122216.GX4323@worktop.programming.kicks-ass.net>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sat, 11 Sep 2021 22:47:52 +0800
Message-ID: <CALOAHbCwnAiw+A0z2NvjT1z55kxCRmiF-pHdMSm1iTG1O_bHpA@mail.gmail.com>
Subject: Re: [PATCH peterz-queue:sched/core] sched: fix build warning with W=1
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 11, 2021 at 8:22 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Sat, Sep 11, 2021 at 08:25:05AM +0000, Yafang Shao wrote:
> > kernel test robot reported some build warnings with W=1 as below,
> >
> > kernel/sched/fair.c:892:34: warning: variable 'stats' set but not used
> > kernel/sched/core.c:10238:42: warning: variable 'stats' set but not used
> > kernel/sched/fair.c:893:29: warning: variable 'p' set but not used
> > kernel/sched/rt.c:1292:29: warning: variable 'p' set but not used
> > kernel/sched/deadline.c:1486:34: warning: variable 'stats' set but not used
> > arch/nds32/include/asm/current.h:10:13: warning: variable '$r25' set but not used
> >
> > These warnings happen when CONFIG_SCHEDSTATS is not set, in which
> > case the schedstat_* functions will be none. We should add
> > '__maybe_unused' to fix it
>
> I really hate all of this, I think the compiler is just being unhelpful
> in the extreme. Also, I spupose the warning is in W=1 for a reason,
> let's just completely ignore all of this.

Got it.
Thanks for the review.

-- 
Thanks
Yafang
