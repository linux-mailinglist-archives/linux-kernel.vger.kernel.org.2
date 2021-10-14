Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C913C42CFD8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 03:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbhJNBWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 21:22:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:40210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229496AbhJNBWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 21:22:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E19E61175;
        Thu, 14 Oct 2021 01:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634174427;
        bh=iidS7hC3XOKChZgO3b6/5KVhisRlE7FXRiSypgU83nQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=TVDLnCO24OEKwKgK0CZDQk3JB/50pfRl5KSBCVPEK2o090H11t8bhg4giJvUituPe
         deYzzd4mAmTPElBcnk1E0LFP8Lfu9NBA1k/FY+jKJsIp4A7oEs8JpEBMZfHNPcV4aV
         PuUkM6wubyZYTRq+2gj2oxn/JCtTypkMkjMh5hkWsxc43aiZ0eqNZa2UBMQ/JlwnZA
         WErnHAOBQ6t55hSDLj16/H7wGz9NO+ZMPp8Q9jhspHLBefYMKmJ/840fTaMIKGcIna
         qu/U+LIJcFyLrIAesG4n573i/KKMlPhtc9E0y615qNK4qGJXTTI69f+UnzuE+G7lvW
         7L7WuB46iV9MQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1633967088-5058-1-git-send-email-abel.vesa@nxp.com>
References: <1633967088-5058-1-git-send-email-abel.vesa@nxp.com>
Subject: Re: [GIT PULL] clk: imx: Updates for v5.16
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>,
        Mike Turquette <mturquette@baylibre.com>
Date:   Wed, 13 Oct 2021 18:20:25 -0700
Message-ID: <163417442574.936110.1046645530837982962@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2021-10-11 08:44:48)
> The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd=
8f:
>=20
>   Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git/ tags/=
clk-imx-5.16
>=20
> for you to fetch changes up to e8271eff5d8c8499289380edbf3bc47de83ab70b:
>=20
>   clk: imx: Make CLK_IMX8ULP select MXC_CLK (2021-10-06 22:17:42 +0300)
>=20
> ----------------------------------------------------------------

Thanks. Pulled into clk-next
