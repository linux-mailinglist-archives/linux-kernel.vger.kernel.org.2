Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A3A31B26E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 21:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhBNUdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 15:33:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:45536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229875AbhBNU3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 15:29:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 92D0F64E10;
        Sun, 14 Feb 2021 20:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613334719;
        bh=H9R+ROHxYjq8viD0A7JhSpt+PKnH2ZZlZyjfS9tvzaE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=MphepIgReWOOD91sruv3QysITn0bNsmx8UjNa12TDO/QitX9DQMmXQNLXbaba0kx3
         N7QkzxQMYLKryX0CwLOqxl2nzODg/2pvJEkssdI2E0rEh0HRAQHUq/4m621V3B4BWJ
         KPVgVB76hUou1B60SLTGHd8RWRRxx//pswxQN4LO7yejKtqX0UikSp1UXlV8HZIx40
         87eoT484A0lQ51ErmUzYcJ5kpvEZYSsV9FC556DotmuFK1t0BeQB8Nm/SRyUeFDPxP
         AoRgmt0TIoOpMuoO/ckJ5gHnI5cnRrKNrwgftZ72Co99XrxDXf3LKl8sDUrmGlbbEC
         1bf3bH26JXc1A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210211052206.2955988-3-daniel@0x0f.com>
References: <20210211052206.2955988-1-daniel@0x0f.com> <20210211052206.2955988-3-daniel@0x0f.com>
Subject: Re: [PATCH v2 2/7] dt-bindings: clk: mstar msc313 mpll binding description
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     w@1wt.eu, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Daniel Palmer <daniel@0x0f.com>
To:     Daniel Palmer <daniel@0x0f.com>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Date:   Sun, 14 Feb 2021 12:31:58 -0800
Message-ID: <161333471841.1254594.13083213077100654814@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Daniel Palmer (2021-02-10 21:22:01)
> Add a binding description for the MStar/SigmaStar MPLL clock block.
>=20
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> ---

Applied to clk-next
