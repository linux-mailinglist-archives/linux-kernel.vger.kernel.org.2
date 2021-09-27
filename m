Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D7141970A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 17:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234963AbhI0PDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 11:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234919AbhI0PC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 11:02:59 -0400
X-Greylist: delayed 366 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Sep 2021 08:01:21 PDT
Received: from mail.bugwerft.de (mail.bugwerft.de [IPv6:2a03:6000:1011::59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 31E86C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 08:01:20 -0700 (PDT)
Received: from [192.168.178.130] (p57bc9b61.dip0.t-ipconnect.de [87.188.155.97])
        by mail.bugwerft.de (Postfix) with ESMTPSA id A78D13AF4C9;
        Mon, 27 Sep 2021 14:55:13 +0000 (UTC)
Subject: Re: [PATCH] [RESEND] ARM: sharpsl_param: work around
 -Wstringop-overread warning
To:     Arnd Bergmann <arnd@kernel.org>, soc@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210927145332.2784005-1-arnd@kernel.org>
From:   Daniel Mack <daniel@zonque.org>
Message-ID: <413f2684-f818-4d0b-bf7c-142f55b3737f@zonque.org>
Date:   Mon, 27 Sep 2021 16:55:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210927145332.2784005-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/21 4:53 PM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc warns that accessing a pointer based on a numeric constant may
> be an offset into a NULL pointer, and would therefore has zero
> accessible bytes:
> 
> arch/arm/common/sharpsl_param.c: In function ‘sharpsl_save_param’:
> arch/arm/common/sharpsl_param.c:43:9: error: ‘memcpy’ reading 64 bytes from a region of size 0 [-Werror=stringop-overread]
>    43 |         memcpy(&sharpsl_param, param_start(PARAM_BASE), sizeof(struct sharpsl_param_info));
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> In this particular case, the warning is bogus since this is the actual
> pointer, not an offset on a NULL pointer. Add a local variable to shut
> up the warning and hope it doesn't come back.
> 
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99578

Acked-by: Daniel Mack <daniel@zonque.org>


> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Robert Jarzmik <robert.jarzmik@free.fr>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> If there are no objections, I'd apply this one through the soc tree.
> ---
>  arch/arm/common/sharpsl_param.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/common/sharpsl_param.c b/arch/arm/common/sharpsl_param.c
> index efeb5724d9e9..6237ede2f0c7 100644
> --- a/arch/arm/common/sharpsl_param.c
> +++ b/arch/arm/common/sharpsl_param.c
> @@ -40,7 +40,9 @@ EXPORT_SYMBOL(sharpsl_param);
>  
>  void sharpsl_save_param(void)
>  {
> -	memcpy(&sharpsl_param, param_start(PARAM_BASE), sizeof(struct sharpsl_param_info));
> +	struct sharpsl_param_info *params = param_start(PARAM_BASE);
> +
> +	memcpy(&sharpsl_param, params, sizeof(*params));
>  
>  	if (sharpsl_param.comadj_keyword != COMADJ_MAGIC)
>  		sharpsl_param.comadj=-1;
> 

