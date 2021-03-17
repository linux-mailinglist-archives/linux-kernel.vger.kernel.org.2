Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBC133F0D1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 14:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbhCQNAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 09:00:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:34962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230308AbhCQNAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 09:00:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A01F764F67;
        Wed, 17 Mar 2021 13:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615986033;
        bh=BYP0zb63pWh1HK9J4ylmQsUNitP2SanjDXwd4g62XzY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gr/AphFbw+RRIf6e4KJRErA9DFhYoctqKnHjSAbZMYIS4c2gfq6ufZg3G3YjIjB/W
         IcHIPYeXnuYd9Hof2W36t2EIWE2FSqNqL7rSPhNizhnau4I5pDcudEOSum85iAZBtP
         h5A2KNynb4vPsDm1yZeaFbJRFuglUHDY4x62gkhENKGh/wazfFxk1C/TYfY/Zg+KCp
         wnCZ/3mRTpFoeZM4oVKK73HIaODDR9YDDqm47i/MlWYYHt/GxbVkzp1dEWi5RhOpOG
         vXQXXMyeikHDR86PbbmcdZbhgDnPQAbirdIy4AmHKWa9u4btcxW6KqnWI3QJGmShKL
         phlrn4TghVR+Q==
Date:   Wed, 17 Mar 2021 21:00:28 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     dillon.minfei@gmail.com
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, parthiban@linumiz.com,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx6ull: fix ubi filesystem mount failed
Message-ID: <20210317130027.GV11246@dragon>
References: <1615270520-16951-1-git-send-email-dillon.minfei@gmail.com>
 <1615270520-16951-2-git-send-email-dillon.minfei@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615270520-16951-2-git-send-email-dillon.minfei@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 02:15:20PM +0800, dillon.minfei@gmail.com wrote:
> From: dillon min <dillon.minfei@gmail.com>
> 
> since Micron MT29F2G08ABAEAWP's ecc error management:
> 
> |Description           			| Requirement
> |Minimum required ECC  			| 4-bit ECC per 528 bytes
> |Minimum ECC with internal ECC enabled  | 4-bit ECC per 516 bytes (user data) +
>                                          8bytes (parity data)
> 
> to avoid unnecessary overheads related to bigger ecc calculations.
> need choose to use fsl,use-minimum-ecc, else will run into ecc error.
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

Applied, thanks.
