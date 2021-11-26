Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3760245F156
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 17:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354808AbhKZQNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 11:13:34 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:59152 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbhKZQLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 11:11:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B603622BA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 16:08:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83405C93056;
        Fri, 26 Nov 2021 16:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637942898;
        bh=ldZ57wYv4qTm/b/OZ2H3dnpsDTz+mhkCO8xGuQiSWOY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZVFabhiBa2Zk6NVx8vxlRw0Qc1wp8ozgDLh6R6neq7xcCMCQJ/ap/u/TcA/EE3E6u
         AH0AhlsRBgkU/SkxP4xEnoDj0zfjY7bKlZa4H2Qnwa96vyOBSK3KE3i0w1BVMtsPDQ
         +dXa+WJmVxiOVEWBjy16iAFLzxF+tDrfLS/Vmm70=
Date:   Fri, 26 Nov 2021 17:08:16 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: [PATCH 1/2] kobject: don't delay to cleanup module kobject
Message-ID: <YaEGcEoCqVHwGEZH@kroah.com>
References: <20211105063710.4092936-1-ming.lei@redhat.com>
 <20211105063710.4092936-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211105063710.4092936-2-ming.lei@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021 at 02:37:09PM +0800, Ming Lei wrote:
> CONFIG_DEBUG_KOBJECT_RELEASE is used for debugging kobject release/cleanup
> issue. The module kobject is released after module_exit() returns. If
> this kobject is delayed too much, and may cause other kobject's
> cleaned up a bit earlier before freeing module, then real issue is
> hidden.
> 
> So don't delay module kobject's cleanup, meantime module kobject is
> always cleaned up synchronously, and we needn't module kobject's
> cleanup.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  lib/kobject.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/lib/kobject.c b/lib/kobject.c
> index ea53b30cf483..4c0dbe11be3d 100644
> --- a/lib/kobject.c
> +++ b/lib/kobject.c
> @@ -16,6 +16,7 @@
>  #include <linux/stat.h>
>  #include <linux/slab.h>
>  #include <linux/random.h>
> +#include <linux/module.h>
>  
>  /**
>   * kobject_namespace() - Return @kobj's namespace tag.
> @@ -727,6 +728,10 @@ static void kobject_release(struct kref *kref)
>  	struct kobject *kobj = container_of(kref, struct kobject, kref);
>  #ifdef CONFIG_DEBUG_KOBJECT_RELEASE
>  	unsigned long delay = HZ + HZ * (get_random_int() & 0x3);
> +
> +	if (kobj->ktype == &module_ktype)
> +		delay = 0;

No, there should not be anything "special" about module kobjects to get
this kind of treatment.  They should work like any other kobject and
clean up properly when needed.

thanks,

greg k-h
