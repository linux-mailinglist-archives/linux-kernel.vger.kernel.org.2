Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 161423096BF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 17:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbhA3Q2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 11:28:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:42648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231996AbhA3Oes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 09:34:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B3AC64D9D;
        Sat, 30 Jan 2021 14:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612017212;
        bh=2FJck57w/Ap9lWDCQ4s/1f+rEKej3z1hwhEfv9bDlng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h7EARsaKYLCbQ62o/+7eyiMH+x1sH/xvf+BRFOVwt09Mj3sTPK4DalwA5kO8akq9s
         0a10mlLT0Rq3AVOqcYv1HGXAepiqvTAX1MfiZEqZuCHX0wfZhexQ+PK3yUY2YD/ina
         vLCJknDgXbF91sdsNxoDACyAZyOnfAT1l2UNZGRxIClZYSFeW7X+IGMfoC638HJsM3
         hbSAkWva3jz0EH0VQdwzjBxxPUx+ggMlGcYuKYyVJ51fJN4LIkhD4p0cyPyEBcGM3V
         95zCvw7xWxk3FssLMzwnRycfhR5Ufuztr1HOcNN6h7e18m64+cwISGP/c2oOtDvha+
         by9aOkG/piJ0g==
Date:   Sat, 30 Jan 2021 22:33:27 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     m.felsch@pengutronix.de, krzk@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will@kernel.org
Subject: Re: [PATCH v6 1/3] dt-bindings: arm: imx: add imx8mm nitrogen support
Message-ID: <20210130143326.GO907@dragon>
References: <20210128193554.2496095-1-adrien.grassein@gmail.com>
 <20210128193554.2496095-2-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128193554.2496095-2-adrien.grassein@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 08:35:52PM +0100, Adrien Grassein wrote:
> The Nitrogen8M Mini is an ARM based single board computer (SBC).
> 
> Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied all 3, thanks.
