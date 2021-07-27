Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 708983D7CAC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 19:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbhG0Ry3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 13:54:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:44540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231319AbhG0RyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 13:54:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 44C0A60F4F;
        Tue, 27 Jul 2021 17:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627408459;
        bh=OzNU4k2gXkSYVCCyhRi+vZhZWuaJom9zUNNx43JBdgY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=JOIIuubBJ9sxNkIBsZaQrmb3Qf25XLfwSUZwcP0H83jyV8JsIE2zbrAnWUG1ru/Ea
         S8GkL/RsXcJBJ6Ovw6DNtZYCHXtdqYJIy88arFHUpEOkAG3mayPcPYQiGsttXRxnNJ
         xVZ7p3kb6vb5BpjMQofBWEQoG9QbVPWEq/j0axEvh8g9WK5xcRTKqPeD67rfwY8b+L
         vfEwy7qh2AYnL4fkP1RruyDLndm372wzxCTeGkhgx7f17GY3QmWJ9tOhsfHk1IkrrJ
         XMkhl986s7w3AHVkx3IGICg4neLgi7FjUdSOC74bheikAZlnsjAhNlt5MB6Ewi5IFE
         fo1cbHQ0VcaeA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210726105719.15793-5-chun-jie.chen@mediatek.com>
References: <20210726105719.15793-1-chun-jie.chen@mediatek.com> <20210726105719.15793-5-chun-jie.chen@mediatek.com>
Subject: Re: [v14 04/21] clk: mediatek: Add dt-bindings of MT8192 clocks
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
Date:   Tue, 27 Jul 2021 10:54:17 -0700
Message-ID: <162740845714.2368309.16206704563987773970@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chun-Jie Chen (2021-07-26 03:57:02)
> Add MT8192 clock dt-bindings, include topckgen, apmixedsys,
> infracfg, pericfg and subsystem clocks.
>=20
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---

Applied to clk-next
