Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D547C3D7CC2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 19:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbhG0Rzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 13:55:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:45614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229981AbhG0Rzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 13:55:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D1D0E60F91;
        Tue, 27 Jul 2021 17:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627408540;
        bh=lZaHrsUCW+QSpVB/SQf81Sa0l+Hq1V/N8djHgykDVhw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=FeqM7eoicuCmAOCIfftrSj8+MRbW+t/oZqYn5otnUTqfdzyDF1rvw1aS141aveJoU
         ASwNbpD01N/vWiTCDlOcFqhxRAgFIMHLDdX9ad4C5FnWr97+POffSfvVMPPA55fRLJ
         8XJBHkHBBpvxfpnFicCEEl+iX3miF4VsprZkFx5ZYwYXBswt9bbtNhXcofOnSw8MvG
         9vzrUepoCgBqPLXmMITnjfWe35Yfj5emlmhbyadu/iGmkBSmP7xq+gQXw0W+3f/Slh
         0JLMsaZC60qs7cs/NPln7BP4hC+jJunUkOg9MEDHcU5pkBl276V7W0BoURrwra8F9H
         C66TLHfvlQxOQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210726105719.15793-11-chun-jie.chen@mediatek.com>
References: <20210726105719.15793-1-chun-jie.chen@mediatek.com> <20210726105719.15793-11-chun-jie.chen@mediatek.com>
Subject: Re: [v14 10/21] clk: mediatek: Add MT8192 audio clock support
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
Date:   Tue, 27 Jul 2021 10:55:38 -0700
Message-ID: <162740853879.2368309.18089975265432822576@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chun-Jie Chen (2021-07-26 03:57:08)
> Add MT8192 audio clock provider
>=20
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---

Applied to clk-next
