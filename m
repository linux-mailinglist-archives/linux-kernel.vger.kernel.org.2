Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5C63B56EB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 03:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbhF1Bta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 21:49:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:43678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231735AbhF1Bt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 21:49:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A1AA61A1D;
        Mon, 28 Jun 2021 01:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624844822;
        bh=fXSZr4cZjN5qCdNlOuCtiGlD5RNKolron3XuBjrtEC4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ZKTOT4+TOXr7cyauGgz2DcsnVXsXWSuJWWVMTF496+h50JO1O4Ts6szDFfT3zSZgj
         6t8dndba0Qka35b7WvOB7tDPU8D17gYCjU6HXRqZtWsbMXnx9vXleP4/k6BkMIXDoA
         dlV6DW13iFFGoH23z0gHT9BuUyeUGSYtJ1DrlSpFkGSrD40US3sExV6CInlTP1uhFI
         VRdHTh5jVXhQZxYWcDFUxgQ7YDjMwYlcW9nsvF9KgcGpQa2hHGfH0+9FbI59VxR4da
         +JLBE/oRlZe2YN8kXajAnfmZcASOADVKxk6PT3yy4c53zE3OLPzZTbrJS514Nisf5B
         RPD0oa8MOlCzQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <196c948d708a22b8198c95f064a0f6b6820f9980.1623354574.git.cristian.ciocaltea@gmail.com>
References: <cover.1623354574.git.cristian.ciocaltea@gmail.com> <196c948d708a22b8198c95f064a0f6b6820f9980.1623354574.git.cristian.ciocaltea@gmail.com>
Subject: Re: [PATCH v3 2/6] clk: actions: Fix SD clocks factor table on Owl S500 SoC
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
Date:   Sun, 27 Jun 2021 18:47:01 -0700
Message-ID: <162484482112.3259633.6387862368514938967@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Cristian Ciocaltea (2021-06-10 13:05:22)
> Drop the unsupported entries in the factor table used for the SD[0-2]
> clocks definitions on the Actions Semi Owl S500 SoC.
>=20
> Fixes: ed6b4795ece4 ("clk: actions: Add clock driver for S500 SoC")
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Applied to clk-next
