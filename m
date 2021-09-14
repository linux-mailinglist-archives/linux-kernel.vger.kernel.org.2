Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E5B40BB20
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 00:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235572AbhINWTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 18:19:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:54204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235517AbhINWTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 18:19:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9141261175;
        Tue, 14 Sep 2021 22:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631657901;
        bh=8UYOgxQ/y4fca9kfPI88qemxf6oklkdQ917WplPmLjM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=SuFOgXc6G1WhoCY/Rt4N2Yo1Dri08ELhIlb5jXFBfcBZ8npNrLlxZGqkD3BXZ0IQu
         eXGq/uzbZzI3npBCEy8A6M0tskXRi+nD1sqLakkwVtYcHpgOgOC6YTBkAuOwr89LwS
         aIYFeyJus8kZLLcs0Ig6PQvwUEjcwMwmHLz9BRGw3KSx59tI6s/RSLpmxTamKkIgJD
         /OIngRwPryp6RcM7idZ+SnmXias6nX1Fj92vyznJz/DnzulMx2OpCCxr3qBp5qGa9s
         DcYygKwJWzw5AY0F1v//+bpJp6adH1Lu3U4PJ/VG6HaWLnITNDNNUWrffW8XueUNBJ
         gINRi/cQPuhGA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210914021633.26377-7-chun-jie.chen@mediatek.com>
References: <20210914021633.26377-1-chun-jie.chen@mediatek.com> <20210914021633.26377-7-chun-jie.chen@mediatek.com>
Subject: Re: [v3 06/24] clk: mediatek: Add MT8195 apmixedsys clock support
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
Date:   Tue, 14 Sep 2021 15:18:20 -0700
Message-ID: <163165790018.763609.10824046513029639929@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chun-Jie Chen (2021-09-13 19:16:15)
> Add MT8195 apmixedsys clock controller which provides Plls
> generated from SoC 26m and ssusb clock gate control.
>=20
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> ---

Applied to clk-next
