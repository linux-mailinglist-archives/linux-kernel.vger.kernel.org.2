Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5061C31B275
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 21:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhBNUeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 15:34:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:45556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229927AbhBNUbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 15:31:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CAB5F64E23;
        Sun, 14 Feb 2021 20:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613334732;
        bh=OPd7kWzl3sy3SzVt3tcpy4YL6NjdBtRZuj5FEvLrfdg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=YVuOZ6CqazKZfyhOD3HB8SAFKW607RRrvs00Xbn9/RN0vVsghx5ZT01YhSxQGAorH
         9tCw6dRh8AdfPHrMenshyJubnJVOFSkJqK0+IcUe64ZG15I9wDh8oJMMhRHEsyJAJq
         wiw4Rao6uD1pGxM11KpfxyoExV859tPcKUVUr4RKt56/FKRJebYSjWHk7mAtO2hBtz
         uD8e5lkopN1TI5LqM1asgyWNFl4TVJbiMW+HpCQEzJAVeb479ItR3WFRcYYCIRw8k2
         cdADfPL58YCznpZpbhiKN7s7FPzm96HjyVBBIs+8ZkxGmg1EWwh+CQlZKk+aem/LX1
         oM+N8hYWAT7gA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210211052206.2955988-4-daniel@0x0f.com>
References: <20210211052206.2955988-1-daniel@0x0f.com> <20210211052206.2955988-4-daniel@0x0f.com>
Subject: Re: [PATCH v2 3/7] clk: fixed: add devm helper for clk_hw_register_fixed_factor()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     w@1wt.eu, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Daniel Palmer <daniel@0x0f.com>
To:     Daniel Palmer <daniel@0x0f.com>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Date:   Sun, 14 Feb 2021 12:32:11 -0800
Message-ID: <161333473165.1254594.6998239834596963680@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Daniel Palmer (2021-02-10 21:22:02)
> Add a devm helper for clk_hw_register_fixed_factor() so that drivers that=
 internally
> register fixed factor clocks for things like dividers don't need to manua=
lly unregister
> them on remove or if probe fails.
>=20
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> ---

Applied to clk-next
