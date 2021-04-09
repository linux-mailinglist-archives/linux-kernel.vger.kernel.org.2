Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1BB35A5CE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 20:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234481AbhDIScK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 14:32:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:45586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233332AbhDIScH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 14:32:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 98E0A61104;
        Fri,  9 Apr 2021 18:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617993114;
        bh=+8hEJqNlvBGqGgzMlwFmXXdv48nf4gyOCd8EnKO/if8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=kPXS2sbN+RlSr9PmRPlVRlh6l1ZADD+YTH/OCye/N1QDEz0zHg/g7mHSLQftBU9yH
         ebSRb+AfK+y/WpU9lN+W8ehPZl5P6H/UJ00k3ACTARiXxZQ8rRrEkH7966EIt9o4Cg
         K9rKjtluHYAZoGjfa+7XPX/rh+aeXmqwEuElJFVSssu5Z88/Me1v2o/zJwjLfWcNRM
         PGWAz59S8hh+1lOTRIrUZ99HWGfwJz5tbZP4eV98o9TomUgBIpGHE+r+dw8/hIdWC7
         N4kq3djtul5r7/OBk2viFUR3cLEqF6qDiAHuFnuIBzYh7BDE0wJtOevWeaEqRy3lDN
         /zTv01AOjNV6w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAMhs-H98xzfK4W9KGSKR0QPtm42_K6Y5PzWiA3c-Pugau7oxyQ@mail.gmail.com>
References: <20210309052226.29531-1-sergio.paracuellos@gmail.com> <CAMhs-H_zBqe_+dKV4KT3QyOaONErmnCKME4-7ey2CnWJfUVseg@mail.gmail.com> <161799224004.3790633.10957084716451758402@swboyd.mtv.corp.google.com> <CAMhs-H98xzfK4W9KGSKR0QPtm42_K6Y5PzWiA3c-Pugau7oxyQ@mail.gmail.com>
Subject: Re: [PATCH v11 0/6] MIPS: ralink: add CPU clock detection and clock driver for MT7621
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, John Crispin <john@phrozen.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        COMMON CLK FRAMEWORK <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS 
        <devicetree@vger.kernel.org>, open list:MIPS 
        <linux-mips@vger.kernel.org>, open list:STAGING SUBSYSTEM 
        <devel@driverdev.osuosl.org>, NeilBrown <neil@brown.name>, linux-kernel" 
        <linux-kernel@vger.kernel.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Fri, 09 Apr 2021 11:31:53 -0700
Message-ID: <161799311308.2810947.13610751486361071085@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sergio Paracuellos (2021-04-09 11:25:24)
> Hi Stephen,
>=20
> On Fri, Apr 9, 2021 at 8:17 PM Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Sergio Paracuellos (2021-03-23 01:13:22)
> > > On Tue, Mar 9, 2021 at 6:22 AM Sergio Paracuellos
> > > <sergio.paracuellos@gmail.com> wrote:
> > > >
> > > > Changes in v11:
> > > >  - Collect Rob's Reviewed-by in bindings documentation patch.
> > > >  - Fix MAINTAINERS patch using file 'mediatek,mt7621-sysc.yaml'
> > > >    for documentation bindings.
> > >
> > > Something still missing or something that is needed to be fixed to get
> > > this series applied through your tree?
> > >
> > > Thanks in advance for your time.
> > >
> >
> > Sorry I missed this series. I thought it was going through another tree.
> > It can merge through clk tree. Just a few nits on the clk driver patch
> > but otherwise I've merged the first two patches. If you resend in the
> > next few days it would be great. Thanks.
>=20
> I will hopefully do during this weekend. Since you already merge the
> first two patches, the remaining four should be sent as v12, right?

Yes. I'll push it out to kernel.org shortly.
