Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3858743321A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 11:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235030AbhJSJZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 05:25:33 -0400
Received: from foss.arm.com ([217.140.110.172]:46562 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235023AbhJSJZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 05:25:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3238ED1;
        Tue, 19 Oct 2021 02:23:12 -0700 (PDT)
Received: from bogus (unknown [10.57.25.56])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F9CD3F73D;
        Tue, 19 Oct 2021 02:23:11 -0700 (PDT)
Date:   Tue, 19 Oct 2021 10:23:08 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Mianhan Liu <liumh1@shanghaitech.edu.cn>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] drivers/base/arch_topology.c: remove superfluous
 header
Message-ID: <20211019092308.aldow6jmtx4jffb5@bogus>
References: <20210928193138.24192-1-liumh1@shanghaitech.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928193138.24192-1-liumh1@shanghaitech.edu.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 03:31:38AM +0800, Mianhan Liu wrote:
> arch_topology.c hasn't use any macro or function declared in linux/percpu.h,
> linux/smp.h and linux/string.h.
> Thus, these files can be removed from arch_topology.c safely without
> affecting the compilation of the drivers/base/ module
> 
> Signed-off-by: Mianhan Liu <liumh1@shanghaitech.edu.cn>
> 
> ---
>  drivers/base/arch_topology.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 434076659..92200873b 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -12,15 +12,12 @@
>  #include <linux/device.h>
>  #include <linux/of.h>
>  #include <linux/slab.h>
> -#include <linux/string.h>
>  #include <linux/sched/topology.h>
>  #include <linux/cpuset.h>
>  #include <linux/cpumask.h>
>  #include <linux/init.h>
> -#include <linux/percpu.h>

Don't you need linux/percpu-defs.h for DEFINE_PER_CPU then ?

-- 
Regards,
Sudeep
