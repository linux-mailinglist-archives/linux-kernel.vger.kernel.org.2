Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9304A33E653
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 02:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhCQBjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 21:39:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:60530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230092AbhCQBjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 21:39:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 26B1564F3C;
        Wed, 17 Mar 2021 01:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615945161;
        bh=j6CzSX9wEsNTHn4YGYlT8GSBeZDSs+ZXcd0CaxQgQxw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=cvZCfRfYPGFjO2GbZeZ2COgHxhp9G1Q/jgYZEZysjC3Na6hSocr9zcmbopPZXlffc
         338+DA6kpiTKoKndz1ltb/6qDp/stNHN3BywSlcNwbyjzTgpWIFJrcC4nLLzWF8PiL
         NCHg0scvn1uVbP8lyf18jDVx44xWi88Ftpw0N8Cf5bAZjouObbZrEKVRI8AdQ/kPoK
         R0uqqCDFMoLgSOdGwOCrnnKbY8n23mdU31DJOROdPTCrkqFe+PaXNRHJki1ZaMphEy
         LU3bg6+u3JAyNWIQ9Kjutmi303zdD9T5Vdk1fcZiPPTYRO/IWyvbnXmgly2KXbyrTd
         jjbftWqwq/SBQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210315085608.16010-4-zhangqing@rock-chips.com>
References: <20210315085608.16010-1-zhangqing@rock-chips.com> <20210315085608.16010-4-zhangqing@rock-chips.com>
Subject: Re: [PATCH v5 3/4] clk: rockchip: support more core div setting
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        cl@rock-chips.com, huangtao@rock-chips.com,
        kever.yang@rock-chips.com, tony.xie@rock-chips.com,
        finley.xiao@rock-chips.com, Elaine Zhang <zhangqing@rock-chips.com>
To:     Elaine Zhang <zhangqing@rock-chips.com>, heiko@sntech.de,
        mturquette@baylibre.com, robh+dt@kernel.org
Date:   Tue, 16 Mar 2021 18:39:19 -0700
Message-ID: <161594515997.1478170.15019513894285693388@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Elaine Zhang (2021-03-15 01:56:07)
> Use arrays to support more core independent div settings.
> A55 supports each core to work at different frequencies, and each core
> has an independent divider control.
>=20
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
