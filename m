Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDC042FD72
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 23:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243119AbhJOVeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 17:34:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:44026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243106AbhJOVeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 17:34:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7644360F6F;
        Fri, 15 Oct 2021 21:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634333520;
        bh=QNUJyl7CqYF0RbqP23fSOKnChSyYkX1cJLYbSZI3y6c=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=nZAIRxyIefzTQjuUcjAkQS6tBZGi2E/PNKa9rWuzxuoJnPleMLaww7w9jfjjNCK/D
         zaRcmRQ+ui7QHF5dmiLXHIOdAO5r1LzJ+yxpm4PBqHqY65mNCqcGjbpWYIQ7pVHdz+
         NSRpMQ9r/He8bVWLknOglcDKVwI9FzTPIXUhSpTbijf+hWy+Y/GX8oDqID/4kSSPxJ
         9wQayXlqa7eV3WekC1JYV68kFLt8F1oLDkmQDjz4TdBFFLe3V5vMjDr9KnbR8Ay+u7
         Y+tFDnMHQHAdIRKl4Rs5Cm2eUumJApiS9//z5zfVxFHHcoCuBqKzlEnK1ZsoLHVfLG
         y9fmX2seZ78JA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <67995168-e0fc-0916-7c34-3efedf4bad00@gmail.com>
References: <20210702225145.2643303-1-martin.blumenstingl@googlemail.com> <20210702225145.2643303-2-martin.blumenstingl@googlemail.com> <4eb964ac-4fff-b59d-2660-2f84d8af5901@gmail.com> <CAFBinCAVtd8gmcuvGU79-85CqhSU8a3mBCa_jweeZBd59u+amQ@mail.gmail.com> <CAFBinCAT-FxcHpt=NCt4g-OfzEUhvxh8TNRcY2hb5kdxna0Uyw@mail.gmail.com> <67995168-e0fc-0916-7c34-3efedf4bad00@gmail.com>
Subject: Re: [PATCH v1 1/6] clk: divider: Implement and wire up .determine_rate by default
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Heiko =?utf-8?q?St=C3=BCbner?= <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
To:     Alex Bee <knaerzche@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 15 Oct 2021 14:31:59 -0700
Message-ID: <163433351924.1688384.17959086273596597053@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alex Bee (2021-10-15 12:14:36)
>=20
> Am 14.10.21 um 23:34 schrieb Martin Blumenstingl:
> > On Thu, Oct 14, 2021 at 2:11 PM Martin Blumenstingl
> > <martin.blumenstingl@googlemail.com> wrote:
> > [...]
> >>> Reverting this commit makes it work again: Unless there is a quick and
> >>> obvious fix for that, I guess this should be done for 5.15 - even if =
the
> >>> real issue is somewhere else.
> >> Reverting this patch is fine from the Amlogic SoC point of view.
> >> The main goal was to clean up / improve the CCF code.
> >> Nothing (that I am aware of) is going to break in Amlogic land if we
> >> revert this.
> > Unfortunately only now I realized that reverting this patch would also
> > require reverting the other five patches in this series (since they
> > depend on this one).
> Indeed, that whole series would need have to reverted, which is clear=20
> (to me) when looking at the patches.
> > For this reason I propose changing the order of the checks in
> > clk-composite.c - see the attached patch (which I can send as a proper
> > one once agreed that this is the way to go forward)
>=20
> Yes, your patch papers over the actual issue (no best parent-selection=20
> in case determine_rate is used) and fixes it for now - as expected.
>=20
> But it is not a long-term solution, as we will be at the same point, as=20
> soon as round_rate gets removed from clk-divider. For me, who is=20
> semi-knowledged in clock-framework, it was relatively hard to figure out =

> what was going on. "I'll do this later" has often been heard here.
>=20
> Though, I don't fully follow why moving the priority of determine_rate=20
> lower would have been necessary anyways: from what I understand=20
> determine_rate is expected to be the future-replacement of round_rate=20
> everywhere and should be preferred.

This is the only place I can see where we would have to keep round_rate
around, to mesh together rate rounding with parent selection. We can
probably stop using round_rate in the framework and only use it in the
composite code. It's not a big deal but it's sort of annoying that we
won't be able to fully remove round_rate from the clk_ops without
resolving this. Long term it may make sense to get rid of the composite
clk code entirely. It's pretty confusing code to read and encourages use
of the "basic clk types" which I'd like to see be used via direct
function calls instead of through clk_ops structures.
