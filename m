Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942294143AE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 10:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbhIVIY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 04:24:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:57308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233349AbhIVIYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 04:24:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5FD9F611B0;
        Wed, 22 Sep 2021 08:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632299005;
        bh=3qFrPk5tPOeeoFRNNWLl5WTlrHUVrcVHnKBSIS7Ahag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TGkMRKtBsAoabrvl4nY02DcOFIyVaQ/qP9Z5MTWSe3RSySeQiDLzdbXyPmYEHvyb7
         4kcvLaExe978G7se2WdWBJPhs2SU8RSiC9dDjg0RhGL+2g+cYnvqu/DMcK6KE5+Go+
         DG9gV0S7MhNlOXT1UUr1VZJLhgiMr+UCkn1FsnTbTKIVL0pI06RAOZ8rGTD7bt18Bd
         261VtQ8yAG+HoTYT7KVpxymi1bPJynIWwyfMh+/Q/fL4yIiIku93mAYE9sKJfI4kRs
         bb9XOx9nKSYkWuHu4gYoY8fhWNnQwxjSA7OkbTiAvQZ9LE16wrupRUUYwHzNVe2v0Z
         ZUX/pwdM74fQQ==
Date:   Wed, 22 Sep 2021 16:23:20 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Yunus Bas <y.bas@phytec.de>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        festevam@gmail.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: imx6: phycore-som: Disable micro-SD write
 protection
Message-ID: <20210922082319.GJ13480@dragon>
References: <20210909172555.435430-1-y.bas@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909172555.435430-1-y.bas@phytec.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 07:25:55PM +0200, Yunus Bas wrote:
> The micro-SD card doesn't feature a write-protect pin. Set the
> corresponding property in the devicetree to handle this behavior
> correctly and suppress driver warnings.
> 
> Signed-off-by: Yunus Bas <y.bas@phytec.de>

Applied, thanks!
