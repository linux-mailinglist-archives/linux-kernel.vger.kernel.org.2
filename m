Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B179B362C34
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 02:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235084AbhDQADC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 20:03:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229719AbhDQACz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 20:02:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 34ED16115B;
        Sat, 17 Apr 2021 00:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618617750;
        bh=DtcwCnU2bWW7YUiEpToRNpS8Pj+rL/i63TmoUofqz/U=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=U5R7ieKowAxOZ1uBJMN29kk5OedkpQK9mq7fVSM5HWqUCC77yYbQDfBOek+czQoBZ
         4yTd9KUG7O64FLXx/A1iJTZIHYjM2LLXrWzp7ezL6WvNWMQzngBekYCyap3PbVcfAp
         p/e73gnauEPsq/frvYBAvpYyFVEu49YCBeck+Rl9eE1dpSWvYb0FEprPJuC9fvvai/
         F3B8XYg3ZDPjgoLKxxbrubOI2xQDoqsoxbTPmpBJqFVj0vXzJsaRfOmM2fYigYnjFY
         ihRSK9tLYr0Qh1N0VDf9rdq5CDxoU5LGJzbUnlSyXcuu7BmimRosNuSDezD+SkGonr
         7phRPdxu7cD7g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1618465960-3013-2-git-send-email-flora.fu@mediatek.com>
References: <1618465960-3013-1-git-send-email-flora.fu@mediatek.com> <1618465960-3013-2-git-send-email-flora.fu@mediatek.com>
Subject: Re: [PATCH v2 1/7] dt-bindings: clock: Add MT8192 APU clock bindings
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Flora Fu <flora.fu@mediatek.com>,
        Pi-Cheng Chen <pi-cheng.chen@mediatek.com>,
        Chiawen Lee <chiawen.lee@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        srv_heupstream@mediatek.com
To:     Flora Fu <flora.fu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Fri, 16 Apr 2021 17:02:29 -0700
Message-ID: <161861774904.46595.8483541757848028552@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Flora Fu (2021-04-14 22:52:34)
> Add clock bindings for APU on MT8192.
>=20
> Signed-off-by: Flora Fu <flora.fu@mediatek.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
