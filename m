Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C10B03B8219
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 14:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234653AbhF3M1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 08:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234633AbhF3M07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 08:26:59 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8D4C061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 05:24:30 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id bg14so3875896ejb.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 05:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Eh0RuQARDzYtX6oU1mn3qAV9Ucz3Lp8rJN5AdD4bnhs=;
        b=WBXCycTdBoh6XyOaRz5Q0FgDS+p+Jgx5jtTyEatbqxXji88bYAukahgX9m7BnqakDW
         ScgcdoRm4a22be1BUHuSaUkIe/dro9uVDW84Gzz8byb3jhcDM21cjjVIswHwmAzAT2ay
         3r1KF56s0IiNEdecxUP32P2jUjjQ9x42GuI1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Eh0RuQARDzYtX6oU1mn3qAV9Ucz3Lp8rJN5AdD4bnhs=;
        b=MSWNF5Ws0ZneM78BYWcNVXyXekJHib6sejLYvWcK/bsXEXJOPb9pjROdP0yI/wZR4Z
         GMtvk1xquR/hKV550FpIgBcJPVQWAQnsS04Y7qvOS7l5BGjMdJbRayjqHTcQW0ZgX3MV
         PIuYTNwJNzid+ieG4GAJ6nY85LvUufhDYVxgPehC6y1jyOg8gx67x0wP9AR3fWl5Y6ub
         pel8nkK2t3gFupbpx7uVsGAXoxQB44LGiR3yr93euH2mqHEu4OJHYXnLvhEgJoQIJlwc
         2C5uMXq6iwz0AEXsw6Posz1Cu4y9AeShzFtrOmgaYO8yjPrWwGbn9PU0c1gJzkIOkeNv
         L4hA==
X-Gm-Message-State: AOAM533P3lJcnoFoQuSsHcCqHg5dYGpuiF2Z6Po79BH9I9O5eajqFKQi
        QHb5LgcuX35mbmyYErHqCb0T/yuBzVOtdfGTvFUxnA==
X-Google-Smtp-Source: ABdhPJxwqMZaLfOn6TzLb/GLihpg4GGodAJleAoeLOXW6d+kxnZXNArRcvf9kTne5Z021JckBamQgD4y7urdQuzOzm0=
X-Received: by 2002:a17:906:2dd5:: with SMTP id h21mr35625781eji.522.1625055869329;
 Wed, 30 Jun 2021 05:24:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210621072424.111733-1-jagan@amarulasolutions.com> <DB6PR0402MB2760C13BBF36FF98E4F4635988029@DB6PR0402MB2760.eurprd04.prod.outlook.com>
In-Reply-To: <DB6PR0402MB2760C13BBF36FF98E4F4635988029@DB6PR0402MB2760.eurprd04.prod.outlook.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 30 Jun 2021 17:54:18 +0530
Message-ID: <CAMty3ZDb5h2WJNxW=ZdFty53KFoZJmzZ8aBnFYfxnhKhgrpa8A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/9] arm64: imx8mm: Add MIPI DSI support
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Tomasz Figa <t.figa@samsung.com>,
        Fancy Fang <chen.fang@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-amarula@amarulasolutions.com" 
        <linux-amarula@amarulasolutions.com>,
        Anthony Brandon <anthony@amarulasolutions.com>,
        Francis Laniel <francis.laniel@amarulasolutions.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        Milco Pratesi <milco.pratesi@engicam.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

On Tue, Jun 29, 2021 at 12:40 PM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> Hi Jagan,
>
> > Subject: [RFC PATCH 0/9] arm64: imx8mm: Add MIPI DSI support
> >
> > This series support MIPI DSI on i.MX8MM.
> >
> > It worked directly with existing mxsfb driver but the SEC DSIM timings has to
> > be validate and tested through all platforms, ie reason I'm sending it as RFC.
> >
> > Tested on Engicam i.Core MX8M Mini SoM.
>
> Thanks for the work.
>
> >
> > patch 1: dt-bindings for SEC MIPI DSIM
> >
> > patch 2: SEC MIPI DSIM bridge driver
> >
> > patch 3: dt-bindings for SEC DSIM DPHY
> >
> > patch 4: SEC DSIM DPHY driver
> >
> > patch 5: MIPI DPHY reset enable in blk-ctl
> >
> > patch 6: display mix blk ctl node
> >
> > patch 7: eLCDIF node
> >
> > patch 8: MIPI DSI pipeline nodes
> >
> > patch 9: Enable LVDS panel on EDIMM2.2
> >
> > Note:
> > - all these patches on top of Peng Fan's blk-ctl driver.
>
> Would you please update to use V8 patchset?
>
> And the dtb:
> https://patchwork.kernel.org/project/linux-arm-kernel/
> patch/20210604111005.6804-1-peng.fan@oss.nxp.com/

Thanks for the details.

I will rebase to use this series and test. Will update on blk-ctl patches.

Thanks,
Jagan.
