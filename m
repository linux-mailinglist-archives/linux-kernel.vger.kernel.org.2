Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A67C3CF813
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 12:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237496AbhGTKAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 06:00:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:33110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236934AbhGTJ6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 05:58:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F12A161003;
        Tue, 20 Jul 2021 10:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626777562;
        bh=QsGGuhGelyCCU/3mYQaWcENxQAWsM9ZlixOi0YUBtIc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NM49mNV6MLw5L/sDiP4oYyKqWayF2KFJu7IKnInh+5EaprnUq3622/Qb5fs/QEH/z
         V+OtS2mlcbDBPsyqc18osQuceZO3GzoQjZeRUtweGSRw+3PkD4NtQxMMsEw2i38jXc
         +jlltWTrstWXh0FRhlKsvg6eEnY5oqFyzorozaXg=
Date:   Tue, 20 Jul 2021 12:39:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jorgen Hansen <jhansen@vmware.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, pv-drivers@vmware.com
Subject: Re: [PATCH] MAINTAINERS: Update for VMCI driver
Message-ID: <YPan14jucU9/u6JL@kroah.com>
References: <1626776941-9163-1-git-send-email-jhansen@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626776941-9163-1-git-send-email-jhansen@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2021 at 03:29:01AM -0700, Jorgen Hansen wrote:
> Add maintainer info for the VMware VMCI driver.
> 
> Signed-off-by: Jorgen Hansen <jhansen@vmware.com>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a61f4f3..7e7c6fa 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19792,6 +19792,14 @@ L:	netdev@vger.kernel.org
>  S:	Supported
>  F:	drivers/ptp/ptp_vmw.c
>  
> +VMWARE VMCI DRIVER
> +M:	Jorgen Hansen <jhansen@vmware.com>
> +M:	Vishnu Dasa <vdasa@vmware.com>
> +M:	"VMware, Inc." <pv-drivers@vmware.com>

Please do not use generic aliases as they provide no personal
responsibility.  Just stick with real people.

Also I would need an ack from Vishnu.

thanks,

greg k-h
