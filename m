Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28B8540BB4E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 00:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235723AbhINWVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 18:21:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235766AbhINWVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 18:21:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC34A61164;
        Tue, 14 Sep 2021 22:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631657999;
        bh=+tQ+HUcpjUALQ26qn4AL0nD2qjypWGNXAPFyVWvuJmA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Nrmk/aPRCbrQf8cDc2HSTuqlPDLnG1dqaopSNXjKQOUO4xYxmaQtTpig46QnUz9jU
         445E9Stk4aZL7mcN8j4nk3c4v0Wcdsq3M+ZdlTMGfIJyrtsYEIUDhlrBHQvJ541tSi
         MHTLelNkq2IRQOGAll7qvaQzJg8XoOCYQlZ096TXPBPrs7bVNopOrUjPzWqS34ZYxR
         Xvz2nyyLoiaIH7Ml9vbJXO61p29j5o0LOiiFuHmW54vMkOBBWVsIzQqUlty86Kk+5e
         riXs7p6MyKyplCRIU09qkDrZI5SSchsWSDJF3SBWiHVX19o1KefAPB2M+NKgd6GoaP
         wZ7XECiul60fQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210914021633.26377-22-chun-jie.chen@mediatek.com>
References: <20210914021633.26377-1-chun-jie.chen@mediatek.com> <20210914021633.26377-22-chun-jie.chen@mediatek.com>
Subject: Re: [v3 21/24] clk: mediatek: Add MT8195 vppsys1 clock support
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Date:   Tue, 14 Sep 2021 15:19:58 -0700
Message-ID: <163165799856.763609.9052177212330824045@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chun-Jie Chen (2021-09-13 19:16:30)
> Add MT8195 vppsys1 clock controller which provides clock gate
> controller for Video Processor Pipe.
>=20
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> ---

Applied to clk-next
