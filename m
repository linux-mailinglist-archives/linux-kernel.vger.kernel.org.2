Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F1D3803CC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 08:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbhENGwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 02:52:50 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:36696 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbhENGws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 02:52:48 -0400
Received: by mail-ed1-f51.google.com with SMTP id df21so6307951edb.3;
        Thu, 13 May 2021 23:51:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1gymq95orR5zgtyh8ZSQwnKyiuFehw+cpEXmsD2CDf0=;
        b=t0xDpaM3hgrBCsyaGCbYjw+h0FAHJrQxUNA88xXyxu+5rB2kyeg7sxVDIi4NiBithH
         3ijxA4yIO4inE48xinlj93tSemvRw9159ek6kgaxZtKnydapr0B8LDvVUsXuZgk1TXtT
         teMtQ77rA5gjYspm5/ustHxm0MiFYwMLgHFHqyxPzvf/7Cr4aUuot6j42a1dJXwikr6W
         IEAjwgBDIP4nRyK4IpToRucI5LK0lsK4E0xafkEhPPNkumgovUKLToPaZL+EmymgHzMp
         cI06IlMCmCyv9Tjwc0FJa3Pi4mvtJ2NHezwdkqMxhCDidPc2EpUzOBK3LHyRmubS4qyE
         nHPg==
X-Gm-Message-State: AOAM530YbfaGhYcJJ52VFphIgcc7P5f1GVGUubMlnW3M8gnHXcgCOrxP
        TBp/mzhK2Rhv8Jpgoa+jh0Swaju9DnA=
X-Google-Smtp-Source: ABdhPJyXdXGiv6DhZlc+bTWc7aWFBeNON8OPqZ/xYuVote/cTk5V2YYOcY9zrJu9GcLmFBF3eNPthw==
X-Received: by 2002:a05:6402:5244:: with SMTP id t4mr37013244edd.228.1620975091508;
        Thu, 13 May 2021 23:51:31 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id o3sm3948253edr.84.2021.05.13.23.51.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 May 2021 23:51:30 -0700 (PDT)
Subject: Re: [PATCH] tty: pty: remove redundant initialization of variable fd
To:     Colin King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210513221833.137672-1-colin.king@canonical.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <2f6c2e1e-770b-aade-cdcc-aa4010c36d5e@kernel.org>
Date:   Fri, 14 May 2021 08:51:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210513221833.137672-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14. 05. 21, 0:18, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable fd is being initialized with a value that is never
> read, it is being updated later on. The assignment is redundant and
> can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> ---
>   drivers/tty/pty.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
> index 9b5d4ae5d8f2..2251330e7e00 100644
> --- a/drivers/tty/pty.c
> +++ b/drivers/tty/pty.c
> @@ -626,7 +626,7 @@ static struct cdev ptmx_cdev;
>    */
>   int ptm_open_peer(struct file *master, struct tty_struct *tty, int flags)
>   {
> -	int fd = -1;
> +	int fd;
>   	struct file *filp;
>   	int retval = -EINVAL;
>   	struct path path;
> 


-- 
js
suse labs
