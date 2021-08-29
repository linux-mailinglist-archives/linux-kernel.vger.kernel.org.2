Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A413FA93C
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 07:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbhH2FZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 01:25:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:35594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229634AbhH2FZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 01:25:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9850360C3F;
        Sun, 29 Aug 2021 05:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630214653;
        bh=bGY6E/Gh/5Z3BzRavpvjvORjqZzRufcVODbVuvcLQ74=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=GVVjNIlRNENg932KxWzpTpCSx8SrDM5BnE8ofagKQJyND+8ouSUZQqIEiC6oX+iFq
         +ChUyGn0/Y+8nkh6pM6wz6k5bleOMukojimao8d5oTV/wkQcnE/ui2RFu3FX2aJIRX
         hznFunmrqovXwxjNLKrocm6j5v6ISiv4GTCCsJdTlpCV7TDgmjhqKPRgB3bkAP0jvG
         6gFL4pyl72HLRJKp5qFecwogUF16UjPcB934RFnhT9EK5DWbXRe5E89vHXlchQHyjV
         2yJqT99kQujXAkce6qETpDYnCh/SlKJcde3bkIrfC2Wc+yi3GpOGAsPzdbRGsN5B6X
         92s7EakrOpJCg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210727055537.11785-1-sergio.paracuellos@gmail.com>
References: <20210727055537.11785-1-sergio.paracuellos@gmail.com>
Subject: Re: [PATCH] clk: ralink: avoid to set 'CLK_IS_CRITICAL' flag for gates
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, matthias.bgg@gmail.com,
        linux-kernel@vger.kernel.org, dqfext@gmail.com
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-clk@vger.kernel.org
Date:   Sat, 28 Aug 2021 22:24:12 -0700
Message-ID: <163021465232.2676726.1524959516246529010@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sergio Paracuellos (2021-07-26 22:55:37)
> 'clk_init_data' for gates is setting up 'CLK_IS_CRITICAL'
> flag for all of them. This was being doing because some
> drivers of this SoC might not be ready to use the clock
> and we don't wanted the kernel to disable them since default
> behaviour without clock driver was to set all gate bits to
> enabled state. After a bit more testing and checking driver
> code it is safe to remove this flag and just let the kernel
> to disable those gates that are not in use. No regressions
> seems to appear.
>=20
> Fixes: 48df7a26f470 ("clk: ralink: add clock driver for mt7621 SoC")
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---

Applied to clk-next
