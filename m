Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 641A43B923E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 15:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbhGAN3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 09:29:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:40034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230005AbhGAN3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 09:29:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B692261417;
        Thu,  1 Jul 2021 13:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625145995;
        bh=KE08IZ7N2zGxao9rEaDNwWtGrUCeXJ7OIw+RZIM0zO0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GoA8R/OrX31Xp7phjzlnKyn5dy9p8dTsHF2AL0FSbKKDcVIdrPJKWfNv24hD1ZNjd
         pz055uJeRm05yW2OKnly9+QykHCAkpTcYhSnlUliWCVrRryWgzx4jILXXZ2RvJCWYA
         XPvVgUM0wlpJN7YJV0kMX3gnKSSckNAcNHibVu12NSDu5HKUOXSOyfmvFSaLF5rwsy
         l5/eU8zAHlS77ouQ8CUTTRNQl370GKHC4Le1OX5mTJc1LdEhN2bUk+u75Np4JClWYZ
         upnerC74FpqaLdnXGH3GnaKf9k5zPpuWv8Ipy+/7ystk6in6Ah0lmeMfk48EYNLa4o
         ck8m4gHpSZS4Q==
Date:   Thu, 1 Jul 2021 15:26:29 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxarm@huawei.com, mauro.chehab@huawei.com,
        linux-phy@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-usb@vger.kernel.org,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: repair reference in USB IP DRIVER FOR
 HISILICON KIRIN 970
Message-ID: <20210701152629.66a47fe2@coco.lan>
In-Reply-To: <20210701093903.28733-1-lukas.bulwahn@gmail.com>
References: <20210701093903.28733-1-lukas.bulwahn@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu,  1 Jul 2021 11:39:03 +0200
Lukas Bulwahn <lukas.bulwahn@gmail.com> escreveu:

> Commit 8de6b7edd493 ("phy: phy-hi3670-usb3: move driver from staging into
> phy") moves phy-hi3670-usb3.c from ./drivers/staging/hikey9xx/ to
> ./drivers/phy/hisilicon/, but the new file entry in MAINTAINERS refers to
> ./drivers/phy/hisilicon/phy-kirin970-usb3.c.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains:
> 
>   warning: no file matches  F:  drivers/phy/hisilicon/phy-kirin970-usb3.c
> 
> Repair the file entry by referring to the right location.
> 
> Fixes: 8de6b7edd493 ("phy: phy-hi3670-usb3: move driver from staging into phy")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> applies cleanly on next-20210701
> 
> Mauro, please ack.

Acked-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> Greg, please pick this non-urgent minor fix on top of commit 8de6b7edd493
> 
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 66d047dc6880..a4e0c20b416a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19153,7 +19153,7 @@ M:	Mauro Carvalho Chehab <mchehab@kernel.org>
>  L:	linux-usb@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/phy/hisilicon,hi3670-usb3.yaml
> -F:	drivers/phy/hisilicon/phy-kirin970-usb3.c
> +F:	drivers/phy/hisilicon/phy-hi3670-usb3.c
>  
>  USB ISP116X DRIVER
>  M:	Olav Kongas <ok@artecdesign.ee>



Thanks,
Mauro
