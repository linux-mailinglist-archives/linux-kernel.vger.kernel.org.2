Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C183F7D48
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 22:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242649AbhHYUoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 16:44:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231873AbhHYUoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 16:44:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 12EAF61058;
        Wed, 25 Aug 2021 20:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629924215;
        bh=4oNPo3l/vty6k+TfUufw3+1KoqSnq8T8Db/CsKsDc9Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kZXHdOM1rueTqtqsBmROnb/V6wlREMaANn9uDYUnxNB+sgtXMsNDa1YfQHowJNK72
         IBfW7xJLIMvkEsqdnCfpQNV5x2H365mPeKcnkkyh5SW6/Iid2NIOJYqHg7xEPLxX51
         4rE2BSEpntAARCupS80J5UNXJ5T5IsInD4P/PKfc=
Date:   Wed, 25 Aug 2021 22:43:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fei Li <fei1.li@intel.com>
Cc:     linux-kernel@vger.kernel.org, yu1.wang@intel.com,
        shuox.liu@gmail.com
Subject: Re: [PATCH v2 1/3] virt: acrn: Introduce interfaces for MMIO device
 passthrough
Message-ID: <YSarcddFb5wNQ+LK@kroah.com>
References: <20210825090142.4418-1-fei1.li@intel.com>
 <20210825090142.4418-2-fei1.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825090142.4418-2-fei1.li@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 05:01:40PM +0800, Fei Li wrote:
> From: Shuo Liu <shuo.a.liu@intel.com>
> 
> MMIO device passthrough enables an OS in a virtual machine to directly
> access a MMIO device in the host. It promises almost the native
> performance, which is required in performance-critical scenarios of
> ACRN.
> 
> HSM provides the following ioctls:
>   - Assign - ACRN_IOCTL_ASSIGN_MMIODEV
>     Pass data struct acrn_mmiodev from userspace to the hypervisor, and
>     inform the hypervisor to assign a MMIO device to a User VM.
> 
>   - De-assign - ACRN_IOCTL_DEASSIGN_PCIDEV
>     Pass data struct acrn_mmiodev from userspace to the hypervisor, and
>     inform the hypervisor to de-assign a MMIO device from a User VM.
> 
> Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
> Signed-off-by: Fei Li <fei1.li@intel.com>

Where is the userspace code that uses this new api?

thanks,

greg k-h
