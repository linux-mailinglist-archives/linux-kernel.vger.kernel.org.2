Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5A340BB1A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 00:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235529AbhINWT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 18:19:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:53968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235478AbhINWT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 18:19:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 582AD61164;
        Tue, 14 Sep 2021 22:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631657888;
        bh=tgTTZMjt8Mww5FFR+ZGGWlJ3N4siFq1LQKbrxSONmjA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=F2eXCQLB+jpo0InbEeQPnQrcnq63l/QJUl9S0jiDhO8dGzAOvoEIeANw0o0u2IhPc
         7e5CQ1LW/1liED0WbVgfa4WrPPentOT24r6gxQE1aP4Vys7T0KJ8Vb3mTutpUk1wsR
         nWXZiq3vyzUTBwf/MsV4FWrPat21VIk6x9HBTZQ/haOYHM0Lvt3w8dWyMHdGdnu2Y6
         /leNHGu9Nek7pzKh4Idl3BnRB1I7z8NqlnsKJfl5dTYgYYhquRwJCdeekZyj33tssW
         ykTVMaZJr0gDZZtoc4xmuaWZP90tcAXTQP0HKPdi4nrzf2yfYdXsPQoitsCwwuEK4w
         MJFM4NMoYYAHw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210914021633.26377-5-chun-jie.chen@mediatek.com>
References: <20210914021633.26377-1-chun-jie.chen@mediatek.com> <20210914021633.26377-5-chun-jie.chen@mediatek.com>
Subject: Re: [v3 04/24] clk: mediatek: Add API for clock resource recycle
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
Date:   Tue, 14 Sep 2021 15:18:07 -0700
Message-ID: <163165788720.763609.7235370743590362862@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chun-Jie Chen (2021-09-13 19:16:13)
> In order to avoid resource leak when fail clock registration appears,
> so adds the common interface to handle it.
>=20
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> ---

Applied to clk-next
