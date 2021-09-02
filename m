Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 117393FF222
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 19:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346471AbhIBRPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 13:15:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:57880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234497AbhIBRPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 13:15:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C05761074;
        Thu,  2 Sep 2021 17:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630602891;
        bh=nHyqC71zNDZ60+fGD11mCVisc8kU7q2n+i+qp/g67Bw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k1RwT9uR0l8jtBz4UJcY5Ut34WGnR6BkBpXVAb5eyQc603aUSqfGqb52rs3FLPCZ0
         +0aBdJYsQTVJFENiPOEYM9i6/j+zrbkcoc0Wm5CdsDBo8o8D+Ir5etqZJUEvzUg7yT
         1uVjBrW2XltqrtBXTaYz9KYuxxqTsAmFR3VA1dCbX7cucbXw1NAhRM4nvJUitCEigC
         DBEgHYqld/AmDd7p0tqQzm0TBiDhGnsZ8vlo3haQ+yWqbe8JJjP73KUYYsKsB7CTBl
         3Z8+mgIrJPh4PZtgDxw84ialBl2FdkQsQ7OXJh7WzBpW5VePmJh6nXUx4EU+PmHGf9
         9J4YXTQgxCzDw==
Date:   Thu, 2 Sep 2021 20:14:44 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     linux-kernel@vger.kernel.org, vijayendra.suman@oracle.com,
        mlombard@redhat.com, pjones@redhat.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] iscsi_ibft: Fix isa_bus_to_virt not working under ARM
Message-ID: <YTEGhPnQkgOiOHf7@kernel.org>
References: <20210902140313.1555053-1-konrad.wilk@oracle.com>
 <20210902140313.1555053-2-konrad.wilk@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902140313.1555053-2-konrad.wilk@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021 at 02:03:13PM +0000, Konrad Rzeszutek Wilk wrote:
> The isa_bus_to_virt is only needed under X86 and in fact the code
> that sets the ibft_phys_addr is only compiled under X86.
> 
> As such lets just ifdef the code.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Vijayendra Suman <vijayendra.suman@oracle.com>
> CC: Maurizio Lombardi <mlombard@redhat.com>
> CC: Mike Rapoport <rppt@kernel.org>
> Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> ---
>  drivers/firmware/iscsi_ibft.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/firmware/iscsi_ibft.c b/drivers/firmware/iscsi_ibft.c
> index 612a59e213df..7cde1a7a3ab1 100644
> --- a/drivers/firmware/iscsi_ibft.c
> +++ b/drivers/firmware/iscsi_ibft.c
> @@ -86,7 +86,7 @@ MODULE_VERSION(IBFT_ISCSI_VERSION);
>  
>  static struct acpi_table_ibft *ibft_addr;
>  
> -#ifndef CONFIG_ISCSI_IBFT_FIND
> +#ifdef CONFIG_ISCSI_IBFT_FIND
>  phys_addr_t ibft_phys_addr;
>  #endif

I think this declaration should be removed after you added
acpi_find_ibft_region().

Before your changes we had ibft_phys_addr defined in iscsi_ibft_find.c for
CONFIG_ISCSI_IBFT_FIND=y and the declaration above was needed to avoid
compilation error in ibft_init().

With the only use of ibft_phys_addr hidden under #ifdef CONFIG_ISCSI_IBFT_FIND
this declaration actually hides ibft_phys_addr defined in
iscsi_ibft_find.c.

>  
> @@ -851,7 +851,21 @@ static void __init acpi_find_ibft_region(void)
>  {
>  }
>  #endif
> -
> +#ifdef CONFIG_ISCSI_IBFT_FIND
> +static int __init acpi_find_isa_region(void)
> +{
> +	if (ibft_phys_addr) {
> +		ibft_addr = isa_bus_to_virt(ibft_phys_addr);
> +		return 0;
> +	}
> +	return -ENODEV;
> +}
> +#else
> +static int __init acpi_find_isa_region(void)
> +{
> +	return -ENODEV;
> +}
> +#endif
>  /*
>   * ibft_init() - creates sysfs tree entries for the iBFT data.
>   */
> @@ -864,9 +878,7 @@ static int __init ibft_init(void)
>  	   is called before ACPI tables are parsed and it only does
>  	   legacy finding.
>  	*/
> -	if (ibft_phys_addr)
> -		ibft_addr = isa_bus_to_virt(ibft_phys_addr);
> -	else
> +	if (acpi_find_isa_region())
>  		acpi_find_ibft_region();
>  
>  	if (ibft_addr) {
> -- 
> 2.27.0
> 

-- 
Sincerely yours,
Mike.
