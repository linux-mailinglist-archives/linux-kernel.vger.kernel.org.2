Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38694140E6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 06:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbhIVE7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 00:59:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:42170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231526AbhIVE7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 00:59:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E8F27611B0;
        Wed, 22 Sep 2021 04:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632286671;
        bh=lkJ187UuFm+hUflqvAL12RME91Tld0y6sQHi7SZ4MPQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ewC5BXNFw/vQ4p/R8P4JtmYZ/6rzSntlvhJ/T55MbYOnr+rYWjM2vDkPyvm6K7dvn
         ptPQUH2/R9ol4NwQrJUQpdV63LeTXHtjF8XWPSykiclPqM3ZCAfXLd3jilKqU8US6W
         DZHY/gGrX5Nds5IIw39JRaU152fp49n29R+y9x20Bt6q7jaAqAIH17H3bwPNswiTl1
         n1I2J2WLvXO2LVAcxZydcfZ4ov4N+C5o28o5rL5lMbSPD+0ezZqz+dWDQOChnf57tq
         mvT1rDmmu31k3o1A3TJkKBXUTSLmESDZpkUfS3mfhSKf6f7w5jAOqrZXGMC13Exp8F
         cxxkh8moqewgg==
Date:   Wed, 22 Sep 2021 12:57:46 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: freescale: imx8mq-librem5: align
 operating-points table name with dtschema
Message-ID: <20210922045745.GM10217@dragon>
References: <20210820081557.83603-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820081557.83603-1-krzysztof.kozlowski@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 10:15:57AM +0200, Krzysztof Kozlowski wrote:
> Align the name of operating-points node to dtschema to fix warnings like:
> 
>   ddrc-opp-table: $nodename:0: 'ddrc-opp-table' does not match '^opp-table(-[a-z0-9]+)?$'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Applied, thanks!
