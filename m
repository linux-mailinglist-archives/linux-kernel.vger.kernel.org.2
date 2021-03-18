Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A4D341019
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 22:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbhCRV6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 17:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbhCRV6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 17:58:12 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162C8C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 14:58:12 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id w11so1974622ply.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 14:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8aINFkeozV9QLb38YaP4lMo7VECaA4E2OueeRpmTZ18=;
        b=fBrco9yu/7Zt9CSB/mvreUSfOnfmHAGoD/aCMg0Gd3GPRo+yJHCG0Ux942QG/juUFF
         5vDZ+l5EkgPPSSAM1YHW5UbKam+rafYDl8Lsj64VevAuvI4lT4mU1ERBx0j9hx+TsepW
         jz+wJ0o6BtHj864ZnQPdGSaLC6CaC2CTXBZ94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8aINFkeozV9QLb38YaP4lMo7VECaA4E2OueeRpmTZ18=;
        b=M7Ij7bTAc6C2unUR8ma3XGyOAfeanpTIe1e4gL913JYeKyDh7kRjJBnFceuQvY/tLQ
         HVoylHuyaNNsYkvEuzyuupRhUkA6QXuYNZarXhbRRc7P0/l2o+sTGRJZwdZT1fvYZJXX
         rvHkRjcsEzba+9jYgWFTe4PulygWardQZkkOGKfvGnEhE39IWLfh1to5ezzkXxcLg8yo
         tWmB9nqVaHhDVhHqn7DS0a+Sj1Qpe+geFnZtCukhJnU0xPDa9tK0WLPbHXqTMAawJguN
         k/UYDqFFuMs8yhz4bpmQ5Z+GigsE9MZWl5YeUn4pMf4GanURCkwkZjAJHxkTtkETFIsf
         DMOA==
X-Gm-Message-State: AOAM53322zn01y5/QaPVoSAFefklBtrinNvK3rBF2GnVVUZrFUfnSV//
        /Wwp6cBCA5mfSFpYy+r/Zy2MLRSBYejLBg==
X-Google-Smtp-Source: ABdhPJwnV1NjqButSa1U4Ol4vZn1cJB6olfOXkS5Y7VMZo09+oJM/uaS4hSyS3FVMVLDXdMa91t1/w==
X-Received: by 2002:a17:90a:f010:: with SMTP id bt16mr6410255pjb.116.1616104691380;
        Thu, 18 Mar 2021 14:58:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u17sm2809726pgl.80.2021.03.18.14.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 14:58:10 -0700 (PDT)
Date:   Thu, 18 Mar 2021 14:58:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [RFC PATCH] devres: better type safety with devm_*_action()
Message-ID: <202103181455.E6FE393@keescook>
References: <20210309235917.2134565-1-linux@rasmusvillemoes.dk>
 <871c73f5-70a5-c970-137b-ccb905f406fa@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871c73f5-70a5-c970-137b-ccb905f406fa@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 09:30:12PM +0100, Rasmus Villemoes wrote:
> On 10/03/2021 00.59, Rasmus Villemoes wrote:
> 
> [quoting in full for context to the new CCs]
> 
> > With a little MacroMagic(tm), we can allow users to pass a pointer to
> > a function that actually takes the type of the data argument, instead
> > of forcing the function to have prototype void (*)(void *). Of course,
> > we must still accept such functions.
> > 
> > This can provide a little more type safety in that we get fewer
> > implicit casts to and from void* - as a random example,
> > gpio_mockup_dispose_mappings in drivers/gpio/gpio-mockup.c could take
> > a "struct gpio_mockup_chip *chip" directly.
> > 
> > Moreover, when the action is some "external" API, there will in many
> > cases no longer be a need for a trivial local wrapper -
> > e.g. drivers/watchdog/cadence_wdt.c could just use
> > clk_disable_unprepare directly and avoid defining
> > cdns_clk_disable_unprepare.
> > 
> > Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > ---
> >  drivers/base/devres.c  | 32 +++++++++++++++++++++++---------
> >  include/linux/device.h | 36 ++++++++++++++++++++++++++++++++----
> >  2 files changed, 55 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/base/devres.c b/drivers/base/devres.c
> > index fb9d5289a620..97ebd26bc44a 100644
> > --- a/drivers/base/devres.c
> > +++ b/drivers/base/devres.c
> > @@ -728,15 +728,25 @@ static void devm_action_release(struct device *dev, void *res)
> >  }
> >  
> >  /**
> > - * devm_add_action() - add a custom action to list of managed resources
> > + * __devm_add_action() - add a custom action to list of managed resources
> >   * @dev: Device that owns the action
> >   * @action: Function that should be called
> >   * @data: Pointer to data passed to @action implementation
> >   *
> >   * This adds a custom action to the list of managed resources so that
> >   * it gets executed as part of standard resource unwinding.
> > + *
> > + * Do not call directly, but use the the macro wrapper
> > + * devm_add_action, whose "prototype" is
> > + *
> > + * devm_add_action(struct device *dev, void (*action)(T *), T *data)
> > + *
> > + * This allows use of type-correct callbacks and can avoid wrapping
> > + * external APIs. For example, if the data item is a "struct clk *", one
> > + * can use clk_disable_unprepare directly as the action instead of
> > + * creating a local wrapper taking a "void *" argument.
> >   */
> > -int devm_add_action(struct device *dev, void (*action)(void *), void *data)
> > +int __devm_add_action(struct device *dev, void (*action)(void *), void *data)
> >  {
> >  	struct action_devres *devres;
> >  
> > @@ -751,18 +761,20 @@ int devm_add_action(struct device *dev, void (*action)(void *), void *data)
> >  	devres_add(dev, devres);
> >  	return 0;
> >  }
> > -EXPORT_SYMBOL_GPL(devm_add_action);
> > +EXPORT_SYMBOL_GPL(__devm_add_action);
> >  
> >  /**
> > - * devm_remove_action() - removes previously added custom action
> > + * __devm_remove_action() - removes previously added custom action
> >   * @dev: Device that owns the action
> >   * @action: Function implementing the action
> >   * @data: Pointer to data passed to @action implementation
> >   *
> >   * Removes instance of @action previously added by devm_add_action().
> >   * Both action and data should match one of the existing entries.
> > + *
> > + * Use the macro wrapper devm_remove_action, see __devm_add_action for details.
> >   */
> > -void devm_remove_action(struct device *dev, void (*action)(void *), void *data)
> > +void __devm_remove_action(struct device *dev, void (*action)(void *), void *data)
> >  {
> >  	struct action_devres devres = {
> >  		.data = data,
> > @@ -772,10 +784,10 @@ void devm_remove_action(struct device *dev, void (*action)(void *), void *data)
> >  	WARN_ON(devres_destroy(dev, devm_action_release, devm_action_match,
> >  			       &devres));
> >  }
> > -EXPORT_SYMBOL_GPL(devm_remove_action);
> > +EXPORT_SYMBOL_GPL(__devm_remove_action);
> >  
> >  /**
> > - * devm_release_action() - release previously added custom action
> > + * __devm_release_action() - release previously added custom action
> >   * @dev: Device that owns the action
> >   * @action: Function implementing the action
> >   * @data: Pointer to data passed to @action implementation
> > @@ -783,8 +795,10 @@ EXPORT_SYMBOL_GPL(devm_remove_action);
> >   * Releases and removes instance of @action previously added by
> >   * devm_add_action().  Both action and data should match one of the
> >   * existing entries.
> > + *
> > + * Use the macro wrapper devm_release_action, see __devm_add_action for details.
> >   */
> > -void devm_release_action(struct device *dev, void (*action)(void *), void *data)
> > +void __devm_release_action(struct device *dev, void (*action)(void *), void *data)
> >  {
> >  	struct action_devres devres = {
> >  		.data = data,
> > @@ -795,7 +809,7 @@ void devm_release_action(struct device *dev, void (*action)(void *), void *data)
> >  			       &devres));
> >  
> >  }
> > -EXPORT_SYMBOL_GPL(devm_release_action);
> > +EXPORT_SYMBOL_GPL(__devm_release_action);
> >  
> >  /*
> >   * Managed kmalloc/kfree
> > diff --git a/include/linux/device.h b/include/linux/device.h
> > index ba660731bd25..c924612bfefd 100644
> > --- a/include/linux/device.h
> > +++ b/include/linux/device.h
> > @@ -250,11 +250,39 @@ void __iomem *devm_of_iomap(struct device *dev,
> >  			    resource_size_t *size);
> >  
> >  /* allows to add/remove a custom action to devres stack */
> > -int devm_add_action(struct device *dev, void (*action)(void *), void *data);
> > -void devm_remove_action(struct device *dev, void (*action)(void *), void *data);
> > -void devm_release_action(struct device *dev, void (*action)(void *), void *data);
> >  
> > -static inline int devm_add_action_or_reset(struct device *dev,
> > +/*
> > + * +0 forces the expression to decay to a function pointer. We cannot
> > + * just put an & in front as callers may already include that.
> > + */
> > +#define devm_action_typecheck(action, data)				\
> > +	static_assert(__same_type(action + 0, void (*)(void *)) ||	\
> > +		      __same_type(action + 0, void (*)(typeof(data))))
> > +
> > +#define devm_add_action(dev, action, data) ({				\
> > +	devm_action_typecheck(action, data);				\
> > +	__devm_add_action(dev, (void (*)(void *))action, data);		\
> > +})
> > +#define devm_remove_action(dev, action, data) ({			\
> > +	devm_action_typecheck(action, data);				\
> > +	__devm_remove_action(dev, (void (*)(void *))action, data);	\
> > +})
> > +#define devm_release_action(dev, action, data) ({			\
> > +	devm_action_typecheck(action, data);				\
> > +	__devm_release_action(dev, (void (*)(void *))action, data);	\
> > +})
> > +
> > +
> > +int __devm_add_action(struct device *dev, void (*action)(void *), void *data);
> > +void __devm_remove_action(struct device *dev, void (*action)(void *), void *data);
> > +void __devm_release_action(struct device *dev, void (*action)(void *), void *data);
> > +
> > +#define devm_add_action_or_reset(dev, action, data) ({			\
> > +	devm_action_typecheck(action, data);				\
> > +	__devm_add_action_or_reset(dev, (void (*)(void *))action, data); \
> > +})
> > +
> > +static inline int __devm_add_action_or_reset(struct device *dev,
> >  					   void (*action)(void *), void *data)
> >  {
> >  	int ret;
> > 
> 
> So, this would likely crash and burn under CFI if I understand
> correctly. Is there any way to make such "polymorphic" callbacks with
> type-checking done via macros coexist with CFI? I mean, it's a bit sad
> that in order to have the sanity checks done by CFI, one has to force
> everything through functions that take void* instead of the type that
> they really act on.

Yeah, that'll light up CFI. ;) Why not stick with the existing standard
of callbacks, which is to pass the object pointer the callback is
attached to (as done with timer_struct, etc)?

As in the prototype should be just

	void callback(struct device *dev);

or if we absolutely must have a "data" argument (it'd be better to have
the data directly associated with the struct device):

	void callback(struct device *dev, void *data);

-- 
Kees Cook
