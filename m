Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B15D3FD32B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 07:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242101AbhIAFpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 01:45:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:42414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242085AbhIAFpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 01:45:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4CA5061074;
        Wed,  1 Sep 2021 05:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630475074;
        bh=pfiOdo50JoDcnklFSQnO//blNznZ0uOyTUfx1bKEbyI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=gsdLpY1++BJLTD1ZukR/v/JguaVdddxuQYR56l06ui7S0K37Blt5UcyOeCu+tYaqw
         9DGRBFyBfkLD+yS53HFtEg11BycIepav7qoLcl3sTn40wg42gB4nHNq+sJYAV7ldHK
         gv826AoGmj3mfz6gBiiM4u9QzRBqp9WvdVz2IIjQG2Y03jn691mGJ77pxrPL7kcciA
         hh+CWveyhuwSc6b1+M1DE6EVf3JF3+plGu+4WQhthaO0ik5uqHLbl+Q7eWYCQw6fF2
         C9lpYjru6gi9pROa2sdrhHkwunc9psnULHou2vWRZkg0YYxhOH/2fMcSQlm2Ou7TBl
         jM/v19aXR10Ow==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <35d409b5-75d9-636e-e9c5-42d833b8e592@microchip.com>
References: <20210401122726.28528-1-claudiu.beznea@microchip.com> <6ecc4822-8112-43d4-1259-cd7dfe79d71c@microchip.com> <163021931214.2676726.2951110502140668721@swboyd.mtv.corp.google.com> <35d409b5-75d9-636e-e9c5-42d833b8e592@microchip.com>
Subject: Re: [PATCH v2 0/6] clk: at91: updates for power management and dvfs
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     viresh.kumar@linaro.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To:     Claudiu.Beznea@microchip.com, Ludovic.Desroches@microchip.com,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        mturquette@baylibre.com
Date:   Tue, 31 Aug 2021 22:44:32 -0700
Message-ID: <163047507296.42057.10597374695758699868@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu.Beznea@microchip.com (2021-08-29 22:46:13)
> On 29.08.2021 09:41, Stephen Boyd wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know =
the content is safe
> >=20
> > Quoting Claudiu.Beznea@microchip.com (2021-08-02 01:36:52)
> >> On 01.04.2021 15:27, Claudiu Beznea wrote:
> >> Hi Stephen,
> >>
> >> Please ignore the DVFS patch in this series
> >> (clk: at91: clk-master: update for dvfs) as I have some updates to it.=
 I'll
> >> introduce them in the next version.
> >>
> >=20
> > Can I apply the rest of them though?
> >=20
>=20
> Yes, please! One note, at patch "clk: at91: clk-master: add register
> definition for sama7g5's master clock", is that changes in header
> (include/linux/clk/at91_pmc.h) were taken trough [1] via at91 tree because
> the build was broken at some point for multi_v7_defconfig on linux-next.
>=20

Ok. Maybe it would be best to just resend the ones that you want me to
apply then.
