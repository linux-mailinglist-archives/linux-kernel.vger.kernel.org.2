Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F6B3E207E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 03:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243175AbhHFBLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 21:11:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:56366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242769AbhHFBLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 21:11:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B2CC3610E7;
        Fri,  6 Aug 2021 01:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628212250;
        bh=RABKd+OBGIGq+hL+Zan571iiylejaLL5KcYDrs0gUcc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=fFZqsrn9QRjW235OIiyDO41H3DQoidEty8youhyT79WR3UrV+vztHWn4CKS2tyNpP
         aNHjFNIlONfnWPposonpJugeMJxxq0I6dF7ckPXfBsMfC43sGsMesQrGpgMFxw/ve7
         Cx2FqgoJRZnfcwQq4K5JWWqu093RQ15hJBg1YQ3YBhdFkNBaeGXDXlMEiNE3/S0hPR
         KUxE+P6fT1Qze0Y1N4oz69jrKpHJhG75i5tyKopb78GgD9K4vXOtsaQXB5YGXsWDf7
         83bFDMMdLJx8Xqv0Uiof4Oq2hVF9wQTv2CSPFUTrRFMl/mcSj96u4rlD3YiKgVLVLL
         G6NxrY6fdTPng==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210702225145.2643303-7-martin.blumenstingl@googlemail.com>
References: <20210702225145.2643303-1-martin.blumenstingl@googlemail.com> <20210702225145.2643303-7-martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v1 6/6] clk: stm32mp1: Switch to clk_divider.determine_rate
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-clk@vger.kernel.org
Date:   Thu, 05 Aug 2021 18:10:49 -0700
Message-ID: <162821224952.19113.2518483135031133024@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Martin Blumenstingl (2021-07-02 15:51:45)
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
