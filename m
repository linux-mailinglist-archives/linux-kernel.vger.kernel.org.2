Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92652398136
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 08:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbhFBGlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 02:41:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:33222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229624AbhFBGlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 02:41:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B2DE460C40;
        Wed,  2 Jun 2021 06:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622615964;
        bh=MYiHs0FZ4Dw7IMtBNoNMARh1n5xi8g6LSU/cAJoQvsk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=hmNsSP9y7DcJ6spdECBthW7t5m/H2lcN6IbqWMuqRjpqFcjxkyzWVQKZ3d9bBF4mU
         U189QlTuyyktK8hOt7G8FHHtvnd83Ab8xIiUNQURvbu3fDUDhlUP+JnsH8xMnLNrNQ
         mOll0EX9+FdotwqaZq0UQaZuy6h0gj6N853xj0fiXxrAsYqPdzpl9CbZapR3yvUuZU
         Za1x72QUL+NvpXTDrNMPWPiRSfIpSGdsCtCY2A6TRZNY8QnmjVP7Twcgnh0zbaIVgP
         j3Buuou66Q1VQX0VPQF9kKmJlQR3xD5yOifbFbMSsF32PnRAIeTPaY/ptn+dkmXMsD
         Lqlunzw7bQVyw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1621851730-32287-1-git-send-email-yang.lee@linux.alibaba.com>
References: <1621851730-32287-1-git-send-email-yang.lee@linux.alibaba.com>
Subject: Re: [PATCH] clk: sifive: Fix kernel-doc
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
To:     Yang Li <yang.lee@linux.alibaba.com>, mturquette@baylibre.com
Date:   Tue, 01 Jun 2021 23:39:23 -0700
Message-ID: <162261596346.4130789.2119773948104582418@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Yang Li (2021-05-24 03:22:10)
> Fix function name in sifive-prci.c kernel-doc comment
> to remove a warning.
>=20
> drivers/clk/sifive/sifive-prci.c:573: warning: expecting prototype for
> sifive_prci_init(). Prototype was for sifive_prci_probe() instead
>=20
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---

Applied to clk-next
