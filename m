Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B73683D31ED
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 04:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbhGWB57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 21:57:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:42380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231663AbhGWB56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 21:57:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8296A60EB5;
        Fri, 23 Jul 2021 02:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627007913;
        bh=+3NaWAo1tTtvbezkzEY0NGs/I19agbA+vy6yZHm58Jc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xe/zXZ5dIL3KSka6FMdS8W1jMn51I9Ot7RYKPu9Ey+NTa39BsmVD6EIwM+yTjA9Gv
         8aRPC7soLVRCDeRRHBQuPXRFEVVLwoxGKmfA0W6rVjYs5Me5oFvX50G+MaU99WS3we
         jvvdEMkZNqLL2lKfHLKb4Hpu+sO/erUEXJSuKndzDE9+HUr+7un1l+rk70ULey1iXh
         1D1JXZOP8s4agDlC1KGClW/9wf9UrGA4csGky5myDNVcWpFSawNxxl5KYH+XoQkzpT
         uqW1pnnGrFpqaRCcrKqb/6Y97PBu7fM/0R5Yym5CtgnEbJLGtyh749fx2MRMPaJoIi
         oG2xJGerLHvow==
Date:   Fri, 23 Jul 2021 10:38:28 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx6qdl-gw5904: atecc508a support
Message-ID: <20210723023827.GB28658@dragon>
References: <20210701180633.4905-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210701180633.4905-1-tharvey@gateworks.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2021 at 11:06:33AM -0700, Tim Harvey wrote:
> Add one node for the Atmel ATECC508A 'CryptoAuthentication' i2c device.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks!
