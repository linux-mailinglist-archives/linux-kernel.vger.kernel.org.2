Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA1C23FA89F
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 06:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbhH2ER2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 00:17:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:39676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229534AbhH2ER1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 00:17:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A25DC60231;
        Sun, 29 Aug 2021 04:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630210595;
        bh=pb2oOSItitdYHRmLFBfuZ5tLKROV5ou2ACYAG1rAhlA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=K0rRrxT7xHlmhj3pvc2xNlL6y4w+7IxjTSB3w8c6lWpZ0bAfeWRvdt/rYmJAcIZLZ
         +bcrRSBjkvKqfevSwgUCbNSKtB8Kh5HKTnvMop7DdrycJAmVKVEHpXswz7MqpBxPtJ
         JRgB3TyLiu5MvRQdOTflPIgbXxDat6fFcuQzGmCFaU44pvZw2ReO+0zXIhX2Yzp3Qc
         0Zk5Bk3/x7nbDox7txXSbgyPMhqM0L+YHXJBX7atQd6Uj0GPVD3KiSUwnYzkoPPx0l
         srl9gaFxNiBXiqCV2z6aVJGAD8xV6BlcWby3CEK9gNyDP7gojXttwHENgLD07LXFXR
         8yao167SIo92A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1629889173-5042-1-git-send-email-abel.vesa@nxp.com>
References: <1629889173-5042-1-git-send-email-abel.vesa@nxp.com>
Subject: Re: [GIT PULL] clk: imx: Updates for v5.15
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
To:     Abel Vesa <abel.vesa@nxp.com>
Date:   Sat, 28 Aug 2021 21:16:34 -0700
Message-ID: <163021059444.2676726.13636736135059270626@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2021-08-25 03:59:33)
> The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58=
d3:
>=20
>   Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git/ tags/=
clk-imx-5.15
>=20
> for you to fetch changes up to 86842d255b45fc2103da1cd202f5064397ed41f8:
>=20
>   clk: imx8mn: Add M7 core clock (2021-08-24 16:09:07 +0300)
>=20
> ----------------------------------------------------------------

Thanks. Pulled into clk-next
