Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E94EF421E77
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 07:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbhJEF45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 01:56:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:41930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231142AbhJEF4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 01:56:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A8D566137D;
        Tue,  5 Oct 2021 05:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633413305;
        bh=olP05H9TqQBwP6CYu6c0m/6Q5j7SzdRAWZVzmO/VQqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qHp9Z6z15vNsX8OO7XRLj4Q5b7SRcg9I2cFzD0hTQrhUT3yY7xFvpblhtCGPjuDF7
         BogJ/WMkCHxi7/ducDrNnwG8WgqZqTYKJuclzMsztyVF6wJ5GbT5F9DFehdlasImT7
         fLvxsWS+5Bt7wM+B9ip6+OGE+IK6u8TC/h+4JsSQNYn5TXfnOiSvSIIUK2Cfzz/CCh
         UTWz7KYhuZ25nH7tkL5umLtgrpl81bzRl1FbGOdHbNDVrlITEjfynppysKUZudSi/1
         w/ma7U+/ZJES07e/lre4qpbrNSwVxu1SSXoehC64OBkwNKLC5iwHReBmPA8EQz5MCH
         deR4KwNwgFiZQ==
Date:   Tue, 5 Oct 2021 13:55:00 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, kernel@collabora.com
Subject: Re: [PATCH] imx: soc: Select REGMAP_MMIO
Message-ID: <20211005055459.GO20743@dragon>
References: <20210924140146.29264-1-ezequiel@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210924140146.29264-1-ezequiel@vanguardiasur.com.ar>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 11:01:46AM -0300, Ezequiel Garcia wrote:
> The imx-gpcv2 driver needs Regmap MMIO. Select it, and fix:
> 
> drivers/soc/imx/gpcv2.c:420:34: error: array type has incomplete element type ‘struct regmap_range’
>   420 | static const struct regmap_range imx7_yes_ranges[] = {
>       |                                  ^~~~~~~~~~~~~~~
> drivers/soc/imx/gpcv2.c:421:17: error: implicit declaration of function ‘regmap_reg_range’; did you mean ‘remap_pfn_range’? [-Werror=implicit-function-declaration]
>   421 |                 regmap_reg_range(GPC_LPCR_A_CORE_BSC,
>       |                 ^~~~~~~~~~~~~~~~
>       |                 remap_pfn_range
> 
> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

Applied, thanks!
