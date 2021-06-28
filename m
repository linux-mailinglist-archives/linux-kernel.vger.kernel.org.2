Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 950563B65AC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 17:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236013AbhF1Pde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 11:33:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:39694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235907AbhF1PH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 11:07:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2035061206;
        Mon, 28 Jun 2021 14:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624892055;
        bh=/c6iu5WfXHrHMg2iHXxJCvUhPZ5Ltwmg43YDMEHHhms=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wl5r73Lz+qhMKIksyfSe6Ryt7bvj3NhSo7lQSAt+hvGs69P5CL+PqJqN8Pg33w101
         Pilf1iA7uPnDpXDsYCXm34HS9/peuHvLuGMwHTxI37WU1J/VpVlXF0uXjRmafzTA2r
         obu4bEr4ZTCj0Bi6uiMTOf9WZ+p5Iyf5g8+JenkI=
Date:   Mon, 28 Jun 2021 16:54:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Eric Auger <eric.auger@redhat.com>
Cc:     eric.auger.pro@gmail.com, linux-kernel@vger.kernel.org,
        mihai.carabas@oracle.com, arnd@arndb.de, pizhenwei@bytedance.com,
        andriy.shevchenko@linux.intel.com, pbonzini@redhat.com,
        joe@perches.com
Subject: Re: [PATCH] misc/pvpanic-pci: Allow automatic loading
Message-ID: <YNnilZ/Kg4SpU+bw@kroah.com>
References: <20210628144422.895526-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628144422.895526-1-eric.auger@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 04:44:22PM +0200, Eric Auger wrote:
> The pvpanic-pci driver does not auto-load and requires manual
> modprobe. Let's include a device database using the
> MODULE_DEVICE_TABLE macro.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  drivers/misc/pvpanic/pvpanic-pci.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/misc/pvpanic/pvpanic-pci.c b/drivers/misc/pvpanic/pvpanic-pci.c
> index 9ecc4e8559d5d..30290d42d8aa8 100644
> --- a/drivers/misc/pvpanic/pvpanic-pci.c
> +++ b/drivers/misc/pvpanic/pvpanic-pci.c
> @@ -122,4 +122,6 @@ static struct pci_driver pvpanic_pci_driver = {
>  	},
>  };
>  
> +MODULE_DEVICE_TABLE(pci, pvpanic_pci_id_tbl);
> +

Is this something that you need?  Or is it created by a tool?

thanks,

greg k-h
