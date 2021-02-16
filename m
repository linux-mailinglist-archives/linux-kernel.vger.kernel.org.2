Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E0D31CF8B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 18:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbhBPRsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 12:48:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:37090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231322AbhBPRr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 12:47:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B80364E04;
        Tue, 16 Feb 2021 17:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613497606;
        bh=cyWmo2IWHz6XqlAutw5VL0hTTQ/Ovvrs0LDQkd9uUmI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QSxI3viB0aH5Ccqfh5i+x+/nu+dfBHFZoK1THv+wMqsEZFVe0Jp83ooMfBsZyNLwX
         +pWHY4kn/l2QwaKoI2yAYIZBiAV6jlm4Qy5QaAzLbs/NAXqgEEx+o81mE5Hy7rRnNx
         v166mEDPC+oP+3blR7/P5nCyfHJEZMTlYCcnZUks=
Date:   Tue, 16 Feb 2021 18:46:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Tomasz Jankowski <tomasz1.jankowski@intel.com>,
        Savo Novakovic <savox.novakovic@intel.com>,
        Jianxun Zhang <jianxun.zhang@linux.intel.com>
Subject: Re: [PATCH v1 01/12] gna: add driver module
Message-ID: <YCwFBNa2npYcEIQ+@kroah.com>
References: <20210216160525.5028-1-maciej.kwapulinski@linux.intel.com>
 <20210216160525.5028-2-maciej.kwapulinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210216160525.5028-2-maciej.kwapulinski@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 05:05:14PM +0100, Maciej Kwapulinski wrote:
> --- /dev/null
> +++ b/drivers/misc/gna/gna_driver.c
> @@ -0,0 +1,65 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright(c) 2017-2021 Intel Corporation
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME " " fmt

You are a driver, you should never need a pr_* call, so this should not
be needed.  You should always just use dev_* instead.

> --- /dev/null
> +++ b/drivers/misc/gna/gna_driver.h
> @@ -0,0 +1,41 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright(c) 2017-2021 Intel Corporation */
> +
> +#ifndef __GNA_DRIVER_H__
> +#define __GNA_DRIVER_H__
> +
> +#include <linux/kernel.h>
> +#include <linux/mutex.h>
> +#include <linux/types.h>
> +
> +#define GNA_DRV_NAME	"gna"

Way too generic, no one knows what "gna" is.

> +#define GNA_DRV_VER	"1.2.0"

As Andy said, this means nothing within the kernel (or really, outside
the kernel either), so please drop.

> +
> +#define GNA_MAX_DEVICES		16

Why 16?

And if that's all, then just use the misc device api, that saves you so
much overhead and mess and you don't have to worry about sysfs and
classes or anything like that at all.

thanks,

greg k-h
