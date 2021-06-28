Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3AEC3B577E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 04:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbhF1C5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 22:57:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:59016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232069AbhF1C5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 22:57:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8BD3C61A1D;
        Mon, 28 Jun 2021 02:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624848906;
        bh=kXuC6iyf8MxbUadBO9NawpFPy7enZ1JCPUfa5FDGm4Y=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=hYa5bfgdPvb/5oNYYg9e2b82XU1ZvkGO7c7l/hhllFdC8RlkcZnAAylWd9wK1dnmE
         tTipuqFDW7NQjv4yy+wmr4RtRdQ2hFdUBEprtt9h8hJmU30PwF9OV/pRLrwmd9uqwq
         ltRH6qNoI15sDd+BZOhfh6TOUVyUZDUfp7+zrUEpo5+hKUJS07ahC2mJOmgn8JRoSX
         aCKGpPSBfW+33552K8oN+XJO5FlsBiODizbbiYXs/eD6Yc1dfvA5NrqnowSvFyaz1W
         ofgRmb7vYJ+VUWOSSVaumZX+v0p2KaIjqnlRTlqLIuxR7tsRVH3YKPP+lrj1HKWI76
         DTxR0Fbf5wrhA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210331201632.24530-6-avolmat@me.com>
References: <20210331201632.24530-1-avolmat@me.com> <20210331201632.24530-6-avolmat@me.com>
Subject: Re: [PATCH v4 5/7] dt-bindings: clock: st: clkgen-pll: add new introduced compatible
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Alain Volmat <avolmat@me.com>
To:     Alain Volmat <avolmat@me.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Sun, 27 Jun 2021 19:55:05 -0700
Message-ID: <162484890538.2516444.11117577255103204540@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alain Volmat (2021-03-31 13:16:30)
> New compatible are added, supporting various kind of clkgen-pll
> used for STiH407, STiH410 and STiH418
>=20
> Signed-off-by: Alain Volmat <avolmat@me.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---

Applied to clk-next
