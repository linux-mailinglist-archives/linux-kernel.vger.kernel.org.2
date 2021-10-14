Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACD842E487
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 01:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234284AbhJNXEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 19:04:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:42690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230503AbhJNXEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 19:04:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 291E861053;
        Thu, 14 Oct 2021 23:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634252564;
        bh=KQhnfft+SeT/c5QZdp7RT0ENepdXT9rmIDodbBGmQKk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=V987DMuuAu143/QxCL25gnT67YWoLWnzDLrxGaQU2lZE4cKadqwaoj7ZSuvF1ueSH
         4BFY2IndapYKmGjvJoV1jnI41eVkgUZ1JfE9Ll/CO9Xe52stcM286MeRcND9ugxvQr
         wNQpjT1xp3meLcjMOcSsUTgg4eJb3JWl7Ve0aCJouIN4G1by8xMOuSZmWso+/FPv5Y
         bmmxric7fYEBbPbnqdvLHWHbrlmIwZjFqVzdcfX/Vlp9vGJTJ9vy0uy6j4ov3XDBOZ
         pMfGEADfc88zSMGY/IlJWghPrOzo+tiga7LzpmLXEaJUkGAqI23UrF4tZmmJ9Ez87H
         5H/aqQSyW2ExA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAL_Jsq+GHt+DqHa0GeLKWoni+Lghg5wg5ssREZBdSD-=K3XQ1A@mail.gmail.com>
References: <20210923064137.60722-1-zhang.lyra@gmail.com> <20210923064137.60722-3-zhang.lyra@gmail.com> <YV1XpL7ibF1y4LbV@google.com> <CAL_Jsq+eqqv=qtKOiNdEpYGi2amek_m+Q-Z9A769pXXqJ4R88A@mail.gmail.com> <YWVD0RXHVLxuXEIN@google.com> <CAMuHMdWqYVp1JyzZoidAJhPy9ypRnSOWHJLz5knDUMcFHPOzAw@mail.gmail.com> <YWfSz00Rj5AVhkgT@google.com> <CAL_Jsq+GHt+DqHa0GeLKWoni+Lghg5wg5ssREZBdSD-=K3XQ1A@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] dt-bindings: mfd: sprd: Add bindings for ums512 global registers
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-clk <linux-clk@vger.kernel.org>, open list:
        OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS 
        <devicetree@vger.kernel.org>, Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>, ;
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
        Cc:     ;
                        ^-missing semicolon to end mail group, extraneous tokens in mailbox, missing end of mailbox
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>
Date:   Thu, 14 Oct 2021 16:02:42 -0700
Message-ID: <163425256290.1688384.5646232860050218479@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rob Herring (2021-10-14 09:18:16)
> On Thu, Oct 14, 2021 at 1:48 AM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > I don't explicitly build DT documentation.
> >
> > Since I use the build bots to let me know if there are strange !(C,
> > ASM, arm, aarch64, mips, ppc, x86) build issues or ones with odd
> > configuration possibilities (randconfig) in the repos I maintain, you
> > might have to convince them that this is important too.
>=20
> It's really just a matter of turning on the build in
> allyesconfig/allmodconfig builds. I've not done that primarily because
> there's one person I don't want to yell at me, but I could probably
> make it arm and/or arm64 only. It's really arch and config
> independent, so doing it multiple times is kind of pointless.
>=20
> I assume for bots you mean kernel-ci mainly? Do you run that before
> stuff gets into linux-next? IMO, that's too late. But still a slight
> improvement if things go in via one tree. Otherwise, I see the
> breakage twice, 1st linux-next then the merge window.
>=20

I run `make dt_binding_check DT_SCHEMA_FILES=3D"<path to yaml file>"` but
nowadays this seems to check all the bindings and not just the one
binding I care to check. Did something break?
