Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF4233D6847
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 22:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbhGZUHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 16:07:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:57620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232087AbhGZUHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 16:07:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A567060F57;
        Mon, 26 Jul 2021 20:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627332454;
        bh=RqG8r0D0ghuPyrjCxi1pKK9MyFYU9qRzhXJW182DPR4=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=TY4ayUm5WzThNdYG2K+DlTF2PXo7DhRU3QJHEkI6YWDCD0UUXqMHaPmILaOD9lw2E
         gJaaVSQH4fkxxSiXf+5ca90pvmmTOkGgp/TLgNByiEczvWiMstt8pPruY6Q28KYCV9
         aj61BQh2SP4dbiIXfqNyH9qVKye2cVudTSlqioaFsQq64colyjqQc0vQ9vnd6kb0St
         11zneo/v/PaFxKfbyy31KOgbZKlwT5ZK4jKpgPNUqYiuOK83LkJT2rLC6F7YSVGS/e
         eHieDy65Xc1HJLY/zyHodbHgZseHwhRABgYVlbYJ6g7LCqhsguJEnPr8TIM54W5WSt
         jomt8oz9jjADg==
Subject: Re: [PATCH v2 1/3] base: mark 'no_warn' as unused
To:     Bill Wendling <morbo@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20210714091747.2814370-1-morbo@google.com>
 <20210726201924.3202278-1-morbo@google.com>
 <20210726201924.3202278-2-morbo@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <c965006c-88e1-3265-eb9c-76dc0bbcb733@kernel.org>
Date:   Mon, 26 Jul 2021 13:47:33 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210726201924.3202278-2-morbo@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Greg and Rafael as the maintainer and reviewer of 
drivers/base/module.c respectively, drop everyone else.

Original post:

https://lore.kernel.org/r/20210726201924.3202278-2-morbo@google.com/

On 7/26/2021 1:19 PM, 'Bill Wendling' via Clang Built Linux wrote:
> Fix the following build warning:
> 
>    drivers/base/module.c:36:6: error: variable 'no_warn' set but not used [-Werror,-Wunused-but-set-variable]
>          int no_warn;
> 
> This variable is used to remove another warning, but causes a warning
> itself. Mark it as 'unused' to avoid that.
> 
> Signed-off-by: Bill Wendling <morbo@google.com>

Even though they evaluate to the same thing, it might be worth using 
"__always_unused" here because it is :)

Regardless:

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>   drivers/base/module.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/module.c b/drivers/base/module.c
> index 46ad4d636731..10494336d601 100644
> --- a/drivers/base/module.c
> +++ b/drivers/base/module.c
> @@ -33,7 +33,7 @@ static void module_create_drivers_dir(struct module_kobject *mk)
>   void module_add_driver(struct module *mod, struct device_driver *drv)
>   {
>   	char *driver_name;
> -	int no_warn;
> +	int __maybe_unused no_warn;
>   	struct module_kobject *mk = NULL;
>   
>   	if (!drv)
> 
