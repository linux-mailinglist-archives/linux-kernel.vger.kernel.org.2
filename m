Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B88CC3F19A9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 14:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239106AbhHSMrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 08:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhHSMrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 08:47:51 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B07DC061575;
        Thu, 19 Aug 2021 05:47:15 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id o2so5793443pgr.9;
        Thu, 19 Aug 2021 05:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ixqCxE/RtYaj+rEgBZfu98gHaJ0UMZzaRlA+CP4jLJ0=;
        b=PQjRpg9CYqMymtIf87U4U9QWo37O7Mux4b/YqN20VY8GaB6uMuhBBZOouqyFOwN5MJ
         Ic7Hw6GpMOXZCs2GTJg+tIAwvtFgt2cBId1sG080BEcwtQQ51kjIM2NjFxEIJUtjyw5o
         muxvgt1y2EzIPUsYy7UiiSVxwO3xMgcKd8suaEL9hy2Z/czuWosh2Q7lQagc/cjSEef+
         LdaKLime+346Jzuy5pAPKab7haVt3ocKOoWC7ToVxNwpaw8J4tEt+Vy0pQufOsJ5vUQY
         Yb+7a3F4RZnkPrS6CSOyxQnh/SIUh3tLZuXpuQ71HdbYmF4hnOlVHR326+eHACRB1ed4
         tb7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ixqCxE/RtYaj+rEgBZfu98gHaJ0UMZzaRlA+CP4jLJ0=;
        b=ANVzjl6lSU6pUFe6+btThEkAiSTPXhZTsTQcqdKJgarfoob9xebkVTpTtfJXsSmTkc
         3o9IVwmiBB0CdRb/BrNlFaZHVj6N1LgpsqU/ycv4fnRWEEBQzTnAQVqRkN2oTKcuHEvC
         X1Jk6/qooUja1QUWZzA6eom7ZyampkbHxro7v3o+8uIumKdxDUp8eRnco0gDfIgGh40j
         fF6N/FoOVeC+fflnN4vdo0jiL9zb3wndSZTSN0U5wxGghOIMGKwQrRK7JK94C4xjtSAP
         2opRDtuL0f4hYfBvEPRPrJZu87Su8WDJwwUCpjPVj1/8vWT1RityNaaOdnrEYhtvclcp
         rt2Q==
X-Gm-Message-State: AOAM533a/aZQFwjYXUqUGf+KsJkLppa9bHD/WtFBOC9X66cMVtQIpG/P
        4NKYQSmPy0gF4mGH5A7m1LfnjRChVKkzIDlxvm4=
X-Google-Smtp-Source: ABdhPJzYnGNeAN5xyb9jVGO4rbETTnVMZor7yAcJLPq8/nGlzbaPKhbD61Pu2kb36029cdMW5srkAnjRx5cJLBx1Vk8=
X-Received: by 2002:a65:45c3:: with SMTP id m3mr13945248pgr.203.1629377234728;
 Thu, 19 Aug 2021 05:47:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210819033001.20136-1-hpa@redhat.com> <1360c64f-b695-a4b8-8b61-a4dfb0e896f0@redhat.com>
 <CAHp75VcdOc+G1Yov9HcGhMbEqzGwemmD7=SHd3qOOsEdAqjg2Q@mail.gmail.com> <CAHp75VfvjVeq716d=aGvZXvmzbpW4+XG66ryVYrBxk5G5Wd6cg@mail.gmail.com>
In-Reply-To: <CAHp75VfvjVeq716d=aGvZXvmzbpW4+XG66ryVYrBxk5G5Wd6cg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 19 Aug 2021 15:46:35 +0300
Message-ID: <CAHp75VfhhwDzREn79cN67J-u0nhNuoXDehU8aXiH8B73qc8VVQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/20] Intel platform driver code movement
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Kate Hsuan <hpa@redhat.com>, Alex Hung <alex.hung@canonical.com>,
        Mark Gross <mgross@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        AceLan Kao <acelan.kao@canonical.com>,
        Jithu Joseph <jithu.joseph@intel.com>,
        Maurice Ma <maurice.ma@intel.com>,
        Sujith Thomas <sujith.thomas@intel.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        Zha Qipeng <qipeng.zha@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dell.Client.Kernel@dell.com,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 3:14 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, Aug 19, 2021 at 3:03 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Thu, Aug 19, 2021 at 1:48 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >
> >
> > > Thank you for your patch-series, I've applied the series to my
> > > review-hans branch:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans
> > >
> > > With the changes mentioned in replies to individual patches.
> >
> > Can we postpone this a bit, please?
> >
> > I have a few comments here and there. I'll send asap.
>
> Hmm... It seems it will take less time if I simply take what you have
> in your repo and produce a v4.
> Would it work?

Oh, there are more issues with the patches. Kconfigs have copy'n'paste
text from Makefiles.
Anyway, it seems I will do a v4.

-- 
With Best Regards,
Andy Shevchenko
