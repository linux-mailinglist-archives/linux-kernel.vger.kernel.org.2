Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F699312040
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 23:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbhBFWJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 17:09:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:45972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229522AbhBFWJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 17:09:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A07364E07;
        Sat,  6 Feb 2021 22:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612649313;
        bh=G5JO4wfHXL3Rm3mvu0w0aeD8DDbQuoaIoRiqsfnDaPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XbtQt5OnGfvRN0oSLrbIbC/GbwV/0N9hd/ry6uRLJxVaHq1T2aI2OuND401yhtESO
         aTb3Skn/gGZ5VZnPazyPsQxibt9cn99VdlmI9MYOqXJ1Y9r7jsFUQn1uVtwbF8sHkF
         D4Sn/hYWbmkmuHBHL3G0PYa/lulsZZP5OWKiP0zyVYhBtEdYwk5veDd2IyudM4aacB
         qdwUHFBNHpYcJB0WU/OpXOqEq1zscXClo2YDWrcl3bnVVs1DNbhpxDdHwyDibAZVjx
         NBf1ALrTM44Z66u1QnYVVPJURnQRCfhJ6j/UO3DgE0raAvwMrzVqAAcT6DGq1Av6Et
         92Hf0xTP7/O3w==
Date:   Sat, 6 Feb 2021 15:08:32 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Santosh Shilimkar <ssantosh@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] memory: ti-emif-pm: Drop of_match_ptr from of_device_id
 table
Message-ID: <20210206220832.GA1466025@ubuntu-m3-large-x86>
References: <20210206111343.19273-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210206111343.19273-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 06, 2021 at 12:13:43PM +0100, Krzysztof Kozlowski wrote:
> The driver can match only via the DT table so the table should be always
> used and the of_match_ptr does not have any sense (this also allows ACPI
> matching via PRP0001, even though it might be not relevant here).  This
> fixes compile warning (!CONFIG_OF with clang):
> 
>     drivers/memory/ti-emif-pm.c:238:34: warning:
>         unused variable 'ti_emif_of_match' [-Wunused-const-variable]
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Yes, this seems to be how everyone is dealing with this warning:

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  drivers/memory/ti-emif-pm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/memory/ti-emif-pm.c b/drivers/memory/ti-emif-pm.c
> index 6c747c1e98cb..179fec2da56d 100644
> --- a/drivers/memory/ti-emif-pm.c
> +++ b/drivers/memory/ti-emif-pm.c
> @@ -340,7 +340,7 @@ static struct platform_driver ti_emif_driver = {
>  	.remove = ti_emif_remove,
>  	.driver = {
>  		.name = KBUILD_MODNAME,
> -		.of_match_table = of_match_ptr(ti_emif_of_match),
> +		.of_match_table = ti_emif_of_match,
>  		.pm = &ti_emif_pm_ops,
>  	},
>  };
> -- 
> 2.25.1
> 
