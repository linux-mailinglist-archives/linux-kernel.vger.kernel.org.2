Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E89F3FA9B8
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 09:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234790AbhH2HHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 03:07:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:51642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234745AbhH2HHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 03:07:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E627601FD;
        Sun, 29 Aug 2021 07:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630220776;
        bh=/bo8CQ5ubL+De4iP99wspV3BIMOcw67mLr0gSrsEL6Y=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Qp2uprQkED0AFOJjO/H2Ei3mleyJOyi592OMt7oYW0mVGvCb8rnT/7gQvDU2XFAl9
         jmg6MoW9lUym9p1yqlZYqbDiTNYp273nen3nOgfxgrFdQasE5hSI5yWayJffzmznhY
         eF+UbKvFSnh5QHiPNzvYOxBE1dg9Lur21WCIZPMD3Bwb4CMhzSuq8OI8Dt5XRjp5Ec
         txbn/w6n+KcO1144RnJeivaYO1yGk0JkOLOqhAown/1pG2E0oDW/mbEi0bLpjhfIzZ
         DLZVEGjPz10ZtFR/LW3tJTJFObz2qrbm9HAEOj9tKqofPOm8VrAWyoFAW+6tR8+VOA
         ay/WjuvKvw7Tw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210825134056.219884-4-krzysztof.kozlowski@canonical.com>
References: <20210825134056.219884-1-krzysztof.kozlowski@canonical.com> <20210825134056.219884-4-krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v3 3/8] dt-bindings: clock: samsung: convert Exynos542x to dtschema
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Sam Protsenko <semen.protsenko@linaro.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Date:   Sun, 29 Aug 2021 00:06:15 -0700
Message-ID: <163022077504.2676726.5936865865796813700@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2021-08-25 06:40:51)
> Merge Exynos542x clock controller bindings to existing DT schema.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---

Applied to clk-next
