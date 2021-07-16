Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 115643CB5D0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 12:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237446AbhGPKRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 06:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235965AbhGPKRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 06:17:20 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E82C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 03:14:25 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id c16so7243642ybl.9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 03:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iuGIeqokxksveNDV8VeICX98RmyrNiDBw8DitAGWHLg=;
        b=CRb+ROcYUseCzx1ggWJ4DRbmNH6qFprgQKZKyen8mr3mM8NO86kkvrltKnBN8AurhQ
         T+PQ3lbhzkSa1ovSD/3ptd/0lXtbmjqq7tqe3vcNNCMhJbjMEltG6hCsXuAGwXWCuUUV
         M8CIc/5scR/h0Vy6fOv2XP3BEXMIjYaMH0zLUfrAP5cirPjE/bxIiSnkPpY/mZ/TgCqd
         LgO77fUMDU2sIuw70aF64ytZib0Ko0/cl0YDWT7jMChslHRLzBL+dwONug8CJ6DESikQ
         WNsZWrpRLq3y4sWBHUWsjUe00SljcWCmqlYy7OcylPKOZJ0S3lvYutiSrrXHlGlU9Kp5
         JHZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iuGIeqokxksveNDV8VeICX98RmyrNiDBw8DitAGWHLg=;
        b=qvYlNcj3dwk2MtPB+OTjv/Xnew8W2s1TMFGN89wC5arahGpYTABrQCR5kSRhU+2eKE
         v8Qk228IJlXpswXXhln0CBGI63JDnQoGQwXiCHvWa5mEhe1shUkmvOCZquxfkKnB/aIy
         QrJNYC4ugI4b3sWEmiZeg2EGW66hCLFOE3nFaJXiAON/aw2Vm5YkfrAnQbci/MCvTHAq
         EqFIQr4sPYIJHE99EdyOs2NP3zYJS/1PIMP5Fr1dI7W4RX7qOaqL9CF2oukZcY9pIMX3
         /W13D968EWwb3ChSnLgBfKnlVkz4ZZtf79XYDzZWIJTftTedLqMyxCMc/Gh8i98XQl1x
         TFBA==
X-Gm-Message-State: AOAM5320pOH8jSIB4sZ8o5nRykPVG3JHmrR41we/XSzGFH5V+CLSYL3s
        yp12s19UpPWnjUKeMLpUkWGDLMBg+wcHU/jWxMw=
X-Google-Smtp-Source: ABdhPJzo88Lq7bhSroU1MJ9N1q8Wpi6VmrVvjFHrQ8OHEVTbVLlrajUJjP1mKn6mHCAsk/4Qh9gzSpSKtI6I70lOq0g=
X-Received: by 2002:a5b:504:: with SMTP id o4mr11904798ybp.332.1626430464415;
 Fri, 16 Jul 2021 03:14:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210702014319.1265766-1-bmeng.cn@gmail.com> <20210702014319.1265766-2-bmeng.cn@gmail.com>
 <CAMuHMdWpJ194jEnXiUhs5dfC-33rGUm7pE9aMHUTYoMCUdFxZA@mail.gmail.com>
In-Reply-To: <CAMuHMdWpJ194jEnXiUhs5dfC-33rGUm7pE9aMHUTYoMCUdFxZA@mail.gmail.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Fri, 16 Jul 2021 18:14:13 +0800
Message-ID: <CAEUhbmXrSJ2dkXYvoZXTZ+3gV3h9OBx3u0hOitwLvMDKa2A4DA@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: dts: microchip: Add ethernet0 to the aliases node
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Lewis Hanly <lewis.hanly@microchip.com>,
        Atish Patra <atish.patra@wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Bin Meng <bin.meng@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Fri, Jul 16, 2021 at 5:23 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Bing,
>
> On Fri, Jul 2, 2021 at 3:44 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> > From: Bin Meng <bin.meng@windriver.com>
> >
> > U-Boot expects this alias to be in place in order to fix up the mac
> > address of the ethernet node.
> >
> > Note on the Icicle Kit board, currently only emac1 is enabled so it
> > becomes the 'ethernet0'.
> >
> > Signed-off-by: Bin Meng <bin.meng@windriver.com>
>
> Thanks for your patch!

Thanks for the review!

>
> > --- a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
> > +++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
> > @@ -9,6 +9,10 @@ / {
> >         model = "Microchip MPFS Icicle Kit";
> >         compatible = "microchip,mpfs-icicle-kit";
> >
> > +       aliases {
> > +               ethernet0 = &emac1;
> > +       };
> > +
> >         chosen {
> >         };
>
> This should be added to the board DTS (microchip-mpfs-icicle-kit.dts)
> instead.

I was wondering the same thing before doing this, but when I checked
all other DTS in arch/riscv/boot I found the aliases node is put in
the SoC dtsi file instead of the board on so I think that's the
convention.

Regards,
Bin
