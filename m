Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2B8840F6C9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 13:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241796AbhIQLjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 07:39:12 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47908 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbhIQLjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 07:39:11 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1168D2240C;
        Fri, 17 Sep 2021 11:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631878669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SQB9ReDsWcAW6c6xO34NLxaVIimCX4Je9qMztzCxImE=;
        b=ffbJBmLbHPTQENqnZzxWmP3NFWGbJjhrzedRGqQMvrjFfBkd1c6kxCjA6KM83tsNyGbI/F
        eM3C2+cNpfU06bSkbs3YvDYfgJQDzGumhuaPeqA/QS1in8jwIDDVxj71GRuriotrm/CC3+
        mvGjbX77sKK3SKau7nApfZi0n7Lme84=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631878669;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SQB9ReDsWcAW6c6xO34NLxaVIimCX4Je9qMztzCxImE=;
        b=EsV4TflTERD/i18XAnA2bDdwd66+0geoozLzhlAO/9p+HbO9IZg9Kh4q1BgkJNYPfebJFW
        aSDPsnbbGiX0N0DA==
Received: from lion.mk-sys.cz (unknown [10.100.200.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 02BF4A3B81;
        Fri, 17 Sep 2021 11:37:49 +0000 (UTC)
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
        id D80CB603FA; Fri, 17 Sep 2021 13:37:48 +0200 (CEST)
Date:   Fri, 17 Sep 2021 13:37:48 +0200
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] nvmem: nintendo-otp: add dependency on CONFIG_HAS_IOMEM
Message-ID: <20210917113748.aula2xsiih5wsjdq@lion.mk-sys.cz>
References: <694766b15cfa3759e3686145417952d320029390.1631877302.git.mkubecek@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <694766b15cfa3759e3686145417952d320029390.1631877302.git.mkubecek@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 01:20:18PM +0200, Michal Kubecek wrote:
> Function nintendo_otp_probe() calls devm_ioremap_resource() which is only
> available if CONFIG_HAS_IOMEM is enabled. Add a kconfig dependency like
> other similar drivers have.
> 
> Fixes: 3683b761fe3a ("nvmem: nintendo-otp: Add new driver for the Wii and Wii U OTP")
> Signed-off-by: Michal Kubecek <mkubecek@suse.cz>

A note: the build failure was already reported in

  https://lore.kernel.org/all/202108250657.h5CWR7Xf-lkp@intel.com/

Michal

> ---
>  drivers/nvmem/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> index 39854d43758b..fb4005df86c0 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -108,6 +108,7 @@ config MTK_EFUSE
>  	  will be called efuse-mtk.
>  
>  config NVMEM_NINTENDO_OTP
> +	depends on HAS_IOMEM
>  	tristate "Nintendo Wii and Wii U OTP Support"
>  	help
>  	  This is a driver exposing the OTP of a Nintendo Wii or Wii U console.
> -- 
> 2.33.0
> 
