Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 510473149B8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 08:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbhBIHtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 02:49:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:37532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229719AbhBIHtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 02:49:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 580CD64E5A;
        Tue,  9 Feb 2021 07:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612856903;
        bh=1fq/TENi8SJjEX/nDofCITIDuTH/sOz+32o4Y1IOg6c=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=W6M1ecOZZ4bqo+PlUqLYmMrCA0TowDQaHqJmrmP1H4Q6gtY/d9e7La/XWCxKXexI2
         odzjy0g5w6DhyG0DMYB96zzAYE+vC0dFtpW8fgKsyoZzbSKuIbvRWoj7qkYZ5XCPHp
         urWS7uEkGG7QDae5wMv3kPBC8rUMcXCQVGDTvLqQ+7sSBOz+G0BSuje8lYY3usE8rD
         komA2h7WlZMo6K0yXhTegp05j5gBN4YwJuqKd/qWoF8vOQwt5oPBVLippKhPIHwsvC
         vytBoOECdGTswIDj2m6eg+KimVcCzbX5bxrYu4i9kw8BWOngWiYe6ov/Ol26Zr33lX
         nWb5Fjmd0ya2w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210131170428.3290-1-pawel.mikolaj.chmiel@gmail.com>
References: <20210131170428.3290-1-pawel.mikolaj.chmiel@gmail.com>
Subject: Re: [PATCH v3] clk: exynos7: Keep aclk_fsys1_200 enabled
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     s.nawrocki@samsung.com, tomasz.figa@gmail.com,
        cw00.choi@samsung.com, linux-samsung-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, <pawel.mikolaj.chmiel@gmail.com>
To:     <pawel.mikolaj.chmiel@gmail.com>, kgene@kernel.org,
        krzk@kernel.org, mturquette@baylibre.com
Date:   Mon, 08 Feb 2021 23:48:21 -0800
Message-ID: <161285690197.418021.15554726449883492168@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting (2021-01-31 09:04:28)
> This clock must be always enabled to allow access to any registers in
> fsys1 CMU. Until proper solution based on runtime PM is applied
> (similar to what was done for Exynos5433), fix this by calling
> clk_prepare_enable() directly from clock provider driver.
>=20
> It was observed on Samsung Galaxy S6 device (based on Exynos7420), where
> UFS module is probed before pmic used to power that device.
> In this case defer probe was happening and that clock was disabled by
> UFS driver, causing whole boot to hang on next CMU access.
>=20

Does this need a Fixes tag?
