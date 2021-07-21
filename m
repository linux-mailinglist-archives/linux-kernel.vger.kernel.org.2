Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 947773D0BED
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 12:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237611AbhGUIwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 04:52:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:60938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237977AbhGUIpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 04:45:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E87DF60231;
        Wed, 21 Jul 2021 09:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626859549;
        bh=yOJ5z3dKNV3+QchjXIKT3u7IgTGFQKf/v3HEvGwojAg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MFNEJy6+0KDma+GVnPxoqHG/SyR6bZYdr9N5GCoasKKLZ+3ZRPnrhd7YAq4qBl9dj
         yA2/lEXl51QkqvB9u9xzEv/IWu1qDifBaCmFAyodadwkTn9nTK9WabCUlfoC4ae/ua
         MGg6tEJI1ZgD931V/EOFH/GTajj7ZchxM5NWUdpM=
Date:   Wed, 21 Jul 2021 11:25:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Arnd Bergmann <arnd@arndb.de>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v14 5/9] staging: hi6421-spmi-pmic: cleanup drvdata
Message-ID: <YPfoGzCtS7sBFESm@kroah.com>
References: <cover.1626515862.git.mchehab+huawei@kernel.org>
 <723edefbb2e9ce0b70d9c7bce95f288e3ea1f5b1.1626515862.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <723edefbb2e9ce0b70d9c7bce95f288e3ea1f5b1.1626515862.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 17, 2021 at 11:58:16AM +0200, Mauro Carvalho Chehab wrote:
> There are lots of fields at struct hi6421_spmi_pmic that aren't
> used. In a matter of fact, only regmap is needed.
> 
> So, drop the struct as a hole, and set just the regmap as
> the drvdata.
> 
> While here, add a missing dot at the Huawei's copyrights.
> 
> Acked-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  drivers/misc/hi6421v600-irq.c               |  9 ++++----
>  drivers/regulator/hi6421v600-regulator.c    | 10 ++++-----
>  drivers/staging/hikey9xx/hi6421-spmi-pmic.c | 16 +++++--------
>  include/linux/mfd/hi6421-spmi-pmic.h        | 25 ---------------------
>  4 files changed, 14 insertions(+), 46 deletions(-)
>  delete mode 100644 include/linux/mfd/hi6421-spmi-pmic.h

This patch fails to apply to my 5.14-rc2 tree, it gets a failure in the
regulator portion of the patch.

thanks,

greg k-h
