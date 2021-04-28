Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1FA636D007
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 02:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238589AbhD1Aiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 20:38:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:33378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230368AbhD1Aiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 20:38:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D8B0961059;
        Wed, 28 Apr 2021 00:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619570286;
        bh=CMfqp2ysuA3/D1+ryUnOiQl7FNrAM41qVmw5/edbOug=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=l2lV0b14X26qEd1HY1IrJldUvviWVRsUx7emUc9OSSzsoAebev0EZxHHX7CVG55Nt
         VO9dKSQrrYIZYU9+AXyAtcte+5pp713PARYKBdcbwrzQnUTDfhqWj7d6chT9EiSHrL
         v74841cOMn1zyrmQKHZwOk2LEheBRTcLyyW1jW5dqsb7TWK1XimkNihoVy1l/r0mY6
         Rs0sEiGm5yu5N1e3gZCNAowYuPW0yrib+bpFrlvYDX4Vo/lli8KKqYxv6cr4LnN+T5
         RnyWmJtwIixPDc99HtS39ejY+jSEZZZvIK2fVnlYId7eZMRtu6RVLGUh8N7aecFAf4
         L6IFVcRCWR/og==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210426155457.21221-1-nm@ti.com>
References: <20210426155457.21221-1-nm@ti.com>
Subject: Re: [PATCH V2 0/4] dt-bindings: soc/arm: Convert pending ti, sci* bindings to json format
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Nishanth Menon <nm@ti.com>
To:     Nishanth Menon <nm@ti.com>, Rob Herring <robh@kernel.org>,
        Tero Kristo <kristo@kernel.org>
Date:   Tue, 27 Apr 2021 17:38:04 -0700
Message-ID: <161957028464.177949.14790878722521589025@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nishanth Menon (2021-04-26 08:54:53)
> Hi,
>=20
> V2 of the series posted in [1] to convert the remaining ti,sci bindings
> to json schema format. V2 is mostly review comments being incorporated -
> details in each of the patches and in applicable patches, I have picked
> up Rob's and Tero's reviewed bys.
>=20
> There are also dts fixups that this series exposes, which is good, but
> I chose to hold them back for now pending binding review at least. The
> complete series is available in [2] if folks are curious - to be posted
> once v5.13-rc1 is available for fixes.

Is Rob going to pick this up? If so

Acked-by: Stephen Boyd <sboyd@kernel.org>
