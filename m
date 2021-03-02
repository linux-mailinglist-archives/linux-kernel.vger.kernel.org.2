Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2198E32AD83
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1837828AbhCBV7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 16:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1835346AbhCBTCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 14:02:52 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA71C06178C
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 11:01:15 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id 201so14442534pfw.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 11:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:newsgroups:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wht29kUAgkDTBmrHaW1q6XJ3NXEO35xEuxud/bR3ziE=;
        b=AZrrmzliYKd1I2bdE1uPjy6MzgCQYn94j+rrwAbHdfT3faZtrRh0wbfaDLNVvtb2qt
         nQaiXureHZxB8+QeqHQXy2X7UiCopVHmJxQd0Tq3jOiFpt3isgYaVZq9xWfn+jY/wrt+
         DJEd6A/bDeZbMJCIigCLzlZA7nHZE2PDIcYqQlcakuxPG+BwYeuA6EbVTkdEuhxJ8q06
         2z/6QTTRESwT3FwsLoeLM1YJFu0fQXoDnhpa7nWKycx9Ky5khf3L7OC7/+uqguXUNSyD
         OF5RABsitB65mU1xlpVZSuBxZCuPJj0w4FEnC4ZR/j8tpfSAecZkr+f1mXSqqSwVGjVm
         26xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:newsgroups:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=wht29kUAgkDTBmrHaW1q6XJ3NXEO35xEuxud/bR3ziE=;
        b=BgWp1vg1278j90tMpzvxHOJ9WS5GyLLm/yLqpTA/jDvxGHxW6Pn1s0o60XqW0E9Zzo
         QsPpgPJJ6pOt97QVv8mwwe8rVLOuLRM2a5EPa4YmWdRhwblyrw+9qM17JCZ6s3+suWi4
         1qbAq/WdIzJ3xGnu9Y5rIAeezvYPHl/CrrQxugr6oMHjSIzqajFl6puW71096i48MHwd
         QeZiHWO8oNu/lVstdavgJ8nE7yn8FlPp2BrxSRbVpmq80cyo8Qe6U4AUbvfS87CCEims
         hdMOM3+1RKF64TDc2VA++3rUVW9UHyVCLxeUp2RD82BGtWuJWX0ny7usZIRnidKqF5ER
         UQgg==
X-Gm-Message-State: AOAM533RO0WJ4FYDqD69XKtQ9uB8/m8Acqjcl20Scfd7T3CLSBjdckTt
        NnlYD/Mb9Vd0Gzsdsn55+0a5oo3clxlE2A==
X-Google-Smtp-Source: ABdhPJywrkBqp9m6xKkrLJLVnWvCouj4D7AyUfUr4U23MJmh3YdXp//gK+9wnKB64E695F64o9FIYA==
X-Received: by 2002:a63:1021:: with SMTP id f33mr1065584pgl.409.1614711674219;
        Tue, 02 Mar 2021 11:01:14 -0800 (PST)
Received: from [192.168.50.50] (c-24-4-73-83.hsd1.ca.comcast.net. [24.4.73.83])
        by smtp.gmail.com with ESMTPSA id e22sm18629680pgk.56.2021.03.02.11.01.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Mar 2021 11:01:13 -0800 (PST)
Sender: Vineet Gupta <vineetg76@gmail.com>
Subject: Re: [PATCH] arc: kernel: Return -EFAULT if copy_to_user() fails
To:     Wang Qing <wangqing@vivo.com>, Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org
Newsgroups: gmane.linux.kernel,gmane.linux.kernel.arc
References: <1614600349-15662-1-git-send-email-wangqing@vivo.com>
From:   Vineet Gupta <vgupta@synopsys.com>
Message-ID: <bed81c02-97e0-9905-0dd3-6064a54691ff@synopsys.com>
Date:   Tue, 2 Mar 2021 11:01:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1614600349-15662-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/21 4:05 AM, Wang Qing wrote:
> The copy_to_user() function returns the number of bytes remaining to be
> copied, but we want to return -EFAULT if the copy doesn't complete.
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>

Acked-by: Vineet Gupta <vgupta@synopsys.com>

Do you want me to pick this up via ARC tree ?

Thx,
-Vineet

> ---
>   arch/arc/kernel/signal.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arc/kernel/signal.c b/arch/arc/kernel/signal.c
> index a78d8f7..fdbe06c
> --- a/arch/arc/kernel/signal.c
> +++ b/arch/arc/kernel/signal.c
> @@ -96,7 +96,7 @@ stash_usr_regs(struct rt_sigframe __user *sf, struct pt_regs *regs,
>   			     sizeof(sf->uc.uc_mcontext.regs.scratch));
>   	err |= __copy_to_user(&sf->uc.uc_sigmask, set, sizeof(sigset_t));
>   
> -	return err;
> +	return err ? -EFAULT : 0;
>   }
>   
>   static int restore_usr_regs(struct pt_regs *regs, struct rt_sigframe __user *sf)
> @@ -110,7 +110,7 @@ static int restore_usr_regs(struct pt_regs *regs, struct rt_sigframe __user *sf)
>   				&(sf->uc.uc_mcontext.regs.scratch),
>   				sizeof(sf->uc.uc_mcontext.regs.scratch));
>   	if (err)
> -		return err;
> +		return -EFAULT;
>   
>   	set_current_blocked(&set);
>   	regs->bta	= uregs.scratch.bta;
> 

