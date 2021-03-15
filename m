Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E5133ABD1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 07:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbhCOGzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 02:55:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:55892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229607AbhCOGzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 02:55:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CCC9861574;
        Mon, 15 Mar 2021 06:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615791301;
        bh=2Zjk/uvnDns77ZTfsest0NfagHcyTprZJLVpCJIYKeQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BLUZE5gw84/xSRhFPXfTyvan4k7zgnUf4f2rBpTaYt5xQUW2ZcZ+67Sf0OSNbC9us
         KKn8mxlGkocggFxXw5Ny8w8owfrYZoBcGdAmXZlxZMu3rQDascVXuS9f3p9PLpJlT8
         wp4G+Y6n2bmC38UZYR/QpBYIM6y3g6J6Nf5deu9zN0KLCD3mPtPIEFNJhmp4B1iY4N
         gzM7p1ol8+DHYa1Xochs3pAc9mWR7Uo8znZ4zPx1qunDvWbywfRB6JbB7Pu9Esa4WO
         CdY0vAJsJ4NfqmxNBvahqBvUWQCaMuf1eXJjAB3Fz4i1y8O+XmL9M60Ga6F70JWIhj
         hCZzN454lkxRQ==
Date:   Mon, 15 Mar 2021 14:54:57 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Kuldeep Singh <kuldeep.singh@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Resolve NXP flexspi bindings compatibility warnings
Message-ID: <20210315065456.GM11246@dragon>
References: <20210309111425.3539755-1-kuldeep.singh@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309111425.3539755-1-kuldeep.singh@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 04:44:23PM +0530, Kuldeep Singh wrote:
> This patches series aim is to resolve NXP flexspi bindings compatibility
> warnings which were observed after running 'make dtbs_check' with
> https://lore.kernel.org/linux-devicetree/20210309103528.3538910-1-kuldeep.singh@nxp.com/
> patch applied.
> 
> Below error was observed:
> /opt/samba/nxf51654/spi/arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dt.yaml: spi@30bb0000: clock-names:0: 'fspi_en' was expected
> 	From schema: /opt/samba/nxf51654/spi/Documentation/devicetree/bindings/spi/nxp,spi-nxp-fspi.yaml
> /opt/samba/nxf51654/spi/arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dt.yaml: spi@30bb0000: clock-names:1: 'fspi' was expected
> 	From schema: /opt/samba/nxf51654/spi/Documentation/devicetree/bindings/spi/nxp,spi-nxp-fspi.yaml
> 
> Resolving above error may require reordering of flexspi clock-names entry.
> 
> Kuldeep Singh (2):
>   arm64: dts: imx8mm: Reorder flexspi clock-names entry
>   arm64: dts: imx8mn: Reorder flexspi clock-names entry

Applied both, thanks.
