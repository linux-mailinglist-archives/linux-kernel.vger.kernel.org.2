Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2764042E473
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 00:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234231AbhJNWyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 18:54:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:39176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234020AbhJNWyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 18:54:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D499C60FC3;
        Thu, 14 Oct 2021 22:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634251936;
        bh=w2M0Nc1Fjh2mq6HKMawsLh1v5jA6O1TVewN7UbNKbrg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ncL12SOg75ZJma1Wyx0P+2DH9LdHfmKm2ltnXOCFI6NnPvnEAClmBbmkUnockx5SW
         LeFbb4aD795XfdudLTU21VTkYuJYi/ltcPLEBK9OGFeoO+fdtgzPWgxj51DM92c6Rb
         HjgL+5SY7w1icSduUKktIX2wjKhwmK0mqdMLS/hnXRrwrotHsXwVdkFm2lDXOCT8XH
         IX2YRdyGPolToO2MEpNDDDaO7RwWd0hwFhH9G+2USJQKeIIb5GA4MOT7xfQzwvmjtJ
         WNHn7ZRIzghkvvH+ck/Cq+VbQHubgukrJx95cr4fN46LyUnLLdZ2N10p4wptQ1KtGS
         CDMbzw69glOiQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAFBinCAT-FxcHpt=NCt4g-OfzEUhvxh8TNRcY2hb5kdxna0Uyw@mail.gmail.com>
References: <20210702225145.2643303-1-martin.blumenstingl@googlemail.com> <20210702225145.2643303-2-martin.blumenstingl@googlemail.com> <4eb964ac-4fff-b59d-2660-2f84d8af5901@gmail.com> <CAFBinCAVtd8gmcuvGU79-85CqhSU8a3mBCa_jweeZBd59u+amQ@mail.gmail.com> <CAFBinCAT-FxcHpt=NCt4g-OfzEUhvxh8TNRcY2hb5kdxna0Uyw@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] clk: divider: Implement and wire up .determine_rate by default
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Heiko =?utf-8?q?St=C3=BCbner?= <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
To:     Alex Bee <knaerzche@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 14 Oct 2021 15:52:15 -0700
Message-ID: <163425193558.1688384.15520943968787313145@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Martin Blumenstingl (2021-10-14 14:34:54)
> On Thu, Oct 14, 2021 at 2:11 PM Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
> [...]
> > > Reverting this commit makes it work again: Unless there is a quick and
> > > obvious fix for that, I guess this should be done for 5.15 - even if =
the
> > > real issue is somewhere else.
> > Reverting this patch is fine from the Amlogic SoC point of view.
> > The main goal was to clean up / improve the CCF code.
> > Nothing (that I am aware of) is going to break in Amlogic land if we
> > revert this.
> Unfortunately only now I realized that reverting this patch would also
> require reverting the other five patches in this series (since they
> depend on this one).
> For this reason I propose changing the order of the checks in
> clk-composite.c - see the attached patch (which I can send as a proper
> one once agreed that this is the way to go forward)
>=20
> Off-list Alex also suggested that I should use rate_ops.determine_rate
> if available.
> While I agree that this makes sense in general my plan is to do this
> in a follow-up patch.
> Changing the order of the conditions is needed anyways and it *should*
> fix the issue reported here (but I have no way of testing that
> unfortunately).
>=20
> Alex, it would be great if you (or someone with Rockchip boards) could
> test the attached patch and let me know if it fixes the reported
> problem.
>=20

I can't read your attached patch. Please send it inline.
