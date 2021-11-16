Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 113C04534C1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 15:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237732AbhKPPCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 10:02:15 -0500
Received: from todd.t-8ch.de ([159.69.126.157]:35453 "EHLO todd.t-8ch.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233685AbhKPPCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 10:02:12 -0500
Date:   Tue, 16 Nov 2021 15:59:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1637074752;
        bh=cb2OUIDphqHIt9Wszcy0dU6ogQaVy9OblEb3njsk/BA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B5PlIfWp5E08QiHGOMYxCuLCDfYIbCPJj9eaWw0rLFxzA7H9i21vDwkA0gIAt3OyX
         S96NinLjfE/a4cPxwZffSsOdNJllUyN1EQrpwBkYWzBRbafCNRsP52kPJBbFjDfkKs
         CcrSv9y00pONx+RkgMvF1gflACpgp/j6Edjvcj+E=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH] xen/privcmd: make option visible in Kconfig
Message-ID: <aa39e0f1-77cb-48f9-ae52-2bdbc19fa702@t-8ch.de>
References: <20211116143323.18866-1-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211116143323.18866-1-jgross@suse.com>
Jabber-ID: thomas@t-8ch.de
X-Accept: text/plain, text/html;q=0.2, text/*;q=0.1
X-Accept-Language: en-us, en;q=0.8, de-de;q=0.7, de;q=0.6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks!

On 2021-11-16 15:33+0100, Juergen Gross wrote:
> This configuration option provides a misc device as an API to userspace.
> Make this API usable without having to select the module as a transitive
> dependency.
> 
> This also fixes an issue where localyesconfig would select
> CONFIG_XEN_PRIVCMD=m because it was not visible and defaulted to
> building as module.
> 
> Based-on-patch-by: Thomas Weißschuh <linux@weissschuh.net>
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  drivers/xen/Kconfig | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
> index a1b11c62da9e..a2e91d3ca372 100644
> --- a/drivers/xen/Kconfig
> +++ b/drivers/xen/Kconfig
> @@ -259,9 +259,14 @@ config XEN_SCSI_BACKEND
>  	  if guests need generic access to SCSI devices.
>  
>  config XEN_PRIVCMD
> -	tristate
> +	tristate "Xen hypercall passthrough driver"
>  	depends on XEN
>  	default m
> +	help
> +	  The hypercall passthrough driver allows user land programs to perform
> +	  Xen hypercalls. This driver is normally required for systems running
> +	  as Dom0 to perform privileged operations, but in some disaggregated
> +	  Xen setups this driver might be needed for other domains, too.
>  
>  config XEN_ACPI_PROCESSOR
>  	tristate "Xen ACPI processor"
> -- 
> 2.26.2

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
