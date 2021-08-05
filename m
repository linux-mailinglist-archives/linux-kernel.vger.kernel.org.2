Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF423E1F8B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 01:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242523AbhHEXuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 19:50:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:37892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235548AbhHEXux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 19:50:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC638610FF;
        Thu,  5 Aug 2021 23:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628207438;
        bh=xQlZE+v1t97oNWrqbLQof/byZopzMvLzdrAQrGUqYOM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=l0MskL8/JMdZPq+VUpJtvuwfCR/fuq6yyk0C8TVNNJfgLMj9aXa1QWt2IvazmBW6r
         kMjCUQZQQ1SrECnvI3Gzk4oQB6ztyzWG6cvHxncHSogDHMZfMuka+vkRS6Ca8p5I5z
         86+oXSE5PZyn3HKkgwmgjJfEYkqH58KnXHeNU06b3skNO2A1Ofqydh6LuXXBHRQNrC
         m247qpIJwdxUw0yJhyJtNVgn4yWbFOtr7oiD56LCUN9rvJdjBx1j/PgWU1nFWZTysA
         7svcSU0tjDdREYo4r8kYRbRkWwuchtgvUXspb5Ah5/QTxfYPTmsOJgjNZ3pBN0t4qP
         Pf1KmV7PvXe8Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210801233314.3150754-2-linus.walleij@linaro.org>
References: <20210801233314.3150754-1-linus.walleij@linaro.org> <20210801233314.3150754-2-linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2] mfd: db8500-prcmu: Handle missing FW variant
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, phone-devel@vger.kernel.org
To:     Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Date:   Thu, 05 Aug 2021 16:50:37 -0700
Message-ID: <162820743752.19113.14907055500653653081@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Linus Walleij (2021-08-01 16:33:14)
> There was an "unknown" firmware variant turning up in the wild
> causing problems in the clock driver. Add this missing variant
> and clarify that varian 11 and 15 are Samsung variants, as this
> is now very well known from released products.
>=20
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Cc: phone-devel@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
