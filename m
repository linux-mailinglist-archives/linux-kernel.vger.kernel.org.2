Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 137603D7DF2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 20:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbhG0SrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 14:47:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:39670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229453AbhG0SrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 14:47:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CDA3A60F6E;
        Tue, 27 Jul 2021 18:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627411627;
        bh=gBJcVXzwtvxyfbyVULU9X8bkoTc/c6NjW5daNvv3bgE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=u7wjvlHT/wfIM7BR2bbJ0ROAeUy0eZVXIoroZX+x15W2vLa6nas/vRg5nYPabXXq7
         iRkkv3nqaEdZO+sQWlaQr6/sBoIG+eluMtvyOVfnHu0MrtsAGkQqaKvi3N3HiMJfWE
         6eaTY88URslX4n74Uv4FCS2ljppJgpoYSGUppe0KHG4KhWQWQqAfTNQLBNZrrRSIAn
         bcsNc9urrpV601N5xSaWRF9/xmlv3ONgSgAZkoRhonxcMKxDwx+IYXBedqrXTCLcQW
         rbw1EYqx46PzQyGbrBzMcS6foS+Q4d0toq8CLY3We96hFABrSddmzCZg936X7GIvw4
         kw0lrFgldJ9+g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210716051732.3422-1-miles.chen@mediatek.com>
References: <20210716051732.3422-1-miles.chen@mediatek.com>
Subject: Re: [RESEND PATCH] clk: mediatek: make COMMON_CLK_MT8167* depend on COMMON_CLK_MT8167
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
        Miles Chen <miles.chen@mediatek.com>
To:     Fabien Parent <fparent@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Miles Chen <miles.chen@mediatek.com>
Date:   Tue, 27 Jul 2021 11:47:06 -0700
Message-ID: <162741162663.2368309.2253718954934851461@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Miles Chen (2021-07-15 22:17:32)
> I found that COMMON_CLK_MT8167* do not depend on COMMON_CLK_MT8167,
> so it is possible to config:
>=20
> CONFIG_COMMON_CLK_MT8167=3Dn
> CONFIG_COMMON_CLK_MT8167_*=3Dy
>=20
> Although it does not cause build breaks with such configuration,
> I think it is clearer to make COMMON_CLK_MT8167* depend on
> COMMON_CLK_MT8167.
>=20
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> ---

Applied to clk-next
