Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A22540BD23
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 03:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbhIOBZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 21:25:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:58216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232017AbhIOBZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 21:25:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A439E61166;
        Wed, 15 Sep 2021 01:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631669024;
        bh=6c/HJVFP1YE2hm4UYxB5Uc5g2ys+3LGEZlpE6HA1oTQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=trZtis5m21H9aS5vZFObZ9Ac1e8xoyIoLSFkb4Y0pKThjdj2JDQfJf/Ljo9h6F2Gx
         usfcjsilatOf6USFadeAW6obLvECDSwNXXB4u4XLQn0ojOZGDEN3HRIhnj9DOdoqMC
         YgL0w7Vqh9ADWxpbJGxRJ/8EIpIKD/jBR0FK2NMDTgfJYpEFNzsUW/I87Tk9I626Lo
         LwPUlUAOQozQvoadycJZ9nJGIvoJDkzGMzhYcS2gtRAGl6xxpPeyNbWAV428C8z/9U
         U6npT+G+oDglMpsBdtOSwfl2HDZeHJZQa0UyvAFlH74m3QXVb6ipbRlsqGovGn1mll
         dACeBvsGXdpLw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210901222526.31065-2-miles.chen@mediatek.com>
References: <20210901222526.31065-1-miles.chen@mediatek.com> <20210901222526.31065-2-miles.chen@mediatek.com>
Subject: Re: [PATCH v3 1/3] clk: composite: export clk_register_composite
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Wendell Lin <wendell.lin@mediatek.com>,
        Hanks Chen <hanks.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
        Miles Chen <miles.chen@mediatek.com>,
        Lee Jones <lee.jones@linaro.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Miles Chen <miles.chen@mediatek.com>
Date:   Tue, 14 Sep 2021 18:23:43 -0700
Message-ID: <163166902348.763609.9050267699584062754@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Miles Chen (2021-09-01 15:25:24)
> To support module build of mediatek clk drivers,
> it is necessary to export clk_register_composite.
>=20
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Hanks Chen <hanks.chen@mediatek.com>
> Cc: Wendell Lin <wendell.lin@mediatek.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> ---

Applied to clk-next
