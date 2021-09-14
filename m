Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A50040BB25
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 00:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235594AbhINWT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 18:19:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:54358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235546AbhINWT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 18:19:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 59E7461166;
        Tue, 14 Sep 2021 22:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631657918;
        bh=yuT49ZLUiStwMqFdlVDdUjhjOeQGsFjtU3vuUb4EGQA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Zv7UQHk4FDcueCVQo4VCCWXtyn0FEuCnIcGqorlBxea15HBgA+bJ/QosbjB+ICGSO
         FH8TE2KcySein8v3dp12NWAB/GJsjbXvsZcFAPUXMXT8oWn5DaqDd36cJy+F25tze8
         AxpFZFYACuvfNDFEJ1joCBB1RTgz1MITi3pNvkl6NNbbuXZoWEswV9j4c3zU+2h+UF
         OA6burT8fd7sYHtaA/Z+7YPHkJH67oDO74buZvjTaje+RYgzVLLwKPAc/oqKaWCKnM
         mp7/o4pdNCzd7/Yla5F4wG4w37exL6UdwEj7plz91w+Rbr6UlAfvKN3hHFeEeTGcs1
         CJHIO0H1RZS4w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210914021633.26377-9-chun-jie.chen@mediatek.com>
References: <20210914021633.26377-1-chun-jie.chen@mediatek.com> <20210914021633.26377-9-chun-jie.chen@mediatek.com>
Subject: Re: [v3 08/24] clk: mediatek: Add MT8195 peripheral clock support
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
Date:   Tue, 14 Sep 2021 15:18:37 -0700
Message-ID: <163165791714.763609.4217812173195120259@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chun-Jie Chen (2021-09-13 19:16:17)
> Add MT8195 peripheral clock controller which provides clock
> gate control for ethernet/flashif/pcie/ssusb.
>=20
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> ---

Applied to clk-next
