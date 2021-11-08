Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB16D447B60
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 08:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236643AbhKHHwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 02:52:54 -0500
Received: from muru.com ([72.249.23.125]:53864 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234554AbhKHHwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 02:52:53 -0500
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 1120C80E4;
        Mon,  8 Nov 2021 07:50:45 +0000 (UTC)
Date:   Mon, 8 Nov 2021 09:50:07 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Santosh Shilimkar <ssantosh@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Dave Gerlach <d-gerlach@ti.com>, soc@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Lee Jones <lee.jones@linaro.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] soc: ti: fix wkup_m3_rproc_boot_thread return type
Message-ID: <YYjWr6mALJvwJp0H@atomide.com>
References: <20211105075119.2327190-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211105075119.2327190-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Arnd Bergmann <arnd@kernel.org> [211105 07:52]:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The wkup_m3_rproc_boot_thread() function uses a nonstandard prototype,
> which broke after Eric's recent cleanup:
> 
> drivers/soc/ti/wkup_m3_ipc.c: In function 'wkup_m3_rproc_boot_thread':
> drivers/soc/ti/wkup_m3_ipc.c:429:16: error: 'return' with a value, in function returning void [-Werror=return-type]
>   429 |         return 0;
>       |                ^
> drivers/soc/ti/wkup_m3_ipc.c:416:13: note: declared here
>   416 | static void wkup_m3_rproc_boot_thread(struct wkup_m3_ipc *m3_ipc)
>       |             ^~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Change it to the normal prototype as it should have been from the
> start.

Thanks

Acked-by: Tony Lindgren <tony@atomide.com>
