Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAFC2413B1E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 22:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbhIUUOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 16:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhIUUOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 16:14:21 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01034C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 13:12:53 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id v19so412807pjh.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 13:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vl75DagWXnUNTjQ1RM6YlSoItnxX94Uk5/hqJPmHyJU=;
        b=I/qz8GnNcrbNEqxPNTRxXrd/BKi6Ma+0lXEGQe/CIq5lpmUmpuMH696cxuL35WmdF8
         LNBTe5GcfB370Qv71qnjVn4ZhkvxnPP/9so6TlzQQ5C2QMdGoGH6wsT5fT1BqHgUH0uj
         6HgM/NcUq6DXo2GQLmP46XDtV62jeCkJLF8AE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vl75DagWXnUNTjQ1RM6YlSoItnxX94Uk5/hqJPmHyJU=;
        b=ZSU2H3rrTPGCtUE67aHyKD7lcuXP58s6/AsHpRPpjrfSrzKeJfo6dfe6IGfomygbUJ
         lpYMExvmagYdt72IyTfT0Uuu0WMpJiuZG/wbgmCYmV6eX2tvw9n78HpCXZPAIoDuiEMt
         CQecKXJCi9Iwgl4b6xspX2tRiCB+wBJIVRB1R1/ZrpwTOff8649HWHVCDEm7YaPd3FVz
         wrHnaA/duKPFs1oh8zTw8cDn57l0kU222b4ZSDJjcQLy3NeM69nn+G7MDIEHLp0jIarT
         v8N7t88c71IGvCOu/Q5exMf8QC94D2iA6/if52FQkUc8wz1hAWrP4BE/KfDeUNg76xnY
         CFHA==
X-Gm-Message-State: AOAM5324uHDcO3wk/GVqrQ8XWuuJEQtrFR3A7+Ucis4ssn+SWhJ7U3/I
        sB/jAwl68IIr8T8ILotv2Dc6dA==
X-Google-Smtp-Source: ABdhPJzb5+j1rA9KpjQ3FqhH1zGoMA4VnVYQqzGH8mO19Cyb72+ef4WEbykAMpnMF0MGf22SbLnYcg==
X-Received: by 2002:a17:90a:353:: with SMTP id 19mr7333779pjf.83.1632255172289;
        Tue, 21 Sep 2021 13:12:52 -0700 (PDT)
Received: from lbrmn-mmayer.ric.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id v12sm11903pjd.9.2021.09.21.13.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 13:12:51 -0700 (PDT)
Received: by lbrmn-mmayer.ric.broadcom.net (Postfix, from userid 1000)
        id A367929D3B19; Tue, 21 Sep 2021 13:06:09 -0700 (PDT)
Date:   Tue, 21 Sep 2021 13:06:09 -0700
From:   Markus Mayer <mmayer@broadcom.com>
To:     Miles Chen <miles.chen@mediatek.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Kubecek <mkubecek@suse.cz>,
        Jisheng Zhang <jszhang3@mail.ustc.edu.cn>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH] scripts/sorttable: riscv: fix undelcred identifier
 'EM_RISCV' error
Message-ID: <20210921200609.GA919124@lbrmn-mmayer.ric.broadcom.net>
References: <20210913030625.4525-1-miles.chen@mediatek.com>
 <20210915215432.02a5e08e@xhacker>
 <20210915160526.tittz3fewddjrqu3@lion.mk-sys.cz>
 <b96f2415d14bcf00338b036155ea7f54b25d9a6d.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b96f2415d14bcf00338b036155ea7f54b25d9a6d.camel@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 12:27:24PM +0800, Miles Chen wrote:
> cc Andrew,
> 
> On Wed, 2021-09-15 at 18:05 +0200, Michal Kubecek wrote:
> > On Wed, Sep 15, 2021 at 09:54:32PM +0800, Jisheng Zhang wrote:
> > > On Mon, 13 Sep 2021 11:06:25 +0800
> > > Miles Chen <miles.chen@mediatek.com> wrote:
> > > 
> > > > Fix the following build break by adding a conditional
> > > > definition of EM_RISCV in order to allow cross-compilation on
> > > > machines which do not have EM_RISCV definition in their host.
> > > > 
> > > > build break log from [1]:
> > > > scripts/sorttable.c:352:7: error: use of undeclared identifier
> > > > 'EM_RISCV'
> > > 
> > > Looks strange I can't reproduce it.  FWICT, this may be seen with
> > > some old toolchains.
> > 
> > I checked the history and EM_RISCV was added to <elf.h> in glibc
> > 2.24 so builds on systems with glibc headers < 2.24 should show
> > this error.

This is happening for us when we try to build ARM(64) cross-builds on
Ubuntu 16.04. Yes, I know, that's a fairly old distro. At the same
time it isn't ancient (extended support is still available), and it
*should* be possible to build the 5.15 kernel on it.

And yes, some of our build machines have been updated to Ubuntu 20.04,
but not all of them. We'll get there eventually. For now this error is
posing a bit of a problem.

> > Michal
> > 
> > > > [1] 
> > > > https://urldefense.com/v3/__https://lore.kernel.org/lkml/e8965b25-f15b-c7b4-748c-d207dda9c8e8@i2se.com/__;!!CTRNKA9wMg0ARbw!2wBeUUDf3Z2m7uJLF51GeZnBFWXRlEQrzGJ72JWIT0MPUcS_RgW98QWTXkEjy9-lhg$
> > > >  
> > > > 
> > > > Cc: Jisheng Zhang <jszhang@kernel.org>
> > > > Reported-by: Stefan Wahren <stefan.wahren@i2se.com>
> > > > Fixes: 54fed35fd393 ("riscv: Enable BUILDTIME_TABLE_SORT")
> > > > Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> > > 
> > > Reviewed-by: Jisheng Zhang <jszhang@kernel.org>
> 
> 
> Hi Andrew,
> 
> I cannot find the maintainer for scripts/sorttable.c, would you pick
> up this change, please?

Yes, please. I've been looking at failed nightly builds since September
12. It's only a forward looking build (so nothing mission critical),
but it would still be nice to have it build again.

Regards,
-Markus
 
> thanks
> Miles
> 
> > > 
> > > > ---
> > > >  scripts/sorttable.c | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > > 
> > > > diff --git a/scripts/sorttable.c b/scripts/sorttable.c
> > > > index f355869c65cd..6ee4fa882919 100644
> > > > --- a/scripts/sorttable.c
> > > > +++ b/scripts/sorttable.c
> > > > @@ -54,6 +54,10 @@
> > > >  #define EM_ARCV2	195
> > > >  #endif
> > > >  
> > > > +#ifndef EM_RISCV
> > > > +#define EM_RISCV	243
> > > > +#endif
> > > > +
> > > >  static uint32_t (*r)(const uint32_t *);
> > > >  static uint16_t (*r2)(const uint16_t *);
> > > >  static uint64_t (*r8)(const uint64_t *);
