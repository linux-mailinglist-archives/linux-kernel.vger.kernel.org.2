Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E177A3419B4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhCSKQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbhCSKP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:15:56 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C137CC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:15:55 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id r193so5466294ior.9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GtahXJp+uaR41csgfyvASKpwx1k07B8T9fka/mVTFKI=;
        b=MJUbI9ZVYA2st4wYNHTZvoSpQVpqGitTSxbV6Ztrg6W3NT8n3zeEjZ4g62iOG6wUQt
         2XJ5/NGfbtIAh+HIIco/1RIiKyN/kuG4SThxOKaQX6hQD96IKjdehhwuuDUclsM+ibW4
         2EGRPKz2YGjq4f4piYZw4vy4Q6bHowNjIEorwvK2SBLSsClGoXrq3lrDMSUGU6ZyZ9Bj
         afO7b1FJ930U+BM+t9QRBMMLVTnrMsuo11We0Xn5rLJZwBZG1OjpF3cu9C9wPEJDiXex
         8EYHQ118TGpJuLut1Eubnvr0LdGTUAmPRIz8fI8+0PkPHyBSTP0KPHW4gvvFcX0gwtny
         T1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GtahXJp+uaR41csgfyvASKpwx1k07B8T9fka/mVTFKI=;
        b=oeMfQt6Z6eeGS2BpvCkGP8A3gITROEwq7QVi9N85EGZjWJuuUgRWKd5f72Fd0d+s2P
         tdOj0bg/3F057KyvI8IcdiL1PkuGueyjkDHGFanmTG7zV79+k0tGIIadwqj1IfIzLeOD
         qx34lLkANOTXiBHEvFxFZQtOlKHdSQHDtdI6ItNeCv9tHRTV0XzGwEx9RXKn7duzPyDZ
         g/0N7+9VwS/wlL+r/FgknZ6ZC4rijliivUKj0MaIQSRtUqG6BNOf8ww3LPIXb/zCfNwu
         6T0qfdC/memlIKE6Scd2cvnI7Oiouo5/XlgtznPVhk/8aXJZ7sICEnEIssAdN1sXElx6
         MKMg==
X-Gm-Message-State: AOAM533xzKt5s1o7yjsWxcZI2CW1nVSd1huQYk6KWlQtk9p/Sh9Li+8T
        /lg8bDfZYs40JnpUDFR8by2w53O/kXwEfcROfio=
X-Google-Smtp-Source: ABdhPJyG/NhpFiy3gCt+bGl+cqjH1OdXj3G0hOtfGzGM8+BJ/GPedDIXEHu5CvM+KGgcX/NiNbkFpzSp30Uh7eLd9Ko=
X-Received: by 2002:a5d:9c50:: with SMTP id 16mr2218315iof.66.1616148955025;
 Fri, 19 Mar 2021 03:15:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210319101246.73513-1-laoar.shao@gmail.com>
In-Reply-To: <20210319101246.73513-1-laoar.shao@gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Fri, 19 Mar 2021 18:15:19 +0800
Message-ID: <CALOAHbAO+2ZHjF8RH4aGFh2Zh9y0-Uwu+rv-NrQjF49YjA-j2w@mail.gmail.com>
Subject: Re: [PATCH v6 resend 0/3] mm, vsprintf: dump full information of page
 flags in pGp
To:     Petr Mladek <pmladek@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>, penberg@kernel.org,
        David Rientjes <rientjes@google.com>, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Joe Perches <joe@perches.com>
Cc:     Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 6:13 PM Yafang Shao <laoar.shao@gmail.com> wrote:
>
> The existed pGp shows the names of page flags only, rather than the full
> information including section, node, zone, last cpuipid and kasan tag.
> While it is not easy to parse these information manually because there
> are so many flavors. We'd better interpret them in printf.
>
> To be compitable with the existed format of pGp, the new introduced ones
> also use '|' as the separator, then the user tools parsing pGp won't
> need to make change, suggested by Matthew. The new added information is
> tracked onto the end of the existed one, e.g.
> [ 8838.835456] Slab 0x000000002828b78a objects=33 used=3 fp=0x00000000d04efc88 flags=0x17ffffc0010200(slab|head|node=0|zone=2|lastcpupid=0x1fffff)
>
> The documentation and test cases are also updated. The result of the
> test cases as follows,
> [68599.816764] test_printf: loaded.
> [68599.819068] test_printf: all 388 tests passed
> [68599.830367] test_printf: unloaded.
>
> This patchset also includes some code cleanup in mm/slub.c.
>
> v6:
> - fixes the build failure and test failure reported by kernel test robot
>
> v5:
> - remove the bitmap and better name the struct, per Petr
>
> v4:
> - extend %pGp instead of introducing new format, per Matthew
>
> v3:
> - coding improvement, per Joe and Andy
> - the possible impact on debugfs and the fix of it, per Joe and Matthew
> - introduce new format instead of changing pGp, per Andy
>
> v2:
> - various coding improvement, per Joe, Miaohe, Vlastimil and Andy
> - remove the prefix completely in patch #2, per Vlastimil
> - Update the test cases, per Andy
>
> Yafang Shao (3):
>   mm, slub: use pGp to print page flags
>   mm, slub: don't combine pr_err with INFO
>   vsprintf: dump full information of page flags in pGp
>
>  Documentation/core-api/printk-formats.rst |  2 +-
>  lib/test_printf.c                         | 90 ++++++++++++++++++++---
>  lib/vsprintf.c                            | 66 +++++++++++++++--
>  mm/slub.c                                 | 13 ++--
>  4 files changed, 149 insertions(+), 22 deletions(-)
>
> --
> 2.18.2
>

Hi Petr,

Any comments on this version ?

Thanks
Yafang
