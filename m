Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A61B135A405
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 18:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234232AbhDIQvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 12:51:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:47252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233038AbhDIQvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 12:51:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A97361005;
        Fri,  9 Apr 2021 16:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617987097;
        bh=NhT5r1HihSgMqIJvx82KccRxqY/ny4TKCiWz0xBkvVE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=u3ZYxmlwZqT+XDZNLGW2YZdM6/OyrlnTtHvU3T2p3o/oXiRPPjF6a1M1F9lrp9zTi
         egoF7ZxoadPL/ycbqq6PhRZh6gcwFOr2rsd1cc9CmekF+T3ItghRXMIcRPuG/8riJ+
         Za6pUNT7P8MB2mjFeOmEaR6VbmB+ftWaE8Poha3z5m/VEbA1s6a9cyzvwCfGNBxXkd
         d1q3nE2fuB490J5QeDQ2Mac1YD7ovNBmnnL72SxnN+HVviYrkc8H+wvIbhgfks810p
         oVg5cvfrQeiVHOB31QzCNXUpjdWK6tm9/439H7cf74Tdt8ytE/YENZmLqFhJNk3OH6
         RhRWRHeJoNOAg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210408081221.qp5kcv23vgz3qqjs@fsr-ub1664-175>
References: <1617568824-2311-1-git-send-email-abel.vesa@nxp.com> <161786558917.3790633.14467115349480488916@swboyd.mtv.corp.google.com> <20210408081221.qp5kcv23vgz3qqjs@fsr-ub1664-175>
Subject: Re: [GIT PULL] clk: imx: Updates for v5.13
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>
Date:   Fri, 09 Apr 2021 09:51:36 -0700
Message-ID: <161798709629.3790633.4531910940427376568@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2021-04-08 01:12:21)
> On 21-04-08 00:06:29, Stephen Boyd wrote:
> > Quoting Abel Vesa (2021-04-04 13:40:24)
> > > The following changes since commit a38fd8748464831584a19438cbb3082b5a=
2dab15:
> > >=20
> > >   Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)
> > >=20
> > > are available in the Git repository at:
> > >=20
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git cl=
k/imx
> > >=20
> > > for you to fetch changes up to 054ef44ea3ef2883e0f63c9a54c91c07f321a0=
b4:
> > >=20
> > >   clk: imx: Reference preceded by free (2021-04-04 22:39:05 +0300)
> > >=20
> > > ----------------------------------------------------------------
> >=20
> > Thanks. Pulled into clk-next. Next time can you send a signed tag with a
> > small blurb about what is included?
>=20
> Oups, I mistakenly used the branch instead of using the tag.
>=20
> The tag is here:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git/tag/?h=
=3Dclk-imx-5.13

Great thanks! I pulled the tag instead.
