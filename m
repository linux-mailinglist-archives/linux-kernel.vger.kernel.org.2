Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB8F4437F2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 22:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbhKBVkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 17:40:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:52470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231755AbhKBVkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 17:40:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C1F2E6109F;
        Tue,  2 Nov 2021 21:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635889065;
        bh=1VrU8fSsYZiyP+NA6n/w32iFRtnZODXdYUxpJO8LKHE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=F3USAviTPofTb0DN1cx4SoPnC3815jGzlaUY9yfAkjAe+vyOTvnWksBtW865Yvdi2
         G10s6GEgF57G7f1tfvgX+rOmlklLLPz1lDS5kHgUYa1rRhhMakBB1ylYx/XjoQL1rt
         nb+44Dhw8/+xckDWWzJCWkOF8UoWJHfy3pkKPwdZEaXywPoXAqWM5g728PV8vUuf/G
         AJjtsLh0l6guPoTaIBIN00ifDqsccRsXsHUHi0gXGZsXTBdIOZ/Ee1uhb3iLrns4T1
         Lnwh8oRYwsoW6LyUg6R6PtKRCNlrPGRuQuhAaEvIqa0U9uXVf6g0wvIAWKBTGAX7C3
         5rp2Ofdd2EoDA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1634000035-3114-6-git-send-email-hayashi.kunihiko@socionext.com>
References: <1634000035-3114-1-git-send-email-hayashi.kunihiko@socionext.com> <1634000035-3114-6-git-send-email-hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH v3 5/5] clk: uniphier: Add SoC-glue clock source selector support for Pro4
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Tue, 02 Nov 2021 14:37:44 -0700
Message-ID: <163588906458.2993099.12595703282505376917@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kunihiko Hayashi (2021-10-11 17:53:55)
> Add SoC-glue clock source selector for ahci controller on UniPhier SoCs.
> Currently this supports Pro4 only.
>=20
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---

Applied to clk-next
