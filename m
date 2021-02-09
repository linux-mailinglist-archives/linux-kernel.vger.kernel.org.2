Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE2D3149AD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 08:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhBIHsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 02:48:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:37410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229464AbhBIHr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 02:47:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3EA0A64DAD;
        Tue,  9 Feb 2021 07:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612856836;
        bh=F22jfFy9W8oMUmsbBd5rEjgo8FcPzu5fWH8d+uvExto=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=X1TeLjv/DpMG9iI/wnak/vJu3odgdTETbzOp/lO3340oyZcyIARHd1Sp6CplwyPGY
         gMolQ7oKa5oc39yze9j70lMSIdX8Oi7iqIN1TeBRuj1fHvi39/+LN+B7oqtd9fGABl
         ABjp2Jcvf+oRToTq0mrG4gixhJ4bCJV1JS4PlrnvQBVkHGiBj4/whmbQt3cG4QJA5R
         td2P2u3WgcmB4aIKLGarQKtCBqcfj54pOH5FDST8D6P7A3zLuwIUgjp1UDgvUIJfOr
         NagsmNgJb+bFLu7+LrVRtR5XIzyg/mNO3uKTLNRxSw05cny9R5RjObyoTmPjM0NtGL
         IXvRMhWnjQqMA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210203105423.682960-1-enric.balletbo@collabora.com>
References: <20210203105423.682960-1-enric.balletbo@collabora.com>
Subject: Re: [PATCH] clk: mediatek: Select all the MT8183 clocks by default
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        Collabora Kernel ML <kernel@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        Mars Cheng <mars.cheng@mediatek.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Owen Chen <owen.chen@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-mediatek@lists.infradead.org
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Date:   Mon, 08 Feb 2021 23:47:14 -0800
Message-ID: <161285683488.418021.7723049164920384151@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Enric Balletbo i Serra (2021-02-03 02:54:23)
> If MT8183 SoC support is enabled, almost all machines will use topckgen,
> apmixedsys, infracfg, mcucfg and subsystem clocks, so it feels wrong to
> require each one to select that symbols manually.
>=20
> Instead, enable it whenever COMMON_CLK_MT8183_* is disabled as
> a simplification. This would add few KB in the kernel image size but
> will make the life a bit easier to the users, anyway you'll need to proba=
bly
> enable all of them if you want to have proper support for that SoC.
>=20
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---

Applied to clk-next
