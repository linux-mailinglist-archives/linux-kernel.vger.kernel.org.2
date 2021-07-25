Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22EF93D4D03
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 11:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbhGYJNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 05:13:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:55728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230305AbhGYJM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 05:12:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 775FA60EB4;
        Sun, 25 Jul 2021 09:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627206810;
        bh=0S5mWKS0YE49dox05634DpEBe3LWGbAlibIkWC4I1Gg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lR/dgZDaAzJhrlzuBwuNvpeBE4nL0O7SwDDAu6rs0nTpn1qZEYJXmDzGlXiIJkSPi
         DEUw9XRrshACWRfm2NN+eObQOA1mI0yECh4j6vL0g937TVrxPAFKz0YkzaLvaT0fp3
         pnIqeT+ksyE4lvJlxwsLHrxLLdA2l6EPkdDNpw4OXahbwQ98vViyQuxeoQkxQaHLjy
         Q6sRvkKKrCT1QTL/rg+jvL0VggyW1G9mMEZssChTBjfJd94JWLFGqNM5/b81t0nwFu
         6VaUZIPmQfH5aIPeZe+giBPVpRNS6YwCRbQw4XZdNAmlpPurDgUKZjsxssLoV6BW+C
         gWfE2It+7QmQA==
Date:   Sun, 25 Jul 2021 12:53:26 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jorgen Hansen <jhansen@vmware.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, pv-drivers@vmware.com,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v2] MAINTAINERS: Update for VMCI driver
Message-ID: <YP00lgKjIJ6tO0tw@unreal>
References: <1626861766-11115-1-git-send-email-jhansen@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626861766-11115-1-git-send-email-jhansen@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 03:02:46AM -0700, Jorgen Hansen wrote:
> Add maintainer info for the VMware VMCI driver.
> 
> v2: moved pv-drivers to L: as private list

Please put changelog under "---".
There is no value to see vXXX in the final commit in the repo.

Thanks

> 
> Acked-by: Vishnu Dasa <vdasa@vmware.com>
> Signed-off-by: Jorgen Hansen <jhansen@vmware.com>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a61f4f3..969a67a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19792,6 +19792,14 @@ L:	netdev@vger.kernel.org
>  S:	Supported
>  F:	drivers/ptp/ptp_vmw.c
>  
> +VMWARE VMCI DRIVER
> +M:	Jorgen Hansen <jhansen@vmware.com>
> +M:	Vishnu Dasa <vdasa@vmware.com>
> +L:	linux-kernel@vger.kernel.org
> +L:	pv-drivers@vmware.com (private)
> +S:	Maintained
> +F:	drivers/misc/vmw_vmci/
> +
>  VMWARE VMMOUSE SUBDRIVER
>  M:	"VMware Graphics" <linux-graphics-maintainer@vmware.com>
>  M:	"VMware, Inc." <pv-drivers@vmware.com>
> -- 
> 2.6.2
> 
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
