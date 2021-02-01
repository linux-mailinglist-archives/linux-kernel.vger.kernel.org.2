Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0017930A75F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 13:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhBAMPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 07:15:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:58780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231356AbhBAMPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 07:15:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B6CF64E9C;
        Mon,  1 Feb 2021 12:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612181665;
        bh=sr0OUsbbRR2WsZKrfh5DHzgj4ENd6zT4FE0yTLuoIxA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lVRELUvvspJfDU/OnDt8yVqZSnOFnRPx2XHTz/arq2ZUJqiQvsJ/zLrkNlVzit/T+
         clcyUZNWaKcOoNyKP54mh8If/YdFI2DQ35wr3D4x4PVQUuvp9jQxEpwmgTRX2+aERP
         qFm5Ft5YYsGtnt3NohdtMZbpNkTWejmuZRlsH3RH/+egSqtvdTdWnlECSdThkXCh5O
         5UyC7CR+axnrJFDWZw7lx3C86uBkJvFe+7XIjTLOUIlsapVMj+S6SkIdqY++U4KiOX
         hVNfuKMXjwR7taPImba0omfll0C//PrtySdGmEEh2cjEdIgdSFybQKCLNckbSJL/SH
         d+HjuFUDzzf8Q==
Received: by mail-oi1-f176.google.com with SMTP id d18so18560711oic.3;
        Mon, 01 Feb 2021 04:14:25 -0800 (PST)
X-Gm-Message-State: AOAM531yiVVWt/jJjKJNpm45AaJDBVgoDFCD+KFqQAtQJg190KBvaPe0
        QK+Ggxh0SsAQZCUqCsxJn9vGHuZq/m2t+0hZ5vU=
X-Google-Smtp-Source: ABdhPJyTobnrtpnDFnImo+7fvW0ySpcJqXhTCxou8wKKGkZERHftm+NzPbSkTYvx+sPnAePmaDXjeWprTwCRvnCqXxc=
X-Received: by 2002:aca:e103:: with SMTP id y3mr10303389oig.11.1612181664884;
 Mon, 01 Feb 2021 04:14:24 -0800 (PST)
MIME-Version: 1.0
References: <20210201033601.1642-1-thunder.leizhen@huawei.com>
 <20210201033601.1642-3-thunder.leizhen@huawei.com> <CAK8P3a142CkJ0kOD6mK+H-E2NrKZ6Ec-aYasddAUmAhTWhrjcA@mail.gmail.com>
 <69103fcc-902a-29f3-1d0e-0d124d778c01@huawei.com>
In-Reply-To: <69103fcc-902a-29f3-1d0e-0d124d778c01@huawei.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 1 Feb 2021 13:14:08 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3wHP-=qJhgZfgnJ++D8sMJpcBGDQ9Fx7GGBEyu6N-Cng@mail.gmail.com>
Message-ID: <CAK8P3a3wHP-=qJhgZfgnJ++D8sMJpcBGDQ9Fx7GGBEyu6N-Cng@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] ARM: hisi: add support for Kunpeng50x SoC
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Russell King <rmk+kernel@arm.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 1, 2021 at 12:49 PM Leizhen (ThunderTown)
<thunder.leizhen@huawei.com> wrote:
> On 2021/2/1 16:35, Arnd Bergmann wrote:
> > On Mon, Feb 1, 2021 at 4:35 AM Zhen Lei <thunder.leizhen@huawei.com> wrote:
> >>
> >> Enable support for the Hisilicon Kunpeng506 and Kunpeng509 SoC.
> >>
> >> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> >
> > Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> >
> > Russell, do you have a preference for how to get this series merged
> > after the last comments are resolved?
> >
> > I think there is no technical problem in having patch two merged through
> > the soc tree, while merging the other three through your tree, but it
> > seems more logical to keep all four together in either location.
>
> Wait, wait. I've coordinated resources urgently. I can run test cases for new changes tonight.

Just to clarify, my question is independent of how quickly it gets merged,
please continue addressing the review comments and sending new versions
in the meantime.

If we decide to take it through the two trees separately, that would just mean
that Wei Xu sends the patch 2/4 to soc@kernel.org for inclusion there
(I'm happy to take that one right away), while the other three will go through
https://www.armlinux.org.uk/developer/patches/.

       Arnd
