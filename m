Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1058142AB8A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 20:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbhJLSHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 14:07:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:38376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231808AbhJLSG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 14:06:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6025D6109E;
        Tue, 12 Oct 2021 18:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634061897;
        bh=TOIZ/lPFpgW5s2Q1ZJj0S3XD3XwX6DCR2QMtHMh5HnI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=lSrOSqOZZCP+H7YGOynlMHxLFlORNDK1/ZLMvLOK2rugUv8G5e6i567su/tntefoJ
         UwMWrAxnW3WClWMisGlFUtxhS4IStUZRCtqeNIk9tE7N6swnPFSWhYxtj6h6uNne3y
         y+4RNpyg9Sl/bPbx6T9jE7xhAhdu/o4J9sBL9x2T70uTeOz0YwBmBRcAXEVfD8hVz+
         88kXQZyK6KPZrzV9o9Xe5JVVQUQYGdEyMUKoE99mE7+0EFYfB5UGMfEcIeuicTyYZZ
         nAOEJySasmDku2hwG0UAvlzEZiTcWMNJbKDsiX/90Tr+i+ZnJZ78wcnURS/bH/FsWa
         O0/kkpnOH4doQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210914090338.5945-1-hsin-hsiung.wang@mediatek.com>
References: <20210914090338.5945-1-hsin-hsiung.wang@mediatek.com>
Subject: Re: [PATCH v12 0/5] Add SPMI support for Mediatek SoC IC
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Tue, 12 Oct 2021 11:04:56 -0700
Message-ID: <163406189612.936959.767305130802405261@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Hsin-Hsiung Wang (2021-09-14 02:03:33)
> This series adds support for new SoC MT6873/MT8192/MT8195 to the spmi dri=
ver.
> This series is based on Chun-Jie's patches[1].
>=20
> [1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=3D52=
1655
>=20
> changes since v11:
> - rebase to v5.15-rc1.
>=20
> Henry Chen (1):
>   spmi: mediatek: Add support for MT8195
>=20
> Hsin-Hsiung Wang (4):
>   dt-bindings: spmi: modify the constraint 'maxItems' to 'minItems'
>   dt-bindings: spmi: document binding for the Mediatek SPMI controller
>   spmi: mediatek: Add support for MT6873/8192
>   arm64: dts: mt8192: add spmi node

Please drop the dts patch from the series so I can easily pick up the
whole lot. Also fix the binding problem reported by Rob. Otherwise the
patches look OK to me.
