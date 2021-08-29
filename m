Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8213FA95E
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 07:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234325AbhH2F33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 01:29:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:36644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229634AbhH2F30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 01:29:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 297AC60F36;
        Sun, 29 Aug 2021 05:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630214915;
        bh=d9x09IXoGPv8OxxwYSFTT3FSxVPusg18qTaIMyUUiPc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=hmlhwSYPz4321xRyh9tQBvsJ1MOydibjEjWRHVwnKNzy9jrskG05C8gZrGAhfnxbf
         dwS8GAkanizh1ArCWUi/rm+UMhDRkw0dwgc/+NG33CuxR5h0Ha1YCAH+7PoJYcJn3T
         MrP/n2dad5mFGG5AfjSK+JE1g1HQacm5qTCOpmhcxP5MEyfd6FkeGBeGCCMbg65ogF
         owyC+N5Z672/yHA6lBLnhtRWdEpNveLIeH3pZw+y3Of/emYJJZ61G2EMsRZPuG3STZ
         gei1q6Rqk40K/VBxb8UwTKqwZ0odTFiTSPIQcteQWrZBkFjx/9rJ0YFn8bAL54YjHU
         ocMIZ1ng6TDww==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210707131213.3283509-1-codrin.ciubotariu@microchip.com>
References: <20210707131213.3283509-1-codrin.ciubotariu@microchip.com>
Subject: Re: [PATCH] clk: at91: clk-generated: Limit the requested rate to our range
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        claudiu.beznea@microchip.com,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 28 Aug 2021 22:28:33 -0700
Message-ID: <163021491397.2676726.7633391558529179439@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Codrin Ciubotariu (2021-07-07 06:12:13)
> On clk_generated_determine_rate(), the requested rate could be outside
> of clk's range. Limit the rate to the clock's range to not return an
> error.
>=20
> Fixes: df70aeef6083 ("clk: at91: add generated clock driver")
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> ---

Applied to clk-next
