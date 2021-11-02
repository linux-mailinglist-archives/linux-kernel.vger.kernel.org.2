Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8056E4437EC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 22:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbhKBVkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 17:40:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:52114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229931AbhKBVkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 17:40:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C06E603E9;
        Tue,  2 Nov 2021 21:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635889052;
        bh=4QaY5fC3m0laLP2lA4oOJn/E9fFwE2H4ZTOW9LkGfJY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Nf8cmS+ikfvk3TA1YieeD5yQrdFNrniTJQLVR3XZWpVt6acymiMy43NQvXMlMqTLI
         +x3hgvHd5WLkcOdfgMq8DzwoM9MDsh9R5WGsz0uolWv9CJREtPeHWSe9stEd/NzeEX
         7PSXPAmAkX/fY3pN05GCdg2PkDUv6IbGjYceWupm/BmEINgJl8YoLmSG55ZL6nwq+O
         llA3D0WHG3baA5xeSCEnFg9W3YrC/8Pd7mtZQjdIo9WpQsWZBS40RNIjzUAj1PWLNY
         XOig9vaq8GOYuBzEu/+6CFEukdjNmOI2SdZzZ+0r1Iq5lGU1dtBDj68GIsqlIlp1qX
         LtX+jsufAewFg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1634000035-3114-4-git-send-email-hayashi.kunihiko@socionext.com>
References: <1634000035-3114-1-git-send-email-hayashi.kunihiko@socionext.com> <1634000035-3114-4-git-send-email-hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH v3 3/5] clk: uniphier: Add NX1 clock support
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Tue, 02 Nov 2021 14:37:30 -0700
Message-ID: <163588905091.2993099.18019292286268836074@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kunihiko Hayashi (2021-10-11 17:53:53)
> Add basic clock data for UniPhier NX1 SoC.
> This includes PLL and clock division data for cpufreq support.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---

Applied to clk-next
