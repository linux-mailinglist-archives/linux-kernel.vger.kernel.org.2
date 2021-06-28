Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 633A13B56CE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 03:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhF1Bii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 21:38:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:39980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231819AbhF1Bih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 21:38:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A04D61A0F;
        Mon, 28 Jun 2021 01:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624844172;
        bh=bmhwZ47jLX0lJilJo5+VApYPQ3OsVfa3yYJ5rZF5Id4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=u5cvbyJq9PLvBGpFLpQdWUSFLIy4pjlEHD0n06tuh2y036+CjgnoLWYzFmXEWfEKO
         4Wabq8pCBY7akup3XW8Vm3oQ79KosJinh8Dg+6Tf7PxQOSBqYR6PIS3qUObvqJ9G11
         XwqGsq7hM7tlpPh947ESCDjXqp5hcnfvSCD+M4qlU6Mt4jsPvamUjIJIyzRpxUuv/l
         p6S+yVX32aVKi/ypu7KvLIbD7xukQZ4jAZ60ztJC3x6+0IC9coSHMiejRKnGv1Obqj
         uz8EAKQNkUlC6c0KnFVjELqs4aesOhrzU5LiyCyULPdO98NMDyDQ5Yt1o6Bx1y3qiJ
         Xa87Ini1lGuww==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210617051814.12018-11-gabriel.fernandez@foss.st.com>
References: <20210617051814.12018-1-gabriel.fernandez@foss.st.com> <20210617051814.12018-11-gabriel.fernandez@foss.st.com>
Subject: Re: [RESEND PATCH v3 10/11] dt-bindings: clock: stm32mp1 new compatible for secure rcc
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Etienne Carriere <etienne.carriere@foss.st.com>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, marex@denx.de
Date:   Sun, 27 Jun 2021 18:36:11 -0700
Message-ID: <162484417147.3259633.10321997098249048450@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting gabriel.fernandez@foss.st.com (2021-06-16 22:18:13)
> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>=20
> Introduce new compatible string "st,stm32mp1-rcc-secure" for
> stm32mp1 clock driver when the device is configured with RCC
> security support hardened.
>=20
> Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---

Applied to clk-next
