Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C763C42E710
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 05:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbhJODJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 23:09:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:43374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229526AbhJODJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 23:09:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 380EC60C4D;
        Fri, 15 Oct 2021 03:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634267238;
        bh=lN+3oZQbY/EQ0fp4ws24tRucNMoqvvmRfObT4W1c5RM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SEq0Cn+qrI5W8LAR49cuzxjOTZAkfsKRK7p9M/3Jw1MTsGmVO0tnwZWGGZmpGYG8m
         3fXgBfRbPfF1wrK94Aer7wDKSrwLyGair/DC1X/sSZ6bObkWi3CSrZQr2LS+Zw3XlW
         swRn6gJ+5lNVa/upNjkC//a9O/pqhIH0RcOGMTIs17HHyUkOEmEN6oohVZy3eMSg9J
         Z4o+xUmuCoGvSzPtAemR5UKJN2qlADkrhUiYwTsLLehBPynNqTdpQS7wMPiu4fLVze
         oyiXAKnQ3N/JSVlo+HMYOUeFvyfqYxH5izLvqTbffH5sNNswEewx2421eIqYxM9LfU
         HA/70+ZKZqtyA==
Date:   Fri, 15 Oct 2021 11:07:10 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH] ARM: dts: imx6dl-prtrvt: drop undocumented TRF7970A NFC
 properties
Message-ID: <20211015030709.GB22881@dragon>
References: <20211010133215.145722-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211010133215.145722-1-krzysztof.kozlowski@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 10, 2021 at 03:32:15PM +0200, Krzysztof Kozlowski wrote:
> Neither the bindings nor the device driver use/document
> "vin-voltage-override" and "t5t-rmb-extra-byte-quirk" properties.
> 
> Cc: Oleksij Rempel <o.rempel@pengutronix.de>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Applied, thanks!
