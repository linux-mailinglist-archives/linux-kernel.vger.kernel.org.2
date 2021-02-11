Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C0E319498
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 21:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhBKUhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 15:37:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:49060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229849AbhBKUhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 15:37:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D862964DDF;
        Thu, 11 Feb 2021 20:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613075785;
        bh=s6MK6AyHiNoTAcSPwsbFg/BT3aG4WkFax9HWorC7jXI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=iLcHnCs+ioTDI5dxVpm31eMs90IveMF2b7IkPgBT3Rwn1SHdVcM4p92Q+R5VJ7Bd3
         mEMcF11/QlxhBF0TXZL1zSKQpx6VGY5Tb2Jlb6yeilM/ivhr+KTGLGfw3qTNvsLYTu
         DyW6WuR1JXVJ5opcXulv7iVKOfe/YjM4x5JWiqf4Ou1a3Io/Y6YiN0uwJkJMXUlMQa
         M94mUC3/mpLtKUSKrje3v2wOGV43Ej4DPUadui5vMuHuPrWT8sIdxAbe9cIjbbJ8Hg
         Ptu1Sdczvc5Rwuu1vwBBWrHkn/mjorCBz3qjmNux7s8MkB6t3OZsTL1y+/6h4OMq8b
         tIS6VlmtImmPw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210119061715.6043-1-ryan_chen@aspeedtech.com>
References: <20210118100813.30821-2-ryan_chen@aspeedtech.com> <20210119061715.6043-1-ryan_chen@aspeedtech.com>
Subject: Re: [PATCH v2] clk: aspeed: Fix APLL calculate formula from ast2600-A2
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Ryan Chen <ryan_chen@aspeedtech.com>
To:     BMC-SW@aspeedtech.com, Michael Turquette <mturquette@baylibre.com>,
        Ryan Chen <ryan_chen@aspeedtech.com>, andrewrj@aj.id.au,
        joel@linux.ibm.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 11 Feb 2021 12:36:23 -0800
Message-ID: <161307578346.1254594.3414342188074176198@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ryan Chen (2021-01-18 22:17:15)
> Starting from A2, the A-PLL calculation has changed. Use the
> existing formula for A0/A1 and the new formula for A2 onwards.
>=20
> Fixes: d3d04f6c330a ("clk: Add support for AST2600 SoC")
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---

Applied to clk-next
