Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF2E45B4F4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 08:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240431AbhKXHM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 02:12:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:40622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239430AbhKXHMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 02:12:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CDB4360555;
        Wed, 24 Nov 2021 07:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637737754;
        bh=69kVynZ61jQU4C3rHNZDi3O/Dmiy3PQKhpTzv4RKBX8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yVBs9ygMqDTl240JGLdj3fUMdEt+OSDD/wco9jtnX0M1g9oLWf+6/HVRMI9nSMmuC
         3JW6l8JGMauh3KfqA0C2h25AAm9LBkMyWmrloun+U8oZjgh3U1ywLBM8ZoHhZpSlF9
         iGbRK6mE4jJdpd/wFBAabi2ZLiaSYadIbDXXv/nU=
Date:   Wed, 24 Nov 2021 08:09:10 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH 1/3] staging: zynpu: Add driver support for ARM(China)
 ZHOUYI AI accelerator
Message-ID: <YZ3lFk+7+AqSX6d3@kroah.com>
References: <20211124065743.421-1-caihuoqing@baidu.com>
 <20211124065743.421-2-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124065743.421-2-caihuoqing@baidu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 02:57:38PM +0800, Cai Huoqing wrote:
> ZHOUYI NPU is an AI accelerator chip which is integrated into ARM SOC,
> such as Allwinner R329 SOC.
> Add driver support for this AI accelerator here.
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>  drivers/staging/Kconfig                   |   2 +
>  drivers/staging/Makefile                  |   1 +
>  drivers/staging/zynpu/Kconfig             |  34 +
>  drivers/staging/zynpu/Makefile            |   7 +
>  drivers/staging/zynpu/z1.c                | 233 ++++++
>  drivers/staging/zynpu/z2.c                | 297 ++++++++
>  drivers/staging/zynpu/zhouyi.h            |  70 ++
>  drivers/staging/zynpu/zhouyi_base.c       |  71 ++
>  drivers/staging/zynpu/zynpu.h             | 252 +++++++
>  drivers/staging/zynpu/zynpu_core.c        | 254 +++++++
>  drivers/staging/zynpu/zynpu_drv.c         | 349 +++++++++
>  drivers/staging/zynpu/zynpu_fops.c        | 245 +++++++
>  drivers/staging/zynpu/zynpu_io.c          | 133 ++++
>  drivers/staging/zynpu/zynpu_io.h          | 119 ++++
>  drivers/staging/zynpu/zynpu_irq.c         | 123 ++++
>  drivers/staging/zynpu/zynpu_irq.h         |  85 +++
>  drivers/staging/zynpu/zynpu_job_manager.c | 467 +++++++++++++
>  drivers/staging/zynpu/zynpu_job_manager.h | 200 ++++++
>  drivers/staging/zynpu/zynpu_mm.c          | 704 +++++++++++++++++++
>  drivers/staging/zynpu/zynpu_mm.h          | 142 ++++
>  drivers/staging/zynpu/zynpu_session.c     | 817 ++++++++++++++++++++++
>  drivers/staging/zynpu/zynpu_session.h     | 283 ++++++++
>  drivers/staging/zynpu/zynpu_sysfs.c       | 205 ++++++

All code added to drivers/staging/ needs a TODO file that lists what
needs to be done to get it out of the staging directory.

You do not explain in this changelog text why this code needs to go
here, and why it could just not go into the "real" part of the kernel
instead.  What is wrong with it that requires it to go here?

thanks,

greg k-h
