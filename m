Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A840E3D7CEA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 19:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbhG0R57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 13:57:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:47416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229453AbhG0R55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 13:57:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A42906056B;
        Tue, 27 Jul 2021 17:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627408677;
        bh=NApySyNNkHtOVvBftwxAyibsqZWM7xqG2gsVMaN0Rlw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=YNieRNQGb5tD8D3X9F4qWchot+fVqvWWBgGSvQWNYq9O3VRx6VutzOiTRDFhwIoYQ
         1aFaIaTW3hTUK/dKj7kD6/6JwEQUlnjDtJe/ZjopjoiNQCZ2+/n6JCjl1e80UorCr6
         Wmdd9GxawdHh2idWaMywtkkhAeR50W5CmHT4gzD9kCxrwTNJ/PGjCY2fvfvEAAFD3H
         WoUQiDFOzs8+XasFOeO1pVTYpM9WOMzY+FllvfX7CsFDCcW6APFgVNnn1c8OZNJckw
         SRozZWpib/DI59OhrD8G0anP7ICrXUaMJnZdyJLEC6jD1Tj6TJpVh7tGL+rNcieWUb
         TcUKIZE9YAjeA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210726105719.15793-22-chun-jie.chen@mediatek.com>
References: <20210726105719.15793-1-chun-jie.chen@mediatek.com> <20210726105719.15793-22-chun-jie.chen@mediatek.com>
Subject: Re: [v14 21/21] clk: mediatek: Add MT8192 vencsys clock support
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
Date:   Tue, 27 Jul 2021 10:57:55 -0700
Message-ID: <162740867556.2368309.6510644230868732963@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chun-Jie Chen (2021-07-26 03:57:19)
> Add MT8192 vencsys clock provider
>=20
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---

Applied to clk-next
