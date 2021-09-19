Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D12410D81
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 23:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbhISVps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 17:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbhISVpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 17:45:47 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6943AC061574;
        Sun, 19 Sep 2021 14:44:21 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id i25so59315965lfg.6;
        Sun, 19 Sep 2021 14:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KmmQo9yCnKliaxUNInvC5AnAL481vPCxkxWha5Jsvbs=;
        b=nYg4yvJwdgA44mlUwO/yd72fmnOz5i8q5ZUuTZMEudlnNiIEWXwGH5alYS/u2aWNq5
         sbTLUav6htammLkXLfFEQ+MKV/1VFSiQ6OKqfglpZj/EsGkdV1b2BBnm+An57yYMoAZR
         iR8BG48I5PASCpuouIZOBPgbeo76HcSbYe0V2iNN7LrSHHYZWjoab9qqwDwDr9zAhZxS
         VX2R906W2Orh04Q2KRyJ1QQx29O/1MtVMEZKuzoh0ZeoaRd0RxfIgiEfjoUmDL+gKPi3
         1tt1kFjgRqaqds0boVI0TS4fZ+mCC1Z8FGxzwfXrAA939c4L/tyYJKxjm6G7olxrahPC
         qcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KmmQo9yCnKliaxUNInvC5AnAL481vPCxkxWha5Jsvbs=;
        b=Cs+hoiJ4jRg/0y5+stvknLhS369uy30J0wrNRAoldNo4b1J1mxaOJjCPTCM+qS7dk8
         DSzzN3WY1h7KSMxa7qzQ9e0ihNZm0ZczKz61EDMkzm64hOCNUZ1uYNmwKaDfD+/yOboP
         35Q1IpZxPEHzL97vYcppbDP3wHBtLm+jf83GxL2tFrg+AAajjfOXvdzJKewfOCGsskw3
         aS/HZqjTiD1J2+hY44QE8qnMGrz9KDs/CEz+4NgB+Mcr9LmGW8CsUPLaBGBTwOMdScK+
         DqJzBwIDaortH+3rR+8L/JI7Bl4h808Y1oeHPz2PCDcHyDuYLmZ3oR9QHjCz+LYF+Dli
         UI+w==
X-Gm-Message-State: AOAM532oX2+sAYuqb1vsQsoutDOPBmUiXRD+/bMRWGgkwi46d9bOd35h
        aZ4NN2cTn/C67s0qcaoa8SDxTOqHbCKQcJQEyEc=
X-Google-Smtp-Source: ABdhPJyl6466HOEvRy+HxPHYWlwSyRgLWFmvaXSl3HM+E4SO875oJjT08qEESioJwGC/7Z+B3uoGacNONyTCUnfGjyU=
X-Received: by 2002:ac2:561c:: with SMTP id v28mr16915165lfd.457.1632087859624;
 Sun, 19 Sep 2021 14:44:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAEyMn7YqrRttqvJzJLA+yVo6WtBZww6QcXT12MMCi+bhjP4pTg@mail.gmail.com>
 <CAEyMn7ZhBfG7703YMr=EDQyf5mHDkLyET5iNqdXDOpJy9ti+rQ@mail.gmail.com>
 <CAOMZO5CZKdc=AmG1eds9Oy_uwqXDWLwPXk74phCDWdjrzkRC4A@mail.gmail.com> <CAEyMn7YaQbLoVy_5Rb+hiwhEj-kbnmCwb0B_soa+Kf0D6iH6oA@mail.gmail.com>
In-Reply-To: <CAEyMn7YaQbLoVy_5Rb+hiwhEj-kbnmCwb0B_soa+Kf0D6iH6oA@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sun, 19 Sep 2021 18:44:08 -0300
Message-ID: <CAOMZO5CGuKQ0yVyoD86G3KnxoBd2fq+uCTTLoqVR-13Y5a-36Q@mail.gmail.com>
Subject: Re: imx8mm board crash in drivers/usb/chipidea/ci_hdrc_imx.c
To:     Heiko Thiery <heiko.thiery@gmail.com>
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

Hi Heiko,

On Sun, Sep 19, 2021 at 4:33 PM Heiko Thiery <heiko.thiery@gmail.com> wrote:

> > Does this patch help?
> > https://pastebin.com/raw/yZKz1huL
>
> I can confirm that on the next-20210915 (that includes commit
> 78e80c4b4238c1f5642b975859664fced4f9c69e) your provided patch solves
> the problem.

Thanks for testing it.

> But is it explainable that in the version before the commit
> 78e80c4b4238c1f5642b975859664fced4f9c69e the problem occurs in the
> form I reported?

I don't understand this problem either. I would suggest bisecting it.
