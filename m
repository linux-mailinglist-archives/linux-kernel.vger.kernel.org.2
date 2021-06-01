Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F8C397BED
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 23:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234870AbhFAVze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 17:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234698AbhFAVzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 17:55:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8084C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 14:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=/5d3lkUs0HdCjFN7gYZBIeUdMqrX3jGp31aNRqItIdI=; b=sSjuiOlhjGsrldpSLCS6G+mqPO
        ATWN5hANnXAqsFYvC3uGxelBUqGzcxZ1fFUCmwjjyPwHDB/GnqcZtqrsRLBRz/NiD0Uehc5UWTa2H
        ogU9jNhJdla5+CYC9a7eAN6aITJVdn9MSlKdNoWybzIpzLsyqVOBSXKyXhRjxbmgJskbWVN9bRieW
        E3EcGo7gXCoML3rSbHieJ59t4o8aoI3bLfa3CdcYK+HekuF5dDcuyg69inNTBaiHNSrNUgPNEQ0EJ
        DDtYigsIjnt9DcaqFKilMn/4+HiDY2+GuvK8zFdecNWF+7F1W5S94OVuiNfOF65yZB+pVexJTuTie
        e2Dt+5+g==;
Received: from [2601:1c0:6280:3f0::ce7d]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1loCKY-000yam-2V; Tue, 01 Jun 2021 21:53:46 +0000
Subject: Re: [PATCH] kconfig.h: explain IS_MODULE(), IS_ENABLED()
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Paul Cercueil <paul@crapouillou.net>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20210601213143.1973770-1-helgaas@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <819816a2-be1a-8d63-a26b-31f8caa8c944@infradead.org>
Date:   Tue, 1 Jun 2021 14:53:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210601213143.1973770-1-helgaas@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/21 2:31 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Extend IS_MODULE() and IS_ENABLED comments to explain why one might use
> "#if IS_ENABLED(CONFIG_FOO)" instead of "#ifdef CONFIG_FOO".
> 
> To wit, "#ifdef CONFIG_FOO" is true only for CONFIG_FOO=y, while
> "#if IS_ENABLED(CONFIG_FOO)" is true for both CONFIG_FOO=y and
> CONFIG_FOO=m.
> 
> This is because "CONFIG_FOO=m" in .config does not result in "CONFIG_FOO"
> being defined.  The actual definitions are in autoconf.h, where:
> 
>   CONFIG_FOO=y   results in   #define CONFIG_FOO 1
>   CONFIG_FOO=m   results in   #define CONFIG_FOO_MODULE 1
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>


Thanks.

> ---
>  include/linux/kconfig.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/kconfig.h b/include/linux/kconfig.h
> index cc8fa109cfa3..20d1079e92b4 100644
> --- a/include/linux/kconfig.h
> +++ b/include/linux/kconfig.h
> @@ -51,7 +51,8 @@
>  
>  /*
>   * IS_MODULE(CONFIG_FOO) evaluates to 1 if CONFIG_FOO is set to 'm', 0
> - * otherwise.
> + * otherwise.  CONFIG_FOO=m results in "#define CONFIG_FOO_MODULE 1" in
> + * autoconf.h.
>   */
>  #define IS_MODULE(option) __is_defined(option##_MODULE)
>  
> @@ -66,7 +67,8 @@
>  
>  /*
>   * IS_ENABLED(CONFIG_FOO) evaluates to 1 if CONFIG_FOO is set to 'y' or 'm',
> - * 0 otherwise.
> + * 0 otherwise.  Note that CONFIG_FOO=y results in "#define CONFIG_FOO 1" in
> + * autoconf.h, while CONFIG_FOO=m results in "#define CONFIG_FOO_MODULE 1".
>   */
>  #define IS_ENABLED(option) __or(IS_BUILTIN(option), IS_MODULE(option))
>  
> 


-- 
~Randy

