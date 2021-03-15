Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FED833AA8D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 05:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhCOEm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 00:42:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:58024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229663AbhCOEmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 00:42:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E90AD64E27;
        Mon, 15 Mar 2021 04:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615783367;
        bh=xpqUAI2bQKt4MazYjIzFFv1VpIJleUFXF6QUoExjDjE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FmgnwVZQD5lWYETypVgoCgVuF1FVc/4MBgnnxGRZCCIsbQtVp8mqUA4yOPj0augiN
         cja7aN4ynhyk08HwD6w26Y5c6girdz2hZf/rLFne2w21KW3sAITFwwLZC3TNuNH6yW
         J9flka2EP8KjzJUIfYgCcSbJiVt6vKZonvrONc7LlqS0P6cbyEkUc2ckWqxLe4GTDg
         w328bPpE1e35JLAsyKFDbzZYGWD+IVpsHfB8w/LBNVtDGm5wO/BtpUJzSWkZoPzP9M
         LknzSOgQZ7+FbqsNNvix4/LfGsDwXRxHx9kR8l3+0+cyJeg5T9MbnPmYKSpcR0TRug
         0xwEfmC0ZRnLQ==
Date:   Mon, 15 Mar 2021 12:42:41 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     m.felsch@pengutronix.de, devicetree@vger.kernel.org,
        will@kernel.org, s.hauer@pengutronix.de,
        linux-kernel@vger.kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de, catalin.marinas@arm.com,
        festevam@gmail.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/1] arm64: dts: imx8mm-nitrogen-r2: add ecspi2 support
Message-ID: <20210315044241.GG11246@dragon>
References: <20210308125518.255216-1-adrien.grassein@gmail.com>
 <20210308125518.255216-2-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308125518.255216-2-adrien.grassein@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021 at 01:55:18PM +0100, Adrien Grassein wrote:
> Add the description for ecspi2 support.
> 
> Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Applied, thanks.
