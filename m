Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F61B3240D4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 16:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237039AbhBXP33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 10:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233351AbhBXOxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 09:53:42 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF82C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 06:52:09 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id v15so2166828wrx.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 06:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+YAiSFXMR2t0ZYfr2igypWEMxKL7wzw6/Ye1sAumeUU=;
        b=A3uGYR3HYCD4CJdZ15lXO7ibOA5JYNaE2gunwTkvREx1Eqfp8zXShRkLkRfzJ99s85
         szym1QthYekYvbPyH7AeR03rtXn6O/rbZ7QxqHby1xHU3VcrM00usrrU4J3A/PlLRWYC
         Pn3VOYtzpoXB/b+iP3NTOBrg0Suycd4Nc2vct8JZfOsOM8M1tHtJOkghmZs5O3Lp0RLg
         klNr7Zwy1Lavl/0UC8DmZ2B4QNGYMGVXXlsxiIO/GG444nXg3MWnlB3T/6Ly70q19hRR
         PiKsjYIESxrm0ZRZQP4nwLio0qmdk8kSnbq5/i2AFLPiSUclyE0tnhPriduuOnsscUem
         Ud3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+YAiSFXMR2t0ZYfr2igypWEMxKL7wzw6/Ye1sAumeUU=;
        b=VBrNelWn7OtO9HDSc1iCpJ4pS92IahYlftPPRw6MDqsFIhL5/8Nj9IlLZ4PiiM6ks0
         MJ5biCdr2scWiCCuzJpHJr4nWDgXKzIMtzYBH5ErnMwLq1kK+BhhC0mmOWqg7L5TMBDE
         fe29fx+sVvPYmsjZxrYrWK4UlHimYTup1M46yLwHOq0/PBEE0SM4KhWv7cYHj5aFMPQq
         JiPDv9yOjvqA9iQB7V+Jjjzp9omoM1S7+HaeRomt05cSAxHzKIW1BxCiE0zr+f0b9B5v
         mzifyX1Mh2OhV0CcjOdRYGQxCWqcn/3JplTUwEFkWaz2KU4jTZMp0/eGdh3jk5WzEyE9
         2f0w==
X-Gm-Message-State: AOAM531I9lflMbuPlD70ZMOQ99RnpVOrfvwl1Vi78Hn102EBPpKtdmSS
        0STG6rXD83Qqw9FewvRLmNLkifKMrliE2A==
X-Google-Smtp-Source: ABdhPJzsjrLPWJSyfGWeLhexFMZpBfpkLog+aGztyiLkBogJw7T3KpbL3GdrSatRRy0nr2fT6tRTrw==
X-Received: by 2002:a5d:474c:: with SMTP id o12mr31048855wrs.161.1614178328098;
        Wed, 24 Feb 2021 06:52:08 -0800 (PST)
Received: from linaro.org ([2a01:e34:ed2f:f020:f137:d18c:50a6:cc6a])
        by smtp.gmail.com with ESMTPSA id d20sm4529774wrc.12.2021.02.24.06.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 06:52:07 -0800 (PST)
Date:   Wed, 24 Feb 2021 15:52:05 +0100
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, andriy.shevchenko@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, Christian Eggers <ceggers@arri.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH v2 1/9] units: Add the HZ macros
Message-ID: <20210224145205.GB534385@linaro.org>
References: <20210224144222.23762-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210224144222.23762-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 03:42:11PM +0100, Daniel Lezcano wrote:
> The macros for the unit conversion for frequency are duplicated in
> different places.
> 
> Provide these macros in the 'units' header, so they can be reused.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Christian Eggers <ceggers@arri.de>
> Reviewed-by: Andy Shevchenko <Andy.Shevchenko@gmail.com>
> ---

Is it possible to have these patches merged through the linux-pm tree ?




-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
