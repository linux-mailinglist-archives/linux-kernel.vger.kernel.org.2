Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48CEE43BF11
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 03:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237574AbhJ0Bhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 21:37:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:37002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234326AbhJ0Bhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 21:37:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0020161090;
        Wed, 27 Oct 2021 01:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635298514;
        bh=wzUAKibokzpu1YYUAj4sR9y15lTC/Rx79Ak5rO0PQZU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=EH5Y6cMpcuJKqlSdDq2VydAAFoQZQjyT+D5XZ+pC1kt4jIOgZtz6l1AcfuSYg0gvU
         7FZZOtBNVr+tAKG2J0r/0dKJRTdohIkSplhM/q1s0ZXOeApOqR3JMzGl8bUBSzo0Jt
         7Wpr2pMKAdFg0xedbO+r+w4Yt36qJjADvGmAOaNqJnsDjn79fvWcakUfHp11YR1Sqs
         5qUSi7ToonoEIMcp90UxdyLqMi/n0jx4tggYZdiJibfJGMFcapfmSLnynWdD6umHI6
         RUknELPSYTTf6k1nH8JJKohSe8BzrXjeY/TqDycsGdwEd6+dtUa+pisSFWW0DXWAx8
         5L/eI9MaxhPPA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2dad9397-425f-baaf-e0fc-5a9e6e39de32@microchip.com>
References: <20211011112719.3951784-1-claudiu.beznea@microchip.com> <2dad9397-425f-baaf-e0fc-5a9e6e39de32@microchip.com>
Subject: Re: [PATCH v5 00/15] clk: at91: updates for power management and dvfs
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ludovic.desroches@microchip.com,
        alexandre.belloni@bootlin.com
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        mturquette@baylibre.com
Date:   Tue, 26 Oct 2021 18:35:12 -0700
Message-ID: <163529851265.15791.12903982814427348260@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nicolas Ferre (2021-10-15 01:33:38)
> Stephen,
>=20
> On 11/10/2021 at 13:27, Claudiu Beznea wrote:
> > Hi,
> >=20
> > This series addresses the clock power management for SAMA7G5 and also
> > updates the master clock driver and sam9x60-pll driver to accommodate
> > the requests at [1] and avoid overclocking of CPU and MCK0 domains while
> > changing the frequency via DVFS.
>=20
> I've just added my Ack tags to the whole series. I think that it brings=20
> so much important additions to our new SoC as well as fixing some (non=20
> urgent) bugs.
>=20
> In order to streamline the process of including this series to upstream, =

> do you want me to send you a pull-request? against latest clk-at91=20
> branch in your tree?
>=20

That's fine. Just let me know if you want to do that in the future. For
now I picked them all up and pushed it out.
