Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B7E3ECE90
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 08:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbhHPGYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 02:24:32 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:39540 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhHPGYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 02:24:31 -0400
Received: by mail-wr1-f46.google.com with SMTP id q6so10416191wrv.6
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 23:23:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lV5i2yVWvXyla3Y88Q6s8ONf8AJPSOqzXZNFw0gdfCI=;
        b=pYBlwVMHgqWFovlnj/O+/egl6ljh8R1FTExEkqc85/mppIx+A7GLDTK+vcXHCrcsCn
         Ijpi+qCHqj+nLAsSGG6+op1htCpo3DVt78sb0iZ3034QIo4sZLXpjNtJJ5NqMpPJmjf+
         93FzddPIvSb0QIOeawqwUV2vaKGEiAfMux5hL+PeNQ3rf/Ng1RE1E0X90LsppZBTtuw2
         subJqV0hzJQwrRdcIsL8xHFTC7In1arH8FjvBn+xPzAhDZWK5DqPfl3zlLtscDsyxzuJ
         gk1PiMss8LpezAQi0Ij2FYa8qW48lahguLopgY01mTLGUVu8iAJN+Ngb6XNDEyNf0DZO
         BwEg==
X-Gm-Message-State: AOAM533Y1C9Ruuu/VFRP0/O7nwayTNVAw5oXEoNrBriIfg9H+yE4qEln
        IDWWB6zsXzN5fhhjcC/7be7YNs6Mq+M=
X-Google-Smtp-Source: ABdhPJxRq4Szj3pGz2MlzIy+8E0pQzss717T59bKdKQjeQ0i1toZ1q27tNaekiOjYU8HglXQARGtPw==
X-Received: by 2002:adf:f809:: with SMTP id s9mr16356664wrp.370.1629095039042;
        Sun, 15 Aug 2021 23:23:59 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id p18sm3685043wrt.13.2021.08.15.23.23.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Aug 2021 23:23:58 -0700 (PDT)
Subject: Re: [PATCH] tty: replace in_irq() with in_hardirq()
To:     Changbin Du <changbin.du@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
References: <20210814005033.2381-1-changbin.du@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <158e002d-3fa4-6027-29cd-33e446cddf19@kernel.org>
Date:   Mon, 16 Aug 2021 08:23:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210814005033.2381-1-changbin.du@gmail.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14. 08. 21, 2:50, Changbin Du wrote:
> Replace the obsolete and ambiguos macro in_irq() with new
> macro in_hardirq().

... which is just a new name.

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>   drivers/tty/sysrq.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> index 6628792431dc..c911196ac893 100644
> --- a/drivers/tty/sysrq.c
> +++ b/drivers/tty/sysrq.c
> @@ -258,7 +258,7 @@ static void sysrq_handle_showallcpus(int key)
>   	if (!trigger_all_cpu_backtrace()) {
>   		struct pt_regs *regs = NULL;
>   
> -		if (in_irq())
> +		if (in_hardirq())
>   			regs = get_irq_regs();
>   		if (regs) {
>   			pr_info("CPU%d:\n", smp_processor_id());
> @@ -280,7 +280,7 @@ static void sysrq_handle_showregs(int key)
>   {
>   	struct pt_regs *regs = NULL;
>   
> -	if (in_irq())
> +	if (in_hardirq())
>   		regs = get_irq_regs();
>   	if (regs)
>   		show_regs(regs);
> 


-- 
js
suse labs
