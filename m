Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423CD33FE0B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 05:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbhCREIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 00:08:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:37474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229454AbhCREHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 00:07:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B2EB964F10;
        Thu, 18 Mar 2021 04:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616040466;
        bh=6Z0+ws9wMVStoDerj/3Uu7pkXPXYhZ2EPZ/Tp7i5qCY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gnZ2CoOg7vKcTtb4Eppj2AEMIEfv6vwrj63dLljaa7d8uNWvjX53N7UdURpDmyETR
         YRPgIJV9Ja/y2MTVAHR95X8sjd1u9ITY5a1K1ESHOK6rmcwXa04wcE0pMQ0iuICFUo
         gMZ2I6tzjiDznTG36cCeu1MreYTTCc3xYPAMGWpK/blT5C12InPnjzAIGBdBWk45wk
         PW+vXE64uaZmSH3wfV5qzOhlegwDYrcR8DvTA3JZQhIlhY2fdz/XFRC3gawGafOqI0
         iGE4klG5GzJ06oy72pTCMaY7BZBH6LOazPjk73sEUyzexHQ2wcm4iEXGluQ8h6J/ef
         ReH6ejWhTbzZw==
Date:   Thu, 18 Mar 2021 12:07:40 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     dillon.minfei@gmail.com
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, parthiban@linumiz.com,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: imx6ull: fix ubi filesystem mount failed
Message-ID: <20210318040740.GX11246@dragon>
References: <1615995909-6240-1-git-send-email-dillon.minfei@gmail.com>
 <1615995909-6240-2-git-send-email-dillon.minfei@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615995909-6240-2-git-send-email-dillon.minfei@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 11:45:09PM +0800, dillon.minfei@gmail.com wrote:
> From: dillon min <dillon.minfei@gmail.com>
> 
> For NAND Ecc layout, there is a dependency from old kernel's nand driver
> setting and current. if old kernel use 4 bit ecc , we should use 4 bit
> in new kernel either. else will run into following error at filesystem
> mounting.
> 
> So, enable fsl,use-minimum-ecc from device tree, to fix this mismatch
> 
> [    9.449265] ubi0: scanning is finished
> [    9.463968] ubi0 warning: ubi_io_read: error -74 (ECC error) while reading
> 22528 bytes from PEB 513:4096, read only 22528 bytes, retry
> [    9.486940] ubi0 warning: ubi_io_read: error -74 (ECC error) while reading
> 22528 bytes from PEB 513:4096, read only 22528 bytes, retry
> [    9.509906] ubi0 warning: ubi_io_read: error -74 (ECC error) while reading
> 22528 bytes from PEB 513:4096, read only 22528 bytes, retry
> [    9.532845] ubi0 error: ubi_io_read: error -74 (ECC error) while reading
> 22528 bytes from PEB 513:4096, read 22528 bytes
> 
> Fixes: f9ecf10cb88c ("ARM: dts: imx6ull: add MYiR MYS-6ULX SBC")
> Signed-off-by: dillon min <dillon.minfei@gmail.com>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> Signed-off-by: Shawn Guo <shawnguo@kernel.org>

Replaced with this version.

Shawn
