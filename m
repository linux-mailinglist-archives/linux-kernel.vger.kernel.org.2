Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F097A3AF9B1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 01:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbhFUXow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 19:44:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:39956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231486AbhFUXov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 19:44:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DE5D7611BD;
        Mon, 21 Jun 2021 23:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624318957;
        bh=LbtiJo7X6u8ObVFmZtZLMgw6UKzAz6klxd8rt//+jjg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=qAyndvQe4lRDEaFpAZafZxLGLDRzxUnWTClbnDQnog1MQXJNBlZR3KiEdDEBmIJCE
         4i7f3o9cRBRuHhETTQbm6+n53L3978fUZ7ncb+HBJkWz+F4CXFuK1cR8JoMTdk85I1
         j1XpzSqmtsYAjPSNqT+O6zm9YtTEv+FnBFkytw1LD2L3CRimGnoAyB6amSEr/JwJRj
         YeommXN+aGrDLB/jw3gVH+fH38Db1OgUJSGTDSkAN+r8LB/nHIUKPR0PzyMeFRXKZb
         Fe3b8YaDahlsRAPVcIGlMJehfJegXa65Dsi7naIXBosxcWucXbttiZkuVsoYQ3dGOd
         2yAg7i2InitJQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1623740819-28040-1-git-send-email-abel.vesa@nxp.com>
References: <1623740819-28040-1-git-send-email-abel.vesa@nxp.com>
Subject: Re: [GIT PULL] clk: imx: Updates for v5.14
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
To:     Abel Vesa <abel.vesa@nxp.com>
Date:   Mon, 21 Jun 2021 16:42:35 -0700
Message-ID: <162431895570.3552334.196688138042205414@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2021-06-15 00:06:59)
> The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627=
b5:
>=20
>   Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git/ tags/=
clk-imx-5.14
>=20
> for you to fetch changes up to c586f53ae159c6c1390f093a1ec94baef2df9f3a:
>=20
>   clk: imx8mq: remove SYS PLL 1/2 clock gates (2021-06-14 17:05:45 +0300)
>=20
> ----------------------------------------------------------------

Thanks. Pulled into clk-next
