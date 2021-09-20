Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F92141134F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 13:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236396AbhITLHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 07:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbhITLHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 07:07:24 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733BBC061574;
        Mon, 20 Sep 2021 04:05:57 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id g1so66644909lfj.12;
        Mon, 20 Sep 2021 04:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PjCxldfRwru44yzVW0vVIwEYDHxb2Xe5XdKPGw3FlCQ=;
        b=HPD2lHWqG6zDhxDAGvWl4FtxoAfAyQ9UcSxpszMNZ6ZIrXxW4h/+VP52vNkJpgBsBo
         znQhwLj6GCtY1ml54rl+bIery2uaz5VrXMu/LesvMUXTpMgL3T4tXA1lUcY+LoBGNrgO
         7q0gvpXHoFtf1ej9pjgV0JiCrod7l9iNKpwYhH8lf2c1WjAfiKtzv0DZYqQCQi/lbtPN
         KkJo5fYnXW6eE8qd4xFcUGLHRFa6iOkP5frs49M53RqDKFNbQt9oqV1DtrdtFanITJCt
         PQLQedlYCTsBhB4Bkk61EO/eAxEjvX+a96p9/XSCd9sxBzqMiCEZt1rOxdVqOSf4iPqQ
         Akng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PjCxldfRwru44yzVW0vVIwEYDHxb2Xe5XdKPGw3FlCQ=;
        b=OixGRQBu3e32ci2xSXYHYtIBdi8e+kSRjtnyAyQFsOUFIkcvDQ1u7UCD6UvY30Tnr8
         rGh3xdkblnoftMFJgSmZTCfunrMbSIJpTdSjljR85GwghH3nq+aeInqr5rbpPdYoL7+P
         tXo6US7zDdFz8j2taxYkFL8kIdZk5Zop3XWcxvgI9QFZw48GC31ssPAq98srHkm2XOvb
         XFezymJeWjl1uOA6ZIWKJCphj/a5kOR95iiDxALn/ectHs3E3OyzQHR3Ov4AvgTfsi8L
         peOEWYyETrJdf8q5w5BEwWjfAgZAD1WxtQ4PMwkfDUDnW0DgjJBsLjBJB5NIg3N/6lyP
         mAyQ==
X-Gm-Message-State: AOAM530L2j6211NzY83o3SUEUDad14cgsUOzMR+mZIrpRaAGtF5AFoa6
        whp/YJl0RToXAANJr/HgL6YV4Ys8/ei7xL70xSY=
X-Google-Smtp-Source: ABdhPJwRO0KgsOPqJA1Vmh2XK1AkjUGHw4AWY9f2Q1131kA6mlJudsn6DIV5deXJDhz0+IkhYjZpbv4AruoQGtWytQc=
X-Received: by 2002:a2e:6e06:: with SMTP id j6mr22228990ljc.382.1632135955758;
 Mon, 20 Sep 2021 04:05:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAEyMn7YqrRttqvJzJLA+yVo6WtBZww6QcXT12MMCi+bhjP4pTg@mail.gmail.com>
 <CAEyMn7ZhBfG7703YMr=EDQyf5mHDkLyET5iNqdXDOpJy9ti+rQ@mail.gmail.com>
 <CAOMZO5CZKdc=AmG1eds9Oy_uwqXDWLwPXk74phCDWdjrzkRC4A@mail.gmail.com>
 <CAEyMn7YaQbLoVy_5Rb+hiwhEj-kbnmCwb0B_soa+Kf0D6iH6oA@mail.gmail.com>
 <CAOMZO5CGuKQ0yVyoD86G3KnxoBd2fq+uCTTLoqVR-13Y5a-36Q@mail.gmail.com>
 <CAEyMn7bN247-J=Qz-k3LZMVYb8pdYSP3BSCsNE9yyvfDfmdK0g@mail.gmail.com> <CAOMZO5DEg81E23QBpsv44BxytEhNNoXy-r5BbnubUJTERzWYLQ@mail.gmail.com>
In-Reply-To: <CAOMZO5DEg81E23QBpsv44BxytEhNNoXy-r5BbnubUJTERzWYLQ@mail.gmail.com>
From:   Heiko Thiery <heiko.thiery@gmail.com>
Date:   Mon, 20 Sep 2021 13:05:43 +0200
Message-ID: <CAEyMn7Yvc_tck=Hd8GE1a7uO8nRsrkdJ7b_jL6EY0-U6b=TjoQ@mail.gmail.com>
Subject: Re: imx8mm board crash in drivers/usb/chipidea/ci_hdrc_imx.c
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Peter Chen <peter.chen@nxp.com>, Jun Li <jun.li@nxp.com>,
        Yu Kuai <yukuai3@huawei.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Mo., 20. Sept. 2021 um 12:52 Uhr schrieb Fabio Estevam <festevam@gmail.com>:
>
> Hi Heiko,
>
> On Mon, Sep 20, 2021 at 6:17 AM Heiko Thiery <heiko.thiery@gmail.com> wrote:
>
> > Now it is clear to me. I used the dtb for my board that had already
> > changed the phy node and tried to boot the "old" kernel 5.14. Thus no
> > phy could be found. Nevertheless the kernel should not crash in case
> > no phy was found.
>
> Agreed. The patch I proposed earlier should fix the problem, correct?
> https://pastebin.com/raw/yZKz1huL

Yes this should do it.

-- 
Heiko
