Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4E3C3375EB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 15:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbhCKOlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 09:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233683AbhCKOkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 09:40:35 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80EFC061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 06:40:34 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 184so2443354ljf.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 06:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QUcPBtm4+ilX7IBeJadFRWzG939sRFv09Bop/EMXhUY=;
        b=yzKXuQ3/J/SngJyDaDCqNeri/gXS4XJWy9PGK29BknE5n8hlBYKVG2AP0tFbpzzRvh
         qRzIHKSH0+lp8gvcvpnZbSA2GOt/c9NTPj2P/cbQ2AGEePywpgOI/bMoqn103jP8nbcn
         tiNNT5LvfVqIyeSXi9XzYPQxqxdYx+XPsSHvtZyqjQuPQiEOnhSLJipei/VMmNbf+oea
         hj1BdmBVbF4aznJ3tcjLNy14oPzYudLFWS9UTWLdGRoGWJtzt1J+XZhdbKWIQBqpR1cu
         W8O2Iw5DyMb/Auca+F7iDUxVKfSrNoKa9GcjIHW0/fFf0WqjfbkVxSDytu+k1hErvF1r
         90zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QUcPBtm4+ilX7IBeJadFRWzG939sRFv09Bop/EMXhUY=;
        b=oF0brk7lHcVtUA4fkehuhPUEp2bQy8iSUpjGleG1coRld+709WP03mDkK9rUa+1ine
         lci5R4ffHDoirldp5ABtbp7wba9HOPSQbDnLyy/LIHpRSG+L5sQ7ai38ElvBjgReJ4PF
         a6vRLaMMWAmPn7VtcWfnYhI5L2Ia1fmGMgGvU3It8ZuPmVEC44B0peZgZZlRZO5ohdxU
         FNYu4EbfhW54UmjCzVd3TbjW0yD/5OQJQqT/gIpUTWVHI7ulkkquxvYpq1ns1gLu9SzJ
         NBFGojwusDfctJHs/RgKY20WgHr/LTE5S9x7wfTFIpMI2pXIISi0AahCsMiLTV0lcDgV
         u0Qg==
X-Gm-Message-State: AOAM533KZELXCSL+hpq0NzBo4rLg8a59WG5EiFUwnPKQM85aI7DCmZkV
        rYG9FS5FDlK0UwwSeknuUxRRDOrHUFCDEKAK/zfB0Q==
X-Google-Smtp-Source: ABdhPJz7z1I5EjMIdfchrJWVpNJGEAzcCu9hBl7SZv7vwujVov2KiUn6Gr/KhKzHePJwvP9MU8jwUqNOOVTmdmBQUeM=
X-Received: by 2002:a2e:864a:: with SMTP id i10mr4833356ljj.467.1615473633384;
 Thu, 11 Mar 2021 06:40:33 -0800 (PST)
MIME-Version: 1.0
References: <1614662511-26519-1-git-send-email-rnayak@codeaurora.org> <CAHp75VfJqXQM+L4NnoN8p_iLpdc1SWFkBwFZAq5sHengPKnwJw@mail.gmail.com>
In-Reply-To: <CAHp75VfJqXQM+L4NnoN8p_iLpdc1SWFkBwFZAq5sHengPKnwJw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 11 Mar 2021 15:40:22 +0100
Message-ID: <CACRpkdYUvxQ+SoVKPCCiQk0aa4kYeRktw9vA3yt=rnJOCYZ0iQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: qcom: sc7280: Fix SDC_QDSD_PINGROUP and
 UFS_RESET offsets
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 11:41 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Mar 2, 2021 at 9:32 PM Rajendra Nayak <rnayak@codeaurora.org> wrote:
> >
> > The offsets for SDC_QDSD_PINGROUP and UFS_RESET were off by 0x100000
> > due to an issue in the scripts generating the data.
>
> > Fixes: ecb454594c43: ("pinctrl: qcom: Add sc7280 pinctrl driver")
> >
> > Reported-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> > Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>
> Should be no blank lines in the tag block.

Yeah I fixed it up when applying.

Just one of these maintainer perks I offer free of charge ;)

Yours,
Linus Walleij
