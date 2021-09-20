Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 781A34111D2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 11:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236294AbhITJTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 05:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbhITJT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 05:19:26 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B21BC061574;
        Mon, 20 Sep 2021 02:17:59 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id b15so46575673lfe.7;
        Mon, 20 Sep 2021 02:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9MJUyrdjtL92fDVKRhBW6cihvti+fX42bYpBsWMvv+E=;
        b=NSEXhIOt00QDtxSI+izwhuCtvzp95rPJVKrC6aoKUqAF15wMlMZd0t5HNFHYK7aR+A
         TDWt77yv+ysif3eiz58aZ3O8NUfNoxCxB2vwddMZpLDGH1j2KnCs1RmmpkgBwNR7LLnW
         WxMJa2Mcm7QL1oShXaJqf34MuYtIb7iB6e4p1OZlsuIB0Jlr+nYhiIoTSqeS/FslaIQI
         kz8MzEaZbc1C3YePXdn4gJQFmy4faw8YlIVbXFXzxVrs7miJhPxv4kImnfwDiO0fGsFr
         CbJEkKCJESKCT29EHNceurQ5LoyKzHe1PtnHYAkRH/1Xv0J6zl+ZxJ9h9vGDJtQK0p/L
         iTVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9MJUyrdjtL92fDVKRhBW6cihvti+fX42bYpBsWMvv+E=;
        b=Jo4EuIkqcw9Yfj+FhOWbBUxvYAIcU+gLlLZqhEqbo1fY4lSRYD4VQnl+TliksBo5xf
         XPPzOwq/mq1j2A5rtiZasz6yPYghLXqAUP8JPIE1Y1Fi/dEJcfst3GIUv9yXnppTHfXH
         pybZdDrUfjvF8xhTYiFpR2eYyBHAUXTAqARrg3Ybt5xSVDVncBfJH0Wh+1EMDE+7zJ+R
         Jq6dZ+0/bJXyxq9i8qI6lHxvryVePr7wJvIFGCPwpjxGeKG5GO/lon1kmRgTsR6ULMC5
         F2bwJRWB+7YpKZMH20OdGreAAnTnDmpDjfeLXlxO6zZNXjB3spTuXjC4hdOBHJbf06fz
         DwmA==
X-Gm-Message-State: AOAM53027hNjKdu4ciYT4nDtug7TB22J4SsqiL8LF6G55hq1BfEp2etl
        4UlAp7PCU/uN5E6tI2NQdtl4Onc3axque0OPSiA=
X-Google-Smtp-Source: ABdhPJwoIpasqIx1T1N6K13hYk8GvZnLEHX+DkL4uyx0oKv0iMaCX06Xngtlq+rf/FDN4TVMwoWiSNmp3XoGaE11zZI=
X-Received: by 2002:ac2:504a:: with SMTP id a10mr17619938lfm.470.1632129478015;
 Mon, 20 Sep 2021 02:17:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAEyMn7YqrRttqvJzJLA+yVo6WtBZww6QcXT12MMCi+bhjP4pTg@mail.gmail.com>
 <CAEyMn7ZhBfG7703YMr=EDQyf5mHDkLyET5iNqdXDOpJy9ti+rQ@mail.gmail.com>
 <CAOMZO5CZKdc=AmG1eds9Oy_uwqXDWLwPXk74phCDWdjrzkRC4A@mail.gmail.com>
 <CAEyMn7YaQbLoVy_5Rb+hiwhEj-kbnmCwb0B_soa+Kf0D6iH6oA@mail.gmail.com> <CAOMZO5CGuKQ0yVyoD86G3KnxoBd2fq+uCTTLoqVR-13Y5a-36Q@mail.gmail.com>
In-Reply-To: <CAOMZO5CGuKQ0yVyoD86G3KnxoBd2fq+uCTTLoqVR-13Y5a-36Q@mail.gmail.com>
From:   Heiko Thiery <heiko.thiery@gmail.com>
Date:   Mon, 20 Sep 2021 11:17:46 +0200
Message-ID: <CAEyMn7bN247-J=Qz-k3LZMVYb8pdYSP3BSCsNE9yyvfDfmdK0g@mail.gmail.com>
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

Hi Fabio,

Am So., 19. Sept. 2021 um 23:44 Uhr schrieb Fabio Estevam <festevam@gmail.com>:
>
> Hi Heiko,
>
> On Sun, Sep 19, 2021 at 4:33 PM Heiko Thiery <heiko.thiery@gmail.com> wrote:
>
> > > Does this patch help?
> > > https://pastebin.com/raw/yZKz1huL
> >
> > I can confirm that on the next-20210915 (that includes commit
> > 78e80c4b4238c1f5642b975859664fced4f9c69e) your provided patch solves
> > the problem.
>
> Thanks for testing it.
>
> > But is it explainable that in the version before the commit
> > 78e80c4b4238c1f5642b975859664fced4f9c69e the problem occurs in the
> > form I reported?
>
> I don't understand this problem either. I would suggest bisecting it.

Now it is clear to me. I used the dtb for my board that had already
changed the phy node and tried to boot the "old" kernel 5.14. Thus no
phy could be found. Nevertheless the kernel should not crash in case
no phy was found.

So I made a beginner's mistake here. But this also means that you can
no longer start an old kernel with the changed dtb. This comes into
play when you e.g. a standard distribution where the embedded dtb is
passed from the uboot via EFI boot.

-- 
Heiko
