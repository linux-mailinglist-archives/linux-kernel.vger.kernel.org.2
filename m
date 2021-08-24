Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD3D3F55DC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 04:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbhHXCc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 22:32:27 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:52262 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230141AbhHXCcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 22:32:25 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UlRzlif_1629772289;
Received: from B-X3VXMD6M-2058.local(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0UlRzlif_1629772289)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 24 Aug 2021 10:31:29 +0800
Subject: Re: [PATCH] x86/kdump: fix wrong judge about crash_size var
From:   Xin Hao <xhao@linux.alibaba.com>
To:     tglx@linutronix.de
Cc:     mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20210813071252.90278-1-xhao@linux.alibaba.com>
Message-ID: <88a2ca7b-9335-33c4-37f7-8f0de2c56114@linux.alibaba.com>
Date:   Tue, 24 Aug 2021 10:31:28 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210813071252.90278-1-xhao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,  everyone:

     Why nobody review this patch?

在 2021/8/13 下午3:12, Xin Hao 写道:
> The type of crash_size is unsigned long long, so
> it can not be less than 0, so there fix it.
>
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> ---
>   arch/x86/kernel/setup.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index bff3a784aec5..95b80ec11741 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -472,11 +472,11 @@ static void __init reserve_crashkernel(void)
>
>   	/* crashkernel=XM */
>   	ret = parse_crashkernel(boot_command_line, total_mem, &crash_size, &crash_base);
> -	if (ret != 0 || crash_size <= 0) {
> +	if (ret != 0 || !crash_size) {
>   		/* crashkernel=X,high */
>   		ret = parse_crashkernel_high(boot_command_line, total_mem,
>   					     &crash_size, &crash_base);
> -		if (ret != 0 || crash_size <= 0)
> +		if (ret != 0 || !crash_size)
>   			return;
>   		high = true;
>   	}
> --
> 2.31.0

-- 
Best Regards!
Xin Hao

