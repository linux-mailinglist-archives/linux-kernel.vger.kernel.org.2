Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1023D7CB5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 19:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbhG0RzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 13:55:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:45170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229591AbhG0RzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 13:55:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BAE4660F4F;
        Tue, 27 Jul 2021 17:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627408502;
        bh=7YITf+6vCWg/2TcduJ15J7mKtAeA2eCG6DFSJLScR9A=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=pokUSmq2ZatQHOM7uTUWqlnIk6ssmOQLkInhd4gsg1+tem2n/aJUnUNK+v8a2ldWs
         +lKh3Q6Lvt/SAVBgBLQ6IKsySTPNZ/sY+TE+u67g9teoIB4rgOOujzdJvvxIMnPDqc
         0TCTsE9xwpBLmj8mLITZ/UauyqTT9CLTBjGke8+gHljsda58MRoT39WmZZdKtFrAeL
         GztK5R8e+BMHIAwJ3KMy2ov8aXCdFVdN233jqVQ7AR/sttZOF66wduJHsgcJ+8hYv4
         nElbyrQ20+Wiwoh6rqN4+Zxwrb7CCtu4/epQMesQZ6qpxkCWS5SIAk0qHygGMgp5d5
         0OL0Q2vqBSyMw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210726105719.15793-8-chun-jie.chen@mediatek.com>
References: <20210726105719.15793-1-chun-jie.chen@mediatek.com> <20210726105719.15793-8-chun-jie.chen@mediatek.com>
Subject: Re: [v14 07/21] clk: mediatek: Add configurable enable control to mtk_pll_data
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Date:   Tue, 27 Jul 2021 10:55:00 -0700
Message-ID: <162740850059.2368309.10593418620932998201@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chun-Jie Chen (2021-07-26 03:57:05)
> In all MediaTek PLL design, bit0 of CON0 register is always
> the enable bit.
> However, there's a special case of usbpll on MT8192.
> The enable bit of usbpll is moved to bit2 of other register.
> Add configurable en_reg and pll_en_bit for enable control or
> default 0 where pll data are static variables.
> Hence, CON0_BASE_EN could also be removed.
> And there might have another special case on other chips,
> the enable bit is still on CON0 register but not at bit0.
>=20
> Reviewed-by: Ikjoon Jang <ikjn@chromium.org>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---

Applied to clk-next
