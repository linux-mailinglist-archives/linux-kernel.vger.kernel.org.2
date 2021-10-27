Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1A543BF02
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 03:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237490AbhJ0BcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 21:32:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:34910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231458AbhJ0BcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 21:32:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A42D61040;
        Wed, 27 Oct 2021 01:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635298191;
        bh=EMt/dllsPExZmeLgiFTfjhC3BFyE2z/pbIGXK4RgpE0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Sihtpe8R22x1AsqC3LzWYrfUTRfCMSNLB6HXzrfGBkYKO44ejcUCedv/fIXR/Zef7
         uOsSIvjnxJmqs9YiXBdJ4xjrDPbhnY5//StfY5PsHTw7AMwc8oyTPBaD6BQ7qpJtWI
         YoevB1eHAWGOtKSLKssrcn+uI3Ov/gJ99QMrR+6Yr6vuRxcaW+g0cTknC52Q5DpWhx
         4TE9vW/gLFXrrMaJ6mFJBAL8L0BecQpGbhtJC25jiFCOz1QOUzF+fvSBQvjq5yShYb
         wpr7uFr+kc4c+NX7HLw+3MajoxeMivxEhw9bl8QJIdozsB3R9Z6qkLeBdf8FVnCMTQ
         n3Kkgezk4G/9A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211021122248.33261-1-nicolas.ferre@microchip.com>
References: <20211021122248.33261-1-nicolas.ferre@microchip.com>
Subject: Re: [GIT PULL] clk: at91: clk changes for 5.16
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
To:     linux-clk@vger.kernel.org, mturquette@baylibre.com,
        nicolas.ferre@microchip.com
Date:   Tue, 26 Oct 2021 18:29:50 -0700
Message-ID: <163529819030.15791.7009809622910069319@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting nicolas.ferre@microchip.com (2021-10-21 05:22:48)
> From: Nicolas Ferre <nicolas.ferre@microchip.com>
>=20
> Stephen,
>=20
> Here are the clk changes for 5.16. I took the initiative to create a
> Pull-Request for it as it's surely more convenient, as I proposed in my
> reply to Claudiu's cover letter.

Thanks. I didn't pick it up this time but I can pick it up next time. I
wanted to take the clk.c patch via a different branch.
