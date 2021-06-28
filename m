Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7143B5771
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 04:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbhF1C5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 22:57:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:58616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232013AbhF1C5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 22:57:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7324561A0F;
        Mon, 28 Jun 2021 02:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624848878;
        bh=YPeVdN/A3qlwSQDdOo2SRUgJtwOLPQlCo8Qwy64E4JE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=i+2uBBkoAGfk/VyeOjF7g53g034QSjc8RJq7DzdVphST9QxstqEbZpgGqTAFvJ2rv
         zfinu7VP4Wz6LzvXjW4B7AjaYJLPJhHsRECHZE/RvYp0jB2OGGXX96eRORSA2SaMOJ
         ZERvziVZlSR1bqAuEbFqkJiM9AubJLT56iXVpPdHadsAUkSIGcHUxmgc3R9s0CfsCV
         fyXSiwNEUZ0JYZAjExPlBWdhxKvpMZNAp9TOZL8av9O9grBwak4pKGT18wjD5DE5ZX
         okTusXtkh8/3GrkWLg9mh6FT1xrxVF7HKkSaIBmPoPROZ5t6hGQDZfUVguoAlqMmH4
         DiaYLNr0+SZFQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210331201632.24530-2-avolmat@me.com>
References: <20210331201632.24530-1-avolmat@me.com> <20210331201632.24530-2-avolmat@me.com>
Subject: Re: [PATCH v4 1/7] clk: st: clkgen-pll: remove unused variable of struct clkgen_pll
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Alain Volmat <avolmat@me.com>
To:     Alain Volmat <avolmat@me.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Sun, 27 Jun 2021 19:54:37 -0700
Message-ID: <162484887737.2516444.17714164441200198932@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alain Volmat (2021-03-31 13:16:26)
> ODF field within the struct clkgen_pll is never used by the driver
> and can thus be removed.
>=20
> Signed-off-by: Alain Volmat <avolmat@me.com>
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---

Applied to clk-next
