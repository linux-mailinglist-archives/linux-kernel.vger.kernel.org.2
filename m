Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 510AA3F862F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 13:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241886AbhHZLOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 07:14:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:56632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233961AbhHZLOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 07:14:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EB7716109F;
        Thu, 26 Aug 2021 11:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629976441;
        bh=R3+zOTYnzWSKqvKSLGGkpOD2vXvF+hXaLxX3Au6E5Ys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dv7IkdXaqE+okpU9nbnP0i0e7gbo51Zz29i8e75jBiPJclocGPZ03lfV2lCZmgGgG
         tVxN+H2CzUjQfDV7S8Cxn/OTdayHIuJ6NmR2jynJvlqeupxt3pXRoYYsnxYS8unXNi
         54qToR1du6dws/p3PBH+O/cd3ZIhnsNnBqBzmXew=
Date:   Thu, 26 Aug 2021 13:13:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
Cc:     balbi@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, kun.liu2@amd.com,
        alexander.deucher@amd.com
Subject: Re: [RESEND PATCH 2/2] usb: dwc3: pci add property to allow user
 space role switch
Message-ID: <YSd3c/57V0/xpLYq@kroah.com>
References: <20210824192337.3100288-1-Nehal-Bakulchandra.shah@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824192337.3100288-1-Nehal-Bakulchandra.shah@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 12:53:37AM +0530, Nehal Bakulchandra Shah wrote:
> For AMD platform there is a requirement to enable user space role
> switch from host to device and device to host as customer platform is not
> completely capable of OTG i.e. with type C controller it does not have PD
> to support role switching. Hence, based ACPI/EC interrupt role switch is
> triggered by the usemode script running in background.
> 
> Signed-off-by: Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
> ---
>  drivers/usb/dwc3/drd.c      | 2 ++
>  drivers/usb/dwc3/dwc3-pci.c | 1 +
>  2 files changed, 3 insertions(+)

Why is just patch 2/2 resent?

confused,

greg k-h
