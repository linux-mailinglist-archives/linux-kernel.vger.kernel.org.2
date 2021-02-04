Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C5D30F7B3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 17:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237982AbhBDQZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 11:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237094AbhBDPFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 10:05:39 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920F4C061788
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 07:04:59 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d16so3841121wro.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 07:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=iSl2Rcu9DFOJsdwvIuhfSkBsJm6uHIoCbqyE3izD8Ns=;
        b=umCRXHSvpM7g937dntndearYQJY+mUu/ZaxSaUl7Kw/eejgvhdIGVagmnDa1JXv7b0
         iyHPzn4TorRo/SVQTHOLsfCi3aZ1LzQVx0HEN3mePSg0QA3tlEyvaO98nhd03THsTV1N
         /P4OjKNA6tluuP9M5InIi0qkEtYjYHvL4h+HJ7ZERViE8kNDgClo6n6Aza2RTetjsa8r
         IikDheckgcbGLjHB7p3MSTNHi0TdIJfRtxtzzf0RrW/84Kaiq1jVnFebNMxDkb5eqNzh
         wemy/rmFEgFZz2OK2rNAh8SYApsd08VKGjD/C6gtkvxKwL5SRldh5IXUbcIwWvI+dxYG
         2LTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=iSl2Rcu9DFOJsdwvIuhfSkBsJm6uHIoCbqyE3izD8Ns=;
        b=QseRMp6oON4drp1K+ejnWQ8zq7BFMQnutkjpz6C84cQigKJLEigN1MVPoPJPEZ7KZs
         V5aW61w8ln8z7OhS78I0VXtCnPcc/A6bqAQ0Y0E+UATBJXDSsrI5Hf2GDTVC2usE3FW3
         P0O+rwBtH59oiejhuDk/e8crgzTsCOJdfkeHw7wpn3xORf9FVvexxDKoPH63v71NuAvg
         Yw78Xee8YgNFmMxHLzPWJN18AusAuNYFEW1LW1IloiKpAkSIKHM/F0IdUrYXZ5ke+KFf
         MRyvF7uWgWHw2RLW/7n6TaqWUPWWgW/4TdIRZpXGHweNfLZ1199gXPYRU0miw4I/NKZw
         QYfA==
X-Gm-Message-State: AOAM532kAFuZNaFoonKwve0YH2gRaKPPLZeXLy/D1VOWqUMMZoqiWJ19
        EOWmNv/wlevQ4iIuiv8Ak0b17m1o1QKXXg==
X-Google-Smtp-Source: ABdhPJzl01vkDs21Nl6eEVqqiXRHlolXUpJeugF2RjwAGsrJOyOZzOm6wNCOL3Ygcx9Ez8et69Y/7w==
X-Received: by 2002:a5d:4492:: with SMTP id j18mr9738199wrq.403.1612451098383;
        Thu, 04 Feb 2021 07:04:58 -0800 (PST)
Received: from dell ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id d23sm6335346wmd.11.2021.02.04.07.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 07:04:57 -0800 (PST)
Date:   Thu, 4 Feb 2021 15:04:56 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v4 4/5] ASoC: Intel: Add DMI quirk table to
 soc_intel_is_byt_cr()
Message-ID: <20210204150456.GN2789116@dell>
References: <20210120214957.140232-1-hdegoede@redhat.com>
 <20210120214957.140232-5-hdegoede@redhat.com>
 <20210204135616.GL2789116@dell>
 <20210204140515.GC4288@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210204140515.GC4288@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Feb 2021, Mark Brown wrote:

> On Thu, Feb 04, 2021 at 01:56:16PM +0000, Lee Jones wrote:
> 
> > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> > Applied, thanks.
> 
> While we we were just having a discussion about what to do about this
> stuff...

We were?

This set has all the Acks we need to proceed.  What's blocking?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
