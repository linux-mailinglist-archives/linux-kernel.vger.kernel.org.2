Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5139236E94D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 13:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbhD2LFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 07:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbhD2LFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 07:05:31 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D3CC06138D
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 04:04:45 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id a22-20020a05600c2256b029014294520f18so6205037wmm.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 04:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=u9W0Vns7Qfc+W3lTNxIiq9z3pgtPdaqfch++QGz+ttk=;
        b=wJjIKtzHsUz4kKIKs4ZBz/rqpF7WGfu8ZIeLf/+5K12N7XYD4bCBuFo1hShqUl5T+g
         pvq8T+1dEJVJwfC2eUprlJJCCFdEVSqseeRASyfQotze+nsuxXjZHum1XOHKzCJB+ArP
         G9jM2k/1CAIDMAqku/CtK6QblJck/0J8Txu0aoRk1wpcTr1WNflRJjADMurNJvyHFqBE
         Gmkpi3mx0i6NQMheKmjkcGAtjdLdjsvd8NgZii+s+c6ZmoMuneU9mK1BG2zxWztrHoke
         tyFVA9krVBvTpPFmT0zoEuKJnJvcWWQYFM9rS90NuH+I3d5lr8ntsOMxlKjmlZ46xZwf
         BAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=u9W0Vns7Qfc+W3lTNxIiq9z3pgtPdaqfch++QGz+ttk=;
        b=SC3rn80VrymPzkI/tFAkHgttmq24SmV6diIDmLfwdbzU5gGCO/UTqSodlqq6iIOgCK
         Zw/IqxGnLVwnG9MT9vETg+g3sO/lPdjLeM8dbt7YqJXYOt60NIguLSbke/xqi5PTNqEH
         XdTmZIlA4soJdkuHTkTcH/7FtPiePwMM4dzbgRuP0TYmRXzOyXHZsfaDwEkkvcggvUF1
         HUIdmom6F+vLnGJMsBqapOtkVYl/dlkJeT+LxgYbrX/N3JoA2hA7HTVJBRlnc7vZRG51
         9B/PmMcIUrubbEGq8pF6kwwBW1hG3nyNKTIN5O93b6fmGmuYcD38Hm2j76MHBOhCGXEW
         7xXw==
X-Gm-Message-State: AOAM531XSfG6/Md5vrkoauFFVHKvSO9wknC4zt9aJ17JbRhsxsqEaKZ+
        3VbQAqin0DByJHOK0CWknEWiVw==
X-Google-Smtp-Source: ABdhPJxApcK4ezeBO81ziSt/GeUMwscwM9IUnrpA8fKLa9Qt/TG7t4GbenXo2DO0TZidfePCzFcYug==
X-Received: by 2002:a05:600c:4f86:: with SMTP id n6mr9684841wmq.33.1619694283766;
        Thu, 29 Apr 2021 04:04:43 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id f8sm3193743wmc.8.2021.04.29.04.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 04:04:43 -0700 (PDT)
Date:   Thu, 29 Apr 2021 12:04:33 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Fenglin Wu <fenglinw@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, subbaram@codeaurora.org,
        collinsd@codeaurora.org, aghayal@codeaurora.org
Subject: Re: [PATCH 2/2] pwm: pwm-qcom: add driver for PWM modules in QCOM
 PMICs
Message-ID: <20210429110433.GK6446@dell>
References: <20210427102247.822-1-fenglinw@codeaurora.org>
 <20210427102247.822-3-fenglinw@codeaurora.org>
 <20210427170748.wglupc6zwrndalxs@pengutronix.de>
 <YImfkM/ll1nCmopq@orome.fritz.box>
 <20210429065213.inajpznvfxa2xsld@pengutronix.de>
 <20210429070653.GJ6446@dell>
 <YIqH/eimua/gwDW8@orome.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YIqH/eimua/gwDW8@orome.fritz.box>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Apr 2021, Thierry Reding wrote:

> On Thu, Apr 29, 2021 at 08:06:53AM +0100, Lee Jones wrote:
> > On Thu, 29 Apr 2021, Uwe Kleine-König wrote:
> > 
> > > Hello,
> > > 
> > > On Wed, Apr 28, 2021 at 07:46:56PM +0200, Thierry Reding wrote:
> > > > On Tue, Apr 27, 2021 at 07:07:48PM +0200, Uwe Kleine-König wrote:
> > > > > I would like to see the register definition to use a common prefix (like
> > > > > QCOM_PWM_) and that the names of bit fields include the register name.
> > > > > So something like:
> > > > > 
> > > > > 	#define QCOM_PWM_PWM_SIZE_CLK		0x41
> > > > > 	#define QCOM_PWM_PWM_SIZE_CLK_FREQ_SEL 		GENMASK(1, 0)
> > > > > 
> > > > > even if the names are quite long, its usage is less error prone. Maybe
> > > > > it makes sense to drop the duplicated PWM (but only if all or no
> > > > > register contains PWM in its name according to the reference manual).
> > > > > Also maybe QCOM_PWM_PWMSIZECLK_FREQSEL might be a good choice. I let you
> > > > > judge about the details.
> > > > 
> > > > Please stop requesting this. A common prefix is good for namespacing
> > > > symbols, but these defines are used only within this file, so there's no
> > > > need to namespace them.
> > > 
> > > I do consider it important. The goal of my review comments is to improve
> > > the drivers according to what I consider sensible even if that might not
> > > fit your metrics. 
> > > 
> > > Consistent name(space)ing is sensible because the names of static
> > > functions are used in backtraces. It is sensible because tools like
> > > ctags, etags and cscope work better when names are unique. It is
> > > sensible because it's harder than necessary to spot the error in
> > > 
> > > 	writel(PWM_EN_GLITCH_REMOVAL_MASK, base + REG_ENABLE_CONTROL);
> > > 
> > > . It is sensible because the rule "Use namespacing for all symbols" is
> > > easier than "Use namespacing for symbols that might conflict with
> > > (present or future) names in the core or that might appear in user
> > > visible messages like backtraces or KASAN reports". It's sensible
> > > because then it's obvious when reading a code line that the symbol is
> > > driver specific. It is useful to have a common prefix for driver
> > > functions because that makes it easier to select them for tracing.
> > > 
> > > > Forcing everyone to use a specific prefix is just going to add a bunch
> > > > of characters but doesn't actually add any value.
> > > 
> > > That's your opinion and I disagree. I do see a value and the "burden" of
> > > these additional characters is quite worth its costs. In my bubble most
> > > people also see this value. This includes the coworkers I talked to,
> > > several other maintainers also insist on common prefixes[1] and it
> > > matches what my software engineering professor taught me during my
> > > studies. I also agree that longer names are more annoying than short
> > > ones, but that doesn't outweigh the advantages in my eyes and a good
> > > editor helps here.
> > 
> > FWIW, I'm +1 for proper namespacing for the purposes of; tracing,
> > logging and future proofing, even if it does add a few more chars.
> > Less of a problem now the 80-char rule is waning.
> 
> I've mentioned this in other threads before, but in retrospect I suppose
> I could've been more specific. For function names, even static ones,
> yes, I agree a common prefix is better.

I think you were very specific:

 "Again, these are local symbols and there's no need for namespacing. The
  only case where this would need to change is if the symbols started
  conflicting with global ones, but until that happens, let's just keep
  the names short and concise."

:)

> But there's absolutely no reason to enforce it for register
> definitions or local variables because the symbols will never show
> up anywhere.

I personally like namespacing defines too since it makes local ones
easily distinguishable from defines pulled in from API's header
files.

But at the end of the day, it's your train-set.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
