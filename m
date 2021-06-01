Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15591396C96
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 07:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbhFAFCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 01:02:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:50222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230170AbhFAFCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 01:02:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE38E6102A;
        Tue,  1 Jun 2021 05:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622523663;
        bh=kNdCmu0Ne4ouGWs+tyMNaaXD0+25jXNACguOyM29hAI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EGio6xOpGKUO5Y/1X6sQnHGqI+BMLW7JuVUrp5hDecSYs4J/upZ4xeEQtwUFI5coR
         evkq7WAvgRwpJmBPzUTjeFVgiiwW8qo2k5WPR37bLI5YgCKbLdGcSZWHSpea9wyF5m
         3zhYgaJav2C/DNz2N8QtYiX4BbHnKvNTkthdGwi4=
Date:   Tue, 1 Jun 2021 07:01:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        song.bao.hua@hisilicon.com, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/2] drivers/base/node.c: use bin_attribute to avoid buff
 overflow
Message-ID: <YLW/DZBYOcYxzRaK@kroah.com>
References: <1622516210-10886-1-git-send-email-tiantao6@hisilicon.com>
 <1622516210-10886-3-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622516210-10886-3-git-send-email-tiantao6@hisilicon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 10:56:50AM +0800, Tian Tao wrote:
> Reading sys/devices/system/cpu/cpuX/nodeX/ returns cpumap and cpulist.
> However, the size of this file is limited to PAGE_SIZE because of the
> limitation for sysfs attribute. so we use bin_attribute instead of
> attribute to avoid NR_CPUS too big to cause buff overflow.
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> ---
>  drivers/base/node.c | 49 +++++++++++++++++++++++++++++++------------------
>  1 file changed, 31 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index f449dbb..a19be64 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -27,42 +27,42 @@ static struct bus_type node_subsys = {
>  };
>  
>  
> -static ssize_t node_read_cpumap(struct device *dev, bool list, char *buf)
> +static ssize_t node_read_cpumap(struct kobject *kobj, bool list,

Why not stick with the dev pointer here?  These are devices, please use
them.

thanks,

greg k-h
