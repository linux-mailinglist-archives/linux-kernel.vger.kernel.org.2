Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10F5140BAE6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 00:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234192AbhINWEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 18:04:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:49890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231559AbhINWEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 18:04:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B27936108F;
        Tue, 14 Sep 2021 22:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631656982;
        bh=oigmEST1EHQL5Om5LvHyBc0X19sT+8476VYDnxPswWs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=hAYqoc22cxkB8K5SjRZZVsaMGXnNvakxTsd9vpallnn7G5aq49zEKLHBHRBgHCcCM
         V0mVpAbvUJpq3pfJhAfZ8KHF4G/Uft1WF/ifLvHnxlVn45OmpNurkU9h6tpKJfJA+8
         bZpaR2OxRGc2i+h4LEVW1tENDZ+5mmad5yBXyDS8ZzogmI2qn07/aWboOebCHs4MPd
         kEgwvxbEBUJRBT27vQ6okoGN81N73uEfH2yBSedAPghJnfed6PxJtOLESXecb1YSF0
         /6f2Vg+6y1x9upyclij0ym81crZShm6MauK0lcS0qNlcWbfIb2W8AyMUNHwa9zR5uQ
         myDBPCE8Ev2tA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210913082633.110168-1-clement.leger@bootlin.com>
References: <20210913082633.110168-1-clement.leger@bootlin.com>
Subject: Re: [PATCH] clk: at91: check pmc node status before registering syscore ops
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Clement Leger <clement.leger@bootlin.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Date:   Tue, 14 Sep 2021 15:03:01 -0700
Message-ID: <163165698139.763609.11633047159530535523@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Clement Leger (2021-09-13 01:26:33)
> Currently, at91 pmc driver always register the syscore_ops whatever
> the status of the pmc node that has been found. When set as secure
> and disabled, the pmc should not be accessed or this will generate
> abort exceptions.
> To avoid this, add a check on node availability before registering
> the syscore operations.
>=20
> Signed-off-by: Clement Leger <clement.leger@bootlin.com>

Any Fixes tag?
