Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE24E40BCDB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 03:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbhIOBDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 21:03:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:46804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234115AbhIOBDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 21:03:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B6DF6115B;
        Wed, 15 Sep 2021 01:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631667748;
        bh=ANSWcyS6KAEBQiwpArpYFBmZDTuJhrG4ICfHQwYUUMw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=YwfWzNvX56raqMt2yRf2oIVJaX69PPZK4y/64veKJRRUpYtBq4WslhQcdZVf1gRMI
         bIhmDRqKTdVrKIqR9G/rOmh/2Lc9/E67Zk5GOBFNI0S0lgGuoYYKi5SpUIY3R/u0t6
         9Iuzgf3Syvmrw6l3//NKiUXwv/GmNud5U9B7cc+PseQQ8s76SNoksd8xSmEqGHe+lt
         lI6OpwsA7x7j/yxdNFigpig5yxPsjUL5tXEeyA9r/WAP+Bxuzye3GPAD7DotEWbEJu
         oYJcnJD12T0wLai9VQ1pQXpzlWvkaxMeDs0dB/IlekQsNyoC6YKT4RjfJf3PV1jt2h
         XpqSOuXWJxWSA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1631521490-17171-5-git-send-email-abel.vesa@nxp.com>
References: <1631521490-17171-1-git-send-email-abel.vesa@nxp.com> <1631521490-17171-5-git-send-email-abel.vesa@nxp.com>
Subject: Re: [PATCH 4/8] clk: imx: Rework all clk_hw_register_gate2 wrappers
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, Abel Vesa <abel.vesa@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>
Date:   Tue, 14 Sep 2021 18:02:27 -0700
Message-ID: <163166774746.763609.7862662751557629363@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2021-09-13 01:24:46)
> Instead of having multiple inline functions that were calling
> clk_hw_register_gate2, implement a generic low-level __imx_clk_hw_gate2
> and implement the rest as macros that pass on as arguments whatever
> is needed in each case.
>=20
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
