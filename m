Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE173E207B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 03:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243166AbhHFBLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 21:11:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:56290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242769AbhHFBK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 21:10:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6473161176;
        Fri,  6 Aug 2021 01:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628212243;
        bh=9ddLVrEMbcuwWfjwyTUIp5+wk0404rhszEa1fNlCPCA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=BokKoxbZwHwfnT1FjTY+QFhY2B/lSzPFFf8KfDT0XkkIFVcogOasJuOVP99xqq/7F
         oT7LU2nlAvbyq2QOtAbqtv6sbFt8mUTHGjO6m6//kBqrdsaWzffFfGh3g0zl4t91TY
         Jk0U0/BRLbiDf2t6xzpuB1b1gNDEGZs6At46OlB8ExF6spPR9v4DR+TxLp2nRt1AN/
         uSWXksH9y2/FgVcyiBkEYwYsWHD7nlkTHaMUD+0iG/EHkvLcNsaiRrDKF9qLGxmesx
         lReMKX3CoPVytgpN2vCm6s4HTat93ja7TpWRPTBBWbYW1pAktdvd1qE8BCyGvL0Lv7
         IOMy0nNzny81A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210702225145.2643303-6-martin.blumenstingl@googlemail.com>
References: <20210702225145.2643303-1-martin.blumenstingl@googlemail.com> <20210702225145.2643303-6-martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v1 5/6] clk: stm32h7: Switch to clk_divider.determine_rate
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-clk@vger.kernel.org
Date:   Thu, 05 Aug 2021 18:10:41 -0700
Message-ID: <162821224129.19113.5484324790744582709@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Martin Blumenstingl (2021-07-02 15:51:44)
> .determine_rate is meant to replace .round_rate in CCF in the future.
> Switch over to .determine_rate now that clk_divider_ops has gained
> support for that.
>=20
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Cc: linux-stm32@st-md-mailman.stormreply.com
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---

Applied to clk-next
