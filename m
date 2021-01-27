Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 727983058DE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 11:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235744AbhA0KyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 05:54:05 -0500
Received: from foss.arm.com ([217.140.110.172]:38536 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236011AbhA0Kto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 05:49:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 175D531B;
        Wed, 27 Jan 2021 02:48:59 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 157943F66B;
        Wed, 27 Jan 2021 02:48:57 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Yue Hu <zbestahu@gmail.com>, thara.gopinath@linaro.org,
        peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, huyue2@yulong.com,
        zhangwen@yulong.com, zbestahu@163.com
Subject: Re: [PATCH] init/Kconfig: correct thermal pressure retrieve API
In-Reply-To: <20210127054451.1240-1-zbestahu@gmail.com>
References: <20210127054451.1240-1-zbestahu@gmail.com>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Wed, 27 Jan 2021 10:48:49 +0000
Message-ID: <jhjr1m61wq6.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/21 13:44, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
>
> We're using arch_scale_thermal_pressure() to retrieve per CPU thermal
> pressure.
>
> Signed-off-by: Yue Hu <huyue2@yulong.com>

Whoever wrote that clearly got "arch" and "topology" mixed up!

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

> ---
>  init/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/init/Kconfig b/init/Kconfig
> index c4e0a7e..5b35e15 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -525,7 +525,7 @@ config SCHED_THERMAL_PRESSURE
>         i.e. put less load on throttled CPUs than on non/less throttled ones.
>
>         This requires the architecture to implement
> -	  arch_set_thermal_pressure() and arch_get_thermal_pressure().
> +	  arch_set_thermal_pressure() and arch_scale_thermal_pressure().
>
>  config BSD_PROCESS_ACCT
>       bool "BSD Process Accounting"
> --
> 1.9.1
