Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4ECB3B56F7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 03:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbhF1Bty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 21:49:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:44124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231941AbhF1Btw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 21:49:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF5006197F;
        Mon, 28 Jun 2021 01:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624844847;
        bh=QSprWaRkacNp/fztWSjF++zzYSBMzCCl1pa80LuXLbc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=blhIR+8L4WJJetoWjnDud462xpPvq9vCQ2/4XNfltu1xPFFKinq/sL3lD7DWKqaNs
         ODwgEKUlUkkjcEAU0GPDrT9Ohd03ibBlgg5lPJ0BcU1Ix+o9gMW2YUMWsLX2+AM+TP
         S1iA29thgErpSU6EtQfXiDYr4smxSfuUjCy4Y/9a0pBBepDb6OnLj1G+Qp4C7GZhJK
         c0aOzyVKv1V5q35wKBelpvTmMM5TMaKpkz79K42arHyKHBxampkWFu7vO4ZAuueKkU
         M3lcsK6L8PMOat65ae+OmzmBtmyItS1Cgb3lpyeCCPLoYsNi1QwKP5Em3wfW81yYPs
         vANPbCBE2iP+g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <d62e4f1f85c5cef05be14d9e8143e88bbddd2e0f.1623354574.git.cristian.ciocaltea@gmail.com>
References: <cover.1623354574.git.cristian.ciocaltea@gmail.com> <d62e4f1f85c5cef05be14d9e8143e88bbddd2e0f.1623354574.git.cristian.ciocaltea@gmail.com>
Subject: Re: [PATCH v3 6/6] clk: actions: Add NIC and ETHERNET clock support for Actions S500 SoC
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
To:     Andreas =?utf-8?q?F=C3=A4rber?= <afaerber@suse.de>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Edgar Bernardi Righi <edgar.righi@lsitec.org.br>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Sun, 27 Jun 2021 18:47:26 -0700
Message-ID: <162484484656.3259633.15967015792311053054@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Cristian Ciocaltea (2021-06-10 13:05:26)
> Add support for the missing NIC and ETHERNET clocks in the Actions Semi
> Owl S500 SoC clock driver.
>=20
> Additionally, change APB clock parent from AHB to the newly added NIC.
>=20
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Applied to clk-next
