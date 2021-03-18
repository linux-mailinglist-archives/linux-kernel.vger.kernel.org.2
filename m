Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5F1340F3B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 21:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbhCRUar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 16:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbhCRUaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 16:30:15 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52817C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 13:30:15 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id k10so6032868ejg.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 13:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B++KzSIKVH2ZtdtLLuYVkdeR3YmbtOGoV/2HSygzxJ8=;
        b=hHqV9z8p8bcOXFXfuiKEjd2M41uQ/wHBOLVHeZSpyedfEcxvP9okWLJpGjDNXAzTen
         kc+RaAAnSaGRL8zrs6wZnabZlg1/tJgNDqzbVsHxmwGWi5UJdFLuXh0xlQ3lf/WukEEz
         6IqRB05taITR1trMgtyxzmNsicAdvr6bw5Qbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B++KzSIKVH2ZtdtLLuYVkdeR3YmbtOGoV/2HSygzxJ8=;
        b=gLglKGqmzVlyXjnJgKZJzdT4hhZahYfbzMID6VcKuaPvybkaRalSm83+vpli0bezuW
         5sG7VkQ0joko1jEc/NmaxruTtEIF4ewZ2cZEgVGVkEWZ/bnU4Pn6AZqkJsWuGhzdhhcu
         uzT1qNVhyURdsqZYA2OlkLul++cbHXgpcjjdMCrqGyAdTLhS8XBurt5BqIgNJ4JF6tkW
         /hxkcGPq5FpGfBtac1FUlR9UCnfFejaIDqDcT4SdqmPdm2Nt4gvon6w/RJY24FTHrcqy
         yZRja8oYnGt/5iBwgGLINvVYQrb1lxIgGAzodGC35hLoc50loTqU8ogjDXkyQ4XpdsJU
         /DUw==
X-Gm-Message-State: AOAM532Zl72wjXFlvVHS+mmfXyfjV/0CS12zYxQU1Pn3qX51xWCpMC4C
        wLuBi/otiw3Y32zX87shO0ADSw==
X-Google-Smtp-Source: ABdhPJw3UJ4zxZHqyyslXoqe8/aDMtWjVXWKzd9hgkFI9Uie6BUbAz1UchvazT6O3SVZgylhca7tfQ==
X-Received: by 2002:a17:906:75a:: with SMTP id z26mr445970ejb.22.1616099414008;
        Thu, 18 Mar 2021 13:30:14 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id hy25sm2463755ejc.119.2021.03.18.13.30.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Mar 2021 13:30:13 -0700 (PDT)
Subject: Re: [RFC PATCH] devres: better type safety with devm_*_action()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20210309235917.2134565-1-linux@rasmusvillemoes.dk>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <871c73f5-70a5-c970-137b-ccb905f406fa@rasmusvillemoes.dk>
Date:   Thu, 18 Mar 2021 21:30:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210309235917.2134565-1-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/2021 00.59, Rasmus Villemoes wrote:

[quoting in full for context to the new CCs]

> With a little MacroMagic(tm), we can allow users to pass a pointer to
> a function that actually takes the type of the data argument, instead
> of forcing the function to have prototype void (*)(void *). Of course,
> we must still accept such functions.
> 
> This can provide a little more type safety in that we get fewer
> implicit casts to and from void* - as a random example,
> gpio_mockup_dispose_mappings in drivers/gpio/gpio-mockup.c could take
> a "struct gpio_mockup_chip *chip" directly.
> 
> Moreover, when the action is some "external" API, there will in many
> cases no longer be a need for a trivial local wrapper -
> e.g. drivers/watchdog/cadence_wdt.c could just use
> clk_disable_unprepare directly and avoid defining
> cdns_clk_disable_unprepare.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  drivers/base/devres.c  | 32 +++++++++++++++++++++++---------
>  include/linux/device.h | 36 ++++++++++++++++++++++++++++++++----
>  2 files changed, 55 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/base/devres.c b/drivers/base/devres.c
> index fb9d5289a620..97ebd26bc44a 100644
> --- a/drivers/base/devres.c
> +++ b/drivers/base/devres.c
> @@ -728,15 +728,25 @@ static void devm_action_release(struct device *dev, void *res)
>  }
>  
>  /**
> - * devm_add_action() - add a custom action to list of managed resources
> + * __devm_add_action() - add a custom action to list of managed resources
>   * @dev: Device that owns the action
>   * @action: Function that should be called
>   * @data: Pointer to data passed to @action implementation
>   *
>   * This adds a custom action to the list of managed resources so that
>   * it gets executed as part of standard resource unwinding.
> + *
> + * Do not call directly, but use the the macro wrapper
> + * devm_add_action, whose "prototype" is
> + *
> + * devm_add_action(struct device *dev, void (*action)(T *), T *data)
> + *
> + * This allows use of type-correct callbacks and can avoid wrapping
> + * external APIs. For example, if the data item is a "struct clk *", one
> + * can use clk_disable_unprepare directly as the action instead of
> + * creating a local wrapper taking a "void *" argument.
>   */
> -int devm_add_action(struct device *dev, void (*action)(void *), void *data)
> +int __devm_add_action(struct device *dev, void (*action)(void *), void *data)
>  {
>  	struct action_devres *devres;
>  
> @@ -751,18 +761,20 @@ int devm_add_action(struct device *dev, void (*action)(void *), void *data)
>  	devres_add(dev, devres);
>  	return 0;
>  }
> -EXPORT_SYMBOL_GPL(devm_add_action);
> +EXPORT_SYMBOL_GPL(__devm_add_action);
>  
>  /**
> - * devm_remove_action() - removes previously added custom action
> + * __devm_remove_action() - removes previously added custom action
>   * @dev: Device that owns the action
>   * @action: Function implementing the action
>   * @data: Pointer to data passed to @action implementation
>   *
>   * Removes instance of @action previously added by devm_add_action().
>   * Both action and data should match one of the existing entries.
> + *
> + * Use the macro wrapper devm_remove_action, see __devm_add_action for details.
>   */
> -void devm_remove_action(struct device *dev, void (*action)(void *), void *data)
> +void __devm_remove_action(struct device *dev, void (*action)(void *), void *data)
>  {
>  	struct action_devres devres = {
>  		.data = data,
> @@ -772,10 +784,10 @@ void devm_remove_action(struct device *dev, void (*action)(void *), void *data)
>  	WARN_ON(devres_destroy(dev, devm_action_release, devm_action_match,
>  			       &devres));
>  }
> -EXPORT_SYMBOL_GPL(devm_remove_action);
> +EXPORT_SYMBOL_GPL(__devm_remove_action);
>  
>  /**
> - * devm_release_action() - release previously added custom action
> + * __devm_release_action() - release previously added custom action
>   * @dev: Device that owns the action
>   * @action: Function implementing the action
>   * @data: Pointer to data passed to @action implementation
> @@ -783,8 +795,10 @@ EXPORT_SYMBOL_GPL(devm_remove_action);
>   * Releases and removes instance of @action previously added by
>   * devm_add_action().  Both action and data should match one of the
>   * existing entries.
> + *
> + * Use the macro wrapper devm_release_action, see __devm_add_action for details.
>   */
> -void devm_release_action(struct device *dev, void (*action)(void *), void *data)
> +void __devm_release_action(struct device *dev, void (*action)(void *), void *data)
>  {
>  	struct action_devres devres = {
>  		.data = data,
> @@ -795,7 +809,7 @@ void devm_release_action(struct device *dev, void (*action)(void *), void *data)
>  			       &devres));
>  
>  }
> -EXPORT_SYMBOL_GPL(devm_release_action);
> +EXPORT_SYMBOL_GPL(__devm_release_action);
>  
>  /*
>   * Managed kmalloc/kfree
> diff --git a/include/linux/device.h b/include/linux/device.h
> index ba660731bd25..c924612bfefd 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -250,11 +250,39 @@ void __iomem *devm_of_iomap(struct device *dev,
>  			    resource_size_t *size);
>  
>  /* allows to add/remove a custom action to devres stack */
> -int devm_add_action(struct device *dev, void (*action)(void *), void *data);
> -void devm_remove_action(struct device *dev, void (*action)(void *), void *data);
> -void devm_release_action(struct device *dev, void (*action)(void *), void *data);
>  
> -static inline int devm_add_action_or_reset(struct device *dev,
> +/*
> + * +0 forces the expression to decay to a function pointer. We cannot
> + * just put an & in front as callers may already include that.
> + */
> +#define devm_action_typecheck(action, data)				\
> +	static_assert(__same_type(action + 0, void (*)(void *)) ||	\
> +		      __same_type(action + 0, void (*)(typeof(data))))
> +
> +#define devm_add_action(dev, action, data) ({				\
> +	devm_action_typecheck(action, data);				\
> +	__devm_add_action(dev, (void (*)(void *))action, data);		\
> +})
> +#define devm_remove_action(dev, action, data) ({			\
> +	devm_action_typecheck(action, data);				\
> +	__devm_remove_action(dev, (void (*)(void *))action, data);	\
> +})
> +#define devm_release_action(dev, action, data) ({			\
> +	devm_action_typecheck(action, data);				\
> +	__devm_release_action(dev, (void (*)(void *))action, data);	\
> +})
> +
> +
> +int __devm_add_action(struct device *dev, void (*action)(void *), void *data);
> +void __devm_remove_action(struct device *dev, void (*action)(void *), void *data);
> +void __devm_release_action(struct device *dev, void (*action)(void *), void *data);
> +
> +#define devm_add_action_or_reset(dev, action, data) ({			\
> +	devm_action_typecheck(action, data);				\
> +	__devm_add_action_or_reset(dev, (void (*)(void *))action, data); \
> +})
> +
> +static inline int __devm_add_action_or_reset(struct device *dev,
>  					   void (*action)(void *), void *data)
>  {
>  	int ret;
> 

So, this would likely crash and burn under CFI if I understand
correctly. Is there any way to make such "polymorphic" callbacks with
type-checking done via macros coexist with CFI? I mean, it's a bit sad
that in order to have the sanity checks done by CFI, one has to force
everything through functions that take void* instead of the type that
they really act on.

Rasmus
