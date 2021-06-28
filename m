Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 940013B56C5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 03:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbhF1Bi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 21:38:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:39814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232009AbhF1Bi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 21:38:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 31CE161A1D;
        Mon, 28 Jun 2021 01:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624844161;
        bh=sIhBTuSvTzvzpOYA3vNS+ueHf+xQoVCrrpGOqlwJjEg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=JTTi/5pfq6aUp2AcTANRH6cKx3BnbpZ7gtczAKnX/muZeR7KJf5cvhe0M/X50rzuf
         mazgY5fowOCH8KgbSTWb94nZQ+UFKQPL3utfggaHrE41ilY42FHp4ftFWyepuktbxo
         W5UjEhMJaFOZH58RdLMcoW1lyUdc8lfOFQDXFseU6X4MoFcEsdvul69latWIKSvGyx
         CWw2SFkNynqGpyOvnmN2BxnjYiEBD4hGYwjlPlNAoK3q42441aQjppxf/ri7x6JkYH
         YUNQfDSHoylY7H7cIgF0q+CDQXeEXDI/jalRz63M4SOINz2ClAxeoUS7l3EJpYYZfm
         XrFRQrpPS4ZCQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210617051814.12018-9-gabriel.fernandez@foss.st.com>
References: <20210617051814.12018-1-gabriel.fernandez@foss.st.com> <20210617051814.12018-9-gabriel.fernandez@foss.st.com>
Subject: Re: [RESEND PATCH v3 08/11] dt-bindings: reset: add IDs for SCMI reset domains on stm32mp15
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
Date:   Sun, 27 Jun 2021 18:36:00 -0700
Message-ID: <162484416011.3259633.1627850825241102954@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting gabriel.fernandez@foss.st.com (2021-06-16 22:18:11)
> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>=20
> stm32mp15 TZ secure firmware provides SCMI reset domains for
> secure resources. This change defines the SCMI reset domain
> identifiers used by SCMI agents and servers.
>=20
> Stm32mp15 TZ secure firmware provides SCMI clocks for oscillators, some
> PLL output and few secure aware interfaces. This change defines the
> SCMI clock identifiers used by SCMI agents and servers.
>=20
> Server SCMI0 exposes reset controllers for resources under RCC[TZEN]
> configuration control.
>=20
> Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---

Applied to clk-next
