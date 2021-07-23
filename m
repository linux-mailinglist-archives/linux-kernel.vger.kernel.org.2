Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37E813D3513
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 09:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234267AbhGWGb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 02:31:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234089AbhGWGbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 02:31:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4091C60EAF;
        Fri, 23 Jul 2021 07:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627024318;
        bh=4cmWsgvaQ+B4vevF2HapA88vFfJfmOjvq20U3Ou7mGA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kUDRNZKTItE1/fYQnjYaKoWrbOi4wakOPhIYWSJsFM5GAwjJigbnHCGBT+3Ru0e4Y
         3cposMt7EUmAg66ZSTzcJMqJbB5p4axadkobfBy0+4q+4VV2YKuJm/KWw0GlwcNqc6
         brlNSXfUiNvL6wcREpzBWxCH0uJdV3V6WpWbjcc7r9PcSnxLhnD9RbrwssKQPg/aRp
         HpaeXL4Nm5OU55tN/SRxpGW69Z9E4B35knLoYIR8hvM4zjvpDtSbnKx9cH/1aBInYN
         iGw1/+w5dCzkVZ+HKwyZTe3oM1qbHeXDjc1L7/tgDGGYMPB1e4Ms0wp4tmbGSU0GL/
         3tgJByuXElFaA==
Date:   Fri, 23 Jul 2021 15:11:54 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Kwon Tae-young <tykwon@m2i.co.kr>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mq-evk: Remove unnecessary blank lines
Message-ID: <20210723071153.GD30773@dragon>
References: <20210715070749.13552-1-tykwon@m2i.co.kr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715070749.13552-1-tykwon@m2i.co.kr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:07:49PM +0900, Kwon Tae-young wrote:
> Unnecessary blank lines do NOT help readability, so remove them.
> 
> Signed-off-by: Kwon Tae-young <tykwon@m2i.co.kr>

Applied, thanks!
