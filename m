Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFB33E1427
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 13:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241157AbhHELxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 07:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241100AbhHELxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 07:53:04 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF9CC061765;
        Thu,  5 Aug 2021 04:52:50 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id l19so8147140pjz.0;
        Thu, 05 Aug 2021 04:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mGypu+NaaW+Jhwv++tohvkOpOq2EXdTSw+wGzb6zcXY=;
        b=GKXmOU+ySf+o3OukbvSv/pA5RbTOf44GtDdunsovYzvoPvUnPMlSz4t0g+UqM3SsnG
         G1nzYSU4UXFic6w/8n6qihydAo38qyYbFj9YRvlrkRu+Wvjf9X5m2j2r/aKuSdpz2hvy
         C1vy+TeRBfItlx+pL7J7cYgw2plEnn/Z9hUA0yi5/hIg1Hs4lX01hDtVAoFKSdOgABeu
         ylgYVhXb5UJMvGdJTR5tSCUrHE63OAYYHpDHwiYMTvR2/lbYT3VOb0zsuc7j40xbusBf
         JK8Jx4viVS1X9ygZuHkq6qq5YGRDNZnHCkQd2X6i21oZZFLZLugKVoJeHr0WdTF0lfKK
         ADxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mGypu+NaaW+Jhwv++tohvkOpOq2EXdTSw+wGzb6zcXY=;
        b=SMV6el+/Ews/kYUmWTlTYqcRmzUhG0BLQVXzgAVngW42ceXlZowzi3nH6HRtKtoCCI
         APpKz4ebjg4Ubkhw7xy6B3jgMgCrzVC6olndNp/uTBNGhlykDzoGu6WEorU+jWmkmIwJ
         F52zR21XH8a3Z8DLVnB28p7TgG1xKe42xxb3fMDbBE5m2A5i2XtR9JMjIJOWVCnZXMcC
         Z0C54im9Lqff4X1iEV3MdprJA8sRyyzP7ktoRBeUV2C7M+AcQ0EZPkELXBlMSF604xbH
         vKnV7Sffv3i5hLBKDSX3pyXJbNl0ItbIFazg7LltAcvmjPSvMJK2CSRYp9h4KvFv0r9g
         eiIg==
X-Gm-Message-State: AOAM5305KzNqZeoaC9K+tkN1+DU/xLsSqpntNU4rbgUKUiMmIQkeUSbP
        GvspaWX69wa7FmZ9dj23ebTFzf23N6PITm4h9nU=
X-Google-Smtp-Source: ABdhPJyqrlC+wjN7QOWKQ3nQEXmW3Mste+3scQ3W1W2pJRbKhcHo+smIRdnf47EbM8CP0WtbPya/hI4LB7KfbDt26Hg=
X-Received: by 2002:a65:5ccd:: with SMTP id b13mr2323pgt.203.1628164369860;
 Thu, 05 Aug 2021 04:52:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210801085155.3170-1-len.baker@gmx.com> <CAHp75VcD_Kqedpkw-Pj+uQbWqdu_9FhXqJS5TuGUPoVv2x45-Q@mail.gmail.com>
 <YQvJB5s1zY2yO87D@kroah.com> <CAHp75VeUH3+dZ6scREA-sZz8-7AF_MLobde+2-eZJz=MsxaW0Q@mail.gmail.com>
 <YQvNnf0o9w4fdVjr@kroah.com>
In-Reply-To: <YQvNnf0o9w4fdVjr@kroah.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 5 Aug 2021 14:52:10 +0300
Message-ID: <CAHp75VdWiGM9-AqSeBC0tTWCVyLbjyf-F8_R0uns__HEUdrQMQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Remove all strcpy() uses
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc:     Len Baker <len.baker@gmx.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Phil Reid <preid@electromag.com.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc: David, Daniel, Noralf.

The idea is to move fbtft under drivers/fbdev on the same terms, i.e.
no acceptance of the new drivers there.
The rationale is that for some of the panels it (fbtft) will be the
only driver and nobody will convert it to tiny DRM.
See more below.

On Thu, Aug 5, 2021 at 2:38 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Thu, Aug 05, 2021 at 02:30:35PM +0300, Andy Shevchenko wrote:
> > On Thu, Aug 5, 2021 at 2:18 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > On Sun, Aug 01, 2021 at 02:40:40PM +0300, Andy Shevchenko wrote:
> > > > On Sun, Aug 1, 2021 at 11:53 AM Len Baker <len.baker@gmx.com> wrote:
> > > > >
> > > > > strcpy() performs no bounds checking on the destination buffer. This
> > > > > could result in linear overflows beyond the end of the buffer, leading
> > > > > to all kinds of misbehaviors. So, this serie removes all strcpy uses
> > > > > from the "staging/fbtft" subsystem.
> > > > >
> > > > > Also, refactor the code a bit to follow the kernel coding-style and
> > > > > avoid unnecessary variable initialization.
> > > >
> > > > I don't see patch 3 (even on lore.kernel.org).
> > > >
> > > > Greg, Geert, does it make sense to move this driver outside of staging?
> > >
> > > If you clean up everything that needs to be done, yes, please do.
> >
> > Do we have a clear TODO for that?
> >
> > The current one has the item which is not feasible to achieve in
> > reasonable time. Some of those drivers won't be converted to tiny DRM.
> > So the idea is to keep this out of staging in the maintenance phase
> > (as it currently states, i.e. no new drivers accepted).  For the rest
> > I'm not sure what else can be done (checkpatch? coccinelle?).
> > Actually the first sentence in this paragraph is a motivation for
> > moving out of staging.
>
> Take it up with the DRM developers/maintainers.  If they approve for
> this to move out of staging without being converted over to use tiny
> DRM, then I am fine to move it out.

Got it.  Cc'ed this to corresponding people.

-- 
With Best Regards,
Andy Shevchenko
