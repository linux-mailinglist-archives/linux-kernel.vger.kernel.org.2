Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C35D42CFDC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 03:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbhJNB0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 21:26:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:41032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229846AbhJNB0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 21:26:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B5DB61175;
        Thu, 14 Oct 2021 01:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634174686;
        bh=t/xmcSaUbAJyjcbhyfW0vdbKAWGJwwD4Z01GnJJh39U=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Vt/5cDw1l3veaxrTeAsg/9SjzyXcM8kWCWrLirIxrZANwVcxAD4JEFJZiPYgGWDaW
         xfiBSLPpijR7UEZ5zXJxctWpQIZPIW61GbG9DNbop+bT05wxJoko7t400No3R9VdN+
         MHwXpFNvbvLgwu+348z5n/0jfR3a21PAN2jA0eF1HDHZulc0ZgPtw6bQNCZEL7gQQQ
         /C7WnhWHdOqMAnoIx+rT1uszRhY5v6C0buXLWvd38hUUS/N9dx+kIrLOIjsTpnXJ8Z
         W0iPQ6UtiqhJ/KJkbp2CKeuy/YfnwRqhlFJhhErvGRUc50PGu/pYRB8MRD9t5b5dJU
         RA81Z6CEXZDnw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211012103612.101859-2-AjitKumar.Pandey@amd.com>
References: <20211012103612.101859-1-AjitKumar.Pandey@amd.com> <20211012103612.101859-2-AjitKumar.Pandey@amd.com>
Subject: Re: [PATCH v2 1/5] x86: clk: Add config option to enable 48MHz fixed fch clk
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Alexander.Deucher@amd.com,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Michael Turquette <mturquette@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>
To:     Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        linux-clk@vger.kernel.org
Date:   Wed, 13 Oct 2021 18:24:44 -0700
Message-ID: <163417468443.936110.1163914591071839489@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ajit Kumar Pandey (2021-10-12 03:36:08)
> At present 48MHz clk support is only enabled for RV architecture
> using "is-rv" device property initialized from boot loader. This
> limit 48MHz fixed clock gate support to RV platform unless we add
> similar device property in boot loader for other architecture.
>=20
> Add Kernel config option to enable 48MHz fixed clk gate registration
> with clock framework. This enahanced flexibility to enable 48MHz fch
> clock support on any platforms by simply enabling kernel config. Also
> replace RV with FIXED as generic naming convention across platforms.

What do we do if I enable CLK_FIXED_FCH in Kconfig but don't populate
the 48MHz clk? It's always present so this isn't actually a problem?
Why does the bootloader set an 'is-rv' property at all?
