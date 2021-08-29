Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCFB83FA8ED
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 06:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbhH2Ei0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 00:38:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:47648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229534AbhH2EiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 00:38:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2886D608FE;
        Sun, 29 Aug 2021 04:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630211844;
        bh=o5kZAWHj2MKi+NF+1MHtAoY0KxxvTi+48fvJKuVxBJY=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=MLr2ZVtmSWTFSCRojHilafcfV5FTYydQOY3QK3VJA7/bScVQyn79WoZ/VAkpWS9VX
         mua2PPwuUp2PDH0praJvvwsgwm12dZ2tVednGXxF0YtomSkUqdJSkzYFsf4HU53ow2
         zrv6CUAizuLN4KBVMRZSUZ4GHAt0HpJFcWfKzOPeEU9BvYCcpYUDlDts0VOQjLu0Gn
         +o2zKTMNo0+CHa1O9aH4GN8ssxx4ZAQwqVh0SBr0ljlg0Qz5IiYRDNZk/QMREFzFjI
         SXiTuqHbAsbcMNXH/awP/BEKse+8R5iggzMV6orfUyHGSszL4NZBiDJTxqHz9K7+jH
         DbZfi89/5RR/w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210818080518.9491-1-ryan_chen@aspeedtech.com>
References: <20210818080518.9491-1-ryan_chen@aspeedtech.com>
Subject: Re: [PATCH 0/1] Fix AST2600 hpll calculate formula
From:   Stephen Boyd <sboyd@kernel.org>
To:     Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
        Michael Turquette <mturquette@baylibre.com>,
        bmc-sw@aspeedtech.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan_chen <ryan_chen@aspeedtech.com>
Date:   Sat, 28 Aug 2021 21:37:22 -0700
Message-ID: <163021184290.2676726.4978141961679779291@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ryan Chen (2021-08-18 01:05:17)
> AST2600 HPLL calculate has few different with other pll calculate
>=20
> Ryan Chen (1):

Please don't send cover letters for a single patch.

>   clk:aspeed:Fix AST2600 hpll calculate formula
>=20
>  drivers/clk/clk-ast2600.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
>=20
> --=20
> 2.17.1
>
